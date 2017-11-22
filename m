Received: from eggs.gnu.org ([2001:4830:134:3::10]:53555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOl-0002hF-Nh
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOk-0002WI-9o
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:31 -0500
Date: Wed, 22 Nov 2017 14:57:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122035754.GJ2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-5-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVh9lyqKgK19OcEf"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-5-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] e500: additional CCSR registers
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


--EVh9lyqKgK19OcEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:12PM -0600, Michael Davidsaver wrote:
> Add CCSRBAR to allow CCSR region to be relocated.
> Guest memory size introspection.
> Dummy RAM error controls.
> Guest clock introspection.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Looks fine from the POV of someone who doesn't know details about
e500.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/e500.c      |  2 ++
>  hw/ppc/e500.h      |  1 +
>  hw/ppc/e500_ccsr.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/ppc/e500plat.c  |  1 +
>  hw/ppc/mpc8544ds.c |  1 +
>  5 files changed, 75 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 474a46a985..057be1751b 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -853,7 +853,9 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      dev =3D qdev_create(NULL, "e500-ccsr");
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
>                                OBJECT(dev), NULL);
> +    qdev_prop_set_uint32(dev, "porpllsr", params->porpllsr);
>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
> +    qdev_prop_set_uint32(dev, "ram-size", ram_size);
>      qdev_init_nofail(dev);
>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
> diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
> index 40f72f2de2..1f39095dfa 100644
> --- a/hw/ppc/e500.h
> +++ b/hw/ppc/e500.h
> @@ -22,6 +22,7 @@ typedef struct PPCE500Params {
>      hwaddr pci_mmio_base;
>      hwaddr pci_mmio_bus_base;
>      hwaddr spin_base;
> +    uint32_t porpllsr; /* value of PORPLLSR register */
>      uint32_t decrementor_freq; /* in Hz */
>      bool skip_load;
>      bool tsec_nic;
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index 1b586c3f42..c58b17f06b 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -31,6 +31,16 @@
> =20
>  /* E500_ denotes registers common to all */
> =20
> +#define E500_CCSRBAR     (0)
> +
> +#define E500_CS0_BNDS    (0x2000)
> +
> +#define E500_CS0_CONFIG  (0x2080)
> +
> +#define E500_ERR_DETECT  (0x2e40)
> +#define E500_ERR_DISABLE (0x2e44)
> +
> +#define E500_PORPLLSR    (0xE0000)
>  #define E500_PVR         (0xE00A0)
>  #define E500_SVR         (0xE00A4)
> =20
> @@ -44,7 +54,11 @@ typedef struct {
> =20
>      MemoryRegion iomem;
> =20
> -    uint32_t defbase;
> +    uint32_t defbase, base;
> +    uint32_t ram_size;
> +    uint32_t merrd;
> +
> +    uint32_t porpllsr;
>  } CCSRState;
> =20
>  #define TYPE_E500_CCSR "e500-ccsr"
> @@ -53,10 +67,28 @@ typedef struct {
>  static uint64_t e500_ccsr_read(void *opaque, hwaddr addr,
>                                    unsigned size)
>  {
> +    CCSRState *ccsr =3D opaque;
>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      switch (addr) {
> +    case E500_CCSRBAR:
> +        return ccsr->base >> 12;
> +    case E500_CS0_BNDS:
> +        /* we model all RAM in a single chip with addresses [0, ram_size=
) */
> +        return (ccsr->ram_size - 1) >> 24;
> +    case E500_CS0_CONFIG:
> +        return 1 << 31;
> +    case E500_ERR_DETECT:
> +        return 0; /* (errors not modeled) */
> +    case E500_ERR_DISABLE:
> +        return ccsr->merrd;
> +    case E500_PORPLLSR:
> +        if (!ccsr->porpllsr) {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "Machine does not provide valid PORPLLSR\n");
> +        }
> +        return ccsr->porpllsr;
>      case E500_PVR:
>          return env->spr[SPR_PVR];
>      case E500_SVR:
> @@ -72,10 +104,22 @@ static uint64_t e500_ccsr_read(void *opaque, hwaddr =
addr,
>  static void e500_ccsr_write(void *opaque, hwaddr addr,
>                                 uint64_t value, unsigned size)
>  {
> +    CCSRState *ccsr =3D opaque;
>      PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>      CPUPPCState *env =3D &cpu->env;
>      uint32_t svr =3D env->spr[SPR_E500_SVR] >> 16;
> =20
> +    switch (addr) {
> +    case E500_CCSRBAR:
> +        value &=3D 0x000fff00;
> +        ccsr->base =3D value << 12;
> +        sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
> +        return;
> +    case E500_ERR_DISABLE:
> +        ccsr->merrd =3D value & 0xd;
> +        return;
> +    }
> +
>      switch (svr) {
>      case 0: /* generic.  assumed to be mpc8544ds or e500plat board */
>      case 0x8034: /* mpc8544 */
> @@ -104,11 +148,20 @@ static const MemoryRegionOps e500_ccsr_ops =3D {
>      }
>  };
> =20
> +static int e500_ccsr_post_load(void *opaque, int version_id)
> +{
> +    CCSRState *ccsr =3D opaque;
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
> +    return 0;
> +}
> +
>  static void e500_ccsr_reset(DeviceState *dev)
>  {
>      CCSRState *ccsr =3D E500_CCSR(dev);
> =20
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ccsr->defbase);
> +    ccsr->base =3D ccsr->defbase;
> +    e500_ccsr_post_load(ccsr, 1);
>  }
> =20
>  static void e500_ccsr_initfn(Object *obj)
> @@ -123,15 +176,30 @@ static void e500_ccsr_initfn(Object *obj)
> =20
>  static Property e500_ccsr_props[] =3D {
>      DEFINE_PROP_UINT32("base", CCSRState, defbase, 0xff700000),
> +    DEFINE_PROP_UINT32("ram-size", CCSRState, ram_size, 0),
> +    DEFINE_PROP_UINT32("porpllsr", CCSRState, porpllsr, 0),
>      DEFINE_PROP_END_OF_LIST()
>  };
> =20
> +static const VMStateDescription vmstate_e500_ccsr =3D {
> +    .name =3D TYPE_E500_CCSR,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D e500_ccsr_post_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(base, CCSRState),
> +        VMSTATE_UINT32(merrd, CCSRState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static
>  void e500_ccsr_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
>      dc->props =3D e500_ccsr_props;
> +    dc->vmsd =3D &vmstate_e500_ccsr;
>      dc->reset =3D e500_ccsr_reset;
>  }
> =20
> diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> index 3d07987bd1..4e763d9c09 100644
> --- a/hw/ppc/e500plat.c
> +++ b/hw/ppc/e500plat.c
> @@ -47,6 +47,7 @@ static void e500plat_init(MachineState *machine)
>          .pci_mmio_base =3D 0xC00000000ULL,
>          .pci_mmio_bus_base =3D 0xE0000000ULL,
>          .spin_base =3D 0xFEF000000ULL,
> +        .porpllsr =3D 0, /* TODO missing valid value */
>          .decrementor_freq =3D 400000000,
>      };
> =20
> diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
> index 6d9931c475..f5e0042245 100644
> --- a/hw/ppc/mpc8544ds.c
> +++ b/hw/ppc/mpc8544ds.c
> @@ -40,6 +40,7 @@ static void mpc8544ds_init(MachineState *machine)
>          .pci_mmio_bus_base =3D 0xC0000000ULL,
>          .pci_pio_base =3D 0xE1000000ULL,
>          .spin_base =3D 0xEF000000ULL,
> +        .porpllsr =3D 0, /* TODO missing valid value */
>          .decrementor_freq =3D 400000000,
>      };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EVh9lyqKgK19OcEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU9cAACgkQbDjKyiDZ
s5K2wxAAyLDNhziomYUuKDcy4/EfwofCXV+4gn1q866kTJAz1pruq6acIUBq7Cfk
hXf5ZPG0WBImVZp6E8EXr38CEQssqk2oyqhrn3MptC444QbvoSMKtnWvQnAPb5vI
n4NHvQzBtDgEn0et4OZMtJmaoJql0rq0KQwmn7V1yCmNrmbbjk2uNjXvo2DQbksj
Gv9N1IV7f8IVI2gpOTqCXmH0zjU+oSC0fJKm5Z3XI6le+9eo1xgdpjnMI6kedQWo
vHTXD0yrVjG9fHLywnDw6/SHcFhJKIBacfym1vNUT1OfgUJZZw1u6PXsDVWOdbL7
JA2rb9Un1TXQCe8xpydbAMfXKJxFv1kHPV9cnCWShkcImDOWbl6JL5CcB4v5sn3G
HU1be1RB1cuCDlLRMEzF2l1SXHm/HzBQuwtoPEax4q9FZsg0/0Vw85qHsTXMwK8t
uZ3ba7SA3lY4EFdE3z5OxcZnE4ssnzveNYu6cV1at3EG0zoFGAGgurBT1ix5j5HI
khFGQ/oRZEahaMH5xAlFGOg05nlviivd0sE98LpQFrhf4OGBrt4Iiu3XW4BRrXSf
4A/WonT+yIv3dqWkK1DSFAqQKhSbN4raCillajc/xiaAwTWsBEhHVmJBJqdjWXEI
Qdk1+dGuDL8qVMeSnCssWx/vUNeEMcxHZ8HipgZCsy4XvnsuIlk=
=+irm
-----END PGP SIGNATURE-----

--EVh9lyqKgK19OcEf--
