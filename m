Received: from eggs.gnu.org ([2001:4830:134:3::10]:33977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQ0m-00006j-8A
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQ0h-0007Cw-W1
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:51:04 -0400
Received: from ozlabs.org ([203.11.71.1]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fcQ0g-0007CF-Ty
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:50:59 -0400
Date: Mon, 9 Jul 2018 16:49:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709064950.GI22363@umbus.fritz.box>
References: <20180705182001.16537-7-mdavidsaver@gmail.com>
	<20180707174909.23451-1-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <20180707174909.23451-1-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/14] tests: ds-rtc test 12 hour mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 10:49:09AM -0700, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/ds-rtc-common.h       |  9 ++++---
>  tests/ds-rtc-current-test.c |  2 +-
>  tests/ds-rtc-set-test.c     | 58 +++++++++++++++++++++++++++++++++++++++=
++++--
>  3 files changed, 63 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
> index c8e6c2bc5b..5bc7ab32a6 100644
> --- a/tests/ds-rtc-common.h
> +++ b/tests/ds-rtc-common.h
> @@ -20,12 +20,15 @@ static uint8_t addr;
>  static bool use_century;
> =20
>  /* input buffer must have at least 7 elements */
> -static inline time_t rtc_parse(const uint8_t *buf)
> +static inline time_t rtc_parse(const uint8_t *buf, int *mmode)
>  {
>      struct tm parts;
> =20
>      parts.tm_sec =3D from_bcd(buf[0]);
>      parts.tm_min =3D from_bcd(buf[1]);
> +    if (mmode) {
> +        *mmode =3D !!(buf[2] & 0x40);
> +    }
>      if (buf[2] & 0x40) {
>          /* 12 hour */
>          /* HOUR register is 1-12. */
> @@ -51,7 +54,7 @@ static inline time_t rtc_parse(const uint8_t *buf)
>      return mktimegm(&parts);
>  }
> =20
> -static time_t rtc_gettime(void)
> +static time_t rtc_gettime(int *mmode)
>  {
>      uint8_t buf[7];
> =20
> @@ -61,7 +64,7 @@ static time_t rtc_gettime(void)
>      /* read back current time registers */
>      i2c_recv(i2c, addr, buf, 7);
> =20
> -    return rtc_parse(buf);
> +    return rtc_parse(buf, mmode);
>  }
> =20
>  #endif /* DSRTCCOMMON_H */
> diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
> index 6acbbed9a6..3c15482a9d 100644
> --- a/tests/ds-rtc-current-test.c
> +++ b/tests/ds-rtc-current-test.c
> @@ -28,7 +28,7 @@ void test_rtc_current(void)
> =20
>      actual =3D time(NULL);
>      /* new second may start here */
> -    expected =3D rtc_gettime();
> +    expected =3D rtc_gettime(NULL);
>      g_assert_cmpuint(expected, <=3D, actual + max_delta);
>      g_assert_cmpuint(expected, >=3D, actual);
>  }
> diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
> index 35e1a36281..3a742e897f 100644
> --- a/tests/ds-rtc-set-test.c
> +++ b/tests/ds-rtc-set-test.c
> @@ -29,6 +29,18 @@ static uint8_t test_time_24_12am[8] =3D {
>      0x17,
>  };
> =20
> +static uint8_t test_time_12_12am[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 00:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x52, /* 12 AM in 12 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
>  static uint8_t test_time_24_6am[8] =3D {
>      0, /* address */
>      /* Wed, 22 Nov 2017 06:30:53 +0000 */
> @@ -41,6 +53,18 @@ static uint8_t test_time_24_6am[8] =3D {
>      0x17,
>  };
> =20
> +static uint8_t test_time_12_6am[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 06:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x46, /* 6 AM in 12 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
>  static uint8_t test_time_24_12pm[8] =3D {
>      0, /* address */
>      /* Wed, 22 Nov 2017 12:30:53 +0000 */
> @@ -53,6 +77,18 @@ static uint8_t test_time_24_12pm[8] =3D {
>      0x17,
>  };
> =20
> +static uint8_t test_time_12_12pm[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 12:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x72, /* 12 PM in 24 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
>  static uint8_t test_time_24_6pm[8] =3D {
>      0, /* address */
>      /* Wed, 22 Nov 2017 18:30:53 +0000 */
> @@ -65,6 +101,18 @@ static uint8_t test_time_24_6pm[8] =3D {
>      0x17,
>  };
> =20
> +static uint8_t test_time_12_6pm[8] =3D {
> +    0, /* address */
> +    /* Wed, 22 Nov 2017 18:30:53 +0000 */
> +    0x53,
> +    0x30,
> +    0x66, /* 6 PM in 12 hour mode */
> +    0x03, /* monday is our day 1 */
> +    0x22,
> +    0x11 | 0x80,
> +    0x17,
> +};
> +
>  /* write in and read back known time */
>  static
>  void test_rtc_set(const void *raw)
> @@ -76,16 +124,18 @@ void test_rtc_set(const void *raw)
> =20
>      const uint8_t *testtime =3D raw;
>      time_t expected, actual;
> +    int mode_expect, mode_actual;
> =20
>      /* skip address pointer and parse remainder */
> -    expected =3D rtc_parse(&testtime[1]);
> +    expected =3D rtc_parse(&testtime[1], &mode_expect);
> =20
>      i2c_send(i2c, addr, testtime, 8);
>      /* host may start new second here */
> -    actual =3D rtc_gettime();
> +    actual =3D rtc_gettime(&mode_actual);
> =20
>      g_assert_cmpuint(expected, <=3D, actual);
>      g_assert_cmpuint(expected + max_delta, >=3D, actual);
> +    g_assert_cmpint(mode_expect, =3D=3D, mode_actual);
>  }
> =20
>  int main(int argc, char *argv[])
> @@ -108,6 +158,10 @@ int main(int argc, char *argv[])
>      qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, test_=
rtc_set);
>      qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, tes=
t_rtc_set);
>      qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, test_=
rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set12_12am", test_time_12_12am, tes=
t_rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set12_6am", test_time_12_6am, test_=
rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set12_12pm", test_time_12_12pm, tes=
t_rtc_set);
> +    qtest_add_data_func("/ds-rtc-i2c/set12_6pm", test_time_12_6pm, test_=
rtc_set);
> =20
>      ret =3D g_test_run();
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltDBYwACgkQbDjKyiDZ
s5K1hQ//VJh2MF13kg5vmBw8vnQxLAV6/oN8Xb5X+wmKk2qwxhWfH33KhujofHoh
sqlqX0++fViQBS1wT7X7pm86C57lRZkMVjwwDLAA0u+BTI/G9p65wOn4GV6uj0rF
GZbg2r4lpbZ+50Vr9Oh5O9g8zpBV05MsI+hLZkmHxQi3idDa4kjyroOaI6dquNoZ
X0yNNPFFFzKyyOEwKAGlKyGD08p7H46/rwhIuGBNEC8P6TgUH2yyopPUq5FPRX6X
nyclxQQaY6u0sL1KPsWG2EeJI0kHU2ryRwYlanQzHJRQBILuKOvUSnGe74iwGqcL
rll8EIsHuO6dnOTI1lcLV+g7qFWApHeKeVIF8EGkILqTj5qREjN61pLAndTsc07H
r71Q0yivxBhDvOb1d+ZoJ9ICHmlNYBHtBBH35EnS2+cazP2BQ/egpkylzNwFQ9gJ
OSpdA1qiXG7QtMXdINI/UEaVoz0o+DZUd1aw7Y3PCf8Z4pZg1NVk6bLVGxA0EKlc
AqrdPgK9AGbq8FXqiMAnFDjSwEjSdWidpqjt2Kih/QZPjrkcrteWKEcMYtb8vFA0
GXS1UtyUmqE47TTZkt+WY89eA2HzdyKRyNmnYR2cd/EpmGku9Yy+RmE49z0fBoW1
xH+dqAq3+jlWVVOpbUtsBV2ZQSshBRJkJSmTwg9MarLr81VouF0=
=901F
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
