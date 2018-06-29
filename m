Received: from eggs.gnu.org ([2001:4830:134:3::10]:46417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYpvO-0006t0-U7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYpvL-0004Fs-P7
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56574 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYpvL-0004FN-IM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21164400B454
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:42:39 +0000 (UTC)
Date: Fri, 29 Jun 2018 17:42:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629094233.GI2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87po0cad8n.fsf_-_@dusky.pond.sub.org>
	<871scsaapo.fsf@dusky.pond.sub.org> <20180627123228.GE2516@xz-mi>
	<87r2kr2r9h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2kr2r9h.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 11:29:30AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jun 27, 2018 at 10:35:15AM +0200, Markus Armbruster wrote:
> >> Markus Armbruster <armbru@redhat.com> writes:
> >> 
> >> > Another lose end: event COMMAND_DROPPED seems to lack test coverage.
> >> 
> >> Hmm, dropping commands serves to limit the request queue.  What limits
> >> the response queue?
> >
> > As long as we have a request queue limitation, that'll somehow be
> > "part of" the limitation of response queue.  Since the real responses
> > (let's not consider the events first) should be no more than the
> > maximum QMP requests that we allow in the request queue (one response
> > for one request).  In that sense it seems fine to me.
> 
> "Normal" flow of the request through the server (QEMU):
> 
>     receive
>  -> handle_qmp_command()
> 
>  -> request queue: mon->qmp.qmp_requests
> 
>  -> monitor_qmp_bh_dispatcher()
>  -> monitor_qmp_dispatch_one()
>  -> monitor_qmp_respond()
>  -> monitor_json_emitter()
> 
>  -> response queue: mon->qmp.qmp_requests
> 
>  -> monitor_qmp_response_pop_one()
>  -> monitor_qmp_bh_responder()
>  -> monitor_json_emitter_raw()
>  -> monitor_puts()
> 
>  -> output buffer: mon->outbuf
> 
>  -> monitor_flush_locked()
> 
> The purpose of event COMMAND_DROPPED is flow control notification: when
> the client sends more than we're willing to buffer, we drop the excess
> and notify the client.
> 
> If the client sends too many requests too quickly, the request queue
> fills up, and flow control kicks in.  Good.
> 
> As long as the client sends requests at a moderate pace, the request
> queue never fills up: the dispatch & execute code sitting between
> request queue and response queue drains it just fine.
> 
> The response queue proper also doesn't fill up: the emitter code sitting
> between response queue and output buffer drains it just fine.
> 
> However, output buffer can still grow without bounds!
> monitor_flush_locked() requires the client to keep up to make progress.
> Our flow control fails then.
> 
> Extreme case: a (misbehaving!) client that keeps sending requests at a
> moderate pace while not reading any responses.  output buffer grows
> without bounds.
> 
> Less extreme case: a client sends a small number of requests quickly,
> then reads responses very slowly or not at all for some reason, say
> because the network goes bad right at this time.  Here, the size of the
> request queue does limit the size of output buffer, as you proposed, but
> the size multiplier isn't really known.
> 
> My point is: the idea "limiting the request queue also limits the
> response queue + output buffer" isn't entirely wrong, but it's not
> entirely right, either.

Good point!  I obviously overlooked this.

> 
> Can we improve flow control to cover the complete flow, not just the
> flow into the request queue?

How about we simply apply the queue length to the response queue as
well?  Here's the steps:

(1) A new CommandDropReason called COMMAND_DROP_REASON_RESPONSE_FULL,
    showing that one command is dropped since response queue of the
    monitor is full.

(2) When handle QMP command, we not only check request queue, but also
    response queue.  If response queue length is bigger than
    QMP_REQ_QUEUE_LEN_MAX, then we drop the command with the reason
    COMMAND_DROP_REASON_RESPONSE_FULL.

We can do more fine-grained flow control in the future, though I hope
this would work for us as the first step.

> 
> >> Before OOB, the monitor read at most one command, and wrote its response
> >> with monitor_puts().
> >> 
> >> For input, this leaves queueing to the kernel: if the client sends
> >> commands faster than the server can execute them, eventually the kernel
> >> refuses to buffer more, and the client's send either blocks or fails
> >> with EAGAIN.
> >> 
> >> Output is a mess.  monitor_puts() uses an output buffer.  It tries to
> >> flush at newline.  Issues:
> >> 
> >> * If flushing runs into a partial write, the unwritten remainder remains
> >>   in the output buffer until the next newline.  That newline may take
> >>   its own sweet time to arrive.
> 
> Hmm, it's also flushed via mon->out_watch.  If that works how I guess it
> does, there's no deadlock.
> 
> >>                                  Could even lead to deadlocks, where a
> >>   client awaits complete output before it sends more input.  Bug,
> >>   predates OOB, doesn't block this series.
> >
> > True.  Though I noticed that we have a "hackish" line in
> > monitor_json_emitter_raw():
> >
> >     qstring_append_chr(json, '\n');
> >
> > So it seems that at least we should never encounter a deadlock, after
> > all there will always be a newline there. But I'd say I agree with you
> > on that it's at least not that "beautiful". :-)
> 
> The newline ensures responses arrive on their own line.  JSON doesn't
> care about lines (makes sense), and qmp-spec.txt doesn't care, either
> (that's wrong, in my opinion).  Anyone playing with QMP by hand will
> definitely care.  Even QMP clients might.
> 
> The newline also triggers the actual write(), because monitor_puts() is
> line-buffered.  That buffering makes sense for HMP, but it's useless for
> QMP.  Let's not worry about that right now.

Yeah.

> 
> The flushing, however, is not guaranteed to write anything!  If
> qemu_chr_fe_write() fails with EAGAIN, mon->outbuf remains unchanged.

Ouch!  I know that watch, but I didn't notice that it's actually not
following the general semantics of "flush".  Though it's for sure
understandable since we don't want to hang-death the main thread, but
the name "flush" might be misleading.

> 
> >> * If the client fails to read, the output buffer can grow without bound.
> >>   Not a security issue; the client is trusted.  Just bad workmanship.
> >
> > True.
> >
> >> 
> >> OOB doesn't change this for monitors running in the main thread.  Only
> >> mux chardevs run there.
> >> 
> >> Aside: keeping special case code around just for mux is a really bad
> >> idea.  We need to get rid of it.
> >
> > We should be running the same code path even for MUX-ed typed, right?
> > Do you mean to put MUX-ed typed handling onto iothreads as well when
> > you say "get rid of it"?
> 
> I figure I'll cover this in my reply to Daniel.  If not, I'll reply to
> this one again.
> 
> >> For monitors running in an I/O thread, we add another buffer: the
> >> response queue.  It's drained by monitor_qmp_bh_responder().  I guess
> >> that means the response queue is effectively bounded by timely draining.
> >> Correct?
> >
> > I don't see a timely manner to flush it, but as long as we queue
> > anything (including events) onto the response queue, we'll poke the
> > bottom half (in monitor_json_emitter() we call qemu_bh_schedule()) so
> > we'll possibly drain the queue very soon, and there should be no
> > chance to have a stale message in that queue.
> 
> As long as bottom halves work, the response queue remains small.  That's
> okay.
> 
> >> Buffering twice seems silly, but that could be addressed in follow-up
> >> patches.
> >
> > Do you mean that we can write the response immediately into
> > Monitor.outbuf, then only flush it in iothread?  IMHO that's fine -
> > after all, the response queue, as mentioned above, should have a
> > natural restriction as well due to the request queue, then we won't
> > waste too much resources for that.  Meanwhile using a queue with QMP
> > response objects seems to be a bit more cleaner to me from design pov
> > (though I might be wrong).
> 
> Again, let's not worry about this right now.

Thanks,

-- 
Peter Xu
