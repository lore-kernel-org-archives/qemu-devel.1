Received: from eggs.gnu.org ([2001:4830:134:3::10]:51036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqI6-00043K-HB
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqI3-0000Zm-Bb
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:00:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqI3-0000ZX-5V
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:00:47 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9d830b8b-6129-18c6-98e6-98356f64d54a@redhat.com>
Date: Sat, 10 Mar 2018 20:00:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-15-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/09/2018 02:59 AM, Peter Xu wrote:
> Originally QMP goes through these steps:
> 
>    JSON Parser --> QMP Dispatcher --> Respond
>        /|\    (2)                (3)     |
>     (1) |                               \|/ (4)
>         +---------  main thread  --------+
> 
> This patch does this:
> 
>    JSON Parser     QMP Dispatcher --> Respond
>        /|\ |           /|\       (4)     |
>         |  | (2)        | (3)            |  (5)
>     (1) |  +----->      |               \|/
>         +---------  main thread  <-------+
> 
> So the parsing job and the dispatching job is isolated now.  It gives us
> a chance in following up patches to totally move the parser outside.

s/following/follow/

> 
> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH is
> used for all the monitors.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 178 insertions(+), 23 deletions(-)
> 

>   
>       if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>           QString *req_json = qobject_to_json(req);

More context conflicts.


> +/*
> + * Pop one QMP request from monitor queues, return NULL if not found.
> + * We are using round-robin fashion to pop the request, to avoid
> + * processing command only on a very busy monitor.  To achieve that,

s/command/commands/

> + * when we processed one request on specific monitor, we put that

s/processed/process/
s/on/on a/

> + * monitor to the end of mon_list queue.
> + */
> +static QMPRequest *monitor_qmp_requests_pop_one(void)
> +
> +    /*
> +     * If OOB is not enabled on current monitor, we'll emulate the old
> +     * behavior that we won't process current monitor any more until

s/current/the current/g

> +     * it is responded.  This helps make sure that as long as OOB is

/is responded/has responded/

> +     * not enabled, the server will never drop any command.
> +     */

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
