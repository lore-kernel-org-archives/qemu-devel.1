Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6abg-0001P5-Qr
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6abd-0006HH-Lf
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:04 -0400
Date: Fri, 5 May 2017 11:36:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505103658.GB11350@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-17-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/17] block: protect
 modification of dirty bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:57PM +0200, Paolo Bonzini wrote:
> @@ -410,6 +442,18 @@ int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBi=
tmap *bitmap,
>      }
>  }
> =20
> +int bdrv_get_dirty(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
> +                   int64_t sector)

Is it a good idea to offer an unlocked bdrv_get_dirty() API?  It
encourages non-atomic access to the bitmap, e.g.

  if (bdrv_get_dirty()) {
      ...do something outside the lock...
      bdrv_reset_dirty_bitmap();
  }

The unlocked API should be test-and-set/clear instead so that callers
automatically avoid race conditions.

> diff --git a/block/mirror.c b/block/mirror.c
> index dc227a2..6a5b0f8 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -344,10 +344,12 @@ static uint64_t coroutine_fn mirror_iteration(Mirro=
rBlockJob *s)
> =20
>      sector_num =3D bdrv_dirty_iter_next(s->dbi);
>      if (sector_num < 0) {
> +        bdrv_dirty_bitmap_lock(s->dirty_bitmap);

bdrv_dirty_iter_next() is listed under "functions that require manual
locking" but it's being called outside of the lock.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDFXKAAoJEJykq7OBq3PI2boH/1K6qZURXCqPUQi6aobD4dgj
GlFWOxnRPvePGylDFB1RGczIjrKUm1dRJinfCNbjc/Ph1XQnwSHNlzheXBi+UtgU
g5upqgWe88noKuIkgXHBlq+oSh6TYXZ3ykM3YrSc/Y5B5OHYaGqdMX0gQHdr+PtH
BwrFR6wEHbW52JZq3hTRhYnLDHy+lTUkS5xFDU/2KlhWnm0Zi95SdYK3OtKB1jCe
SmuHBn7w+xUip7F4AdgIUR7y7vaM2wLHst45/nbrgYsIwEGK2DTE7Qp6gYKjLB/+
iiotxRfvA7lJwJm7ZsonMGEfIQCv50c7bNnpWamXbFdLK25D9GudhW/sNpgATa4=
=9C5B
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
