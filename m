Received: from eggs.gnu.org ([2001:4830:134:3::10]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqSP-00073Q-8P
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euqSM-0007tI-34
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:11:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euqSL-0007t8-Te
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 21:11:26 -0500
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-17-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b384b0db-efc4-09d3-d671-fefab24b8448@redhat.com>
Date: Sat, 10 Mar 2018 20:11:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-17-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 16/23] monitor: send event when command
 queue full
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
> Set maximum QMP command queue length to 8.  If queue full, instead of

If the queue is full

> queue the command, we directly return a "command-dropped" event, telling

s/queue/queuing/

> client that specific command is dropped.

s/client that/the client that a/

> 
> Note that this flow control mechanism is only valid if OOB is enabled.
> If it's not, the effective queue length will always be 1, which strictly
> follows original behavior of QMP command handling (which never drop

s/drop/drops/

> messages).
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)

> 
> diff --git a/monitor.c b/monitor.c
> index 5104e5db07..4d57a8d341 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -4007,6 +4007,8 @@ static void monitor_qmp_bh_dispatcher(void *data)
>       }
>   }
>   
> +#define  QMP_REQ_QUEUE_LEN_MAX  (8)

Parens are redundant on a single int, but it doesn't hurt to leave them 
in a macro definition.

> @@ -4049,6 +4054,18 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>       if (!qmp_oob_enabled(mon)) {
>           monitor_suspend(mon);
>           req_obj->need_resume = true;
> +    } else {
> +        /* Drop the request if queue is full. */
> +        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
> +            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +            qapi_event_send_command_dropped(id,
> +                                            COMMAND_DROP_REASON_QUEUE_FULL,
> +                                            NULL);

Most qapi_event_send_* callers pass &error_abort (migration/ram.c being 
the only exception I could find); why not this one?  I'm changing it for 
consistency; we can revert back to NULL if testing finds a problem with it.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
