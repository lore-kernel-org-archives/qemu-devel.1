Received: from eggs.gnu.org ([209.51.188.92]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gzf8y-000101-EZ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gzf8x-0006YR-5L
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gzf8w-0006Xj-SE
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:11:51 -0500
Date: Fri, 1 Mar 2019 10:11:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190301101141.GB2851@work-vm>
References: <20190227164900.16378-1-dgilbert@redhat.com>
	<20190228062803.GA7471@xz-x1> <20190228114019.GB4970@work-vm>
	<20190228120103.GD9217@redhat.com> <20190228122822.GD4970@work-vm>
	<20190301032718.GB7661@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190301032718.GB7661@xz-x1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Cleanup during exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Feb 28, 2019 at 12:28:22PM +0000, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> > > On Thu, Feb 28, 2019 at 11:40:19AM +0000, Dr. David Alan Gilbert wr=
ote:
> > > > * Peter Xu (peterx@redhat.com) wrote:
> > > > > On Wed, Feb 27, 2019 at 04:49:00PM +0000, Dr. David Alan Gilber=
t (git) wrote:
> > > > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > > >=20
> > > > > > Currently we cleanup the migration object as we exit main aft=
er the
> > > > > > main_loop finishes; however if there's a migration running th=
ings
> > > > > > get messy and we can end up with the migration thread still t=
rying
> > > > > > to access freed structures.
> > > > > >=20
> > > > > > We now take a ref to the object around the migration thread i=
tself,
> > > > > > so the act of dropping the ref during exit doesn't cause us t=
o lose
> > > > > > the state until the thread quits.
> > > > > >=20
> > > > > > Cancelling the migration during migration also tries to get t=
he thread
> > > > > > to quit.
> > > > > >=20
> > > > > > We do this a bit earlier; so hopefully migration gets out of =
the way
> > > > > > before all the devices etc are freed.
> > > > >=20
> > > > > So does it mean that even with the patch it's still possible th=
e
> > > > > migration thread will be accessing device structs that have alr=
eady
> > > > > been freed which can still crash QEMU?
> > > >=20
> > > > Possibly yes; I'm not sure how to go to the next stage and stop t=
hat
> > > > case; the consensus seems to be we don't want to explicitly block
> > > > during the exit process, so doing a join on the migration thread =
doesn't
> > > > seem to be wanted.
> > >=20
> > > Essentially the many  *_cleanup() calls at the end of main() in vl.=
c
> > > are only ever safe if all background threads have stopped using the
> > > resources that are being freed. This isn't the case with migration
> > > currently. I also worry about other threads that might be running
> > > in QEMU, SPICE in particular as it touchs many device backends.
> > >=20
> > > Aborting the migration & joining the migration threads is the natur=
al
> > > way to address this. Cancelling appears to require the main loop to
> > > still be running, so would require main_loop_should_exit() to issue
> > > the cancel & return false unless it has completed. This would delay
> > > shutdown for as long as it takes migration to abort.
> >=20
> > ish - cancelling performs a shutdown(2) on the fd, that should be eno=
ugh
> > in most cases to kick the migration thread into falling out without
> > main loop interaction; I think...
>=20
> Dave, could you hint me on when shutdown() will not suffice (say,
> we'll hang death if we do join() upon the migration thread)?

I think I mostly worry about when we hang in a device's migration code
or where that interacts with an external program (e.g. vhost-user).

> >=20
> > > FWIW, even the bdrv_close_all() call during shutdown can delay thin=
gs
> > > for a considerable time if draining the backends isn't a quick op,
> > > which could be the case if there are storage problems (blocked loca=
l
> > > I/O, or interrupted network - rbd/ceph/nfs clients). So I'm not sur=
e
> > > that stopping migration is inherantly worse than what's already
> > > possible with block cleanup, in terms of delaying things.
> > >=20
> > > A slightly more hacky approach would be to pthread_cancel() all the
> > > migration threads. Normally we'd never use pthread_cancel() as it
> > > is incredibly hard to ensure all memory used by the threads is
> > > freed. Since we're about to exit the process though, this cleanup
> > > does not matter. The risk, however, is that one of the threads is
> > > holding a mutex which then blocks the rest of the *cleanup function=
s,
> > > so this still feels dangerous.
> > >=20
> > > Overall to me a clean cancel & join of the migration threads feels
> > > like the only safe option, unless we just remove all notion of
> > > cleanup from QEMU & delete all the _cleanup functions in main()
> > > and let the OS free all memory.
> >=20
> > That's actually my preference; I think trying to do clean tidy ups
> > here is very racy and doesn't gain much.  However, for things like
> > storage there may be locks that have to be properly dropped and
> > bitmaps and things to be stored/sync'd - so just exiting probably
> > isn't safe either.
>=20
> I'm unsure about whether I caught the whole idea but I feel like we
> can't drop all the cleanup hooks since what if we want to do something
> else than "freeing memories"?  Or anything that the OS can't do for us
> but we want to try to do before the process quits.  If that operation
> hangs we'll probably face a similar hang issue.

Right; things like where the block code wants to ensure that
bitmaps/data structtures/buffers are saved out - you need to give them a
chance.

> Regarding pthread_cancel() - it will only work if the thread reaches
> cancellation points, right?  Then does it mean that it still cannot
> guarantee the thread will quit very soon and we still have chance that
> we'll wait forever when join()?  One major reason that the thread will
> be waiting should be the migration streams but AFAIU shutdown() (as
> Dave has mentioned) should solve this problem properly, then I'm
> unsuer how pthread_cancel() can help much comparing to shutdown()...

If I understand correctly, threads are always cancelable by default?

> My understanding (probably not correct, but I'll just speak loud...)
> is that we will never have a way to guarantee a process to quit
> cleanly all the time because there're really many things that can hang
> (I'm assuming we've already solved the MigrationState refcounting
> issue by this patch, so I'm assuming we're having a "hang QEMU" rather
> than crashing issue).  Then IMHO we could simply do whatever we can do
> to cleanup everything assuming no hang will happen, and if it really
> happens we use SIGKILL which will be the last thing we can do by which
> we might lost many things (e.g., unflushed caches in block layer) but
> we've tried our best.  For migration, it'll be (1) cancel (not
> pthread_cancel, but cancel the migration to trigger shutdown() on fds
> or whatever) (2) join thread (3) finalize/cleanup data structures.

Right so the question I think is just whether it's worth adding the join
at the moment which turns us from a small-risk of crash to small-risk of
hang.

> IMHO SIGKILL is the real de-facto solution for all these issues to me.
> And even if with SIGKILL we can still hang.... but I'll assume those
> hangs will be kernel problems not QEMU since SIGKILL should be
> designed to kill a process without a question.

Dave

> Thanks,
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
