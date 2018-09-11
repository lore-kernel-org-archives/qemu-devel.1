Received: from eggs.gnu.org ([2001:4830:134:3::10]:39751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXfp-0006jz-AL
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXfo-00014O-8z
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:41:01 -0400
Date: Tue, 11 Sep 2018 11:27:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911012739.GC7978@umbus.fritz.box>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
In-Reply-To: <20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] 40p: add fixed IRQ routing for LSI
 SCSI device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: hpoussin@reactos.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 09:46:31PM +0100, Mark Cave-Ayland wrote:
> Whilst the PReP specification describes how all PCI IRQs are routed via I=
RQ
> 15 on the interrupt controller, the real 40p machine has a routing quirk =
in
> that the LSI SCSI device is routed directly to IRQ 13.
>=20
> Enable the external IRQ for the LSI SCSI device by wiring up the IRQ with
> qdev to the relevant interrupt controller gpio.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/prep.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 615865e46c..94fc36b7ef 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -621,7 +621,7 @@ static void ibm_40p_init(MachineState *machine)
>      CPUPPCState *env =3D NULL;
>      uint16_t cmos_checksum;
>      PowerPCCPU *cpu;
> -    DeviceState *dev;
> +    DeviceState *dev, *i82378_dev;
>      SysBusDevice *pcihost, *s;
>      Nvram *m48t59 =3D NULL;
>      PCIBus *pci_bus;
> @@ -666,11 +666,11 @@ static void ibm_40p_init(MachineState *machine)
>      }
> =20
>      /* PCI -> ISA bridge */
> -    dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"=
));
> -    qdev_connect_gpio_out(dev, 0,
> +    i82378_dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "=
i82378"));
> +    qdev_connect_gpio_out(i82378_dev, 0,
>                            cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
> -    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
> -    isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
> +    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
> +    isa_bus =3D ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
> =20
>      /* Memory controller */
>      dev =3D DEVICE(isa_create(isa_bus, "rs6000-mc"));
> @@ -703,6 +703,7 @@ static void ibm_40p_init(MachineState *machine)
>          dev =3D DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
>                                         "lsi53c810"));
>          lsi53c8xx_handle_legacy_cmdline(dev);
> +        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
> =20
>          /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>          pci_vga_init(pci_bus);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXGgsACgkQbDjKyiDZ
s5KX6w//T5b+qqO7OFKvGQCH7w/yPdryETR+q/mNkkY2KKp+9hBKdmT2OsNWFmIu
z4MAlQFpSq13FdAzROLmwP05TvrzpxGbIBlhr4zKmHjvCbXSaKn0DSnLM3DrEduQ
gfPmsLwKjb/yi/ierfi8k9zzSTJ4C4vxVdkbbax+l0hOofJPQXJfrguolgNa7ixB
4G6/G5TvhXs2YM560MOTmBYh5wDOgpYDoH+HUE5WmmwmxxpdeNa7uA/8RED3ZUKs
kyitXxhAryGzezLBgqeNVPbAE+DafJRXR7qAZuQ6fx3kHbpt4iE4O1vdpFtitKc9
WJHTx9gmNXcSjdxW2hOaPix44adaeBq7EzRuWbdXs6D1dS9VGAtYQ3NvFeXBrBgf
PEtO1L5EAc3R3UCTuv/7HdmpQLVRIiPW5833vJ+GuoX0lWOFR7zOkdWGFNZLZ8eq
hQr3wHMQO3bsGLcCXkLCOSGQgdbHCaLME+uQVaXF8VTIy2YwWpoFw6zheD8Tg7lH
2Uhy6jGXUEAUIs41VMNT1z7Rp98x5BufjszDtT6OhK+thwZG3aZPWeKGleZI4ca4
qLSGClteDISXP7tUdcf7GEYcIY3WpIaY5dwTMjYZ4AD0UH9VqMBIr5EFs4V3dsHl
jPejE6ZKEUN/wKc8Xnzp8p4oX5xwRlonlBZvEoVW4GPsraliS7A=
=A/Qb
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
