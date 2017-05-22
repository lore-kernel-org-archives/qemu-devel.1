Received: from eggs.gnu.org ([2001:4830:134:3::10]:38438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCifl-0007bK-44
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dCifh-0002o9-5x
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dCifg-0002nm-T4
	for qemu-devel@nongnu.org; Mon, 22 May 2017 04:26:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3103A7F6A4
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 08:26:30 +0000 (UTC)
Date: Mon, 22 May 2017 09:26:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170522082623.GD5158@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1495176212-14446-1-git-send-email-peterx@redhat.com>
	<1495176212-14446-2-git-send-email-peterx@redhat.com>
	<20170519082538.GD4912@redhat.com> <20170519125139.GM2081@work-vm>
	<20170519125601.GD28392@redhat.com> <20170519130200.GO2081@work-vm>
	<20170519131344.GA22341@redhat.com> <20170519143312.GP2081@work-vm>
	<20170519145126.GA17164@redhat.com> <20170519184133.GU2081@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519184133.GU2081@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Fri, May 19, 2017 at 07:41:34PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Fri, May 19, 2017 at 03:33:12PM +0100, Dr. David Alan Gilbert wrote:
> > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > shutdown() is safe, in that it stops any other threads accessing the fd
> > > > > but doesn't allow it's reallocation until the close;  We perform the
> > > > > close only when we've joined all other threads that were using the fd.
> > > > > Any of the threads that do new calls on the fd get an error and quickly
> > > > > fall down their error paths.
> > > > 
> > > > Ahh that's certainly an interesting scenario. That would certainly be
> > > > a problem with the migration code when this was originally written.
> > > > It had two QEMUFile structs each with an 'int fd' field, so when you
> > > > close 'fd' on one QEMUFile struct, it wouldn't update the other QEMUFile
> > > > used by another thread.
> > > > 
> > > > Since we switched over to use QIOChannel though, I think the thread
> > > > scenario you describe should be avoided entirely. When you have multiple
> > > > QEMUFile objects, they each have a reference counted pointer to the same
> > > > underlying QIOChannel object instance. So when QEMUFile triggers a call
> > > > to qio_channel_close() in one thread, that'll set fd=-1 in the QIOChannel.
> > > > Since the other threads have a reference to the same QIOChannel object,
> > > > they'll now see this fd == -1 straightaway.
> > > > 
> > > > So, IIUC, this should make the need for shutdown() redundant (at least
> > > > for the thread race conditions you describe).
> > > 
> > > That's not thread safe unless you're doing some very careful locking.
> > > Consider:
> > >   T1                      T2       
> > >      oldfd=fd               tmp=fd
> > >      fd=-1
> > >      close(oldfd)
> > >      unrelated open()
> > >                             read(tmp,...
> > > 
> > > In practice every use of fd will be a copy into a tmp and then the
> > > syscall; the unrelated open() could happen in another thread.
> > > (OK, the gap between the tmp and the read is tiny, although if we're
> > > doing multiple operations chances are the compiler will optimise
> > > it to the top of a loop).
> > > 
> > > There's no way to make that code safe.
> > 
> > Urgh, yes, I see what you mean.
> > 
> > Currently the QIOChannelCommand implementation, uses a pair of anonymous
> > pipes for stdin/out to the child process. I wonder if we could switch
> > that to use socketpair() instead, thus letting us shutdown() on it too.
> > 
> > Though I guess it would be sufficient for qio_channel_shutdown() to
> > merely kill the child PID, while leaving the FDs open, as then you'd
> > get EOF and/or EPIPE on the read/writes.
> 
> Yes, I guess it's a question of which one is more likely to actually
> kill the exec child off; the socketpair is more likely to cause the
> source side migration code to cancel cleanly, although a kill -9 
> should sort out a wayward exec child.

I'm also curious if there's any real world performance difference between
using a pipe vs socketpair to communicate with a child process

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
