Received: from eggs.gnu.org ([2001:4830:134:3::10]:58715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj5Ip-0006GE-TD
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj5Io-0008Dl-Sh
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:04:43 -0400
Date: Sat, 19 Aug 2017 18:02:42 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170819150242.xk3l4zfiwytzljxq@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<01b7212cc910cea55e4a1ac8d4704afaff0647b4.1502979710.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7sboqbmhmyzcbuv"
Content-Disposition: inline
In-Reply-To: <01b7212cc910cea55e4a1ac8d4704afaff0647b4.1502979710.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--z7sboqbmhmyzcbuv
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 05:28:15PM +0300, Alberto Garcia wrote:
>Both the throttling limits set with the throttling.iops-* and
>throttling.bps-* options and their QMP equivalents defined in the
>BlockIOThrottle struct are integer values.
>
>Those limits are also reported in the BlockDeviceInfo struct and they
>are integers there as well.
>
>Therefore there's no reason to store them internally as double and do
>the conversion everytime we're setting or querying them, so this patch
>uses int64_t for those types.
>
>LeakyBucket.level and LeakyBucket.burst_level do however remain double
>because their value changes depending on the fraction of time elapsed
>since the previous I/O operation.
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

> include/qemu/throttle.h | 4 ++--
> util/throttle.c         | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
>index 66a8ac10a4..c466f6ccaa 100644
>--- a/include/qemu/throttle.h
>+++ b/include/qemu/throttle.h
>@@ -77,8 +77,8 @@ typedef enum {
>  */
>
> typedef struct LeakyBucket {
>-    double  avg;              /* average goal in units per second */
>-    double  max;              /* leaky bucket max burst in units */
>+    int64_t avg;              /* average goal in units per second */
>+    int64_t max;              /* leaky bucket max burst in units */
>     double  level;            /* bucket level in units */
>     double  burst_level;      /* bucket level in units (for computing bur=
sts) */
>     unsigned burst_length;    /* max length of the burst period, in secon=
ds */
>diff --git a/util/throttle.c b/util/throttle.c
>index 1f29cf9918..55a2451a14 100644
>--- a/util/throttle.c
>+++ b/util/throttle.c
>@@ -106,13 +106,13 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
>         /* If bkt->max is 0 we still want to allow short bursts of I/O
>          * from the guest, otherwise every other request will be throttled
>          * and performance will suffer considerably. */
>-        bucket_size =3D bkt->avg / 10;
>+        bucket_size =3D (double) bkt->avg / 10;
>         burst_bucket_size =3D 0;
>     } else {
>         /* If we have a burst limit then we have to wait until all I/O
>          * at burst rate has finished before throttling to bkt->avg */
>         bucket_size =3D bkt->max * bkt->burst_length;
>-        burst_bucket_size =3D bkt->max / 10;
>+        burst_bucket_size =3D (double) bkt->max / 10;
>     }
>
>     /* If the main bucket is full then we have to wait */
>--=20
>2.11.0
>
>

--z7sboqbmhmyzcbuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmYUxIACgkQc2J8L2kN
9xCvqw/+PMH1FvK9nqTjyS98DvVTYSwtx2l5WTrKwWfkto42RSArbBuMo4SDf2tI
C7DS2jfrZvGaTrbA0F2SghMS1OHu7Sk/PxvS0Dnhmth/J7jikfOzd6YiWsaZGDSr
V3ong1Zcu/6i5cOyMZ94R6PYEDeN119tsWPpOSTFACYoAWH6dEX3dVQKmexEvZRQ
O8yWkDKnyqUiCU3P4dudSq/eoPJVAYdiqg2zPXiWnyiH1HAOOquYIN57hh70Z6O+
2thoQ2DWfu5PFsDza5ntzATgc+9wJ58i9ue95FAbzYUkUISCRGPEqPjXH7vx93MF
czE08DT3ZJms2yjoZsncbgr06IkJMlD3jiBIsx5uP1CdqG5vvkEPX7q1WR4SAy6l
RId92FkKqJyRWmzZQE80uLlDgK2BUKMOQNSJWq6Ex99sw84g4KdhjWfsK2XvHNhb
XmBbFx9inWd8aBRYe02CznxMOAL2sJEv4jqSjfpEc9gBlEiIQ2lKeIQt05dgJ9N5
bYUB9rH2mEafaPy/v6bYZNJKd077MQQ8B5KofaxQ7Pqgp2LmrYFn4wa6bJApEpKo
RixHM3lz1pBtzAFo9ZfwJ2wQzb6PnfmimrP+NSmUAsm2Fj405FOZws6nDsqHu9+F
dpPX76lk9rlA1WtZIeK+wih61W6VsZzJs7NbuSt1B4IkM4GUXMk=
=jJBa
-----END PGP SIGNATURE-----

--z7sboqbmhmyzcbuv--
