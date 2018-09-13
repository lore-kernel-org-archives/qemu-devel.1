Received: from eggs.gnu.org ([2001:4830:134:3::10]:48271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0FTs-0007yn-3Y
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 20:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1g0FTo-0001Wx-Ur
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 20:27:36 -0400
Date: Thu, 13 Sep 2018 10:24:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180913002457.GN7978@umbus.fritz.box>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
	<20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
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


--uWbmMdDzzl2TXAgx
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

This doesn't apply clean to ppc-for-3.1 for me.

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

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluZrlkACgkQbDjKyiDZ
s5LP9A//SfkA2g9/UEj8SrceLy9xBD/JuKzqlH0qfFYmmFHwshyGN/dZs1E9IpOk
yACleZgEjwcq26GRddMXogRURwLTQEUX0/XgyJ3ctakCr35BQG2aQ8irTpAjlkmO
0LlVqjhK/gVd/YvgtLQGSEE8QDO4Bqm6FWg70UAyX/V966mS38Dd4e65Xzkf8uUs
wRbVYBY/C/QanSNGrFwbQCkjonmc1KCEF6JB1PfE2zNk8Pkf1sWBgvzRQce0BPZ7
4E3FN9s79MLl8EBM7ui+oRtaR8sxfsqJnQOdekw8Kkk1vCwHWfh+PhnsxV1mQ/be
qr4jHd1hYoGbsafXyJT33/xs/ReTAH9MXiW5rSkRlHTrvlbu9vtRogSlmpabuZLF
lHif0fx4o8LjWz9IQ9IKmip9FHLd6fCOKIs1qoCAT7fHQr15XP9qVjbE4EnIlxVJ
h/A/jdKI2Omxqwy2i4msk6dhQuPobDL0rdzBPYT+qLlGO7I3v0VsK+fphWOhSHaf
bFOBMULqIdNHIpMYyV3vuVs6D53/dSsVgV0Bs+F9mQAyfyFrc3sUhlbhOONniJPu
rCpHpE0QDeFYZ8FCVNr8I+8Vtc3EGUWXT6XpAP8KyhhMayMbLCIclgDjemBpKxM3
A/IANfnjETbfZPwT0JqSsWJQ/I/RABsCDU1UwbGpLON2O/qSysg=
=Ik2q
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--
