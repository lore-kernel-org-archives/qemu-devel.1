Received: from eggs.gnu.org ([209.51.188.92]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGlrO-0005FY-Qe
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGlrN-0003pG-PK
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 10:48:26 -0400
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
	<20190417100929.39943-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
Date: Wed, 17 Apr 2019 09:48:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190417100929.39943-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, fam@euphon.net, den@virtuozzo.com, mreitz@redhat.com,
 stefanha@redhat.com
Message-ID: <dd1f30c4-e6ab-6481-ae34-412fa8533a5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/io: bdrv_pdiscard: support int64_t
 bytes parameter
References: <20190417100929.39943-1-vsementsov@virtuozzo.com>
 <20190417100929.39943-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190417100929.39943-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/17/19 5:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> This fixes at least one overflow in qcow2_process_discards.

It's worth calling out how long the problem of passing >2G discard
requests has been present (my reply to the cover letter tracked down
0b919fae as tracking a 64-bit discard region but passing it to
bdrv_discard() which took an int sectors; I'm not sure if later changes
to byte-based rather than sector-based made a difference).


> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry=
(void *opaque)
>      aio_wait_kick();
>  }
> =20
> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, in=
t bytes)
> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> +                                  int64_t bytes)
>  {
>      BdrvTrackedRequest req;
>      int max_pdiscard, ret;
>      int head, tail, align;
>      BlockDriverState *bs =3D child->bs;
> =20
> -    if (!bs || !bs->drv) {
> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {

This change seems unrelated? Oh, it's because you are inlining the rest
of what bdrv_check_byte_request used to do.

>          return -ENOMEDIUM;
>      }
> =20
> @@ -2679,9 +2680,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *chil=
d, int64_t offset, int bytes)
>          return -EPERM;
>      }
> =20
> -    ret =3D bdrv_check_byte_request(bs, offset, bytes);
> -    if (ret < 0) {
> -        return ret;

If we keep this call in place, we can flag if there were any other
callers that were passing truncated 64-bit quantities. But I also agree
that now that we are switching to a 64-bit interface, we no longer have
to check whether callers were properly limiting their requests.

Hmm - I just realized that bdrv_check_byte_request() takes a size_t
(rather than int64_t) size argument - could this result in any other
truncations on a 32-bit platform that don't affect 64-bit platforms?

> @@ -2711,12 +2711,13 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *ch=
ild, int64_t offset, int bytes)
>          goto out;
>      }
> =20
> -    max_pdiscard =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard,=
 INT_MAX),
> +    max_pdiscard =3D QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_pdiscard,=

> +                                                BDRV_REQUEST_MAX_BYTES=
),
>                                     align);

This change is a no-op, since BDRV_REQUEST_MAX_BYTES is already INT_MAX
aligned down to sector size, and align is at least sector size.

>      assert(max_pdiscard >=3D bs->bl.request_alignment);
> =20
>      while (bytes > 0) {
> -        int num =3D bytes;
> +        int64_t num =3D bytes;
> =20
>          if (head) {
>              /* Make small requests to get to alignment boundaries. */
> @@ -2778,7 +2779,7 @@ out:
>      return ret;
>  }
> =20
> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes)
>  {
>      Coroutine *co;
>      DiscardCo rwco =3D {
>=20

I'm not sure the patch is perfect, but I definitely agree that we want
to support 64-byte discard length (where the block layer fragments the
request as needed) rather than the current 32-byte discard length (where
callers have to be careful to not suffer from truncation).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly3PLEACgkQp6FrSiUn
Q2oy6AgAo5cCga5p/j860/OxocJuLIHml0oQlrDTCx2+WTmJVEEW1gidAfmISRRe
VOkvSIKSmK9Yur91GOVjL0Oa2Yb2SlnIBxw0kiGuVi11C6JxWDWNPZRvoKwkaXIb
4wov68M0Elrj9gaPlO5iRIbkJqj4VJuSeyQVPccL+6XmohUroBgTKwgENyOQNAzO
Pau3zNes/Vy77gUOm6Kro28rEg46GlOOcaPhsxYoERwc2jXSyHGa2IFdLIEoenQ2
eln1Z4iDQ6DPM5MFKkrVRld2mdnoOTfLvRw8IxQWKzmtnM2FI+BfqOgsxfY/f2xy
atfXVqPVdI0bKusLeO0guYJnpG8m2A==
=gbF3
-----END PGP SIGNATURE-----

--Il8CR8COfxCetBk0W7SE0XdQMkisZjfL4--
