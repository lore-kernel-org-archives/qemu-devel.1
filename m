Received: from eggs.gnu.org ([2001:4830:134:3::10]:43806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6u-0003ec-KL
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRA6r-0004ws-Qs
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:06:36 -0500
Date: Tue, 19 Dec 2017 16:06:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171219050603.GP4786@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<890b7a4e88ca271acd6f19ce20a7979fbac424ae.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CKf/2jVYos1l2hij"
Content-Disposition: inline
In-Reply-To: <890b7a4e88ca271acd6f19ce20a7979fbac424ae.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 16/17] tests: run ds-rtc-i2c-test w/
 ppc/mvme3100
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


--CKf/2jVYos1l2hij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:14PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But will need to be rebased on the other revised patches.

> ---
>  tests/Makefile.include  | 3 ++-
>  tests/ds-rtc-i2c-test.c | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 56045cdf09..062d4e5b7b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -308,6 +308,7 @@ check-qtest-ppc-y +=3D tests/boot-order-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
>  check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
> +check-qtest-ppc-y +=3D tests/ds-rtc-i2c-test$(EXESUF)
> =20
>  check-qtest-ppc64-y =3D tests/spapr-phb-test$(EXESUF)
>  gcov-files-ppc64-y =3D ppc64-softmmu/hw/ppc/spapr_pci.c
> @@ -745,7 +746,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-tables-te=
st.o \
>  	tests/boot-sector.o tests/acpi-utils.o $(libqos-obj-y)
>  tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o $(libqos-o=
bj-y)
>  tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-obj-y)
> -tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj=
-y)
> +tests/ds-rtc-i2c-test$(EXESUF): tests/ds-rtc-i2c-test.o $(libqos-imx-obj=
-y) $(libqos-e500-obj-y)
>  tests/m25p80-test$(EXESUF): tests/m25p80-test.o
>  tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj-y)
>  tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> diff --git a/tests/ds-rtc-i2c-test.c b/tests/ds-rtc-i2c-test.c
> index 0586dbd467..f7dab1863e 100644
> --- a/tests/ds-rtc-i2c-test.c
> +++ b/tests/ds-rtc-i2c-test.c
> @@ -18,6 +18,9 @@
>  #define IMX25_I2C_0_BASE 0x43F80000
>  #define DS1338_ADDR 0x68
> =20
> +#define E500_CCSR_BASE 0xff700000
> +#define DS1375_ADDR 0xd0
> +
>  static I2CAdapter *i2c;
>  static uint8_t addr;
>  static bool use_century;
> @@ -148,6 +151,11 @@ int main(int argc, char *argv[])
>          addr =3D DS1338_ADDR;
>          use_century =3D false;
> =20
> +    } else if (strcmp(arch, "ppc") =3D=3D 0) {
> +        qtest_start("-machine mvme3100-1152");
> +        i2c =3D e500_i2c_create(E500_CCSR_BASE);
> +        addr =3D DS1375_ADDR;
> +        use_century =3D true;
>      }
> =20
>      qtest_add_data_func("/ds-rtc-i2c/set24", test_time_24, test_rtc_set);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CKf/2jVYos1l2hij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo4njsACgkQbDjKyiDZ
s5IbyxAAr+3liTBsVCkzB7eiKTwZZ8zsb1HHQKosKE8MGWgrT41CyR2Lmigy6riB
FqBGoNGI6uuZF6tQqRBu0UT82ERNqOm7wKawiMLI8tJEPVEFiIQAPxl6qOb+jE+/
NBhGn/BPT83xIjH6lrL/n5RxbZdDFVbmjkY+HMDeWQEMI87py8raGm7/wGDgl0Mh
lWqHJ9e4lpmrGpX73suXS3Nz4eKh3bpGQuANmaIaQaHDj6vb/OdiM8e3vD7WOPaP
FJaHZ0V5vdPS7PZE6T5ko7H/mdfKTQ1O4i5JpW6C6jZtSxTYJA8Aw6OaIFy9u93Q
QfD7cCe8p3NTOT3aPKM9ugTyWzE0f1RhU7ye+al9tiIp00AdtOMwz+Wn4NWYJQFR
ZyLiTCAXn5EZlXN+Jg50fFW7sG+DCXdNCd+GwyHzWuV6p3ZrBxlneOtcXTTw3TDb
9M0WzxgjdWAupUCgyeQ+MethVCcJwsya85yifGwWe+Gu9Y1ioI1+72KIrTBr1j55
cb76x1SooDFeKp9E9B8xsWnV0/AaFLzruRRQkj5q5p+VUYW+Iw3L4Dpt7D6yVHyc
VTxb4G9fUKgqJqjJP8shS/mSLh1aQhg7kDlbBqZilc6A4IQfuOfK8Tmihg3NkG0J
JfNbS05b94r3VFJFnhxkAGHZyNtvOXRQraSZ6FDk0+fiKVf+9yE=
=I8Az
-----END PGP SIGNATURE-----

--CKf/2jVYos1l2hij--
