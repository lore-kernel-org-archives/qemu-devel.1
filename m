Received: from eggs.gnu.org ([2001:4830:134:3::10]:60429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MWH-0008WT-Ik
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f9MWG-0006Ii-BI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:15:29 -0400
Date: Fri, 20 Apr 2018 11:15:08 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180420031508.GE10319@stefanha-x1.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
	<20180419081344.GA14514@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <20180419081344.GA14514@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 04:13:44PM +0800, Fam Zheng wrote:
> On Thu, 04/19 15:52, Stefan Hajnoczi wrote:
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
> > +    if (ret !=3D 0) { /* the return value is a positive errno */
> > +        error_setg_errno(errp, ret, "fadvise failed");
> > +        return;
> > +    }
> > +#endif /* __linux__ */
>=20
> What about the #else branch? It doesn't automatically work, I guess?

Right, no error is reported.  This is existing QEMU behavior.

If we want to change behavior then it must be done consistently (i.e. by
auditing the other block drivers) and we need to be prepared for bug
reports (just like file locking, it may expose interesting use cases
that we cannot easily dismiss as wrong).  I didn't want to go there.

If there is consensus then I will change the behavior.

Stefan

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2Vs8AAoJEJykq7OBq3PIpTQIAKKb12A0tXanZvijlSxYi2xD
kmQsCLaRp1ltcbBSRvNwlQ0vAvOhkJwxszqtrNSjTrJ2Huj2hwRgyp0IgR9TTj3S
wPb8IkhoCE/0GZQmqfvuQpqtWGfZwuWojJmNXzZq1hqTaOEj72NqjnhqR+1IzdTf
tI8k161SMXI3blKIFODQHz48YX5kUlDEAAFiNCeIrhDHIoIoGRXCNkeTBZX9vBPu
K9+r4cXHb1dN+/n0Ei4xVJNp8N8EhJTfkhnoC2lYwZcOqK2u63z2TAUB0pFu50fa
vuKmwTtwpTYROXxvtI27xGn3UFJt7iz7Vzq4M93hmjLLjQ1FwTowYGWdmUH0xoE=
=6yW1
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--
