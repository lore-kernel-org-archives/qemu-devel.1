Received: from eggs.gnu.org ([2001:4830:134:3::10]:42219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQynF-00048Z-97
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQynE-0001HY-Ew
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:01:33 -0500
Date: Mon, 18 Dec 2017 17:01:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218170122.GS16653@stefanha-x1.localdomain>
References: <20171215031547.31006-1-f4bug@amsat.org>
	<20171215031547.31006-20-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lCKkSrrNUaKEhaIQ"
Content-Disposition: inline
In-Reply-To: <20171215031547.31006-20-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 19/20] sdhci: add a check_capab_sdma()
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Andrzej Zaborowski <balrogg@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>


--lCKkSrrNUaKEhaIQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 12:15:46AM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/sdhci-test.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 966bd00499..b7646bccc6 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -12,6 +12,7 @@
> =20
>  #define SDHC_CAPAB                      0x40
>  FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
> +FIELD(SDHC_CAPAB, SDMA,                     22, 1);
>  #define SDHC_HCVER                      0xFE
> =20
>  static const struct sdhci_t {
> @@ -21,16 +22,19 @@ static const struct sdhci_t {
>          uintptr_t addr;
>          uint8_t version;
>          uint8_t baseclock;
> +        struct {
> +            bool sdma;
> +        } capab;
>      } sdhci;
>  } models[] =3D {
>      { "arm",    "smdkc210",
> -        {0x12510000, 2, 0} },
> +        {0x12510000, 2, 0, {1} } },
>      { "arm",    "sabrelite",
> -        {0x02190000, 3, 0} },
> +        {0x02190000, 3, 0, {1} } },
>      { "arm",    "raspi2",           /* bcm2835 */
> -        {0x3f300000, 3, 52} },
> +        {0x3f300000, 3, 52, {0} } },
>      { "arm",    "xilinx-zynq-a9",   /* exynos4210 */
> -        {0xe0100000, 3, 0} },
> +        {0xe0100000, 3, 0, {1} } },
>  };
> =20
>  static uint32_t sdhci_readl(uintptr_t base, uint32_t reg_addr)
> @@ -90,6 +94,15 @@ static void check_capab_baseclock(uintptr_t addr, uint=
8_t expected_freq)
>      g_assert_cmpuint(capab_freq, =3D=3D, expected_freq);
>  }
> =20
> +static void check_capab_sdma(uintptr_t addr, bool supported)
> +{
> +    uint64_t capab, capab_sdma;
> +
> +    capab =3D sdhci_readq(addr, SDHC_CAPAB);
> +    capab_sdma =3D FIELD_EX64(capab, SDHC_CAPAB, SDMA);
> +    g_assert_cmpuint(capab_sdma, =3D=3D, supported);
> +}
> +
>  static void test_machine(const void *data)
>  {
>      const struct sdhci_t *test =3D data;
> @@ -98,6 +111,7 @@ static void test_machine(const void *data)
> =20
>      check_specs_version(test->sdhci.addr, test->sdhci.version);
>      check_capab_readonly(test->sdhci.addr);
> +    check_capab_sdma(test->sdhci.addr, test->sdhci.capab.sdma);
>      check_capab_baseclock(test->sdhci.addr, test->sdhci.baseclock);
> =20
>      qtest_quit(global_qtest);
> --=20
> 2.15.1
>=20

--lCKkSrrNUaKEhaIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN/RiAAoJEJykq7OBq3PIhOgH/RQ6NDZ+VLVKBX72vksd1Oyg
nVfx8ClB6cqZglOhRq1WJ/GYoqKymQMT4KJw6PAWymipC123O2he1y83D8c5vjBm
Le7vtlIaFxNt7q6QrYL1fS5jUUVrqMagLoW20+na2oVMwl4AO1CMO1ujIaIfGCyf
ZLgFA3v9T0/DBjcIn25qtzjx3HBclx5XHeSttR3yORK3ytT66PgOVBWrJLdu6u13
IFoTX/L8W/k568kLQdxMCye9H7a9ldMsqlqMQE2BVlqaYRqaWM41w4kyQmBatL5D
CN0gNscKww/diEux5VGppz2I3lxVPeZtI69MOqqrtdri/eaSIMZxjgaWucoVrD4=
=MfQz
-----END PGP SIGNATURE-----

--lCKkSrrNUaKEhaIQ--
