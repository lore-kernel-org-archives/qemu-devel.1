Received: from eggs.gnu.org ([2001:4830:134:3::10]:57168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2VWw-0008FS-0Y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e2VWs-0002nu-TT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:55:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e2VWs-0002mx-KE
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 00:55:30 -0400
Date: Thu, 12 Oct 2017 12:55:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171012045524.GA30901@pxdev.xzpeter.org>
References: <ea8f7d8d-9f07-517f-68cd-bdc87b900fa4@oracle.com>
	<20171011173656.GD2253@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171011173656.GD2253@work-vm>
Subject: Re: [Qemu-devel] QEMU migration cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Jag Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org, quintela@redhat.com, Karl Heubaum <karl.heubaum@oracle.com>, Sunit Jain <sunit.jain@oracle.com>

On Wed, Oct 11, 2017 at 06:36:56PM +0100, Dr. David Alan Gilbert wrote:
> * Jag Raman (jag.raman@oracle.com) wrote:
> > Hi,
> 
> Hi Jag,

(Yet another Hi From Peter :)

> 
> > I'd like to check about the behavior of a QEMU instance when live
> > migration is cancelled.
> > 
> > If the migration of a guest OS from source QEMU instance to destination
> > instance is cancelled, the destination instance exits with a failure
> > code. Could you please explain why this design decision was taken?
> 
> There isn't really any communication of the cancellation - the source
> just stops, and the destination is left to conclude it's got an
> incomplete migration instance.
> 
> > I'm wondering if it's OK to change the behavior of the destination
> > instance in this case. Would it be OK for the destination instance to
> > not exit with the failure code, and instead retry processing incoming
> > migration? I'm dealing with an internal bug report that's asking whether
> > it would make more sense for the destination process to hang around for
> > another attempt at migration than to be killed.
> 
> Can you explain why you'd want that to happen in the case of a
> cancellation? I can see why you might want to do it in the event of
> a network failure (which is the case Peter is dealing with for
> postcopy);  but why after a cancellation?

Yes, I would ask the same question.

Allowing the migration to be able to reconnect is a feature that needs
extra work (that's why I worked on the postcopy recovery for sure), so
IMHO we need explicit and good reason to have such extra logic.

For postcopy, if network failure happens, it has its good reason since
it crashes the VM (VM got split brain after that).  AFAIU that's the
only reason why we need the "postcopy recover" thing.

For precopy, if network failure happens, we don't really lose the VM
(since the states are still all complete on source side). So we can
just restart a migration if we want a reconnect to happen.  The only
defect is that we need to re-transfer the data that we may have
already transferred.  But I really don't think that's a big problem
especially if the network failure is very rare.

> 
> > We came across Peter's planned changes to migration postcopy[1] which
> > indicate that migration-cancellation is planned to be enhanced during
> > the postcopy phase. Are there any such enhancements planned for the
> > active phase as well?
> 
> Not planned; as far as I know this is the first time anyone has asked
> for it;  it's probably possible to reuse some of Peter's code for it.
> Essentially you have many of the same problems, in particular you don't
> quite know how much of the data sent was actually received by the
> destination (hmm I wonder if we can modify Peter's code to allow it
> before it goes in :-)

I hope not, for now. :-)

I have had assumptions on postcopy in the series (though I cannot
really tell immediately now since I have forgotten some of the
details). I did think about making it general for both precopy and
postcopy when starting, but I must have encountered something awkward,
then I took the assumption after some "pros and cons" comparison.

But of course I would like to know the requirements first.  If we do
have solid reasons for it and want to pursue, we may reconsider.

Thanks,

> 
> There may be some gotcha's to do with the exact point at which the
> cancellation happened (e.g. restarting after you've started serialising
> the device state may be trickier).
> 
> > I'd also like to know the difference between qemu_fclose() &
> > qemu_file_shutdown(). The source instance currently uses the shutdown
> > function to terminate the connection between source & destination. But
> > it seems to disconnect the connection abruptly. Whereas fclose function
> > seems to disconnect it more gracefully. When I dug deeper, I couldn't
> > specifically tell the difference between the two. I'd like to know if I
> > could substitute the shutdown function with fclose function in
> > migrate_fd_cancel().
> 
> close() closes the file descriptor and at that point it's no longer
> valid and could get reallocated.  So for example if another thread is still using it
> then the other thread (e.g. the migration thread) is suddenly trying to
> use a non-existing fd, even worse that fd could have been reallocated
> and it ends up writing migration data to a disk or network socket.
> As you say 'close' is graceful - the downside of that is that it waits
> to have sent all it's data and for some part of the TCP socket close
> to happen (I don't know the details).
> 
> shutdown() doesn't deallocate the fd; it just forces all operations on
> it to error and return.  The nice part of this is that if the
> networking to the destination host has broken and you have a hung
> socket, you can still perform the shutdown(), and then restart a
> migration to a different host.    With close() you might have to wait
> 10s of minutes for the TCP socket to eventually give up before erroring.
> Because it doesn't deallocate it, the migration threads just take
> the failure paths and don't do anything illegal, but just drop out
> at the end with a failed migration, whichever part of code they happened
> to have been stuck in.
> 
> Dave
> 
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05892.html
> > 
> > Thanks!
> > --
> > Jag
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
