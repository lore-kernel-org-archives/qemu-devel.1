Received: from eggs.gnu.org ([2001:4830:134:3::10]:45805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PJA-0002Fn-2z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f9PJ8-00020S-Tj
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:14:08 -0400
Date: Fri, 20 Apr 2018 08:13:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180420061358.GA4078@localhost.localdomain>
References: <20180419075232.31407-1-stefanha@redhat.com>
	<20180419075232.31407-2-stefanha@redhat.com>
	<20180419081344.GA14514@lemon.usersys.redhat.com>
	<20180420031508.GE10319@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20180420031508.GE10319@stefanha-x1.localdomain>
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
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 20.04.2018 um 05:15 hat Stefan Hajnoczi geschrieben:
> On Thu, Apr 19, 2018 at 04:13:44PM +0800, Fam Zheng wrote:
> > On Thu, 04/19 15:52, Stefan Hajnoczi wrote:
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
> > > +    if (ret !=3D 0) { /* the return value is a positive errno */
> > > +        error_setg_errno(errp, ret, "fadvise failed");
> > > +        return;
> > > +    }
> > > +#endif /* __linux__ */
> >=20
> > What about the #else branch? It doesn't automatically work, I guess?
>=20
> Right, no error is reported.  This is existing QEMU behavior.
>=20
> If we want to change behavior then it must be done consistently (i.e. by
> auditing the other block drivers) and we need to be prepared for bug
> reports (just like file locking, it may expose interesting use cases
> that we cannot easily dismiss as wrong).  I didn't want to go there.
>=20
> If there is consensus then I will change the behavior.

I think either way that would be for a separate patch.

I'm also not sure how useful that change would actually be because it
might give you a false sense of safety: Even with this patch, you still
need to be exactly aware of the conditions that make live migration with
shared storage work correctly. If we error out on some unsafe cases,
but not on others, this might be confusing.

On the other hand, the problematic image format drivers have been
setting migration blockers for a long time, so you could also argue that
file-posix is inconsistent with them because it completely ignores
unsafe scenarios.

Kevin

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJa2YUmAAoJEH8JsnLIjy/WlCEP/0+60pQGpgk89zYAmvcvYCH5
SHo4MyPwnTTbRVm8hfZYvfSGK2Dquf/cq/plBZRwRrJgBrv6s5XQZ28FeJ/aC+Mo
r6HPqvzl4SrFmHBbFKe9V3jwRXaoj8vYJ2N62yIapRL6egeZ+Hd/+8maiaSJtMk9
0D5HQJ8EuvbItLVEE7FfQk09d0fLbqL1UpYSJqnRukCpN3ZsdwZV1+OENxqNEf/O
cox7fX9xtFZHnOsMlOYKhUhmu9VJCXxmEbaW0tfhpaqd6PYy11nd+Sal5VCqubxE
6VQlQHz0N+JKKp+HwIKbc6Ugq43a7gy4ihvil2DaBxRzMkZqpV7luhd4K1Lw5eUA
+CMKNjKBKmDiFAC4Fzl5wgX3qU6MGDQRn/252dIbe1t9CaTx+7K+YC2XmfoI49Gf
sI01PwLSGftsbI7dCgagj5IesITpHDkSc4+SyTMd4jYcVAr2/ds0OQOxp94QdODK
7TDLaUvz7C6T9Z+z2VF8tZQNsHH+pbXQmrc/IOie+feOebJI1AcFVc+eoT9ajPuB
rFtQ2DLHAFaohK/HqofzGMu5Hu7Krfbx9kQNGvHf/H1LRQInkuxBxxabdIFRRhwx
2AN8x7RPXTpIAQzZh8A67IokBvX/nUm3BkzvoJXULEd0kmw+WKCP8710M4lLNNo9
Yxdeg7VIF6qyttnMyFLk
=tJW+
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
