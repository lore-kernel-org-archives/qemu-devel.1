Received: from eggs.gnu.org ([2001:4830:134:3::10]:33173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj5cg-0006lJ-0S
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj5ce-0005iE-Tu
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:25:14 -0400
Date: Sat, 19 Aug 2017 18:23:12 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170819152312.752zb42qc5ko6rat@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<112e28c8da085ffd59381d86f3acb0b8f75d5f9a.1502979710.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tllxusu6get6koj"
Content-Disposition: inline
In-Reply-To: <112e28c8da085ffd59381d86f3acb0b8f75d5f9a.1502979710.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] throttle: Remove throttle_fix_bucket()
 / throttle_unfix_bucket()
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


--2tllxusu6get6koj
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 05:28:14PM +0300, Alberto Garcia wrote:
>The throttling code can change internally the value of bkt->max if it
>hasn't been set by the user. The problem with this is that if we want
>to retrieve the original value we have to undo this change first. This
>is ugly and unnecessary: this patch removes the throttle_fix_bucket()
>and throttle_unfix_bucket() functions completely and moves the logic
>to throttle_compute_wait().
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>
>---
> util/throttle.c | 62 +++++++++++++++++++++-------------------------------=
-----
> 1 file changed, 23 insertions(+), 39 deletions(-)
>
>diff --git a/util/throttle.c b/util/throttle.c
>index 9a6bda813c..1f29cf9918 100644
>--- a/util/throttle.c
>+++ b/util/throttle.c
>@@ -95,23 +95,36 @@ static int64_t throttle_do_compute_wait(double limit, =
double extra)
> int64_t throttle_compute_wait(LeakyBucket *bkt)
> {
>     double extra; /* the number of extra units blocking the io */
>+    double bucket_size;   /* I/O before throttling to bkt->avg */
>+    double burst_bucket_size; /* Before throttling to bkt->max */
>
>     if (!bkt->avg) {
>         return 0;
>     }
>
>-    /* If the bucket is full then we have to wait */
>-    extra =3D bkt->level - bkt->max * bkt->burst_length;
>+    if (!bkt->max) {
>+        /* If bkt->max is 0 we still want to allow short bursts of I/O
>+         * from the guest, otherwise every other request will be throttled
>+         * and performance will suffer considerably. */
>+        bucket_size =3D bkt->avg / 10;
>+        burst_bucket_size =3D 0;

Might be wrong, but shouldn't that be
    bucket_size =3D (bkt->avg / 10) * bkt->burst_length?
    burst_bucket_size =3D (bkt->avg / 10) / 10;

>+    } else {
>+        /* If we have a burst limit then we have to wait until all I/O
>+         * at burst rate has finished before throttling to bkt->avg */
>+        bucket_size =3D bkt->max * bkt->burst_length;
>+        burst_bucket_size =3D bkt->max / 10;
>+    }
>+
>+    /* If the main bucket is full then we have to wait */
>+    extra =3D bkt->level - bucket_size;
because it used to be that if bkt->max is 0 then
 extra =3D bkt->level - (bkt->avg /10) * bkt->burst_length; //fixed value
 and now it's
 extra =3D bkt->level - (bkt->avg / 10);

 and

>     if (extra > 0) {
>         return throttle_do_compute_wait(bkt->avg, extra);
>     }
>
>-    /* If the bucket is not full yet we have to make sure that we
>-     * fulfill the goal of bkt->max units per second. */
>+    /* If the main bucket is not full yet we still have to check the
>+     * burst bucket in order to enforce the burst limit */
>     if (bkt->burst_length > 1) {
>-        /* We use 1/10 of the max value to smooth the throttling.
>-         * See throttle_fix_bucket() for more details. */
>-        extra =3D bkt->burst_level - bkt->max / 10;
>+        extra =3D bkt->burst_level - burst_bucket_size;
This used to be=20

    extra =3D bkt->burst_level - (bkt->avg / 10) / 10;
and now it's
    extra =3D bkt->burst_level  - 0;


>         if (extra > 0) {
>             return throttle_do_compute_wait(bkt->max, extra);
>         }
>@@ -358,31 +371,6 @@ bool throttle_is_valid(ThrottleConfig *cfg, Error **e=
rrp)
>     return true;
> }
>
>-/* fix bucket parameters */
>-static void throttle_fix_bucket(LeakyBucket *bkt)
>-{
>-    double min;
>-
>-    /* zero bucket level */
>-    bkt->level =3D bkt->burst_level =3D 0;
>-
>-    /* If bkt->max is 0 we still want to allow short bursts of I/O
>-     * from the guest, otherwise every other request will be throttled
>-     * and performance will suffer considerably. */
>-    min =3D bkt->avg / 10;
>-    if (bkt->avg && !bkt->max) {
>-        bkt->max =3D min;
>-    }
>-}
>-
>-/* undo internal bucket parameter changes (see throttle_fix_bucket()) */
>-static void throttle_unfix_bucket(LeakyBucket *bkt)
>-{
>-    if (bkt->max < bkt->avg) {
>-        bkt->max =3D 0;
>-    }
>-}
>-
> /* Used to configure the throttle
>  *
>  * @ts: the throttle state we are working on
>@@ -397,8 +385,10 @@ void throttle_config(ThrottleState *ts,
>
>     ts->cfg =3D *cfg;
>
>+    /* Zero bucket level */
>     for (i =3D 0; i < BUCKETS_COUNT; i++) {
>-        throttle_fix_bucket(&ts->cfg.buckets[i]);
>+        ts->cfg.buckets[i].level =3D 0;
>+        ts->cfg.buckets[i].burst_level =3D 0;
>     }
>
>     ts->previous_leak =3D qemu_clock_get_ns(clock_type);
>@@ -411,13 +401,7 @@ void throttle_config(ThrottleState *ts,
>  */
> void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg)
> {
>-    int i;
>-
>     *cfg =3D ts->cfg;
>-
>-    for (i =3D 0; i < BUCKETS_COUNT; i++) {
>-        throttle_unfix_bucket(&cfg->buckets[i]);
>-    }
> }
>
>
>--=20
>2.11.0
>
>

--2tllxusu6get6koj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmYV+AACgkQc2J8L2kN
9xDV5A/8CJOx8MpSJ34LN+ywePu+PcS2ZCPzyHEFSTRaJVP82k0HRkjg+zC4X5mq
Sw4WlrpxG/8q9fFnYEDkPhebI5g9Uv5rFsy/0VRovrElFCAGZp5T9sl+NNGJSzBs
tEPgRSHjHw07ikItd9tCnUSW7Q60xBmol9+HWNWR1WLc057ezx3okeXN4RA98N4j
iGtYSuky+7I/3bQSeZN2+IGv4rmwZbjfpVMysnyCclilhBwntUI1plDemez8L7bD
JsI/yW2YM+izskxmVuozy4R3W4e63lYN/n/0CjE/kf+IxM9Ivmg9YRm4+8ssTkmu
GHNcwOnXOVqdwf1kWLet4864mzFIzmqL3lz5vpB4sqPlP/tKxfJmZP+I8Cw/Kr1R
tZvj9Z1d85ETPyKyleH8cDxVWXl2cVeNG6nSH5m4htMCkUbm1Iq1CUyCVy1Chs/u
dId0X2WpS1DrpsGiv/1tz3GFg7SOXYaLCS5IB3s0lalsQeBcQ/hK9NWvS2oDXHo9
ehWi1RJzOmGzja0WrCgXGSMwsT9FzkI4UxgLBC89bROPGtTeFIJ12j2TKLiwp0+L
jN0ul1jK598cUyxLeXcL/STt2Gg4qnWy6gHFFF0BKIWm/I6dEdTs4A3H1nYry4fH
AASMSHr92qPdM3BBPJPFbH3+pAEegPKIanM5YwiRJJ1WmadUWjE=
=P0Mb
-----END PGP SIGNATURE-----

--2tllxusu6get6koj--
