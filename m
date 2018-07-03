Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BJ-00085z-Ro
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fa9BG-0001wG-NQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 20:28:33 -0400
Date: Tue, 3 Jul 2018 10:19:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180703001903.GD3422@umbus.fritz.box>
References: <20180702093755.7384-1-david@redhat.com>
	<20180702093755.7384-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aDj5WtVma0yWCzS8"
Content-Disposition: inline
In-Reply-To: <20180702093755.7384-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] pc-dimm: assign and verify the
 "addr" property during pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>


--aDj5WtVma0yWCzS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 11:37:55AM +0200, David Hildenbrand wrote:
> We can assign and verify the slot before realizing and trying to plug.
> reading/writing the address property should never fail for DIMMs, so let's
> reduce error handling a bit by using &error_abort. Getting access to the
> memory region now might however fail. So forward errors from
> get_memory_region() properly.
>=20
> As all memory devices should use the alignment of the underlying memory
> region for guest physical address asignment, do detection of the
> alignment in pc_dimm_pre_plug(), but allow pc.c to overwrite the
> alignment for compatibility handling.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             | 16 ++++---------
>  hw/mem/pc-dimm.c         | 50 +++++++++++++++++++++-------------------
>  hw/ppc/spapr.c           |  7 +++---
>  include/hw/mem/pc-dimm.h |  6 ++---
>  4 files changed, 37 insertions(+), 42 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 934b7155b1..54f3c954a5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1678,7 +1678,9 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>                                 Error **errp)
>  {
>      const PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> +    const PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      const bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIM=
M);
> +    const uint64_t legacy_align =3D TARGET_PAGE_SIZE;
> =20
>      /*
>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
> @@ -1696,7 +1698,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev),
> +                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, =
errp);
>  }
> =20
>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> @@ -1705,18 +1708,9 @@ static void pc_memory_plug(HotplugHandler *hotplug=
_dev,
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
> -    PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
> -    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> -    uint64_t align =3D TARGET_PAGE_SIZE;
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> -    if (pcmc->enforce_aligned_dimm) {
> -        align =3D memory_region_get_alignment(mr);
> -    }
> -
> -    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
> +    pc_dimm_plug(dev, MACHINE(pcms), &local_err);
>      if (local_err) {
>          goto out;
>      }
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index e56c4daef2..fb6bcaedc4 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -29,9 +29,14 @@
> =20
>  static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error *=
*errp);
> =20
> -void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **e=
rrp)
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
> +                      const uint64_t *legacy_align, Error **errp)
>  {
> +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      Error *local_err =3D NULL;
> +    MemoryRegion *mr;
> +    uint64_t addr, align;
>      int slot;
> =20
>      slot =3D object_property_get_int(OBJECT(dev), PC_DIMM_SLOT_PROP,
> @@ -43,44 +48,41 @@ void pc_dimm_pre_plug(DeviceState *dev, MachineState =
*machine, Error **errp)
>      }
>      object_property_set_int(OBJECT(dev), slot, PC_DIMM_SLOT_PROP, &error=
_abort);
>      trace_mhp_pc_dimm_assigned_slot(slot);
> +
> +    mr =3D ddc->get_memory_region(dimm, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    align =3D legacy_align ? *legacy_align : memory_region_get_alignment=
(mr);
> +    addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
> +                                    &error_abort);
> +    addr =3D memory_device_get_free_addr(machine, !addr ? NULL : &addr, =
align,
> +                                       memory_region_size(mr), &local_er=
r);
> +    if (local_err) {
> +        goto out;
> +    }
> +    trace_mhp_pc_dimm_assigned_address(addr);
> +    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP,
> +                             &error_abort);
>  out:
>      error_propagate(errp, local_err);
>  }
> =20
> -void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
> -                  Error **errp)
> +void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp)
>  {
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm,
>                                                                &error_abo=
rt);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> -    Error *local_err =3D NULL;
>      uint64_t addr;
> =20
> -    addr =3D object_property_get_uint(OBJECT(dimm),
> -                                    PC_DIMM_ADDR_PROP, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    addr =3D memory_device_get_free_addr(machine, !addr ? NULL : &addr, =
align,
> -                                       memory_region_size(mr), &local_er=
r);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    object_property_set_uint(OBJECT(dev), addr, PC_DIMM_ADDR_PROP, &loca=
l_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -    trace_mhp_pc_dimm_assigned_address(addr);
> +    addr =3D object_property_get_uint(OBJECT(dev), PC_DIMM_ADDR_PROP,
> +                                    &error_abort);
> =20
>      memory_device_plug_region(machine, mr, addr);
>      vmstate_register_ram(vmstate_mr, dev);
> -
> -out:
> -    error_propagate(errp, local_err);
>  }
> =20
>  void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bf012235b6..33543c6373 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3150,13 +3150,12 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> -    uint64_t align, size, addr;
> +    uint64_t size, addr;
>      uint32_t node;
> =20
> -    align =3D memory_region_get_alignment(mr);
>      size =3D memory_region_size(mr);
> =20
> -    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
> +    pc_dimm_plug(dev, MACHINE(ms), &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -3223,7 +3222,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          return;
>      }
> =20
> -    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), errp);
> +    pc_dimm_pre_plug(dev, MACHINE(hotplug_dev), NULL, errp);
>  }
> =20
>  struct sPAPRDIMMState {
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 7b120416d1..b382eb4303 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -79,8 +79,8 @@ typedef struct PCDIMMDeviceClass {
>                                                 Error **errp);
>  } PCDIMMDeviceClass;
> =20
> -void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine, Error **e=
rrp);
> -void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
> -                  Error **errp);
> +void pc_dimm_pre_plug(DeviceState *dev, MachineState *machine,
> +                      const uint64_t *legacy_align, Error **errp);
> +void pc_dimm_plug(DeviceState *dev, MachineState *machine, Error **errp);
>  void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aDj5WtVma0yWCzS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls6wPUACgkQbDjKyiDZ
s5LDMhAAqAc6JjIL1JqAFtGpxE8DJgm+36BomVCtSMRYwEkDe+ZEugnyheKd6+du
DwYdutYZQsp9CB3qaEiTpUTAMTMefnC7PP9PLI5EgfxJ15YKHwiVVFda5Vc3bgVk
MdaYwKt4FPUd/9siPvJVSuJNtvlzNWz4t/Ag4v6jX4WveZoEkRvQACUNU+iODQgv
eORp5VU77pvLWRNtr392Us54DNTDRoPMLOC8zZclRg4G4yT5q7ZExO88ayK0J77A
Jou5JnUTwt2nZg8QvNNC5hh0PkOamyAckpzIKq88vBSra5wSmYHXBfBryjO57XFN
WzP1TldtTv16ABpm5E1OS6Bhf6uYH0wNpNCHejzHNvs5R4SoQJPxyjdp7oG1DjBW
3F9D7wUusszHqFUlD8bA5zKF3RVvWGlQxadPm4GCib5SI7nQtGv0rr53xr5lNNmm
/wRTrKuH/lfUiKbVTeWlQ4SWzXwIuKNKm35gMDX9gWeJseZWpvzCyEBkpHA+BAhL
D4lHyYfzJdmwJyinuSShprZZqNHwJMO1P15uAt7w3o8HCUFm2xpZe1JSKsDGMxBO
F8CzsbBYXgOllzr9DdkcZki7/+BqbLvxSFXuCUQjAWlGOaVY9Q+mbFNuJA09gGTS
SRKYG5tgy5T/+Br1Xku58zUKe7nOcKL4m8V4wLCdqZUkVHw+050=
=W+vg
-----END PGP SIGNATURE-----

--aDj5WtVma0yWCzS8--
