Received: from eggs.gnu.org ([2001:4830:134:3::10]:47212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMAO1-0004v7-4Q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMANx-0002yJ-Vu
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 05:23:37 -0500
Date: Tue, 5 Dec 2017 17:53:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205065304.GK3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ArrI7P/b+va1vZ8"
Content-Disposition: inline
In-Reply-To: <15378780eee5dc9ebc68361463a0fd6acea55556.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] e500: move PCI host bridge into CCSR
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


--7ArrI7P/b+va1vZ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:11PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Hmm.  Is there anything you're *not* planning to move under the CCSR.
If not, I'm really wondering if the CCSR ought to be a device in its
own right, rather than just a container memory region used within the
machine.

> ---
>  hw/ppc/e500.c      | 13 ++++---------
>  hw/ppc/e500_ccsr.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index cfd5ed0152..b0c8495aef 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -769,6 +769,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      qdev_prop_set_uint32(dev, "mpic-model", params->mpic_version);
>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
>      qdev_prop_set_uint32(dev, "ram-size", ram_size);
> +    qdev_prop_set_uint32(dev, "pci_first_slot", params->pci_first_slot);
> +    qdev_prop_set_uint32(dev, "pci_first_pin_irq", pci_irq_nrs[0]);
>      qdev_init_nofail(dev);
>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
> @@ -778,20 +780,13 @@ void ppce500_init(MachineState *machine, PPCE500Par=
ams *params)
> =20
> =20
>      /* PCI */
> -    dev =3D qdev_create(NULL, "e500-pcihost");
> -    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev=
),
> -                              &error_abort);
> -    qdev_prop_set_uint32(dev, "first_slot", params->pci_first_slot);
> -    qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
> -    qdev_init_nofail(dev);
> +    dev =3D DEVICE(object_resolve_path("/machine/pci-host", 0));
> +    assert(dev);
>      s =3D SYS_BUS_DEVICE(dev);
>      for (i =3D 0; i < PCI_NUM_PINS; i++) {
>          sysbus_connect_irq(s, i, qdev_get_gpio_in(mpicdev, pci_irq_nrs[i=
]));
>      }
> =20
> -    memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
> -                                sysbus_mmio_get_region(s, 0));
> -
>      pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>      if (!pci_bus)
>          printf("couldn't create PCI controller!\n");
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index cd8216daaf..4ec8f7524d 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -50,6 +50,8 @@
> =20
>  #define E500_DUART_OFFSET(N) (0x4500 + (N) * 0x100)
> =20
> +#define E500_PCI_OFFSET  (0x8000ULL)
> +
>  #define E500_PORPLLSR    (0xE0000)
>  #define E500_PVR         (0xE00A0)
>  #define E500_SVR         (0xE00A4)
> @@ -75,6 +77,7 @@ typedef struct {
> =20
>      DeviceState *pic;
>      DeviceState *i2c;
> +    DeviceState *pcihost;
>  } CCSRState;
> =20
>  #define TYPE_E500_CCSR "e500-ccsr"
> @@ -201,6 +204,7 @@ static void e500_ccsr_init(Object *obj)
>      DeviceState *dev =3D DEVICE(obj);
>      CCSRState *ccsr =3D E500_CCSR(dev);
> =20
> +    /* prepare MPIC */
>      assert(current_machine);
>      if (kvm_enabled()) {
> =20
> @@ -228,6 +232,18 @@ static void e500_ccsr_init(Object *obj)
>      object_property_add_alias(obj, "mpic-model",
>                                OBJECT(ccsr->pic), "model",
>                                &error_fatal);
> +
> +    /* prepare PCI host bridge */
> +    ccsr->pcihost =3D qdev_create(NULL, "e500-pcihost");
> +    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(ccs=
r->pcihost),
> +                              &error_abort);
> +
> +    object_property_add_alias(obj, "pci_first_slot",
> +                              OBJECT(ccsr->pcihost), "first_slot",
> +                              &error_fatal);
> +    object_property_add_alias(obj, "pci_first_pin_irq",
> +                              OBJECT(ccsr->pcihost), "first_pin_irq",
> +                              &error_fatal);
>  }
> =20
>  static void e500_ccsr_realize(DeviceState *dev, Error **errp)
> @@ -240,6 +256,7 @@ static void e500_ccsr_realize(DeviceState *dev, Error=
 **errp)
>                            ccsr, "e500-ccsr", 1024 * 1024);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &ccsr->iomem);
> =20
> +    /* realize MPIC */
>      qdev_init_nofail(ccsr->pic);
>      pic =3D SYS_BUS_DEVICE(ccsr->pic);
> =20
> @@ -275,6 +292,13 @@ static void e500_ccsr_realize(DeviceState *dev, Erro=
r **errp)
>                                  sysbus_mmio_get_region(pic, 0));
>      /* Note: MPIC internal interrupts are offset by 16 */
> =20
> +    /* realize PCI host bridge*/
> +    qdev_init_nofail(ccsr->pcihost);
> +
> +    memory_region_add_subregion(&ccsr->iomem, E500_PCI_OFFSET,
> +                                sysbus_mmio_get_region(
> +                                    SYS_BUS_DEVICE(ccsr->pcihost), 0));
> +
>      /* attach I2C controller */
>      ccsr->i2c =3D qdev_create(NULL, "mpc8540-i2c");
>      object_property_add_child(qdev_get_machine(), "i2c[*]",
> @@ -314,6 +338,9 @@ static Property e500_ccsr_props[] =3D {
>      DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
>      DEFINE_PROP_UINT32("ccb-freq", CCSRState, ccb_freq, 333333333u),
>      /* "mpic-model" aliased from MPIC */
> +    /* "pci_first_slot"
> +     * "pci_first_pin_irq" aliased from PCI host bridge
> +     */
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ArrI7P/b+va1vZ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomQlAACgkQbDjKyiDZ
s5Ko6RAAhGQxeq/BGjeid/tpKM5SU2KvAA/THdaByUHrZgME8N5upAvS57LzsFRY
n8iSD/cg4h0swqg86NCgcOss2sI4/XVkz4Xf0XpdXfaAC2uFfNLNNzQ5fQKkYVFE
yvTzPks1ax8yJBN0n0DTmJign20ot6ZL0s+YiX11Sb8Np1J34+f9HRydRNn2WEjN
pQ8PSTtdtD1S/IyIJfGm8Dw2oPxWw4j8IM4WfuU8Rmr3nZEe0w6XouHKu/2EFi4q
midfGCE93vz9fwphBdF3BIbTr4l+Kwbp6Myo1AXwuKFv61hubSxtX4WZOMhtkh5e
6gShQRLFkecuJyDPYBVnCnfYFmVoS00oMOTJwHCV6KiVa/ZwIeg0NakTyxiuHABH
qHqIA2bBh7BBKsakqVipkYcG5l7adJ05246tAnn0i4qQQ7DX653IW1r63j41FXsz
wHYuHPDUPam/Ty4Bdgr6Kth03MMrtHDAltpH2f7WyV+rWVi5jnZvvXAJy4y8Ssy0
Kud20cZc7z2VNtYWsXbz/bxi8Xq+IMxp+mfpaFj1A8ynGvjXyczO3uecm9Ed7rcD
jVw0CRVTmdbh9amq+vUacD/ui0QZ37BPDNVBO6Th/ckc71uYu/SK9RH47EY5lTwE
RPwhdVR8+GMvtIt7wH80o1RaoluJVUJcbHOi0Ae0+EbCQDpbOIs=
=T2Fs
-----END PGP SIGNATURE-----

--7ArrI7P/b+va1vZ8--
