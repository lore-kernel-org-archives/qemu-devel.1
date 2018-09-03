Received: from eggs.gnu.org ([2001:4830:134:3::10]:39744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwjR4-0001iP-2z
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fwjR0-0001jg-P5
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:38:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fwjR0-0001jP-Ha
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 03:38:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B397A40216E9
	for <qemu-devel@nongnu.org>; Mon,  3 Sep 2018 07:38:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-4-peterx@redhat.com>
Date: Mon, 03 Sep 2018 09:38:00 +0200
In-Reply-To: <20180903043149.4076-4-peterx@redhat.com> (Peter Xu's message of
	"Mon, 3 Sep 2018 12:31:45 +0800")
Message-ID: <87pnxv9gkn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/7] monitor: suspend monitor instead of
 send CMD_DROP
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

> When we received too many qmp commands, previously we'll send
> COMMAND_DROPPED events to monitors, then we'll drop the requests.  Now
> instead of dropping the command we stop reading from input when we
> notice the queue is getting full.  Note that here since we removed the
> need_resume flag we need to be _very_ careful on the suspend/resume
> paring on the conditions since unmatched condition checks will hang
> death the monitor.  Meanwhile, now we will need to read the queue length
> to decide whether we'll need to resume the monitor so we need to take
> the queue lock again even after popping from it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The subject's "send CMD_DROP" fails to highlight the important part:
we're no longer dropping commands.  Moreover, the commit message could
do a better job explaining the tradeoffs.  Here's my try:

    monitor: Suspend monitor instead dropping commands

    When a QMP client sends in-band commands more quickly that we can
    process them, we can either queue them without limit (QUEUE), drop
    commands when the queue is full (DROP), or suspend receiving commands
    when the queue is full (SUSPEND).  None of them is ideal:

    * QUEUE lets a misbehaving client make QEMU eat memory without bounds.
      Not such a hot idea.

    * With DROP, the client has to cope with dropped in-band commands.  To
      inform the client, we send a COMMAND_DROPPED event then.  The event is
      flawed by design in two ways: it's ambiguous (see commit d621cfe0a17),
      and it brings back the "eat memory without bounds" problem.

    * With SUSPEND, the client has to manage the flow of in-band commands to
      keep the monitor available for out-of-band commands.

    We currently DROP.  Switch to SUSPEND.

    Managing the flow of in-band commands to keep the monitor available for
    out-of-band commands isn't really hard: just count the number of
    "outstanding" in-band commands (commands sent minus replies received),
    and if it exceeds the limit, hold back additional ones until it drops
    below the limit again.

    Note that we need to be careful pairing the suspend with a resume, or
    else the monitor will hang, possibly forever.


> ---
>  monitor.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 3b90c9eb5f..9e6cad2af6 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -89,6 +89,8 @@
>  #include "hw/s390x/storage-attributes.h"
>  #endif
>  
> +#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> +

Let's drop the parenthesis.

>  /*
>   * Supported types:
>   *
> @@ -4124,29 +4126,33 @@ static QMPRequest *monitor_qmp_requests_pop_any(void)
>  static void monitor_qmp_bh_dispatcher(void *data)
>  {
>      QMPRequest *req_obj = monitor_qmp_requests_pop_any();
> +    Monitor *mon;
>      QDict *rsp;
>      bool need_resume;
>  
>      if (!req_obj) {
>          return;
>      }
> -

Let's keep the blank line.

> +    mon = req_obj->mon;
>      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> -    need_resume = !qmp_oob_enabled(req_obj->mon);
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    need_resume = !qmp_oob_enabled(req_obj->mon) ||
> +        mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1;

Note for later: this is the condition guarding monitor_resume().

Is this race-free?  We have two criticial sections, one in
monitor_qmp_requests_pop_any(), and one here.  What if two threads
interleave like this

    thread 1                            thread 2
    ------------------------------------------------------------------
    monitor_qmp_requests_pop_any()
        lock
        dequeue
        unlock
                                        monitor_qmp_requests_pop_any()
                                            lock
                                            dequeue
                                            unlock
                                        lock
                                        check queue length
                                        unlock
                                        if queue length demands it
                                             monitor_resume() 
    lock
    check queue length
    unlock
    if queue length demands it
        monitor_resume()

Looks racy to me: if we start with the queue full (and the monitor
suspended), both threads' check queue length see length
QMP_REQ_QUEUE_LEN_MAX - 2, and neither thread resumes the monitor.
Oops.

Simplest fix is probably moving the resume into
monitor_qmp_requests_pop_any()'s critical section.

> +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>      if (req_obj->req) {
>          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?: "");
> -        monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
> +        monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
>      } else {
>          assert(req_obj->err);
>          rsp = qmp_error_response(req_obj->err);
>          req_obj->err = NULL;
> -        monitor_qmp_respond(req_obj->mon, rsp, NULL);
> +        monitor_qmp_respond(mon, rsp, NULL);
>          qobject_unref(rsp);
>      }
>  
>      if (need_resume) {
>          /* Pairs with the monitor_suspend() in handle_qmp_command() */
> -        monitor_resume(req_obj->mon);
> +        monitor_resume(mon);
>      }
>      qmp_request_free(req_obj);

The replacement of req_obj->mon by mon makes this change less clear than
it could be.  Let's figure out the possible race, and then we'll see
whether we'll still want this replacement.

>  
> @@ -4154,8 +4160,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
>      qemu_bh_schedule(qmp_dispatcher_bh);
>  }
>  
> -#define  QMP_REQ_QUEUE_LEN_MAX  (8)
> -
>  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
>  {
>      Monitor *mon = opaque;
> @@ -4205,19 +4209,12 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
       /*
        * If OOB is not enabled on the current monitor, we'll emulate the
        * old behavior that we won't process the current monitor any more
        * until it has responded.  This helps make sure that as long as
        * OOB is not enabled, the server will never drop any command.
        */

This comment is now stale, we don't drop commands anymore.

>      if (!qmp_oob_enabled(mon)) {
>          monitor_suspend(mon);
>      } else {
> -        /* Drop the request if queue is full. */
> -        if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
> -            qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +        if (mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
>              /*
> -             * FIXME @id's scope is just @mon, and broadcasting it is
> -             * wrong.  If another monitor's client has a command with
> -             * the same ID in flight, the event will incorrectly claim
> -             * that command was dropped.
> +             * If this is _exactly_ the last request that we can
> +             * queue, we suspend the monitor right now.
>               */
> -            qapi_event_send_command_dropped(id,
> -                                            COMMAND_DROP_REASON_QUEUE_FULL);
> -            qmp_request_free(req_obj);
> -            return;
> +            monitor_suspend(mon);
>          }
>      }

The conditional and its comments look unbalanced.  Moreover, the
condition is visually dissimilar to the one guarding the matching
monitor_resume().  What about:

       /*
        * Suspend the monitor when we can't queue more requests after
        * this one.  Dequeuing in monitor_qmp_bh_dispatcher() will resume
        * it.
        * Note that when OOB is disabled, we queue at most one command,
        * for backward compatibility.
        */
       if (!qmp_oob_enabled(mon) ||
           mon->qmp.qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
           monitor_suspend(mon);
       }

You'll have to update the comment if you move the resume to
monitor_qmp_requests_pop_any().

Next:

       /*
        * Put the request to the end of queue so that requests will be
        * handled in time order.  Ownership for req_obj, req, id,
        * etc. will be delivered to the handler side.
        */

Suggest asserting mon->qmp.qmp_requests->length < QMP_REQ_QUEUE_LEN_MAX
here.

       g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
       qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
