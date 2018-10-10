Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA2xW-00008o-Lv
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 21:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gA2xU-0005Ys-Lo
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 21:06:42 -0400
Date: Wed, 10 Oct 2018 12:06:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181010010607.GI7004@umbus.fritz.box>
References: <1539002382-3764-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+N3zU4ZlskbnZaJ"
Content-Disposition: inline
In-Reply-To: <1539002382-3764-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/ppc/spapr_rng: Introduce
 CONFIG_SPAPR_RNG switch for spapr_rng.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--2+N3zU4ZlskbnZaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 02:39:42PM +0200, Thomas Huth wrote:
> The spapr-rng device is suboptimal when compared to virtio-rng, so
> users might want to disable it in their builds. Thus let's introduce
> a proper CONFIG switch to allow us to compile QEMU without this device.
> The function spapr_rng_populate_dt is required for linking, so move it
> to a different location.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-3.1, thanks.

> ---
>  v2: Put spapr_rng_populate_dt() into spapr.c instead of a header
>=20
>  default-configs/ppc64-softmmu.mak |  1 +
>  hw/ppc/Makefile.objs              |  3 ++-
>  hw/ppc/spapr.c                    | 23 +++++++++++++++++++++++
>  hw/ppc/spapr_rng.c                | 23 -----------------------
>  include/hw/ppc/spapr.h            |  2 --
>  5 files changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-so=
ftmmu.mak
> index b94af6c..24d4717 100644
> --- a/default-configs/ppc64-softmmu.mak
> +++ b/default-configs/ppc64-softmmu.mak
> @@ -17,3 +17,4 @@ CONFIG_XICS=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_SPAPR=3D$(CONFIG_PSERIES)
>  CONFIG_XICS_KVM=3D$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
>  CONFIG_MEM_HOTPLUG=3Dy
> +CONFIG_SPAPR_RNG=3Dy
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 4ab5564..4e0c1c0 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -3,8 +3,9 @@ obj-y +=3D ppc.o ppc_booke.o fdt.o
>  # IBM pSeries (sPAPR)
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> -obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
=2Eo
> +obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
>  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> +obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
>  # IBM PowerNV
>  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
>  ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 98868d8..e666872 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -610,6 +610,29 @@ static void spapr_populate_cpus_dt_node(void *fdt, s=
PAPRMachineState *spapr)
>      g_free(rev);
>  }
> =20
> +static int spapr_rng_populate_dt(void *fdt)
> +{
> +    int node;
> +    int ret;
> +
> +    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
> +    if (node <=3D 0) {
> +        return -1;
> +    }
> +    ret =3D fdt_setprop_string(fdt, node, "device_type",
> +                             "ibm,platform-facilities");
> +    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
> +    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
> +
> +    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
> +    if (node <=3D 0) {
> +        return -1;
> +    }
> +    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
> +
> +    return ret ? -1 : 0;
> +}
> +
>  static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_=
t addr)
>  {
>      MemoryDeviceInfoList *info;
> diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
> index d2acd61..644bac9 100644
> --- a/hw/ppc/spapr_rng.c
> +++ b/hw/ppc/spapr_rng.c
> @@ -132,29 +132,6 @@ static void spapr_rng_realize(DeviceState *dev, Erro=
r **errp)
>      }
>  }
> =20
> -int spapr_rng_populate_dt(void *fdt)
> -{
> -    int node;
> -    int ret;
> -
> -    node =3D qemu_fdt_add_subnode(fdt, "/ibm,platform-facilities");
> -    if (node <=3D 0) {
> -        return -1;
> -    }
> -    ret =3D fdt_setprop_string(fdt, node, "device_type",
> -                             "ibm,platform-facilities");
> -    ret |=3D fdt_setprop_cell(fdt, node, "#address-cells", 0x1);
> -    ret |=3D fdt_setprop_cell(fdt, node, "#size-cells", 0x0);
> -
> -    node =3D fdt_add_subnode(fdt, node, "ibm,random-v1");
> -    if (node <=3D 0) {
> -        return -1;
> -    }
> -    ret |=3D fdt_setprop_string(fdt, node, "compatible", "ibm,random");
> -
> -    return ret ? -1 : 0;
> -}
> -
>  static Property spapr_rng_properties[] =3D {
>      DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
>      DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index ad4d7cf..0805ad8 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -745,8 +745,6 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64=
_t legacy_offset);
> =20
>  #define TYPE_SPAPR_RNG "spapr-rng"
> =20
> -int spapr_rng_populate_dt(void *fdt);
> -
>  #define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2+N3zU4ZlskbnZaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu9UH0ACgkQbDjKyiDZ
s5KszhAA1JmusZiI1nj1xb8gxc0EfmnplsFFtDB+h5R79498CbJtY7RIJcwVpUH3
B6SzgXiRUr76cYMrEkH8zOLJnZoZcc3+12BnLo2+LRvN8JlN7rE2cmec99q8G4t5
4oL6RKjw6ac9eEZ4Ol9dHBYpEiPU6kxpBtlqIBbuLwUhGgyGqmPjtuVORoUkegJW
L8V533dKAIsoWRVVtPxNhjjAaXJ0emY1MYhV6PZuDL4cTQP8Lwz2jasL/nOYBvk7
WqjcWGX18hEHqIPWBeDse9ROqnJOSKxuSS60zuJOFell6SYMIERBfJSLB60jYFQQ
jpIRMIgvxPq0qgam2ZJrwkdo0FVuhxseePi8qq5GJBkjxVknsf0iFeEJjA6+Y1Ii
U4ppvGAMhI7BmJIlIZNTr1HFP5hG7As3hGrVUXt1WfVrW+oFILOaXBe8sLBHm6Ne
eBsEQWHTOIe2RjL5NYH0i0xbYE23SdMGP34wf36ikQl4NMX5bBmX9WXxouGBu3ID
VvpirYTtZlzZXvRJXWsgUgjAlds7/py7HtWieQYYqAw/3RujZ3s83tZsAjBxASz4
M2QSe2iV1n8ERfao2h9GZ2eEIorA3HFYbs1y5IL+3DFOfSPbzRx1sEeOQYXnNGdZ
l1Q+P4QAn6uDSAUJD6g/3q/17xm8l6gV1m/NqqiLWNdMjvH+Rtk=
=9qUH
-----END PGP SIGNATURE-----

--2+N3zU4ZlskbnZaJ--
