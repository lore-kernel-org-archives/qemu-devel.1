Received: from eggs.gnu.org ([2001:4830:134:3::10]:51176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2EB-0004MV-3r
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2E9-0002EE-SS
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:03 -0400
Date: Mon, 13 Aug 2018 12:00:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813020031.GH4079@umbus>
References: <20180810120418.6695-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <20180810120418.6695-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] 40p: don't use legacy fw_cfg_init_mem()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hpoussin@reactos.org


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 01:04:18PM +0100, Mark Cave-Ayland wrote:
> Instead initialise the device via qdev to allow us to set device properti=
es
> directly as required.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.1, thanks.

> ---
>  hw/ppc/prep.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 3401570d98..9cf4a2adc3 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -706,7 +706,7 @@ static void ibm_40p_init(MachineState *machine)
>      uint16_t cmos_checksum;
>      PowerPCCPU *cpu;
>      DeviceState *dev;
> -    SysBusDevice *pcihost;
> +    SysBusDevice *pcihost, *s;
>      Nvram *m48t59 =3D NULL;
>      PCIBus *pci_bus;
>      ISABus *isa_bus;
> @@ -799,7 +799,16 @@ static void ibm_40p_init(MachineState *machine)
>      }
> =20
>      /* Prepare firmware configuration for OpenBIOS */
> -    fw_cfg =3D fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
> +    dev =3D qdev_create(NULL, TYPE_FW_CFG_MEM);
> +    fw_cfg =3D FW_CFG(dev);
> +    qdev_prop_set_uint32(dev, "data_width", 1);
> +    qdev_prop_set_bit(dev, "dma_enabled", false);
> +    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
> +                              OBJECT(fw_cfg), NULL);
> +    qdev_init_nofail(dev);
> +    s =3D SYS_BUS_DEVICE(dev);
> +    sysbus_mmio_map(s, 0, CFG_ADDR);
> +    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
> =20
>      if (machine->kernel_filename) {
>          /* load kernel */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltw5j8ACgkQbDjKyiDZ
s5JMtg/+KtFxafDJGn0H6BviIFmTvBp91mYB1zsOHBCR8bJaK1YJ5kUCA2OVNVDZ
ExYEk5bWfju8GJ/pQ4M/tctMG5JPHIqwjlvXlCyJpn9jS+hdj1XaRN4AJ1BEn/NW
Sfc0wiuLXmu+kaPCk0Mokv46fyqRtL5ZWSEli3LyTwuTEgaHACpdEiJycChGTjhx
SiKNUSC8IMWMXYoGxDdIz6if5e557YUS9KEllRIytwc6fxLpj3PIFM0bIEw89lNn
TO/j6HTNK32y8zmLNC83Wj/xjgwvRiUK6IqV2ACViofGSoCppPdVxk0rDGhHD5XS
C1gpHBq4zZVRpwRRbefwYkEctyalnXZR932O+Ni2RH7V3TerUJRknye3FlljBr7m
oXUcXZ7V+ng8xWlTK5+JCwovy3YpFwYZNPRCcnY9gvH0S/UJczhq4aY1UKFxpeCI
h6l4Q+iDJaSSHIzADYXMgNnnjYiFefEp9H/O/aMynSIblm/BDGU8Qs39YPkft7ef
OcFzZi0f267mnUhx49XxfZUeqJKa2mcTwQApdarlKgjNhUGUKxGY/t1SDiSh5X8P
TirOkeMzU24JiB9y7c+Asm3Ae7qnLLZuY+vb64MSYatj+MtIJ5Q01vH+Mh2zVFnA
DgVfpGEP5i2QxAsDWoC4ZAfjRtkpMgH9JOCTwVwUXEZUJeqTTN4=
=pnPD
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
