Received: from eggs.gnu.org ([2001:4830:134:3::10]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ666-0003CV-TK
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQ662-0007k6-S5
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:37:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQ662-0007gD-K4
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 01:37:18 -0500
Date: Sat, 16 Dec 2017 14:37:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171216063703.GD22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-17-peterx@redhat.com>
	<20171213200938.GG8317@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213200938.GG8317@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 16/26] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 13, 2017 at 08:09:38PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:50PM +0800, Peter Xu wrote:
> > @@ -3956,12 +3968,122 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> >          }
> >      }
> >  
> > -err_out:
> > -    monitor_qmp_respond(mon, rsp, err, id);
> > +    /* Respond if necessary */
> > +    monitor_qmp_respond(mon, rsp, NULL, id);
> > +
> > +    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
> > +    if (!qmp_oob_enabled(mon)) {
> > +        monitor_resume(mon);
> 
> monitor_resume() does not work between threads: if the event loop is
> currently blocked in poll() it won't notice that the monitor fd should
> be watched again.
> 
> Please add aio_notify() to monitor_resume() and monitor_suspend().  That
> way the event loop is forced to check can_read() again.

Ah, yes.  I think monitor_suspend() does not need the notify?  Since
if it's sleeping it won't miss the next check in can_read() after all?

Regarding to monitor_resume(), I noticed that I missed the fact that
it's only tailored for HMP before, which seems to be a bigger problem.
Do you agree with a change like this?

diff --git a/monitor.c b/monitor.c
index 9970418d6f..8f96880ad7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4244,10 +4244,12 @@ int monitor_suspend(Monitor *mon)
 
 void monitor_resume(Monitor *mon)
 {
-    if (!mon->rs)
-        return;
     if (atomic_dec_fetch(&mon->suspend_cnt) == 0) {
-        readline_show_prompt(mon->rs);
+        if (monitor_is_qmp(mon)) {
+            aio_notify(mon_global.mon_iothread->ctx);
+        } else {
+            assert(mon->rs);
+            readline_show_prompt(mon->rs);
+        }
     }
 }

Even, I'm thinking about whether I should start to introduce
iothread_notify() now to mask out the IOThread.ctx details.

> 
> > +    }
> >  
> >      qobject_decref(req);
> >  }
> >  
> > +/*
> > + * Pop one QMP request from monitor queues, return NULL if not found.
> > + * We are using round-robin fasion to pop the request, to avoid
> > + * processing command only on a very busy monitor.  To achieve that,
> > + * when we processed one request on specific monitor, we put that
> > + * monitor to the end of mon_list queue.
> > + */
> > +static QMPRequest *monitor_qmp_requests_pop_one(void)
> > +{
> > +    QMPRequest *req_obj = NULL;
> > +    Monitor *mon;
> > +
> > +    qemu_mutex_lock(&monitor_lock);
> > +
> > +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> > +        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> 
> Please add a doc comment about the monitor_lock < qmp_queue_lock lock
> ordering in the qmp_queue_lock field declaration so that deadlocks can
> be prevented.

Will do.

> 
> > +        req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
> > +        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +        if (req_obj) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (req_obj) {
> > +        /*
> > +         * We found one request on the monitor. Degrade this monitor's
> > +         * priority to lowest by re-inserting it to end of queue.
> > +         */
> > +        QTAILQ_REMOVE(&mon_list, mon, entry);
> > +        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
> > +    }
> > +
> > +    qemu_mutex_unlock(&monitor_lock);
> > +
> > +    return req_obj;
> > +}
> > +
> > +static void monitor_qmp_bh_dispatcher(void *data)
> > +{
> > +    QMPRequest *req_obj;
> > +
> > +    while (true) {
> 
> Previously QEMU could only dispatch 1 QMP command per main loop
> iteration.  Now multiple requests can be processed in a single main loop
> iteration.
> 
> If a producer enqueues requests faster than the dispatcher can dequeue
> them then this is infinite loop will prevent the caller (i.e.  QEMU main
> loop) from making progress.
> 
> The following keeps 1 QMP command per main loop iteration and avoids the
> infinite loop:
> 
>   static void monitor_qmp_bh_dispatcher(void *data)
>   {
>       QMPRequest *req_obj = monitor_qmp_requests_pop_one();
> 
>       if (req_obj) {
>           monitor_qmp_dispatch_one(req_obj);
> 
> 	  /* Reschedule instead of looping so the main loop stays responsive */
>           qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
>       }
>   }

Yes, this sounds better!

> 
> > +    /*
> > +     * Put the request to the end of queue so that requests will be
> > +     * handled in time order.  Ownership for req_obj, req, id,
> > +     * etc. will be delivered to the handler side.
> > +     */
> > +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > +    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> > +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +
> > +    /* Kick the dispatcher routine */
> > +    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> > +
> > +    /*
> > +     * If OOB is not enabled on current monitor, we'll emulate the old
> > +     * behavior that we won't process current monitor any more until
> > +     * it is responded.  This helps make sure that as long as OOB is
> > +     * not enabled, the server will never drop any command.
> > +     */
> > +    if (!qmp_oob_enabled(mon)) {
> > +        monitor_suspend(mon);
> > +    }
> 
> monitor_suspend() must be called before g_queue_push_tail().  Otherwise
> the other thread might complete the request and call monitor_resume()
> before we call monitor_suspend().

Reasonable.  Thanks,

-- 
Peter Xu
