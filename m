Received: from eggs.gnu.org ([2001:4830:134:3::10]:41671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e85qu-0002ew-Jo
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e85qq-0007XZ-DB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:43:16 -0400
Date: Fri, 27 Oct 2017 16:42:58 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027144258.GF7115@umbus>
References: <20171020143852.2443-1-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <20171020143852.2443-1-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] e500: ppce500_init_mpic() return device
 instead of IRQ array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2017 at 09:38:52AM -0500, Michael Davidsaver wrote:
> Actual number of interrupt pins isn't known
> in ppce500_init_mpic() so a hardcoded number
> was used, which causes a crash with older openpic.
>=20
> Instead, return the DeviceState* and change ppce500_init()
> to call qdev_get_gpio_in() to get only the irq pins
> which are needed.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/e500.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index b8d786c479..33adc809ba 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -729,15 +729,13 @@ static DeviceState *ppce500_init_mpic_kvm(PPCE500Pa=
rams *params,
>      return dev;
>  }
> =20
> -static qemu_irq *ppce500_init_mpic(MachineState *machine, PPCE500Params =
*params,
> -                                   MemoryRegion *ccsr, qemu_irq **irqs)
> +static DeviceState *ppce500_init_mpic(MachineState *machine,
> +                                      PPCE500Params *params,
> +                                      MemoryRegion *ccsr,
> +                                      qemu_irq **irqs)
>  {
> -    qemu_irq *mpic;
>      DeviceState *dev =3D NULL;
>      SysBusDevice *s;
> -    int i;
> -
> -    mpic =3D g_new0(qemu_irq, 256);
> =20
>      if (kvm_enabled()) {
>          Error *err =3D NULL;
> @@ -756,15 +754,11 @@ static qemu_irq *ppce500_init_mpic(MachineState *ma=
chine, PPCE500Params *params,
>          dev =3D ppce500_init_mpic_qemu(params, irqs);
>      }
> =20
> -    for (i =3D 0; i < 256; i++) {
> -        mpic[i] =3D qdev_get_gpio_in(dev, i);
> -    }
> -
>      s =3D SYS_BUS_DEVICE(dev);
>      memory_region_add_subregion(ccsr, MPC8544_MPIC_REGS_OFFSET,
>                                  s->mmio[0].memory);
> =20
> -    return mpic;
> +    return dev;
>  }
> =20
>  static void ppce500_power_off(void *opaque, int line, int on)
> @@ -796,8 +790,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      /* irq num for pin INTA, INTB, INTC and INTD is 1, 2, 3 and
>       * 4 respectively */
>      unsigned int pci_irq_nrs[PCI_NUM_PINS] =3D {1, 2, 3, 4};
> -    qemu_irq **irqs, *mpic;
> -    DeviceState *dev;
> +    qemu_irq **irqs;
> +    DeviceState *dev, *mpicdev;
>      CPUPPCState *firstenv =3D NULL;
>      MemoryRegion *ccsr_addr_space;
>      SysBusDevice *s;
> @@ -866,18 +860,18 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
>      memory_region_add_subregion(address_space_mem, params->ccsrbar_base,
>                                  ccsr_addr_space);
> =20
> -    mpic =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs);
> +    mpicdev =3D ppce500_init_mpic(machine, params, ccsr_addr_space, irqs=
);
> =20
>      /* Serial */
>      if (serial_hds[0]) {
>          serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
> -                       0, mpic[42], 399193,
> +                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
>                         serial_hds[0], DEVICE_BIG_ENDIAN);
>      }
> =20
>      if (serial_hds[1]) {
>          serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
> -                       0, mpic[42], 399193,
> +                       0, qdev_get_gpio_in(mpicdev, 42), 399193,
>                         serial_hds[1], DEVICE_BIG_ENDIAN);
>      }
> =20
> @@ -896,7 +890,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      qdev_init_nofail(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
> -        sysbus_connect_irq(s, i, mpic[pci_irq_nrs[i]]);
> +        sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i=
]));
>      }
> =20
>      memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
> @@ -927,7 +921,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          dev =3D qdev_create(NULL, "mpc8xxx_gpio");
>          s =3D SYS_BUS_DEVICE(dev);
>          qdev_init_nofail(dev);
> -        sysbus_connect_irq(s, 0, mpic[MPC8XXX_GPIO_IRQ]);
> +        sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8XXX_GPIO_=
IRQ));
>          memory_region_add_subregion(ccsr_addr_space, MPC8XXX_GPIO_OFFSET,
>                                      sysbus_mmio_get_region(s, 0));
> =20
> @@ -947,7 +941,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
> =20
>          for (i =3D 0; i < params->platform_bus_num_irqs; i++) {
>              int irqn =3D params->platform_bus_first_irq + i;
> -            sysbus_connect_irq(s, i, mpic[irqn]);
> +            sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, irqn));
>          }
> =20
>          memory_region_add_subregion(address_space_mem,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzRfIACgkQbDjKyiDZ
s5K5XA/8C39Io5NqmsbIsDFWuOnYCfwlVDgcaOjFqHnz4qeaVavAhDAYsHYEaW6I
dJLU1D3O27Ns/J1LFL0JmtNaUDiPJN4ACPLojeN0hRD+iPf1h6mp4t9Js/CKbQQH
UC+DfWzBmS0gtkSjrRoKOOE6lOXL9MAqprqInR4E6cnV0Icdb8VS5niPMR1wjtvP
EdMqF1G+Of3gRfCRcOgcZ5aR+Zl78E9MY5etPYUYcM3F2WRb6CGekb+vSKO7eMiP
zDUkICWxXDWubTA/YbaLXmKSrhrTKOMEM7Bs2TcWplghvIIXNMe0t5bPjL8f1e0x
OCrXKtYe01BgD8pp5ClBIiCbAg9XqMvMJZQqDQ2LnmxwLPVv1wujkcfzp4/OezwQ
XtuQrggwVeMHLwItGPcnhO0BDKFBzGiezSE7J+BYQNV+C4s84hkw/JryN+x2Xc5e
THcYH9fFLmrnGK3fpe6HRnEHXNL7AWDjx9UepslWNv0ovZv950EpTpJ69EOXCvbC
CsMKPQTmnbN29GrzaOb22kVjaJcgx3WtSQt6XqZyxcweYeok/od+teNidfO37+3c
IUyL1lTehp/taZdf/J7qkEn9JRsca1Ex2X75ljItGr6sOj7QsJfbnpQ7ZTwUq0Ok
Lm223DFk7ZqKwYCBmmUC/EysybU71zvRyHVqcxh5Pdoe6JjDTcQ=
=MC2v
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
