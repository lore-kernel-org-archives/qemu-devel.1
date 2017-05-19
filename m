Received: from eggs.gnu.org ([2001:4830:134:3::10]:44354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBiy3-0001cc-OK
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBiy0-00063p-HC
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:33:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBiy0-00063Q-7Q
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:33:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF2143B70C
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 14:33:18 +0000 (UTC)
Date: Fri, 19 May 2017 15:33:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170519143312.GP2081@work-vm>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-2-git-send-email-peterx@redhat.com>
	<20170519082538.GD4912@redhat.com> <20170519125139.GM2081@work-vm>
	<20170519125601.GD28392@redhat.com> <20170519130200.GO2081@work-vm>
	<20170519131344.GA22341@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170519131344.GA22341@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/6] io: only allow return path for
 socket typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

* Daniel P. Berrange (berrange@redhat.com) wrote:
> On Fri, May 19, 2017 at 02:02:00PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Fri, May 19, 2017 at 01:51:43PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > On Fri, May 19, 2017 at 02:43:27PM +0800, Peter Xu wrote:
> > > > > > We don't really have a return path for the other types yet. Let's check
> > > > > > this when .get_return_path() is called.
> > > > > > 
> > > > > > For this, we introduce a new feature bit, and set it up only for socket
> > > > > > typed IO channels.
> > > > > > 
> > > > > > This will help detect earlier failure for postcopy, e.g., logically
> > > > > > speaking postcopy cannot work with "exec:". Before this patch, when we
> > > > > > try to migrate with "migrate -d exec:cat>out", we'll hang the system.
> > > > > > With this patch, we'll get:
> > > > > > 
> > > > > > (qemu) migrate -d exec:cat>out
> > > > > > Unable to open return-path for postcopy
> > > > > 
> > > > > This is wrong - post-copy migration *can* work with exec: - it just entirely
> > > > > depends on what command you are running. Your example ran a command which is
> > > > > unidirectional, but if you ran 'exec:socat ...' you would have a fully
> > > > > bidirectional channel. Actually the channel is always bi-directional, but
> > > > > 'cat' simply won't ever send data back to QEMU.
> > > > 
> > > > The thing is it didn't used to be able to; prior to your conversion to
> > > > channel, postcopy would reject being started with exec: because it
> > > > couldn't open a return path, so it was safe.
> > > 
> > > It safe but functionally broken because it is valid to want to use
> > > exec migration with post-copy.
> > > 
> > > > > If QEMU hangs when the other end doesn't send data back, that actually seems
> > > > > like a potentially serious bug in migration code. Even if using the normal
> > > > > 'tcp' migration protocol, if the target QEMU server hangs and fails to
> > > > > send data to QEMU on the return path, the source QEMU must never hang.
> > > > 
> > > > Hmm, we shouldn't get a 'hang' with a postcopy on a link without a
> > > > return path; but it does depend on how the exec: behaves on the
> > > > destination.
> > > > If the destination discards data written to it, then I think the
> > > > behaviour would be:
> > > >    a) Page requests would just get dropped, they'd eventually get
> > > > fulfilled by the background page transmissions, but that could mean that
> > > > a page request would wait for minutes for the page.
> > > >    b) The qemu main thread on the destination can be blocked by that, so
> > > > the monitor might not respond until the page request is fulfilled.
> > > >    c) I'm not quite sure what would happen to the source return-path
> > > > thread
> > > > 
> > > > The behaviour seems to have changed between 2.9.0 (f26 package) and my
> > > > reasonably recent head build.
> > > 
> > > That's due to the bug we just fixed where we mistakenly didn't
> > > allow bi-directional I/O for exec
> > > 
> > >   commit 062d81f0e968fe1597474735f3ea038065027372
> > >   Author: Daniel P. Berrange <berrange@redhat.com>
> > >   Date:   Fri Apr 21 12:12:20 2017 +0100
> > > 
> > >     migration: setup bi-directional I/O channel for exec: protocol
> > >     
> > >     Historically the migration data channel has only needed to be
> > >     unidirectional. Thus the 'exec:' protocol was requesting an
> > >     I/O channel with O_RDONLY on incoming side, and O_WRONLY on
> > >     the outgoing side.
> > >     
> > >     This is fine for classic migration, but if you then try to run
> > >     TLS over it, this fails because the TLS handshake requires a
> > >     bi-directional channel.
> > >     
> > >     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > >     Reviewed-by: Juan Quintela <quintela@redhat.com>
> > >     Signed-off-by: Juan Quintela <quintela@redhat.com>
> > > 
> > > 
> > > > A migration_cancel also doesn't work for 'exec' because it doesn't
> > > > support shutdown() - it just sticks in 'cancelling'.
> > > > On a socket that was broken like this the cancel would work because
> > > > it issues a shutdown() which causes the socket to cleanup.
> > > 
> > > I'm curious why migration_cancel requires shutdown() to work ? Why
> > > isn't it sufficient from the source POV to just close the socket
> > > entirely straight away.
> > 
> > close() closes the fd so that any other uses of the fd get an
> > error and you're at risk of the fd getting reallocated by something
> > else.  So consider if the main thread calls close(), the migration
> > thread and the return thread both carry on using that fd, which might
> > have been reallocated to something different.  Worse I think we came to the
> > consolution that on some OSs a read()/write() blocked in the use of an fd
> > didn't get kicked out by a close.
> 
> I'd be very surprised if close() didn't terminate any other threads doing
> read/write

Prepare to be surprised then - that's the behaviour I found when I tried
it out in 2014.
(Also at the time we found cases where the close() could hang)

> and even more surprised if it they handed out the same FD
> to another thread while something was still in the read.

Right, I don't think that will happen.

> 
> > shutdown() is safe, in that it stops any other threads accessing the fd
> > but doesn't allow it's reallocation until the close;  We perform the
> > close only when we've joined all other threads that were using the fd.
> > Any of the threads that do new calls on the fd get an error and quickly
> > fall down their error paths.
> 
> Ahh that's certainly an interesting scenario. That would certainly be
> a problem with the migration code when this was originally written.
> It had two QEMUFile structs each with an 'int fd' field, so when you
> close 'fd' on one QEMUFile struct, it wouldn't update the other QEMUFile
> used by another thread.
> 
> Since we switched over to use QIOChannel though, I think the thread
> scenario you describe should be avoided entirely. When you have multiple
> QEMUFile objects, they each have a reference counted pointer to the same
> underlying QIOChannel object instance. So when QEMUFile triggers a call
> to qio_channel_close() in one thread, that'll set fd=-1 in the QIOChannel.
> Since the other threads have a reference to the same QIOChannel object,
> they'll now see this fd == -1 straightaway.
> 
> So, IIUC, this should make the need for shutdown() redundant (at least
> for the thread race conditions you describe).

That's not thread safe unless you're doing some very careful locking.
Consider:
  T1                      T2       
     oldfd=fd               tmp=fd
     fd=-1
     close(oldfd)
     unrelated open()
                            read(tmp,...

In practice every use of fd will be a copy into a tmp and then the
syscall; the unrelated open() could happen in another thread.
(OK, the gap between the tmp and the read is tiny, although if we're
doing multiple operations chances are the compiler will optimise
it to the top of a loop).

There's no way to make that code safe.

Dave

> Regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
