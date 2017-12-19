Received: from eggs.gnu.org ([2001:4830:134:3::10]:43807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6u-0003ed-KP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6r-0004wz-Qz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:36 -0500
Date: Tue, 19 Dec 2017 16:06:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219050625.GQ4786@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<6417d3123f961850c57474272c717152100b917a.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline
In-Reply-To: <6417d3123f961850c57474272c717152100b917a.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 17/17] tests: add mvme3100-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:15PM -0600, Michael Davidsaver wrote:
> Exercise some features of the mvme3100 CPLD logic
> and read from the eeprom w/ VPD.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Looks good, but will need a rebase.

> ---
>  tests/Makefile.include |  3 ++
>  tests/mvme3100-test.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 82 insertions(+)
>  create mode 100644 tests/mvme3100-test.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 062d4e5b7b..97bce77ee4 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -373,6 +373,8 @@ check-qtest-s390x-y +=3D tests/virtio-balloon-test$(E=
XESUF)
>  check-qtest-s390x-y +=3D tests/virtio-console-test$(EXESUF)
>  check-qtest-s390x-y +=3D tests/virtio-serial-test$(EXESUF)
> =20
> +check-qtest-ppc-$(CONFIG_E500) +=3D tests/mvme3100-test$(EXESUF)
> +
>  check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
>  check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
> =20
> @@ -782,6 +784,7 @@ tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
>  tests/ac97-test$(EXESUF): tests/ac97-test.o
>  tests/es1370-test$(EXESUF): tests/es1370-test.o
>  tests/intel-hda-test$(EXESUF): tests/intel-hda-test.o
> +tests/mvme3100-test$(EXESUF): tests/mvme3100-test.o $(libqos-e500-obj-y)
>  tests/ioh3420-test$(EXESUF): tests/ioh3420-test.o
>  tests/usb-hcd-ohci-test$(EXESUF): tests/usb-hcd-ohci-test.o $(libqos-usb=
-obj-y)
>  tests/usb-hcd-uhci-test$(EXESUF): tests/usb-hcd-uhci-test.o $(libqos-usb=
-obj-y)
> diff --git a/tests/mvme3100-test.c b/tests/mvme3100-test.c
> new file mode 100644
> index 0000000000..6dde8d1d29
> --- /dev/null
> +++ b/tests/mvme3100-test.c
> @@ -0,0 +1,79 @@
> +#include <stdio.h>
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/libqos.h"
> +#include "libqos/i2c.h"
> +
> +#define assert_equal(A, B) g_assert_cmphex((A), =3D=3D, (B))
> +
> +static
> +I2CAdapter *i2c;
> +
> +static
> +void test_ccsr(void)
> +{
> +    /* CCSRBAR is self referential */
> +    assert_equal(readl(0xff700000), 0x000ff700);
> +
> +    /* introspect memory size */
> +    assert_equal(readl(0xff702080), 0x80000000);
> +    /* value is (ram_size-1)>>24 */
> +    assert_equal(readl(0xff702000), 15);
> +}
> +
> +static
> +void test_cpld(void)
> +{
> +    /* read/write to test register */
> +    assert_equal(readl(0xe2000010), 0x00000000);
> +    assert_equal(readl(0xe2000014), 0xffffffff);
> +
> +    writel(0xe2000010, 0x12345678);
> +
> +    assert_equal(readl(0xe2000010), 0x12345678);
> +    assert_equal(readl(0xe2000014), 0x12345678 ^ 0xffffffff);
> +}
> +
> +static
> +void test_eeprom(void)
> +{
> +    char buf[] =3D "\x00\x00MOTOROLA";
> +
> +    /* 1. zero address pointer
> +     * 2. write 8 bytes,
> +     * 3. re-zero address pointer
> +     */
> +    i2c_send(i2c, 0xa8, (uint8_t *)buf, 10);
> +    i2c_send(i2c, 0xa8, (uint8_t *)buf, 2);
> +
> +    /* read 8 bytes */
> +    i2c_recv(i2c, 0xa8, (uint8_t *)buf, 8);
> +    buf[8] =3D '\0';
> +
> +    /* Read header for Motorola VPD info */
> +    g_assert_cmpstr(buf, =3D=3D, "MOTOROLA");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +    int ret;
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_start("-machine mvme3100-1152");
> +
> +    i2c =3D e500_i2c_create(0xff700000);
> +
> +    qtest_add_func("/mvme3100/ccsr", test_ccsr);
> +    qtest_add_func("/mvme3100/cpld", test_cpld);
> +    qtest_add_func("/mvme3100/eeprom", test_eeprom);
> +
> +    ret =3D g_test_run();
> +
> +    printf("Tests done\n");
> +
> +    qtest_end();
> +    printf("Tests end\n");
> +
> +    return ret;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4nlEACgkQbDjKyiDZ
s5KuPQ/+IFpUGBukdGciobCbP8GvpIuH9ZHgQvfzCDfB/IsN2lISO/Z2XHqZI2Cu
Yb9AJvrUWDzlSwJRjZ4KEYsJFXDrbBKUo1jxcQC94BE4mOS7NeM1egIg+HLMZfzL
ymehCM2Fk6HX4yb7Sq8pfEzn1QoaNl6Xe2w31k3qq+nRlic6+4UDor8N4gBfVHPb
85qOqINMberwnMxZqPNfA2gTL4ZKwdWyplAFp6RDRARNF2CDYg2TiVUVGBac+4ra
Yl0xP5appT6cZW8l5vsSLoBbo5+0uDzVYfLYnsFji3GmAyR4WHGEVVDR5DdCnTjb
ehJ9NuvcJw0/zu0HsfOCY640/sQJvOTRrV3aRCK2hyaNjPQ1bT/VVU1npy+Hi5qd
RBMqyQBdYXc5PZ2SmVU0/LUQBhEJuwIB/m/LJsLi9pH1DU6iCBpU3E8QERIx56+t
HsgMetcn/9neEqemx/K+gU6OffsGuic28qvx9qHdg6ZXYbMn/X1e67XX4YYPHI8t
Jg0O1Y6eWpwSxOH3b6ZLuGna7aohssoJ5u8H+s2/dYhbcjE/Ma+yOFsW9h75HlU+
2SWt2g3yuBKDsL1wqq5ItrJH9CtPEkgKFxAVWyEp8NAbZd4RSNVPAnhGmJj1XM9x
9SJa7UZby79yKfSNvu0V1YBeBUJTvzhbt1iwy/H0B4Pf5u6Vb34=
=oGQz
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--
