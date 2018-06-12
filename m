Received: from eggs.gnu.org ([2001:4830:134:3::10]:40288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOv-0002nQ-6k
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOq-0002Nj-Ul
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:13 -0400
Date: Tue, 12 Jun 2018 11:10:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612011033.GP2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1BKOZKwX7DAU5odC"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-8-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 07/11] pc-dimm: get_memory_region() can
 never fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--1BKOZKwX7DAU5odC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:51PM +0200, David Hildenbrand wrote:
> We already verify when realizing that the memdev property has been
> set. We have no more accesses to get_memory_region() before the device
> is realized.
>=20
> So this function will never fail. Remove the stale check and the
> error variable. Add a comment to the functions stating that they should
> never be called on uninitialized devices.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

and ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             |  7 +------
>  hw/mem/nvdimm.c          |  2 +-
>  hw/mem/pc-dimm.c         | 21 ++++++---------------
>  hw/ppc/spapr.c           | 14 +++-----------
>  include/hw/mem/pc-dimm.h |  4 +++-
>  5 files changed, 14 insertions(+), 34 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 85c040482e..017396fe84 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1706,15 +1706,10 @@ static void pc_dimm_plug(HotplugHandler *hotplug_=
dev,
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint64_t align =3D TARGET_PAGE_SIZE;
>      bool is_nvdimm =3D object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
>      if (memory_region_get_alignment(mr) && pcmc->enforce_aligned_dimm) {
>          align =3D memory_region_get_alignment(mr);
>      }
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index df9716231f..b2dc2bbb50 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -96,7 +96,7 @@ static void nvdimm_init(Object *obj)
>                               nvdimm_get_unarmed, nvdimm_set_unarmed, NUL=
L);
>  }
> =20
> -static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error =
**errp)
> +static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm)
>  {
>      NVDIMMDevice *nvdimm =3D NVDIMM(dimm);
> =20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 5294734529..7bb6ce509c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -35,14 +35,9 @@ void pc_dimm_memory_plug(DeviceState *dev, MachineStat=
e *machine,
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
>      Error *local_err =3D NULL;
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint64_t addr;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
>      addr =3D object_property_get_uint(OBJECT(dimm),
>                                      PC_DIMM_ADDR_PROP, &local_err);
>      if (local_err) {
> @@ -89,7 +84,7 @@ void pc_dimm_memory_unplug(DeviceState *dev, MachineSta=
te *machine)
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> =20
>      memory_device_unplug_region(machine, mr);
>      vmstate_unregister_ram(vmstate_mr, dev);
> @@ -172,7 +167,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v,=
 const char *name,
>          return;
>      }
> =20
> -    mr =3D ddc->get_memory_region(dimm, errp);
> +    mr =3D ddc->get_memory_region(dimm);
>      if (!mr) {
>          return;
>      }
> @@ -223,13 +218,9 @@ static void pc_dimm_unrealize(DeviceState *dev, Erro=
r **errp)
>      host_memory_backend_set_mapped(dimm->hostmem, false);
>  }
> =20
> -static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm, Error=
 **errp)
> +static MemoryRegion *pc_dimm_get_memory_region(PCDIMMDevice *dimm)
>  {
> -    if (!dimm->hostmem) {
> -        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set=
");
> -        return NULL;
> -    }
> -
> +    g_assert(dimm->hostmem);
>      return host_memory_backend_get_memory(dimm->hostmem);
>  }
> =20
> @@ -252,7 +243,7 @@ static uint64_t pc_dimm_md_get_region_size(const Memo=
ryDeviceState *md)
>      const PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(md);
>      MemoryRegion *mr;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &error_abort);
> +    mr =3D ddc->get_memory_region(dimm);
>      if (!mr) {
>          return 0;
>      }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a5f1bbd58a..214286fd2f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3142,14 +3142,10 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint64_t align, size, addr;
>      uint32_t node;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
>      align =3D memory_region_get_alignment(mr);
>      size =3D memory_region_size(mr);
> =20
> @@ -3263,7 +3259,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
>  {
>      sPAPRDRConnector *drc;
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr =3D ddc->get_memory_region(dimm, &error_abort);
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint64_t size =3D memory_region_size(mr);
>      uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
>      uint32_t avail_lmbs =3D 0;
> @@ -3331,16 +3327,12 @@ static void spapr_memory_unplug_request(HotplugHa=
ndler *hotplug_dev,
>      Error *local_err =3D NULL;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
>      uint32_t nr_lmbs;
>      uint64_t size, addr_start, addr;
>      int i;
>      sPAPRDRConnector *drc;
> =20
> -    mr =3D ddc->get_memory_region(dimm, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
>      size =3D memory_region_size(mr);
>      nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> =20
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 627c8601d9..f0e6867803 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -72,7 +72,9 @@ typedef struct PCDIMMDeviceClass {
> =20
>      /* public */
>      void (*realize)(PCDIMMDevice *dimm, Error **errp);
> -    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm, Error **errp);
> +
> +    /* functions should not be called before the device was realized */
> +    MemoryRegion *(*get_memory_region)(PCDIMMDevice *dimm);
>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
>  } PCDIMMDeviceClass;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1BKOZKwX7DAU5odC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfHYgACgkQbDjKyiDZ
s5I+hhAAuE4FuZRembC0DyXpbagGJZzhFNeE5aN3GbY6q/e24v5uAxYcKj4EMaIe
3emCGuF2JfkcgsMDK6wMyUxXjc6YBv0jZBBRcEJeF7CsaBjCWMsqX6C255qYem0k
PNZl1ECMON7N4+2janBrR7g+rAuW0crO7CR2Wuia8tgCOJVY1b5trv41gUfen5qg
9wQHrxH/X/iL8GUshDs1DArht4gKUyIKH5KbgBS293ZlrDs/8R0VLyAA9s3QND6l
ZKzlSm3IfGhAHaEr++AeVwXbQLckIWGzvF23Xs+NvUkxaKrmv2OoH9c1LnJpMnpv
tRmRWCBVLef+3Zmxzyk5X89kq6K5JoLeC/dAOXT1mp4mjxKpjNvIu/kwkWgVIJfW
QGmvZCPP5RhXbsPAL2DSyeHn7lzJsfcdgAZzE9I5O+93TlzhwL/2iUMNooZ1BRse
XwogWcP9AmwohhLyHEUbeWF+TcchFX1MlbL0kt+f5u6ppIJe9SN4XY5bqyzGK9uq
ygsoy6g1TJQr7+SQ39JJ6Z5RgpnYBsmLs/dyOz+hBzKqJuqPyULgWQFxn9Mm55QB
rnJf4osdWSg1wAzf2LvcG/8ezFiBIruf1ANOpjaWD+y8Oi4VamkfzCBEVCsqJYN2
xL6jPV7TjNFyPaZdnCWZYeguwNwRsphIWiMHMkWAxTYeopHzpF0=
=p6ud
-----END PGP SIGNATURE-----

--1BKOZKwX7DAU5odC--
