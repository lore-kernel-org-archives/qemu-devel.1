Received: from eggs.gnu.org ([2001:4830:134:3::10]:56498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR9Ec-00019D-MZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fR9EZ-0000Ew-Jv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:42:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fR9EZ-0000ER-EM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F90BBB43A
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 04:42:42 +0000 (UTC)
Date: Fri, 8 Jun 2018 12:42:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180608044235.GA7736@xz-mi>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvqeyfs2.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Previously we cleanup the queues when we got CLOSED event.  It was used
> 
> we clean up
> 
> > to make sure we won't leftover replies/events of a old client to a new
> 
> we won't send leftover replies/events of an old client
> 
> > client.  Now this patch postpones that until OPENED.
> 
> What if OPENED never comes?

Then we clean that up until destruction of the monitor.  IMHO it's
fine, but I'm not sure whether that's an overall acceptable approach.

> 
> > In most cases, it does not really matter much since either way will make
> > sure that the new client won't receive unexpected old events/responses.
> > However there can be a very rare race condition with the old way when we
> > use QMP with stdio and pipelines (which is quite common in iotests).
> > The problem is that, we can easily have something like this in scripts:
> >
> >   cat $QMP_COMMANDS | qemu -qmp stdio ... | filter_commands
> >
> > In most cases, a QMP session will be based on a bidirectional
> > channel (read/write to a TCP port, for example), so IN and OUT are
> > sharing some fundamentally same thing.  However that's untrue for pipes
> 
> Suggest "are fundamentally the same thing".
> 
> > above - the IN is the "cat" program, while the "OUT" is directed to the
> > "filter_commands" which is actually another process.
> 
> Regarding 'IN is the "cat" program': a pipe is not a program.  Suggest
> 'IN is connected to "cat", while OUT is connected to "filter_commands",
> which are separate processes.
> 
> > Now when we received the CLOSED event, we cleanup the queues (including
> 
> we clean up
> 
> > the QMP response queue).  That means, if we kill/stop the "cat" process
> > faster than the filter_commands process, the filter_commands process is
> > possible to miss some responses/events that should belong to it.
> 
> I'm not sure I understand the error scenario.  Can you explain it in
> more concrete terms?  Like "cat terminates, QEMU reads EOF, QEMU does
> this, QEMU does that, oops, it shouldn't have done that".

One condition could be this (after "quit" command is executed and QEMU
quits the main loop):

1. [main thread] QEMU queues one SHUTDOWN event into response queue

2. "cat" terminates (to distinguish it from the animal, I quote it).
   Logically it can terminate even earlier, but let's just assume it's
   here.

3. [monitor iothread] QEMU reads EOF from stdin, which connects to the
   "cat" process

4. [monitor iothread] QEMU calls the CLOSED event hook for the monitor,
   which will clean up the response queue of the monitor, then the
   SHUTDOWN event is dropped

5. [main thread] clean up the monitors in monitor_cleanup(), when
   trying to flush pending responses, it sees nothing.  SHUTDOWN is
   lost forever

Note that before the monitor iothread was introduced, step [4]/[5]
could never happen since the main loop was the only place to detect
the EOF event of stdin and run the CLOSED event hooks.  Now things can
happen in parallel in the iothread.

I can add these into commit message.

> 
> > In practise, I encountered a very strange SHUTDOWN event missing when
> 
> practice
> 
> May I suggest use of a spell checker?  ;)

Sorry for that.  TODO added: "Find a spell checker for Emacs".

> 
> > running test with iotest 087.  Without this patch, iotest 078 will have
> 
> 087 or 078?

087.  Err.  Even a spell checker won't help me here!

> 
> > ~10% chance to miss the SHUTDOWN event and fail when with Out-Of-Band
> > enabled:
> >
> > 087 8s ... - output mismatch (see 087.out.bad)

I'll take all the rest comments.  Thanks for reviewing.

-- 
Peter Xu
