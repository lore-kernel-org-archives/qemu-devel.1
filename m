Received: from eggs.gnu.org ([2001:4830:134:3::10]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEv-0001sN-6H
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEt-0005pJ-Sn
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:45 -0400
Date: Thu, 23 Mar 2017 15:20:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323042015.GL19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-9-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-9-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] ppc/pnv: add memory regions for the
 ICP registers
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


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:12PM +0100, C=E9dric Le Goater wrote:
> This provides to a PowerNV chip (POWER8) access to the Interrupt
> Management area, which contains the registers of the Interrupt Control
> Presenters of each thread. These are used to accept, return, forward
> interrupts in the system.
>=20
> This area is modeled with a per-chip container memory region holding
> all the ICP registers. Each thread of a chip is then associated with
> its ICP registers using a memory subregion indexed by its PIR number
> in the overall region.
>=20
> The device tree is populated accordingly.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v1:
>=20
>  - added multichip support
>  - adapted to use PnvICPState object
>=20
>  hw/ppc/pnv.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/pnv.h | 19 ++++++++++++
>  2 files changed, 100 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9c239932fb3a..f91e16955fa8 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -218,6 +218,43 @@ static void powernv_create_core_node(PnvChip *chip, =
PnvCore *pc, void *fdt)
>                         servers_prop, sizeof(servers_prop))));
>  }
> =20
> +static void powernv_populate_icp(PnvChip *chip, void *fdt, uint32_t pir,
> +                                 uint32_t nr_threads)
> +{
> +    uint64_t addr =3D PNV_ICP_BASE(chip) | (pir << 12);
> +    char *name;
> +    const char compat[] =3D "IBM,power8-icp\0IBM,ppc-xicp";
> +    uint32_t irange[2], i, rsize;
> +    uint64_t *reg;
> +    int offset;
> +
> +    irange[0] =3D cpu_to_be32(pir);
> +    irange[1] =3D cpu_to_be32(nr_threads);
> +
> +    rsize =3D sizeof(uint64_t) * 2 * nr_threads;
> +    reg =3D g_malloc(rsize);
> +    for (i =3D 0; i < nr_threads; i++) {
> +        reg[i * 2] =3D cpu_to_be64(addr | ((pir + i) * 0x1000));
> +        reg[i * 2 + 1] =3D cpu_to_be64(0x1000);
> +    }
> +
> +    name =3D g_strdup_printf("interrupt-controller@%"PRIX64, addr);
> +    offset =3D fdt_add_subnode(fdt, 0, name);
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
> @@ -231,6 +268,10 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
>          PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> =20
>          powernv_create_core_node(chip, pnv_core, fdt);
> +
> +        /* Interrupt Control Presenters (ICP). One per core. */
> +        powernv_populate_icp(chip, fdt, pnv_core->pir,
> +                             CPU_CORE(pnv_core)->nr_threads);
>      }
> =20
>      if (chip->ram_size) {
> @@ -663,6 +704,38 @@ static void pnv_chip_init(Object *obj)
>      object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
>  }
> =20
> +static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
> +{
> +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> +    char *typename =3D pnv_core_typename(pcc->cpu_model);
> +    size_t typesize =3D object_type_get_instance_size(typename);
> +    int i, j;
> +    char *name;
> +    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
> +
> +    name =3D g_strdup_printf("icp-%x", chip->chip_id);
> +    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE=
);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
> +    g_free(name);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
> +
> +    /* Map the ICP registers for each thread */
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
> +        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
> +
> +        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
> +            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
> +            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
> +
> +            memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp=
->mmio);
> +        }
> +    }
> +
> +    g_free(typename);
> +}
> +
>  static void pnv_chip_realize(DeviceState *dev, Error **errp)
>  {
>      PnvChip *chip =3D PNV_CHIP(dev);
> @@ -729,6 +802,14 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
>      }
>      g_free(typename);
> =20
> +    /* Interrupt Management Area. This is the memory region holding
> +     * all the Interrupt Control Presenter (ICP) registers */
> +    pnv_chip_icp_realize(chip, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
>      /* Create LPC controller */
>      object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
>                               &error_fatal);
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index cfd059fc49db..8e8ca548967d 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -55,6 +55,7 @@ typedef struct PnvChip {
>      MemoryRegion xscom_mmio;
>      MemoryRegion xscom;
>      AddressSpace xscom_as;
> +    MemoryRegion icp_mmio;
> =20
>      PnvLpcController lpc;
>  } PnvChip;
> @@ -140,4 +141,22 @@ typedef struct PnvMachineState {
>  #define PNV_XSCOM_BASE(chip)                                            \
>      (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
> =20
> +/*
> + * XSCOM 0x20109CA defines the ICP BAR:
> + *
> + * 0:29   : bits 14 to 43 of address to define 1 MB region.
> + * 30     : 1 to enable ICP to receive loads/stores against its BAR regi=
on
> + * 31:63  : Constant 0
> + *
> + * Usually defined as :
> + *
> + *      0xffffe00200000000 -> 0x0003ffff80000000
> + *      0xffffe00600000000 -> 0x0003ffff80100000
> + *      0xffffe02200000000 -> 0x0003ffff80800000
> + *      0xffffe02600000000 -> 0x0003ffff80900000
> + */
> +#define PNV_ICP_SIZE         0x0000000000100000ull
> +#define PNV_ICP_BASE(chip)                                              \
> +    (0x0003ffff80000000ull + (uint64_t) PNV_CHIP_INDEX(chip) * PNV_ICP_S=
IZE)
> +
>  #endif /* _PPC_PNV_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00z/AAoJEGw4ysog2bOS1RsP/0uT3EUWgB95n4is4SeAv1Mk
aeRAPVqRvuXNjX7YxVOHDFdhGAHFk2nbyBtiJ9v6MdddTaM22rGbjxHbB4tmv5t5
bXvz+B/dKRh7sy4RSKww6vfErkyEu0ExAJ0fC86AL4Lctj8XMkrIY+FDVRknI+8T
U71JDxD9lGBpPlferWgx0reBgJzv5Lvr6LJ2QO+6f8thmOJSy1mSNMRm5ZdDlcWf
mASUlhqIjy8hqobyhXZv9whHxcWvW6IHjlRkv4pqWEDeNorwDJ6t1NS4o/HRYHCJ
yO1SgTzoi3N/0cg1ps926lg9Y3v353ZkW2hYRwjS5nxqdNSbnaQ5qALs7nzX9xce
UQIQoGqOix5/mE8eR9YRs6V2O+mpIPR67CyQBSsFPxy3xLnX5ZjTuYhEKX/yDp9q
nOawvUMNeP2ZrJGJUQxMHi34IVtHEP2dlGMXxtnuFBJqbvs9P4+FNSrDiFGc9kNy
MaG0AUm7uKAUF7p4y0zeo2HaeYo8AEBxZw0Jo/Uosa2ov4EKmJ370AIVKPBtoSxh
dulf48bSVY1Ptm24yT7WKlHVFTFLy4eonvsWpP9amPh+CE3wAv1mSFHiNsA3LsXg
9/G72U2LCQ81UuEU6QsZU0zzE5csxZwZWuR7+M15SoRbAN0QH7xrHj+o0FDXjwnE
XrK3by1xrPBPP8a40zVI
=6wEJ
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
