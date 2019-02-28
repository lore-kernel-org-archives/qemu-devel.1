Received: from eggs.gnu.org ([209.51.188.92]:51453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gzKnu-0001oX-Rj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gzKns-0007lK-Ri
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gzKnl-0007af-El
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:41 -0500
Date: Thu, 28 Feb 2019 12:28:22 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190228122822.GD4970@work-vm>
References: <20190227164900.16378-1-dgilbert@redhat.com>
	<20190228062803.GA7471@xz-x1> <20190228114019.GB4970@work-vm>
	<20190228120103.GD9217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190228120103.GD9217@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Feb 28, 2019 at 11:40:19AM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Wed, Feb 27, 2019 at 04:49:00PM +0000, Dr. David Alan Gilbert (g=
it) wrote:
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >=20
> > > > Currently we cleanup the migration object as we exit main after t=
he
> > > > main_loop finishes; however if there's a migration running things
> > > > get messy and we can end up with the migration thread still tryin=
g
> > > > to access freed structures.
> > > >=20
> > > > We now take a ref to the object around the migration thread itsel=
f,
> > > > so the act of dropping the ref during exit doesn't cause us to lo=
se
> > > > the state until the thread quits.
> > > >=20
> > > > Cancelling the migration during migration also tries to get the t=
hread
> > > > to quit.
> > > >=20
> > > > We do this a bit earlier; so hopefully migration gets out of the =
way
> > > > before all the devices etc are freed.
> > >=20
> > > So does it mean that even with the patch it's still possible the
> > > migration thread will be accessing device structs that have already
> > > been freed which can still crash QEMU?
> >=20
> > Possibly yes; I'm not sure how to go to the next stage and stop that
> > case; the consensus seems to be we don't want to explicitly block
> > during the exit process, so doing a join on the migration thread does=
n't
> > seem to be wanted.
>=20
> Essentially the many  *_cleanup() calls at the end of main() in vl.c
> are only ever safe if all background threads have stopped using the
> resources that are being freed. This isn't the case with migration
> currently. I also worry about other threads that might be running
> in QEMU, SPICE in particular as it touchs many device backends.
>=20
> Aborting the migration & joining the migration threads is the natural
> way to address this. Cancelling appears to require the main loop to
> still be running, so would require main_loop_should_exit() to issue
> the cancel & return false unless it has completed. This would delay
> shutdown for as long as it takes migration to abort.

ish - cancelling performs a shutdown(2) on the fd, that should be enough
in most cases to kick the migration thread into falling out without
main loop interaction; I think...

> FWIW, even the bdrv_close_all() call during shutdown can delay things
> for a considerable time if draining the backends isn't a quick op,
> which could be the case if there are storage problems (blocked local
> I/O, or interrupted network - rbd/ceph/nfs clients). So I'm not sure
> that stopping migration is inherantly worse than what's already
> possible with block cleanup, in terms of delaying things.
>=20
> A slightly more hacky approach would be to pthread_cancel() all the
> migration threads. Normally we'd never use pthread_cancel() as it
> is incredibly hard to ensure all memory used by the threads is
> freed. Since we're about to exit the process though, this cleanup
> does not matter. The risk, however, is that one of the threads is
> holding a mutex which then blocks the rest of the *cleanup functions,
> so this still feels dangerous.
>=20
> Overall to me a clean cancel & join of the migration threads feels
> like the only safe option, unless we just remove all notion of
> cleanup from QEMU & delete all the _cleanup functions in main()
> and let the OS free all memory.

That's actually my preference; I think trying to do clean tidy ups
here is very racy and doesn't gain much.  However, for things like
storage there may be locks that have to be properly dropped and
bitmaps and things to be stored/sync'd - so just exiting probably
isn't safe either.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
