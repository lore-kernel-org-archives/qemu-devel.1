Received: from eggs.gnu.org ([209.51.188.92]:58268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9Hy-0005VL-Cr
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9Hx-0003H8-Hc
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:37:58 -0400
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Date: Mon, 29 Apr 2019 18:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190402153730.54145-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JXdF4KU0CfyKBVC4L3MRCZcbyEEsggoWF"
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JXdF4KU0CfyKBVC4L3MRCZcbyEEsggoWF
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Subject: Re: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
> Background: decryption will be done in threads, to take benefit of it,
> we should move it out of the lock first.

=2E..which is safe after your commit c972fa123c73501b4, I presume.

(At first glance, the patched looked a bit weird to me because it
doesn't give a reason why dropping the lock around
qcrypto_block_decrypt() would be OK.)

> But let's go further: it turns out, that for locking around switch
> cases we have only two variants: when we just do memset(0) not
> releasing the lock (it is useless) and when we actually can handle the
> whole case out of the lock. So, refactor the whole thing to reduce
> locked code region and make it clean.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 46 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 46e8e39da5..fcf92a7eb6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriv=
erState *bs, uint64_t offset,
> =20
>          ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &clus=
ter_offset);

Isn't this the only function in the loop that actually needs the lock?
Wouldn't it make more sense to just take it around this call?

Max

>          if (ret < 0) {
> +            qemu_co_mutex_unlock(&s->lock);
>              goto fail;
>          }
> =20


--JXdF4KU0CfyKBVC4L3MRCZcbyEEsggoWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHKF0ACgkQ9AfbAGHV
z0A+9QgAtIBFhVDZ5ETQW6JEvtyg7d89UEJ2DNsQYi3I1TRq17mjE2AByIikcMgv
yfiMRh5k9IHjMq4296Ilsu5ijwswPtMIgwDFcDVe5MyH/HeexICVT3J0eWbS3kZ8
sdYJQRTTMAaKl2yS5CrxCqiOup1CtT//71Hk5w4CvYHaAejQPpqgEc4IdCb07jCr
ThhAFueMelTBl7Rhx5bKT7MgNwlG7GiYshTlyGDUSyTSEdK+Tahdxi5JAREkyG5L
/6C+69sk+UQe6JIZ10W7072NXItcCs0fZZh6eDFrFJYnzY6FYuGy/AyS0I02kk3B
RibeNLKZdFpBpAyuElIjazFYdC0wDQ==
=YJY7
-----END PGP SIGNATURE-----

--JXdF4KU0CfyKBVC4L3MRCZcbyEEsggoWF--
