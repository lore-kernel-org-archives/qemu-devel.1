Received: from eggs.gnu.org ([2001:4830:134:3::10]:52062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PW1-0007S4-7X
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PVz-0003d7-Uy
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:27:25 -0400
Date: Fri, 20 Apr 2018 08:27:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180420062718.GC4078@localhost.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
	<20180419091832.GB2730@work-vm>
	<20180420032138.GF10319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline
In-Reply-To: <20180420032138.GF10319@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.04.2018 um 05:21 hat Stefan Hajnoczi geschrieben:
> On Thu, Apr 19, 2018 at 10:18:33AM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Linux posix_fadvise(POSIX_FADV_DONTNEED) invalidates pages*.  Use
> > > this to drop page cache on the destination host during shared storage
> > > migration.  This way the destination host will read the latest copy of
> > > the data and will not use stale data from the page cache.
> > >=20
> > > The flow is as follows:
> > >=20
> > > 1. Source host writes out all dirty pages and inactivates drives.
> > > 2. QEMU_VM_EOF is sent on migration stream.
> > > 3. Destination host invalidates caches before accessing drives.
> > >=20
> > > This patch enables live migration even with -drive cache.direct=3Doff.
> > >=20
> > > * Terms and conditions may apply, please see patch for details.
> > >=20
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  block/file-posix.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >=20
> > > diff --git a/block/file-posix.c b/block/file-posix.c
> > > index 3794c0007a..df4f52919f 100644
> > > --- a/block/file-posix.c
> > > +++ b/block/file-posix.c
> > > @@ -2236,6 +2236,42 @@ static int coroutine_fn raw_co_block_status(Bl=
ockDriverState *bs,
> > >      return ret | BDRV_BLOCK_OFFSET_VALID;
> > >  }
> > > =20
> > > +static void coroutine_fn raw_co_invalidate_cache(BlockDriverState *b=
s,
> > > +                                                 Error **errp)
> > > +{
> > > +    BDRVRawState *s =3D bs->opaque;
> > > +    int ret;
> > > +
> > > +    ret =3D fd_open(bs);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "The file descriptor is not ope=
n");
> > > +        return;
> > > +    }
> > > +
> > > +    if (s->open_flags & O_DIRECT) {
> > > +        return; /* No host kernel page cache */
> > > +    }
> > > +
> > > +#if defined(__linux__)
> > > +    /* This sets the scene for the next syscall... */
> > > +    ret =3D bdrv_co_flush(bs);
> > > +    if (ret < 0) {
> > > +        error_setg_errno(errp, -ret, "flush failed");
> > > +        return;
> > > +    }
> > > +
> > > +    /* Linux does not invalidate pages that are dirty, locked, or mm=
apped by a
> > > +     * process.  These limitations are okay because we just fsynced =
the file,
> > > +     * we don't use mmap, and the file should not be in use by other=
 processes.
> > > +     */
> > > +    ret =3D posix_fadvise(s->fd, 0, 0, POSIX_FADV_DONTNEED);
> >=20
> > What happens if I try a migrate between two qemu's on the same host?
> > (Which I, and avocado, both use for testing; I think think users
> > occasionally do for QEMU updates).
>=20
> The steps quoted from the commit description:
>=20
>   1. Source host writes out all dirty pages and inactivates drives.
>   2. QEMU_VM_EOF is sent on migration stream.
>   3. Destination host invalidates caches before accessing drives.
>=20
> When we reach Step 3 the source QEMU is not doing I/O (no pages are
> locked).  The destination QEMU does bdrv_co_flush() so even if pages are
> still dirty (that shouldn't happen since the source already drained and
> flushed) they will be written out and pages will be clean.  Therefore
> fadvise really invalidates all resident pages.
>=20
> FWIW when writing this patch I tested with both QEMUs on the same host.

Which is actually unnecessary overhead on localhost because the local
kernel page cache can't be incoherent with itself. But I don't think
it's a real problem either.

Kevin

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa2YhGAAoJEH8JsnLIjy/WNGgQAK6JSY2fhpIt9RUOp429yURN
5nc7Nn8OzjYBRJyJ1Xj+dCjFCTOn0AygfvYp/7tJFyw1GCd37y3dtJKXqI+uTSAr
k2FxgZCAXLzp3CQiZHXE/Ul40R1Il0i9mkBB1l73kcWNfj2GcRg02Ve5A+mYShuM
kYZhy1bPdy9qqik/jKx1YQy6NYBxFiYG5rlqTVdIDdtkmH+PZXkMcOHmDgg5XUJW
qCz4f0RxuL2SEl9prZ8z2S9r2k+F08/R0NnytVo8m4p11I2rsGVHaKabf0K8gmYT
j86jMVccMEPRJ9EYSuXJOXC7K6Nahj6fF1vucJoxk80qfu8/y74Q9Mt6MkFTjP7z
uW48xWCpgcU9TaGG9R7jGcgD9NrNcg2Z5HGSCWoVXsGUmgoUUpEYT9uS+WL0TCwp
2O52pqWcwpzY/kdrgMOn8YRrLTk71PoSoiWTI35MoFFtPvzCCkDM4H8gK+6ktV2E
w3kN7BjTwsPFQHVXdk0+XauBDrJ2wYj+e2XmgkueQY0qH0d95hz6s8+1WmFmDQ86
rpAjxTszF9G9nTod4cjtfRKT5zckDBr72m05Y7DxwTLiEoO/H2oGQ78cejSdZVjn
Py/4sdF56rF1tTT2YKDV7c6J+TExyqVFxYmZS647hya9fVMpro+u50c+zNIJUIai
xLeILb4Lr/OIpRgd0HWR
=qeU0
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
