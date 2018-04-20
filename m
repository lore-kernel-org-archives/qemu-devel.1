Received: from eggs.gnu.org ([2001:4830:134:3::10]:35475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9Mca-0002MG-ON
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9McZ-0008Mj-Mk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:22:00 -0400
Date: Fri, 20 Apr 2018 11:21:38 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180420032138.GF10319@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
	<20180419091832.GB2730@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <20180419091832.GB2730@work-vm>
Subject: Re: [Qemu-devel] [RFC 1/2] block/file-posix: implement
 bdrv_co_invalidate_cache() on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:18:33AM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Linux posix_fadvise(POSIX_FADV_DONTNEED) invalidates pages*.  Use
> > this to drop page cache on the destination host during shared storage
> > migration.  This way the destination host will read the latest copy of
> > the data and will not use stale data from the page cache.
> >=20
> > The flow is as follows:
> >=20
> > 1. Source host writes out all dirty pages and inactivates drives.
> > 2. QEMU_VM_EOF is sent on migration stream.
> > 3. Destination host invalidates caches before accessing drives.
> >=20
> > This patch enables live migration even with -drive cache.direct=3Doff.
> >=20
> > * Terms and conditions may apply, please see patch for details.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/file-posix.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >=20
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index 3794c0007a..df4f52919f 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -2236,6 +2236,42 @@ static int coroutine_fn raw_co_block_status(Bloc=
kDriverState *bs,
> >      return ret | BDRV_BLOCK_OFFSET_VALID;
> >  }
> > =20
> > +static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *bs,
> > +                                                 Error **errp)
> > +{
> > +    BDRVRawState *s =3D bs->opaque;
> > +    int ret;
> > +
> > +    ret =3D fd_open(bs);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "The file descriptor is not open"=
);
> > +        return;
> > +    }
> > +
> > +    if (s->open_flags & O_DIRECT) {
> > +        return; /* No host kernel page cache */
> > +    }
> > +
> > +#if defined(__linux__)
> > +    /* This sets the scene for the next syscall... */
> > +    ret =3D bdrv_co_flush(bs);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "flush failed");
> > +        return;
> > +    }
> > +
> > +    /* Linux does not invalidate pages that are dirty, locked, or mmap=
ped by a
> > +     * process.  These limitations are okay because we just fsynced th=
e file,
> > +     * we don't use mmap, and the file should not be in use by other p=
rocesses.
> > +     */
> > +    ret =3D posix_fadvise(s->fd, 0, 0, POSIX_FADV_DONTNEED);
>=20
> What happens if I try a migrate between two qemu's on the same host?
> (Which I, and avocado, both use for testing; I think think users
> occasionally do for QEMU updates).

The steps quoted from the commit description:

  1. Source host writes out all dirty pages and inactivates drives.
  2. QEMU_VM_EOF is sent on migration stream.
  3. Destination host invalidates caches before accessing drives.

When we reach Step 3 the source QEMU is not doing I/O (no pages are
locked).  The destination QEMU does bdrv_co_flush() so even if pages are
still dirty (that shouldn't happen since the source already drained and
flushed) they will be written out and pages will be clean.  Therefore
fadvise really invalidates all resident pages.

FWIW when writing this patch I tested with both QEMUs on the same host.

Stefan

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2VzCAAoJEJykq7OBq3PIIYMIAJEIfqmLVIbOCEDQ2SuDj7x6
7XcOdAScNwYYVrVO9EARYttQnUrKKON2PD6ST1dHLKr/uI9lLqKlmwO+cZKiv6z+
imW2nd7Lf8F/GX5mwmENMaPsRV7BmpVOUQGgO0PEhqZ8zdbNf599pD7ldUsp0j6S
nSgczNqWo6b1AGwO9WlYtmSg0QuZmfNTV9nFTFEXawUtySP9q8Rod6mMOYqoBEyS
N+vnoUQWIDkdRxY6M2Q4NIDfwx8jSEVlIAXO50GMxd6zwxC0Rikrhzc0RPdeD+iF
FgVsPGbWU4XJSM8cH2IMWg8ktXWZh9ENVX/bLlAOxyarQqCcgUV6fY/gCR84LzU=
=XH4m
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
