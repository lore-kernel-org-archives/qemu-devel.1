Received: from eggs.gnu.org ([2001:4830:134:3::10]:39477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLnCC-0003pS-Fa
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLnC5-0005ts-PH
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 04:37:47 -0500
Date: Mon, 4 Dec 2017 20:30:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204093013.GA3057@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<11edba0f74534a8013e6264f8a4f0cdf064a9ecd.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <11edba0f74534a8013e6264f8a4f0cdf064a9ecd.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] e500: additional CCSR registers
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


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:59:06PM -0600, Michael Davidsaver wrote:
> Add CCSRBAR to allow CCSR region to be relocated.
>=20
> Guest memory size introspection via RAM config
> registers.
>=20
> Dummy RAM error controls.
>=20
> Clock introspection via Power on Reset PLL
> Status Register.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

>=20
> ccsrbase also update iack
> ---
>  hw/ppc/e500.c      |  5 ++-
>  hw/ppc/e500_ccsr.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 95 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index b90f4231a6..e22919f4f1 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -51,7 +51,9 @@
> =20
>  #define RAM_SIZES_ALIGN            (64UL << 20)
> =20
> -/* TODO: parameterize */
> +/* TODO: parameterize
> + * Some CCSR offsets duplicated in e500_ccsr.c
> + */
>  #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>  #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
>  #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
> @@ -856,6 +858,7 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>      object_property_add_child(qdev_get_machine(), "e500-ccsr",
>                                OBJECT(dev), NULL);
>      qdev_prop_set_uint32(dev, "base", params->ccsrbar_base);
> +    qdev_prop_set_uint32(dev, "ram-size", ram_size);
>      qdev_init_nofail(dev);
>      ccsr_addr_space =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> =20
> diff --git a/hw/ppc/e500_ccsr.c b/hw/ppc/e500_ccsr.c
> index 1b586c3f42..9400d7cf13 100644
> --- a/hw/ppc/e500_ccsr.c
> +++ b/hw/ppc/e500_ccsr.c
> @@ -30,13 +30,26 @@
>  #include "hw/sysbus.h"
> =20
>  /* E500_ denotes registers common to all */
> +/* Some CCSR offsets duplicated in e500.c */
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
>  #define MPC8544_RSTCR       (0xE00B0)
>  #define MPC8544_RSTCR_RESET      (0x02)
> =20
> +#define E500_MPIC_OFFSET   (0x40000ULL)
> +
>  typedef struct {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -44,19 +57,59 @@ typedef struct {
> =20
>      MemoryRegion iomem;
> =20
> -    uint32_t defbase;
> +    uint32_t defbase, base;
> +    uint32_t ram_size;
> +    uint32_t merrd;
> +
> +    uint32_t porpllsr;
> +
> +    DeviceState *pic;
>  } CCSRState;
> =20
>  #define TYPE_E500_CCSR "e500-ccsr"
>  #define E500_CCSR(obj) OBJECT_CHECK(CCSRState, (obj), TYPE_E500_CCSR)
> =20
> +/* call after changing CCSRState::base */
> +static void e500_ccsr_post_move(CCSRState *ccsr)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
> +
> +        env->mpic_iack =3D ccsr->base +
> +                         E500_MPIC_OFFSET + 0xa0;
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(ccsr), 0, ccsr->base);
> +}
> +
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
> @@ -72,10 +125,22 @@ static uint64_t e500_ccsr_read(void *opaque, hwaddr =
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
> +        e500_ccsr_post_move(ccsr);
> +        return;
> +    case E500_ERR_DISABLE:
> +        ccsr->merrd =3D value & 0xd;
> +        return;
> +    }
> +
>      switch (svr) {
>      case 0: /* generic.  assumed to be mpc8544ds or e500plat board */
>      case 0x8034: /* mpc8544 */
> @@ -104,11 +169,20 @@ static const MemoryRegionOps e500_ccsr_ops =3D {
>      }
>  };
> =20
> +static int e500_ccsr_post_load(void *opaque, int version_id)
> +{
> +    CCSRState *ccsr =3D opaque;
> +
> +    e500_ccsr_post_move(ccsr);
> +    return 0;
> +}
> +
>  static void e500_ccsr_reset(DeviceState *dev)
>  {
>      CCSRState *ccsr =3D E500_CCSR(dev);
> =20
> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ccsr->defbase);
> +    ccsr->base =3D ccsr->defbase;
> +    e500_ccsr_post_move(ccsr);
>  }
> =20
>  static void e500_ccsr_initfn(Object *obj)
> @@ -123,15 +197,30 @@ static void e500_ccsr_initfn(Object *obj)
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlolFaMACgkQbDjKyiDZ
s5JLkxAAuL2w5j3alwLQLKEX4LOi68VhrHRtUxOiWTowWieJdV5EcyJcPIbpRDnq
sw8EcvYv22MRvEyBZaN9vUR5HotvXag5y6nnexYS1M1+59zj/vchIAcnQui70tMU
XfgYmwm1yH//ahY31xlO4zGthDfyvAlTqpdmIVqmeeq0bbKjz5OF51hXBbzPv9Pp
iyM94aM0/N7cZVRgdCvoYGPlpk11N1mx9S+/mXp+G6EHSM89hdCCAJtlgFM94nMf
Va5QAF4ps9VJ8JhucRSKo1/OTGGuaUGpjH1UXYTSfO53uE7sAj49mORoy2F+UC4l
zw1kUvdejBlTZ0Il26RSPRiJn/TTNXqCs1OqKwxxGL960I8EW+9kImKN1gh0T00u
YWKNKefaEQaZ41uLVcyo+r9NaBc10CA4xqD9i/uXZfVIjMemJY6/p+dHv22GGsZa
0jTQ0yiW5QLYcHOdeTqtzj+AzOxbDfgqZaVBzZS5XDQJgAkbJXa4B5uQqHf5jlOr
Ny8WltkTcfsrZDjJ/kMkXFbO51VvOtq5xvG+yG1QamO73rn/k83lkK1sbPvQ0RiE
evMiTjd8qwtsLYpZPB7Lg6Xrf3vSMyycXZTlHByMhAWANFYCP3O6agLgjKt4PzNz
ee7O3SG9ZEXbexOf1bIJIE7ENppJQQJ1OygGTMhUgNRbDM1eNZ8=
=xYVw
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
