Received: from eggs.gnu.org ([2001:4830:134:3::10]:54642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHr4L-0005pt-D2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHr4F-0000i5-9N
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHr4E-0000Q8-RT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B8F43082B4C
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 14:01:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181009062718.1914-1-peterx@redhat.com>
	<20181009062718.1914-2-peterx@redhat.com>
Date: Wed, 31 Oct 2018 15:01:03 +0100
In-Reply-To: <20181009062718.1914-2-peterx@redhat.com> (Peter Xu's message of
	"Tue, 9 Oct 2018 14:27:13 +0800")
Message-ID: <87k1lygqqo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 1/6] monitor: Suspend monitor instead
 dropping commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> When a QMP client sends in-band commands more quickly that we can
> process them, we can either queue them without limit (QUEUE), drop
> commands when the queue is full (DROP), or suspend receiving commands
> when the queue is full (SUSPEND).  None of them is ideal:
>
> * QUEUE lets a misbehaving client make QEMU eat memory without bounds.
> Not such a hot idea.
>
> * With DROP, the client has to cope with dropped in-band commands.  To
> inform the client, we send a COMMAND_DROPPED event then.  The event is
> flawed by design in two ways: it's ambiguous (see commit d621cfe0a17),
> and it brings back the "eat memory without bounds" problem.
>
> * With SUSPEND, the client has to manage the flow of in-band commands to
> keep the monitor available for out-of-band commands.
>
> We currently DROP.  Switch to SUSPEND.
>
> Managing the flow of in-band commands to keep the monitor available for
> out-of-band commands isn't really hard: just count the number of
> "outstanding" in-band commands (commands sent minus replies received),
> and if it exceeds the limit, hold back additional ones until it drops
> below the limit again.
>
> Note that we need to be careful pairing the suspend with a resume, or
> else the monitor will hang, possibly forever.  And here since we need to
> make sure both:
>
>      (1) popping request from the req queue, and
>      (2) reading length of the req queue
>
> will be in the same critical section, we let the pop function take the
> corresponding queue lock when there is a request, then we release the
> lock from the caller.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/interop/qmp-spec.txt |  5 ++--
>  include/monitor/monitor.h |  2 ++
>  monitor.c                 | 52 +++++++++++++++++----------------------
>  qapi/misc.json            | 40 ------------------------------
>  4 files changed, 28 insertions(+), 71 deletions(-)
>
> diff --git a/docs/interop/qmp-spec.txt b/docs/interop/qmp-spec.txt
> index 8f7da0245d..67e44a8120 100644
> --- a/docs/interop/qmp-spec.txt
> +++ b/docs/interop/qmp-spec.txt
> @@ -130,8 +130,9 @@ to pass "id" with out-of-band commands.  Passing it w=
ith all commands
>  is recommended for clients that accept capability "oob".
>=20=20
>  If the client sends in-band commands faster than the server can
> -execute them, the server will eventually drop commands to limit the
> -queue length.  The sever sends event COMMAND_DROPPED then.
> +execute them, the server will stop reading the requests from the QMP
> +channel until the request queue length is reduced to an acceptable
> +range.
>=20=20
>  Only a few commands support out-of-band execution.  The ones that do
>  have "allow-oob": true in output of query-qmp-schema.

Clients need to know the queue length limit to manage the flow.  We
better document it.  Can be done on top.

> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 6fd2c53b09..0c0a37d8cb 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -15,6 +15,8 @@ extern __thread Monitor *cur_mon;
>  #define MONITOR_USE_PRETTY    0x08
>  #define MONITOR_USE_OOB       0x10
>=20=20
> +#define QMP_REQ_QUEUE_LEN_MAX 8
> +
>  bool monitor_cur_is_qmp(void);
>=20=20
>  void monitor_init_globals(void);
> diff --git a/monitor.c b/monitor.c
> index b9258a7438..1f83775fff 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4097,8 +4097,12 @@ static void monitor_qmp_dispatch(Monitor *mon, QOb=
ject *req, QObject *id)
>   * processing commands only on a very busy monitor.  To achieve that,
>   * when we process one request on a specific monitor, we put that
>   * monitor to the end of mon_list queue.
> + *
> + * Note: if the function returned with non-NULL, then the caller will
> + * be with mon->qmp.qmp_queue_lock held, and the caller is responsible
> + * to release it.

The English could use some polish.  We can do that on top as well.

[...]
