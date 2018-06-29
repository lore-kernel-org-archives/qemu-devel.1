Received: from eggs.gnu.org ([2001:4830:134:3::10]:38195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYpHR-0003mh-2M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYpHN-0005wf-Ej
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYpHN-0005ty-8N
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8381387A6E
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:01:20 +0000 (UTC)
Date: Fri, 29 Jun 2018 17:01:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629090115.GH2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<87h8lo74oa.fsf@dusky.pond.sub.org> <20180627133442.GB2455@xz-mi>
	<87woujgi8m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87woujgi8m.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>

On Thu, Jun 28, 2018 at 03:20:41PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jun 27, 2018 at 03:13:57PM +0200, Markus Armbruster wrote:
> >> Monitor behavior changes even when the client rejects capability "oob".
> >> 
> >> Traditionally, the monitor reads, executes and responds to one command
> >> after the other.  If the client sends in-band commands faster than the
> >> server can execute them, the kernel will eventually refuse to buffer
> >> more, and sending blocks or fails with EAGAIN.
> >> 
> >> To make OOB possible, we need to read and queue commands as we receive
> >> them.  If the client sends in-band commands faster than the server can
> >> execute them, the server will eventually drop commands to limit the
> >> queue length.  The sever sends event COMMAND_DROPPED then.
> >> 
> >> However, we get the new behavior even when the client rejects capability
> >> "oob".  We get the traditional behavior only when the server doesn't
> >> offer "oob".
> >> 
> >> Is this what we want?
> >
> > Not really.  But I thought we kept that old behavior, haven't we?
> >
> > In handle_qmp_command() we have this:
> >
> >     /*
> >      * If OOB is not enabled on the current monitor, we'll emulate the
> >      * old behavior that we won't process the current monitor any more
> >      * until it has responded.  This helps make sure that as long as
> >      * OOB is not enabled, the server will never drop any command.
> >      */
> >     if (!qmp_oob_enabled(mon)) {
> >         monitor_suspend(mon);
> >         req_obj->need_resume = true;
> >     } else {
> >         /* Drop the request if queue is full. */
> >         if (mon->qmp.qmp_requests->length >= QMP_REQ_QUEUE_LEN_MAX) {
> >             qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> >             qapi_event_send_command_dropped(id,
> >                                             COMMAND_DROP_REASON_QUEUE_FULL,
> >                                             &error_abort);
> >             qmp_request_free(req_obj);
> >             return;
> >         }
> >     }
> >
> > Here assuming that we are not enabling OOB, then since we will suspend
> > the monitor when we receive one command, then monitor_can_read() later
> > will check with a result that "we should not read the chardev", then
> > it'll leave all the data in the input buffer.  Then AFAIU the QMP
> > client that didn't enable OOB will have similar behavior as before.
> >
> > Also, we will never receive a COMMAND_DROPPED event in that legacy
> > mode as well since it's in the "else" block.   Am I right?
> 
> Hmm.  Did I get confused?  Let me look again.
> 
> Some places check qmp_oob_enabled(), which is true when the server
> offered capability "oob" and the client accepted.  In terms of my reply
> to Daniel, it distinguishes the two run time cases "OOB off" and "OOB
> on".

Exactly.

> 
> Other places check ->use_io_thr, which is true when
> 
>     (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(chr)
> 
> in monitor_init().
> 
> One of these places is get_qmp_greeting().  It makes the server offer
> "oob" when ->use_io_thr.  Makes sense.
> 
> In terms of my reply to Daniel, ->use_io_thr distinguishes between "OOB
> not offered" and ("OOB offered, but rejected by client" or "OOB offered
> and accepted").

Exactly.

To be more clear, let's name the three cases (as you mentioned):

(A) OOB not offered
(B) OOB offered, but rejected by client
(C) OOB offered, and accepted

Then:

(1) qmp_oob_enabled() will only be return true if (C).
(2) ->use_io_thr will only be true if (B) or (C).

> 
> Uses could to violate 'may use "server offered OOB" only for
> configuration purposes', so let's check them:
> 
> * monitor_json_emitter()
> 
>   If mon->use_io_thr, push to response queue.  Else emit directly.
> 
>   I'm afraid run time behavior differs for "OOB not offered" (emit
>   directly) and "OOB offered by rejected" (queue).

Yeah it's different, but logically it's the same.  IMHO it's only a
fast path for main thread.  In other word, I think it can still work
correctly if we remove that else clause.  In that sense, it's not
really a "true" behavior change.

> 
> * qmp_caps_check()
> 
>   If !mon->use_io_thr, reject client's acceptance of "oob".  Implicitly
>   recomputing the set of offered capabilities here is less than elegant,
>   but it's not wrong.
> 
> * monitor_resume()
> 
>   If mon->use_io_thr(), kick the monitor I/O thread.
> 
>   Again, different behavior for the two variations of "OOB off".

This is another example like above - IMHO we can just kick it no
matter what, but we just don't need to do that for main thread (since
we are in main thread so we are sure it is not asleep).  It's just
another trivial enhancement on top of the main logic.

