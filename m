Received: from eggs.gnu.org ([2001:4830:134:3::10]:48817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86LP-0005TB-FA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86LO-0005fg-E6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:42:31 -0400
Date: Tue, 9 May 2017 10:42:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170509144220.GD16825@stefanha-x1.localdomain>
References: <1493971429-10441-1-git-send-email-lidongchen@tencent.com>
	<20170508205401.GA23989@stefanha-x1.localdomain>
	<CAOGPPbfukP450k2CaC6sEiFfca2DQ1OqMGSvZgwOvXr9WUGXaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <CAOGPPbfukP450k2CaC6sEiFfca2DQ1OqMGSvZgwOvXr9WUGXaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] migration/block: move
 bdrv_is_allocated() into bb's AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, Lidong Chen <lidongchen@tencent.com>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 08:59:30PM +0800, 858585 jemmy wrote:
> On Tue, May 9, 2017 at 4:54 AM, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> > On Fri, May 05, 2017 at 04:03:49PM +0800, jemmy858585@gmail.com wrote:
> >> From: Lidong Chen <lidongchen@tencent.com>
> >>
> >> when block migration with high-speed, mig_save_device_bulk hold the
> >> BQL and invoke bdrv_is_allocated frequently. This patch moves
> >> bdrv_is_allocated() into bb's AioContext. It will execute without
> >> blocking other I/O activity.
> >>
> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> ---
> >>      v4 changelog:
> >>           Use the prototype code written by Stefan and fix some bug.
> >>           moves bdrv_is_allocated() into bb's AioContext.
> >> ---
> >>  migration/block.c | 48 +++++++++++++++++++++++++++++++++++++++-------=
--
> >>  1 file changed, 39 insertions(+), 9 deletions(-)
> >
> > Added Paolo because he's been reworking AioContext and locking.
> >
> > The goal of this patch is to avoid waiting for bdrv_is_allocated() to
> > complete while holding locks.  Do bdrv_is_allocated() in the AioContext
> > so event processing continues after yield.
>=20
> Hi Paolo:
>     Some information about the problem.

Lidong, please see my comment below:

> >> @@ -274,17 +298,23 @@ static int mig_save_device_bulk(QEMUFile *f, Blk=
MigDevState *bmds)
> >>      int nr_sectors;
> >>
> >>      if (bmds->shared_base) {
> >> +        AioContext *bb_ctx;
> >> +        Coroutine *co;
> >> +        MigNextAllocatedClusterData data =3D {
> >> +            .cur_sector =3D &cur_sector,
> >> +            .total_sectors =3D &total_sectors,
> >> +            .bb =3D bb,
> >> +        };
> >> +        qemu_event_init(&data.event, false);
> >> +
> >>          qemu_mutex_lock_iothread();
> >> -        aio_context_acquire(blk_get_aio_context(bb));
> >> -        /* Skip unallocated sectors; intentionally treats failure as
> >> -         * an allocated sector */
> >> -        while (cur_sector < total_sectors &&
> >> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
> >> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sector=
s)) {
> >> -            cur_sector +=3D nr_sectors;
> >> -        }
> >> -        aio_context_release(blk_get_aio_context(bb));
> >> +        bdrv_inc_in_flight(blk_bs(bb));
> >
> > Please add a comment explaining why bdrv_inc_in_flight() is invoked.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEdVMAAoJEJykq7OBq3PIZbkIAMIyuio1g/WXi5qFFyVjfQBY
pBXSwq7+C+dxmvDmx1LHTOJiPNAClhuihDtIcjn+gzrxxMXjRxO163YkEb4f7YCL
bO3EE046ly9arceSBAAYdwJyb313oY5hHpBeL0KjHlfamAJRZtlXL105PmC+kUqC
b7WGBJ1Q6k5ytMnfoPC6eFgea00noNc2YWt6SS+Xmi6S2wBcG4qK9PZcj4gGZVqk
V06gFPnukqAeIAsZBT57WQ9m2cmhJDK7tvg4iKuS2dSYrFKM7FNWB5nA3+NojTa1
RAFG9xGpkMDco5J2VANAf/P8KiwLVmRdjvt/n95yuPege2TO6IHq8tGfFjptYQk=
=bhMr
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
