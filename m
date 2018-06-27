Received: from eggs.gnu.org ([2001:4830:134:3::10]:43162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY9cj-0007xi-Jc
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY9cf-0007bu-QN
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:32:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY9cf-0007bL-Jz
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:32:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B47240201CE
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:32:33 +0000 (UTC)
Date: Wed, 27 Jun 2018 20:32:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180627123228.GE2516@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87po0cad8n.fsf_-_@dusky.pond.sub.org>
	<871scsaapo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871scsaapo.fsf@dusky.pond.sub.org>
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

On Wed, Jun 27, 2018 at 10:35:15AM +0200, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Another lose end: event COMMAND_DROPPED seems to lack test coverage.
> 
> Hmm, dropping commands serves to limit the request queue.  What limits
> the response queue?

As long as we have a request queue limitation, that'll somehow be
"part of" the limitation of response queue.  Since the real responses
(let's not consider the events first) should be no more than the
maximum QMP requests that we allow in the request queue (one response
for one request).  In that sense it seems fine to me.

> 
> Before OOB, the monitor read at most one command, and wrote its response
> with monitor_puts().
> 
> For input, this leaves queueing to the kernel: if the client sends
> commands faster than the server can execute them, eventually the kernel
> refuses to buffer more, and the client's send either blocks or fails
> with EAGAIN.
> 
> Output is a mess.  monitor_puts() uses an output buffer.  It tries to
> flush at newline.  Issues:
> 
> * If flushing runs into a partial write, the unwritten remainder remains
>   in the output buffer until the next newline.  That newline may take
>   its own sweet time to arrive.  Could even lead to deadlocks, where a
>   client awaits complete output before it sends more input.  Bug,
>   predates OOB, doesn't block this series.

True.  Though I noticed that we have a "hackish" line in
monitor_json_emitter_raw():

    qstring_append_chr(json, '\n');

So it seems that at least we should never encounter a deadlock, after
all there will always be a newline there. But I'd say I agree with you
on that it's at least not that "beautiful". :-)

> 
> * If the client fails to read, the output buffer can grow without bound.
>   Not a security issue; the client is trusted.  Just bad workmanship.

True.

> 
> OOB doesn't change this for monitors running in the main thread.  Only
> mux chardevs run there.
> 
> Aside: keeping special case code around just for mux is a really bad
> idea.  We need to get rid of it.

We should be running the same code path even for MUX-ed typed, right?
Do you mean to put MUX-ed typed handling onto iothreads as well when
you say "get rid of it"?

> 
> For monitors running in an I/O thread, we add another buffer: the
> response queue.  It's drained by monitor_qmp_bh_responder().  I guess
> that means the response queue is effectively bounded by timely draining.
> Correct?

I don't see a timely manner to flush it, but as long as we queue
anything (including events) onto the response queue, we'll poke the
bottom half (in monitor_json_emitter() we call qemu_bh_schedule()) so
we'll possibly drain the queue very soon, and there should be no
chance to have a stale message in that queue.

> 
> Buffering twice seems silly, but that could be addressed in follow-up
> patches.

Do you mean that we can write the response immediately into
Monitor.outbuf, then only flush it in iothread?  IMHO that's fine -
after all, the response queue, as mentioned above, should have a
natural restriction as well due to the request queue, then we won't
waste too much resources for that.  Meanwhile using a queue with QMP
response objects seems to be a bit more cleaner to me from design pov
(though I might be wrong).

Regards,

-- 
Peter Xu