> 
> * get_qmp_greeting()
> 
>   Covered above, looks good to me.
> 
> * monitor_qmp_setup_handlers_bh()
> 
>   If mon->use_io_thr(), pass the monitor I/O thread's AIOContext to
>   qemu_chr_fe_set_handlers(), else pass NULL.
> 
>   Again, different behavior for the two variations of "OOB off".

This is different indeed, but IMHO it's not really "behavior
difference", it's just the context (thread to run the code) that is
different.  The major code path for case (A) and (B) (which are the
two "off" cases) should be the same (when I say "major", I excluded
those trivial enhancements that I mentioned).

> 
> * monitor_init()
> 
>   If mon->use_io_thr, set up bottom half
>   monitor_qmp_setup_handlers_bh(), else call qemu_chr_fe_set_handlers()
>   directly.

This is indeed a bit tricky (to avoid a potential race that Stefan has
pointed out), however after things are setup it'll be exactly the same
code path for both OFF cases.

And actually when I read the code I noticed that we can actually
simplify the code with this:

diff --git a/monitor.c b/monitor.c
index 0730a27172..5d6bff8d51 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4635,18 +4635,14 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     Monitor *mon = opaque;
     GMainContext *context;

-    if (mon->use_io_thr) {
-        /*
-         * When use_io_thr is set, we use the global shared dedicated
-         * IO thread for this monitor to handle input/output.
-         */
-        context = monitor_get_io_context();
-        /* We should have inited globals before reaching here. */
-        assert(context);
-    } else {
-        /* The default main loop, which is the main thread */
-        context = NULL;
-    }
+    assert(mon->use_io_thr);
+    /*
+     * When use_io_thr is set, we use the global shared dedicated
+     * IO thread for this monitor to handle input/output.
+     */
+    context = monitor_get_io_context();
+    /* We should have inited globals before reaching here. */
+    assert(context);

     qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                              monitor_qmp_event, NULL, mon, context, true);

Since monitor_qmp_setup_handlers_bh() will only be used for IOThread
case.  I can post a patch for that.

> 
>   Again, different behavior for the two variations of "OOB off".
> 
> Either I am confused now, or the two variations of "OOB off" execute
> different code at run time.  Which is it?

As mentioned, they should be running the same code at run time.
Though with some trivial differences, but if you see above most of
them should only be small enhancements which can actually be removed.

> 
> If it's different code, are the differences observable for the client?

AFAIU since the code path should mostly be the same for the two OOF
cases, IMHO there should have no difference observable from the
client, otherwise it's buggy and I'd be willing to fix it.

> 
> Observable or not, I suspect the differences should not exist.

We can remove those "trivial enhancements" if we want to make sure the
code paths are exactly the same, but I'm not sure whether that's
really what we need (or we just need to make sure it's unobservable).

Thanks!

-- 
Peter Xu
