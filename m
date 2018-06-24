Received: from eggs.gnu.org ([2001:4830:134:3::10]:47458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fX2DZ-0007SL-IA
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 06:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fX2DW-0001nV-DF
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 06:26:01 -0400
Date: Sun, 24 Jun 2018 20:12:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180624101256.GA2258@umbus.fritz.box>
References: <1529788685-31687-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <1529788685-31687-1-git-send-email-linux@roeck-us.net>
Subject: Re: [Qemu-devel] [PATCH v4] sam460ex: Fix sam460ex device tree when
 booting the Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 23, 2018 at 02:18:05PM -0700, Guenter Roeck wrote:
> sam460ex (or at least this emulation) does not support the "ibm,cpm" power
> management. As a result, Linux crashes when trying to access it. Remove
> its device tree node. Also, if/when we boot the Linux kernel directly,
> serial port clock frequencies in the device tree file will be unset, and
> serial port initialization will fail. Add valid frequency values to
> the serial ports to be able to use it. Also set valid values for the other
> clock nodes otherwise set by u-boot.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to ppc-for-3.0, thanks.

> ---
> v4: Use correct UART clock.
> v3: Fix style problems (ERROR: braces {} are necessary for all arms ...).
>     Use defines for clock frequencies.
>     Use clock frequencies as reported by u-boot in real system.
>     Use more specific prefix in subject.
>     Fix typos in description.
> v2: Initialize all serial nodes to match u-boot behavior more closely.
>     Use direct fdt API functions and ignore errors when clearing out
>     /cpm and for setting the serial port clocks.
>=20
>  hw/ppc/sam460ex.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
> index bdc53d2..33ea518 100644
> --- a/hw/ppc/sam460ex.c
> +++ b/hw/ppc/sam460ex.c
> @@ -37,6 +37,8 @@
>  #include "hw/i2c/smbus.h"
>  #include "hw/usb/hcd-ehci.h"
> =20
> +#include <libfdt.h>
> +
>  #define BINARY_DEVICE_TREE_FILE "canyonlands.dtb"
>  #define UBOOT_FILENAME "u-boot-sam460-20100605.bin"
>  /* to extract the official U-Boot bin from the updater: */
> @@ -67,6 +69,10 @@
>  */
> =20
>  #define CPU_FREQ 1150000000
> +#define PLB_FREQ 230000000
> +#define OPB_FREQ 115000000
> +#define EBC_FREQ 115000000
> +#define UART_FREQ 11059200
>  #define SDRAM_NR_BANKS 4
> =20
>  /* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
> @@ -255,6 +261,7 @@ static int sam460ex_load_device_tree(hwaddr addr,
>      void *fdt;
>      uint32_t tb_freq =3D CPU_FREQ;
>      uint32_t clock_freq =3D CPU_FREQ;
> +    int offset;
> =20
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_=
FILE);
>      if (!filename) {
> @@ -308,6 +315,27 @@ static int sam460ex_load_device_tree(hwaddr addr,
>      qemu_fdt_setprop_cell(fdt, "/cpus/cpu@0", "timebase-frequency",
>                                tb_freq);
> =20
> +    /* Remove cpm node if it exists (it is not emulated) */
> +    offset =3D fdt_path_offset(fdt, "/cpm");
> +    if (offset >=3D 0) {
> +        fdt_nop_node(fdt, offset);
> +    }
> +
> +    /* set serial port clocks */
> +    offset =3D fdt_node_offset_by_compatible(fdt, -1, "ns16550");
> +    while (offset >=3D 0) {
> +        fdt_setprop_cell(fdt, offset, "clock-frequency", UART_FREQ);
> +        offset =3D fdt_node_offset_by_compatible(fdt, offset, "ns16550");
> +    }
> +
> +    /* some more clocks */
> +    qemu_fdt_setprop_cell(fdt, "/plb", "clock-frequency",
> +                              PLB_FREQ);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb", "clock-frequency",
> +                              OPB_FREQ);
> +    qemu_fdt_setprop_cell(fdt, "/plb/opb/ebc", "clock-frequency",
> +                              EBC_FREQ);
> +
>      rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
>      g_free(fdt);
>      ret =3D fdt_size;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsvbqUACgkQbDjKyiDZ
s5IR+Q//Wg6vt9W5pM2et8szyFOxtw+RLEa4BDOzNQh+E9KUn7xeHW2GEUl6otNo
TacFmPa9KxVKFosgu/KqM04QiqdjPxYvsx4rPOwkeN5VLNGoDoupGaB4kT7/ugp1
21yOBA0wdg26fPveAT75n7QVH5MTvMAVCaIvJpvMW46D2aNDpjIdwgsOooEzsZI7
Y7mnoQnCiOuDGc8YhEaca9VCYTfgXJvgAcMv8+DMjuQuMNzBae6D0NOkP7yncn2T
m+gT+0jOSN+FUzPp+S0IlnMiAdtLhXSn6vYSjppSa+qpu+fiyVlRxOqQ8WnO+RdV
RmW++MPfLF5cqgGTsxNUVU9q2ATtW+q/n/IX2Hs+US7aZ0czhW4QroPir7OmyUI/
P+I8yhgFOg3D6YsOlHjzmCtsCDo6zBqJtlA4GLtSOBgbjQuGNCG3xscu5I1C0nmB
rbK4eqUK6PQnDCj31WRhxsSFsa9M4t5lB3ehmzhjLiRQRirtadx8M0gz/5Kmkfgn
thPSqvPl/6OD/iqa0d+At8/4SA1kSft3uuAhtDNmUiOA9nBQeppCu2mmo/L9W+cc
KZUJp8jbTKayRGvmW7BUPorGiuWu81gpCA05o361p61O8/VTQxmB/hxya/q2hEhs
Wu80ee+Bh8bzUDf6CoWb3j1iaLagIkNE+QMIFzmbZKy4Kuu/AbA=
=TBhO
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
