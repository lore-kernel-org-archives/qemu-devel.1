Received: from eggs.gnu.org ([2001:4830:134:3::10]:33968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQ0j-00006G-3g
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQ0i-0007D1-0L
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:51:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fcQ0g-0007CG-UX
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 02:50:59 -0400
Date: Mon, 9 Jul 2018 16:50:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709065048.GJ22363@umbus.fritz.box>
References: <20180705182001.16537-8-mdavidsaver@gmail.com>
	<20180707175039.23522-1-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline
In-Reply-To: <20180707175039.23522-1-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/14] tests: ds-rtc test wday offset
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


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2018 at 10:50:39AM -0700, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  tests/ds-rtc-common.h       | 10 +++++++---
>  tests/ds-rtc-current-test.c |  9 ++++++++-
>  tests/ds-rtc-set-test.c     |  6 ++++--
>  3 files changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/ds-rtc-common.h b/tests/ds-rtc-common.h
> index 5bc7ab32a6..782ea60453 100644
> --- a/tests/ds-rtc-common.h
> +++ b/tests/ds-rtc-common.h
> @@ -20,7 +20,7 @@ static uint8_t addr;
>  static bool use_century;
> =20
>  /* input buffer must have at least 7 elements */
> -static inline time_t rtc_parse(const uint8_t *buf, int *mmode)
> +static inline time_t rtc_parse(const uint8_t *buf, unsigned *wday, int *=
mmode)
>  {
>      struct tm parts;
> =20
> @@ -51,10 +51,14 @@ static inline time_t rtc_parse(const uint8_t *buf, in=
t *mmode)
>          parts.tm_year +=3D 100u;
>      }
> =20
> +    if (wday) {
> +        *wday =3D parts.tm_wday;
> +    }
> +
>      return mktimegm(&parts);
>  }
> =20
> -static time_t rtc_gettime(int *mmode)
> +static time_t rtc_gettime(unsigned *wday, int *mmode)
>  {
>      uint8_t buf[7];
> =20
> @@ -64,7 +68,7 @@ static time_t rtc_gettime(int *mmode)
>      /* read back current time registers */
>      i2c_recv(i2c, addr, buf, 7);
> =20
> -    return rtc_parse(buf, mmode);
> +    return rtc_parse(buf, wday, mmode);
>  }
> =20
>  #endif /* DSRTCCOMMON_H */
> diff --git a/tests/ds-rtc-current-test.c b/tests/ds-rtc-current-test.c
> index 3c15482a9d..08d8411671 100644
> --- a/tests/ds-rtc-current-test.c
> +++ b/tests/ds-rtc-current-test.c
> @@ -20,17 +20,24 @@
>  static
>  void test_rtc_current(void)
>  {
> +    struct tm tm_actual;
>      time_t expected, actual;
>      /* relax test to limit false positives when host may be overloaded.
>       * Allow larger delta when running "-m quick"
>       */
>      time_t max_delta =3D g_test_slow() ? 1 : 30;
> =20
> +    unsigned wday_expect;
> +
>      actual =3D time(NULL);
>      /* new second may start here */
> -    expected =3D rtc_gettime(NULL);
> +    expected =3D rtc_gettime(&wday_expect, NULL);
> +
> +    gmtime_r(&actual, &tm_actual);
> +
>      g_assert_cmpuint(expected, <=3D, actual + max_delta);
>      g_assert_cmpuint(expected, >=3D, actual);
> +    g_assert_cmpuint(wday_expect, =3D=3D, tm_actual.tm_wday);
>  }
> =20
>  int main(int argc, char *argv[])
> diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
> index 3a742e897f..1004470931 100644
> --- a/tests/ds-rtc-set-test.c
> +++ b/tests/ds-rtc-set-test.c
> @@ -124,17 +124,19 @@ void test_rtc_set(const void *raw)
> =20
>      const uint8_t *testtime =3D raw;
>      time_t expected, actual;
> +    unsigned wday_expect, wday_actual;
>      int mode_expect, mode_actual;
> =20
>      /* skip address pointer and parse remainder */
> -    expected =3D rtc_parse(&testtime[1], &mode_expect);
> +    expected =3D rtc_parse(&testtime[1], &wday_expect, &mode_expect);
> =20
>      i2c_send(i2c, addr, testtime, 8);
>      /* host may start new second here */
> -    actual =3D rtc_gettime(&mode_actual);
> +    actual =3D rtc_gettime(&wday_actual, &mode_actual);
> =20
>      g_assert_cmpuint(expected, <=3D, actual);
>      g_assert_cmpuint(expected + max_delta, >=3D, actual);
> +    g_assert_cmpuint(wday_expect, =3D=3D, wday_actual);
>      g_assert_cmpint(mode_expect, =3D=3D, mode_actual);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltDBcgACgkQbDjKyiDZ
s5KL+xAAi6NJ27O48H2KRysK/Iwhe007GGxrUNkpynCdMHyyglvvmlwNRfw6lksn
6T78vP+QekAYzzg0ZTdti7m0mLy60LLanswqcEklsgOXmq+XdS6xiUUK2pzTKnAK
KD2ov+6ewVKNRndKIBCYm28sCywRxejQIG8QGEd2UbPOF+r3wQpNi9v5iV4tt8Ca
0n7UjiQyLlgG1NgU7tiDk3yrGVzogGyuih4YQQx7ptJS/RtThKeaj6QMMOqDBf0m
1tXMuF2/Suag9iCtmULYTtmNOqIpr4zZgroedYFqXtYsBgXlLNgGu063Ic2y1x2E
BffCx9PYM7vCTOZhUYc3pVytkQKnUTJiM32y9i0fhEMBk6rabeypELyI2g0SNYEA
U1O8erfqz3/TvMXxE+Q3Ie4NlhayHclS54cWmHa9qjz+PeSz6I46KxZVYKpS4Nvp
vnZ0I1/L9lihtr9+npeCq9OXNcgKAoXcjnRxY4NJUcp75IjUwEAMg2uj9oMBnvYT
Ur4isyHvEO8IQwOoc79WBREIYeMnt8Gcr9K/0Qqp61QczwNdlmrW1DwjLq848nZt
m7qDJcIRA9IJtWenhUkMg8TWf3agdmTvkQOyudF9JY39ODLhGx1MZOikogPb9cuz
oySp6m0t61DQPvHg7v2KPEW8ckooV/pgbo4id83OSyFqfDiFiBg=
=HOlt
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--
