Received: from eggs.gnu.org ([2001:4830:134:3::10]:58162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4aX-00035f-Vv
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4aT-0004Nh-18
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:25 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw4aS-0004NX-N8
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:24:20 -0400
Received: by mail-wr0-x244.google.com with SMTP id o21so4883695wrb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:24:20 -0700 (PDT)
Date: Thu, 6 Apr 2017 11:24:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406102416.GA21895@stefanha-x1.localdomain>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170331084147.32716-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] pc-dimm: add 'reserved-size' to
 reserve address range after the ending address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, dan.j.williams@intel.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 31, 2017 at 04:41:44PM +0800, Haozhong Zhang wrote:
> If option 'reserved-size=3DRSVD' is present, QEMU will reserve an
> address range of size 'RSVD' after the ending address of pc-dimm
> device.
>=20
> For the following example,
>     -object memory-backend-file,id=3Dmem0,size=3D4G,...
>     -device nvdimm,id=3Ddimm0,memdev=3Dmem0,reserved-size=3D4K,...

"reserved-size" is not a clear name.  I suggest calling the property
"num-flush-hints" (default 0).  QEMU can calculate the actual size in
bytes.

  -device nvdimm,num-flush-hints=3D1

QEMU will use one flush hint and reserve enough space (e.g. 1 page) for
the MMIO region.

>     -device pc-dimm,id=3Ddimm1,...
> if dimm0 is allocated to address N ~ N+4G, the address range of
> dimm1 will start from N+4G+4K or higher.
>=20
> Its current usage is to reserve spaces for flush hint addresses
> of nvdimm devices.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  hw/mem/pc-dimm.c         | 48 ++++++++++++++++++++++++++++++++++++++++++=
+++---
>  include/hw/mem/pc-dimm.h |  2 ++
>  2 files changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9e8dab0..13dcd71 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/kvm.h"
>  #include "trace.h"
>  #include "hw/virtio/vhost.h"
> +#include "exec/address-spaces.h"
> =20
>  typedef struct pc_dimms_capacity {
>       uint64_t size;
> @@ -44,7 +45,12 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotpl=
ugState *hpms,
>      MemoryRegion *vmstate_mr =3D ddc->get_vmstate_memory_region(dimm);
>      Error *local_err =3D NULL;
>      uint64_t existing_dimms_capacity =3D 0;
> -    uint64_t addr;
> +    uint64_t addr, size =3D memory_region_size(mr);
> +
> +    size +=3D object_property_get_int(OBJECT(dimm), PC_DIMM_RSVD_PROP, &=
local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> =20
>      addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP, &l=
ocal_err);
>      if (local_err) {
> @@ -54,7 +60,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
>      addr =3D pc_dimm_get_free_addr(hpms->base,
>                                   memory_region_size(&hpms->mr),
>                                   !addr ? NULL : &addr, align,
> -                                 memory_region_size(mr), &local_err);
> +                                 size, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -64,7 +70,7 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplu=
gState *hpms,
>          goto out;
>      }
> =20
> -    if (existing_dimms_capacity + memory_region_size(mr) >
> +    if (existing_dimms_capacity + size >
>          machine->maxram_size - machine->ram_size) {
>          error_setg(&local_err, "not enough space, currently 0x%" PRIx64
>                     " in use of total hot pluggable 0x" RAM_ADDR_FMT,
> @@ -315,6 +321,9 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space=
_start,
>          PCDIMMDevice *dimm =3D item->data;
>          uint64_t dimm_size =3D object_property_get_int(OBJECT(dimm),
>                                                       PC_DIMM_SIZE_PROP,
> +                                                     errp) +
> +                             object_property_get_int(OBJECT(dimm),
> +                                                     PC_DIMM_RSVD_PROP,
>                                                       errp);
>          if (errp && *errp) {
>              goto out;
> @@ -382,6 +391,37 @@ static void pc_dimm_check_memdev_is_busy(Object *obj=
, const char *name,
>      error_propagate(errp, local_err);
>  }
> =20
> +static void pc_dimm_get_reserved_size(Object *obj, Visitor *v, const cha=
r *name,
> +                                      void *opaque, Error **errp)
> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(obj);
> +    uint64_t value =3D dimm->reserved_size;
> +
> +    visit_type_size(v, name, &value, errp);
> +}
> +
> +static void pc_dimm_set_reserved_size(Object *obj, Visitor *v, const cha=
r *name,
> +                                      void *opaque, Error **errp)
> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(obj);
> +    Error *local_err =3D NULL;
> +    uint64_t value;
> +
> +    if (dimm->reserved_size) {
> +        error_setg(&local_err, "cannot change 'reserved-size'");
> +        goto out;
> +    }
> +
> +    visit_type_size(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    dimm->reserved_size =3D value;
> +
> + out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void pc_dimm_init(Object *obj)
>  {
>      PCDIMMDevice *dimm =3D PC_DIMM(obj);
> @@ -393,6 +433,8 @@ static void pc_dimm_init(Object *obj)
>                               pc_dimm_check_memdev_is_busy,
>                               OBJ_PROP_LINK_UNREF_ON_RELEASE,
>                               &error_abort);
> +    object_property_add(obj, PC_DIMM_RSVD_PROP, "int", pc_dimm_get_reser=
ved_size,
> +                        pc_dimm_set_reserved_size, NULL, NULL, &error_ab=
ort);
>  }
> =20
>  static void pc_dimm_realize(DeviceState *dev, Error **errp)
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 1e483f2..99c4dfd 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -33,6 +33,7 @@
>  #define PC_DIMM_NODE_PROP "node"
>  #define PC_DIMM_SIZE_PROP "size"
>  #define PC_DIMM_MEMDEV_PROP "memdev"
> +#define PC_DIMM_RSVD_PROP "reserved-size"
> =20
>  #define PC_DIMM_UNASSIGNED_SLOT -1
> =20
> @@ -53,6 +54,7 @@ typedef struct PCDIMMDevice {
>      uint64_t addr;
>      uint32_t node;
>      int32_t slot;
> +    uint64_t reserved_size;
>      HostMemoryBackend *hostmem;
>  } PCDIMMDevice;
> =20
> --=20
> 2.10.1
>=20
>=20

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5hdQAAoJEJykq7OBq3PI0igH/08zyCAr+qd8DPxAyMVzUF+d
yqCZR2HG0/z262NucQfEj02ZnT/wkMFMXGrXZ7ETxUimsGwfZgISs3+H5P45/xk9
lTiQB+Fhz/ncLjyJgg3X1cqK6kN32vH/y5NSAa0zQeT6RJppIciPONElLZzQP2s3
KhKZHpK56edY4vf/AOZcAOSB45ky3tlnlO7ES0xit7/VsM4qNydhhFRU5tTFunqr
WuvBvmu/SPXWe07vnTmtNIJMMA2poBG8pPkdr8cvmythX/pz5lgZ0PU3VHPwueBv
oQs8MDm5x51Xm6ES7IubRh8ObZ/qbCkLe3EaO/bEBh5LC1Hts2Lvm1mT812dwi8=
=Rb87
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
