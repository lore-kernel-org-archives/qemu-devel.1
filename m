Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9nn2-0006vV-Le
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9nn1-0005ty-RK
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:54:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9nn1-0005tF-Im
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 04:54:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id d2-v6so887583wro.7
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 01:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181009062718.1914-1-peterx@redhat.com>
	<20181009062718.1914-3-peterx@redhat.com>
In-Reply-To: <20181009062718.1914-3-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 12:54:37 +0400
Message-ID: <CAJ+F1CJwK4cC5xXviefrOFiQCcrP7fsrDwx2E9mZSg_UtFPXrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 2/6] monitor: resume the monitor earlier
 if needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi
On Tue, Oct 9, 2018 at 10:28 AM Peter Xu <peterx@redhat.com> wrote:
>
> Currently when QMP request queue full we won't resume the monitor until
> we have completely handled the current command.  It's not necessary
> since even before it's handled the queue is already non-full.  Moving
> the resume logic earlier before the command execution.
>
> Note that now monitor_resume() is heavy weighted after 8af6bb14a3a8 and
> it's even possible (as pointed out by Marc-Andr=C3=A9) that the function
> itself may try to take the monitor lock again, so let's do the resume
> after the monitor lock is released to avoid possible dead lock.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 1f83775fff..f5911399d8 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4149,6 +4149,12 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      need_resume =3D !qmp_oob_enabled(mon) ||
>          mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
>      qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +
> +    if (need_resume) {
> +        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> +        monitor_resume(mon);
> +    }

"need_resume" is only set on non-oob enabled monitors.

On monitor_resume(), monitor_qmp_read() may end up being called, which
may call handle_qmp_command().

With regular commands, a new command is queued. But if the command is
"exec-oob", it will dispatch immediately, thus not following the QMP
reply ordering constrain.

Shouldn't it be an error to call exec-oob on non-oob enabled monitors?

> +
>      if (req_obj->req) {
>          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
>          monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
> @@ -4160,10 +4166,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
>          qobject_unref(rsp);
>      }
>
> -    if (need_resume) {
> -        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> -        monitor_resume(mon);
> -    }
>      qmp_request_free(req_obj);
>
>      /* Reschedule instead of looping so the main loop stays responsive *=
/
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
