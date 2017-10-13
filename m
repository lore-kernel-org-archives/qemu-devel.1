Received: from eggs.gnu.org ([2001:4830:134:3::10]:49719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2sCs-0003YI-4r
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2sCo-0007m6-VV
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e2sCo-0007hk-Lk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 01:08:18 -0400
Date: Fri, 13 Oct 2017 13:08:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171013050809.GI30901@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-11-git-send-email-peterx@redhat.com>
	<20170921192903.GH3401@work-vm>
	<20170927073441.GD25011@pxdev.xzpeter.org>
	<20171009185812.GR2374@work-vm>
	<20171010093801.GC20686@pxdev.xzpeter.org>
	<20171010123017.GE2132@work-vm>
	<20171011030058.GG20686@pxdev.xzpeter.org>
	<20171012121952.GD2343@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171012121952.GD2343@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 10/33] migration: allow dst vm pause on
 postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Oct 12, 2017 at 01:19:52PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Tue, Oct 10, 2017 at 01:30:18PM +0100, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Mon, Oct 09, 2017 at 07:58:13PM +0100, Dr. David Alan Gilbert wrote:
> > 
> > [...]
> > 
> > > > > We have to be careful about this; a network can fail in a way it
> > > > > gets stuck rather than fails - this can get stuck until a full TCP
> > > > > disconnection; and that takes about 30mins (from memory).
> > > > > The nice thing about using 'shutdown' is that you can kill the existing
> > > > > connection if it's hung. (Which then makes an interesting question;
> > > > > the rules in your migrate-incoming command become different if you
> > > > > want to declare it's failed!).  Having said that, you're right that at
> > > > > this point stuff has already failed - so do we need the shutdown?
> > > > > (You might want to do the shutdown as part of the recovery earlier
> > > > > or as a separate command to force the failure)
> > > > 
> > > > I assume if I call shutdown before the lock then we'll be good then.
> > > 
> > > The question is what happens if you only allow recovery if we're already
> > > in postcopy-paused state; in the case of a hung socket, since no IO has
> > > actually failed yet, you will still be in postcopy-active.
> > 
> > Hmm, but isn't that a problem of kernel rather than QEMU?  Since
> > sockets are after all managed by kernel.
> 
> Kind of, but it comes down to what the right behaviour of a TCP socket
> is, and the kernel is probably doing the right thing.
> 
> > I don't really know what is the best thing to do to detect whether a
> > socket is stuck.  Assume we can observed that (say, we see migration
> > transferred bytes keep static for 30 seconds), IIRC you mentioned
> > about iptable tricks to break an existing e.g. TCP connection, then we
> > can trigger the -EIO path.
> 
> From the qemu level I'd prefer to make it a command;  if we start
> adding heuristics and timeouts etc then it's very difficult to actually
> get them right.
> 
> > Or do you think we should provide a way to manually trigger the paused
> > state?  Then it goes back to something we discussed with Dan in the
> > earlier post - I'd appreciate if we can postpone the manual trigger
> > support a bit (to make this series small, which is already not...).
> 
> I think that manual trigger is probably necessary; it would just call a
> shutdown() on the sockets and let the things fail into the paused state.
> It'd be pretty simple.  It would be another OOB command; the tricky
> part is just making sure it's thread safe against hte migration
> finishing when you issue it.
> 
> I think it can wait until after this series if you want, but it would
> be good if we can figure it out.

OK.  Let me try it in my next post.  I hope it won't grow into
something bigger (which does happens sometimes... :).

-- 
Peter Xu
