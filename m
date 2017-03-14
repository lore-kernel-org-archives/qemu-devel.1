Received: from eggs.gnu.org ([2001:4830:134:3::10]:36396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQQ-00009l-9a
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cnfQO-0004W6-UZ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 01:55:14 -0400
Date: Tue, 14 Mar 2017 16:52:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170314055245.GL12564@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-6-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hdW7zL/qDS6RXdAL"
Content-Disposition: inline
In-Reply-To: <1488970371-8865-6-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10 5/8] ppc/pnv: map the ICP memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--hdW7zL/qDS6RXdAL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 11:52:48AM +0100, C=E9dric Le Goater wrote:
> and populate the device tree accordingly for the guest to start using
> interrupts. This also links the ICP object to its associated CPUState
> (only used by KVM to control the kernel vCPU).
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c      | 55 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/pnv_core.c | 12 ++++++++----
>  2 files changed, 63 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 7b13b08deadf..0ae11cc3a2ca 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -35,6 +35,7 @@
>  #include "monitor/monitor.h"
>  #include "hw/intc/intc.h"
> =20
> +#include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> =20
>  #include "hw/isa/isa.h"
> @@ -216,6 +217,47 @@ static void powernv_create_core_node(PnvChip *chip, =
PnvCore *pc, void *fdt)
>                         servers_prop, sizeof(servers_prop))));
>  }
> =20
> +static void powernv_populate_icp(PnvChip *chip, void *fdt, int offset,
> +                          uint32_t pir, uint32_t count)
> +{
> +    uint64_t addr;
> +    char *name;
> +    const char compat[] =3D "IBM,power8-icp\0IBM,ppc-xicp";
> +    uint32_t irange[2], i, rsize;
> +    uint64_t *reg;
> +
> +    /*
> +     * TODO: add multichip ICP BAR
> +     */
> +    addr =3D PNV_ICP_BASE(chip) | (pir << 12);
> +
> +    irange[0] =3D cpu_to_be32(pir);
> +    irange[1] =3D cpu_to_be32(count);
> +
> +    rsize =3D sizeof(uint64_t) * 2 * count;
> +    reg =3D g_malloc(rsize);
> +    for (i =3D 0; i < count; i++) {
> +        reg[i * 2] =3D cpu_to_be64(addr | ((pir + i) * 0x1000));
> +        reg[i * 2 + 1] =3D cpu_to_be64(0x1000);
> +    }
> +
> +    name =3D g_strdup_printf("interrupt-controller@%"PRIX64, addr);
> +    offset =3D fdt_add_subnode(fdt, offset, name);
> +    _FDT(offset);
> +    g_free(name);
> +
> +    _FDT((fdt_setprop(fdt, offset, "compatible", compat, sizeof(compat))=
));
> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, rsize)));
> +    _FDT((fdt_setprop_string(fdt, offset, "device_type",
> +                              "PowerPC-External-Interrupt-Presentation")=
));
> +    _FDT((fdt_setprop(fdt, offset, "interrupt-controller", NULL, 0)));
> +    _FDT((fdt_setprop(fdt, offset, "ibm,interrupt-server-ranges",
> +                       irange, sizeof(irange))));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#interrupt-cells", 1)));
> +    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0)));
> +    g_free(reg);
> +}
> +
>  static void powernv_populate_chip(PnvChip *chip, void *fdt)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> @@ -229,6 +271,10 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> =20
>          powernv_create_core_node(chip, pnv_core, fdt);
> +
> +        /* Interrupt Control Presenters (ICP). One per thread. */
> +        powernv_populate_icp(chip, fdt, 0, pnv_core->pir,

All the xicp nodes under the root bus, is that correct?

> +                             CPU_CORE(pnv_core)->nr_threads);
>      }
> =20
>      if (chip->ram_size) {
> @@ -697,6 +743,7 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
>          error_propagate(errp, error);
>          return;
>      }
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> =20
>      /* Cores */
>      pnv_chip_core_sanitize(chip, &error);
> @@ -711,6 +758,7 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
>               && (i < chip->nr_cores); core_hwid++) {
>          char core_name[32];
>          void *pnv_core =3D chip->cores + i * typesize;
> +        int j;
> =20
>          if (!(chip->cores_mask & (1ull << core_hwid))) {
>              continue;
> @@ -738,6 +786,13 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
>                                  PNV_XSCOM_EX_CORE_BASE(pcc->xscom_core_b=
ase,
>                                                         core_hwid),
>                                  &PNV_CORE(pnv_core)->xscom_regs);
> +
> +        /* Map the ICP registers for each thread */
> +        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
> +            memory_region_add_subregion(&chip->icp_mmio,
> +                                 (pcc->core_pir(chip, core_hwid) + j) <<=
 12,
> +                                  &PNV_CORE(pnv_core)->icp_mmios[j]);
> +        }
>          i++;
>      }
>      g_free(typename);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 8633afbff795..d28fa445b11b 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -25,6 +25,7 @@
>  #include "hw/ppc/pnv.h"
>  #include "hw/ppc/pnv_core.h"
>  #include "hw/ppc/pnv_xscom.h"
> +#include "hw/ppc/xics.h"
> =20
>  static uint64_t pnv_core_icp_read(void *opaque, hwaddr addr, unsigned wi=
dth)
>  {
> @@ -165,7 +166,7 @@ static void powernv_cpu_reset(void *opaque)
>      env->msr |=3D MSR_HVB; /* Hypervisor mode */
>  }
> =20
> -static void powernv_cpu_init(PowerPCCPU *cpu, Error **errp)
> +static void powernv_cpu_init(PowerPCCPU *cpu, XICSFabric *xi, Error **er=
rp)
>  {
>      CPUPPCState *env =3D &cpu->env;
>      int core_pir;
> @@ -185,6 +186,9 @@ static void powernv_cpu_init(PowerPCCPU *cpu, Error *=
*errp)
>      cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
> =20
>      qemu_register_reset(powernv_cpu_reset, cpu);
> +
> +    /* xics_cpu_setup() assigns the CPU to the ICPState */
> +    xics_cpu_setup(xi, cpu);
>  }
> =20
>  /*
> @@ -232,7 +236,7 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D {
>      .endianness =3D DEVICE_BIG_ENDIAN,
>  };
> =20
> -static void pnv_core_realize_child(Object *child, Error **errp)
> +static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
>  {
>      Error *local_err =3D NULL;
>      CPUState *cs =3D CPU(child);
> @@ -244,7 +248,7 @@ static void pnv_core_realize_child(Object *child, Err=
or **errp)
>          return;
>      }
> =20
> -    powernv_cpu_init(cpu, &local_err);
> +    powernv_cpu_init(cpu, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -298,7 +302,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
>      for (j =3D 0; j < cc->nr_threads; j++) {
>          obj =3D pc->threads + j * size;
> =20
> -        pnv_core_realize_child(obj, &local_err);
> +        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>          if (local_err) {
>              goto err;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hdW7zL/qDS6RXdAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYx4UtAAoJEGw4ysog2bOSGX0P/3EuOiPnzeZAr2PZ2/AJeEKI
c/Ky3n6I25CsBc8Ht96MUS1pnjKTvYC/yYQc6bVGciRGoHCc69EcvZNNR17BXDV9
njUU1yLi39+9+OSJDhI3byMtUwYTZPa07QP9eBqbdbabxEGeIFZ7TFXBqNtfEUgK
CuDgCQCw+WqC+X6VBzVAN6/TyQrbWgZ4WyOuwl/K/WpUpddE4PtRZBTbvDt1+8R8
DUwBf5GB3/6oMkPRBWtyerGtOhmS/MvwRQaVOMom5mNH+yJhcIgq0Rb7l3GThiiC
68RK1/68IUiRVvhTFR7ql/PsSMOp7LHoM0ebv5aYHzmIPsDSizkxUG1Lq5dJHTsC
VhY8bqCCpskABZyUIDDe1DTiUHeqxbLPCDxKKGUZU4/zDJx7Ya801l8wXSijsewB
yIsKIx2ONdVRS5gDvkp7LnnalQq/KWYshjv3r3A/18e6yzIaSaA+x4rO+MCFLGo4
iPHisJpmZW3jXSf4lEy0MqEllDopmzWXYABGiKMOHfSy0Y2zrsBC5MrDQKNV6Ekw
19Jbjr8SFnng9l5oe6LDyOXD+oGg/thQyDg3bREtfZz3dIpuE4pc8TFY8DtWFZUj
5uSw/gT66NzZ5MIkBlIame6y4b9jmlVEvwNTaJCf1CWYx7jMb0wUL2cuuPmT3LAN
t0DEX5V46YW3imeRfv6h
=sfyn
-----END PGP SIGNATURE-----

--hdW7zL/qDS6RXdAL--
