Received: from eggs.gnu.org ([2001:4830:134:3::10]:52290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etsD8-00015y-96
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:51:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etsD5-0000TW-8J
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:51:42 -0500
Date: Thu, 8 Mar 2018 17:15:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308061541.GO3083@umbus.fritz.box>
References: <20180308023337.21062-1-haozhong.zhang@intel.com>
	<20180308023337.21062-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WoqaC9TUMqqIOlla"
Content-Disposition: inline
In-Reply-To: <20180308023337.21062-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/5] pc-dimm: make
 qmp_pc_dimm_device_list() sort devices by address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org


--WoqaC9TUMqqIOlla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 10:33:33AM +0800, Haozhong Zhang wrote:
> Make qmp_pc_dimm_device_list() return sorted by start address
> list of devices so that it could be reused in places that
> would need sorted list*. Reuse existing pc_dimm_built_list()
> to get sorted list.
>=20
> While at it hide recursive callbacks from callers, so that:
>=20
>   qmp_pc_dimm_device_list(qdev_get_machine(), &list);
>=20
> could be replaced with simpler:
>=20
>   list =3D qmp_pc_dimm_device_list();
>=20
> * follow up patch will use it in build_srat()
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

ppc part

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c         | 83 +++++++++++++++++++++++++-----------------=
------
>  hw/ppc/spapr.c           |  3 +-
>  include/hw/mem/pc-dimm.h |  2 +-
>  numa.c                   |  4 +--
>  qmp.c                    |  7 +---
>  stubs/qmp_pc_dimm.c      |  4 +--
>  6 files changed, 50 insertions(+), 53 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 6e74b61cb6..4d050fe2cd 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -162,45 +162,6 @@ uint64_t get_plugged_memory_size(void)
>      return pc_existing_dimms_capacity(&error_abort);
>  }
> =20
> -int qmp_pc_dimm_device_list(Object *obj, void *opaque)
> -{
> -    MemoryDeviceInfoList ***prev =3D opaque;
> -
> -    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
> -        DeviceState *dev =3D DEVICE(obj);
> -
> -        if (dev->realized) {
> -            MemoryDeviceInfoList *elem =3D g_new0(MemoryDeviceInfoList, =
1);
> -            MemoryDeviceInfo *info =3D g_new0(MemoryDeviceInfo, 1);
> -            PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);
> -            DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
> -            PCDIMMDevice *dimm =3D PC_DIMM(obj);
> -
> -            if (dev->id) {
> -                di->has_id =3D true;
> -                di->id =3D g_strdup(dev->id);
> -            }
> -            di->hotplugged =3D dev->hotplugged;
> -            di->hotpluggable =3D dc->hotpluggable;
> -            di->addr =3D dimm->addr;
> -            di->slot =3D dimm->slot;
> -            di->node =3D dimm->node;
> -            di->size =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_=
SIZE_PROP,
> -                                                NULL);
> -            di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostme=
m));
> -
> -            info->u.dimm.data =3D di;
> -            elem->value =3D info;
> -            elem->next =3D NULL;
> -            **prev =3D elem;
> -            *prev =3D &elem->next;
> -        }
> -    }
> -
> -    object_child_foreach(obj, qmp_pc_dimm_device_list, opaque);
> -    return 0;
> -}
> -
>  static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
>  {
>      unsigned long *bitmap =3D opaque;
> @@ -276,6 +237,50 @@ static int pc_dimm_built_list(Object *obj, void *opa=
que)
>      return 0;
>  }
> =20
> +MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
> +{
> +    GSList *dimms =3D NULL, *item;
> +    MemoryDeviceInfoList *list =3D NULL, *prev =3D NULL;
> +
> +    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &dimms);
> +
> +    for (item =3D dimms; item; item =3D g_slist_next(item)) {
> +        PCDIMMDevice *dimm =3D PC_DIMM(item->data);
> +        Object *obj =3D OBJECT(dimm);
> +        MemoryDeviceInfoList *elem =3D g_new0(MemoryDeviceInfoList, 1);
> +        MemoryDeviceInfo *info =3D g_new0(MemoryDeviceInfo, 1);
> +        PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);
> +        DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
> +        DeviceState *dev =3D DEVICE(obj);
> +
> +        if (dev->id) {
> +            di->has_id =3D true;
> +            di->id =3D g_strdup(dev->id);
> +        }
> +        di->hotplugged =3D dev->hotplugged;
> +        di->hotpluggable =3D dc->hotpluggable;
> +        di->addr =3D dimm->addr;
> +        di->slot =3D dimm->slot;
> +        di->node =3D dimm->node;
> +        di->size =3D object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NU=
LL);
> +        di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostmem));
> +
> +        info->u.dimm.data =3D di;
> +        elem->value =3D info;
> +        elem->next =3D NULL;
> +        if (prev) {
> +            prev->next =3D elem;
> +        } else {
> +            list =3D elem;
> +        }
> +        prev =3D elem;
> +    }
> +
> +    g_slist_free(dimms);
> +
> +    return list;
> +}
> +
>  uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
>                                 uint64_t address_space_size,
>                                 uint64_t *hint, uint64_t align, uint64_t =
size,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7e1c858566..44a0670d11 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -722,8 +722,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      }
> =20
>      if (hotplug_lmb_start) {
> -        MemoryDeviceInfoList **prev =3D &dimms;
> -        qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
> +        dimms =3D qmp_pc_dimm_device_list();
>      }
> =20
>      /* ibm,dynamic-memory */
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index d83b957829..1fc479281c 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -93,7 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_s=
tart,
> =20
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
> =20
> -int qmp_pc_dimm_device_list(Object *obj, void *opaque);
> +MemoryDeviceInfoList *qmp_pc_dimm_device_list(void);
>  uint64_t pc_existing_dimms_capacity(Error **errp);
>  uint64_t get_plugged_memory_size(void);
>  void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> diff --git a/numa.c b/numa.c
> index 5d7529c1d9..7ca2bef63f 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -520,12 +520,10 @@ void memory_region_allocate_system_memory(MemoryReg=
ion *mr, Object *owner,
> =20
>  static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>  {
> -    MemoryDeviceInfoList *info_list =3D NULL;
> -    MemoryDeviceInfoList **prev =3D &info_list;
> +    MemoryDeviceInfoList *info_list =3D qmp_pc_dimm_device_list();
>      MemoryDeviceInfoList *info;
>      PCDIMMDeviceInfo     *pcdimm_info;
> =20
> -    qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
>      for (info =3D info_list; info; info =3D info->next) {
>          MemoryDeviceInfo *value =3D info->value;
> =20
> diff --git a/qmp.c b/qmp.c
> index 8c7d1cc479..4b2517d8b5 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -731,12 +731,7 @@ void qmp_object_del(const char *id, Error **errp)
> =20
>  MemoryDeviceInfoList *qmp_query_memory_devices(Error **errp)
>  {
> -    MemoryDeviceInfoList *head =3D NULL;
> -    MemoryDeviceInfoList **prev =3D &head;
> -
> -    qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
> -
> -    return head;
> +    return qmp_pc_dimm_device_list();
>  }
> =20
>  ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
> diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_pc_dimm.c
> index 9ddc4f619a..b6b2cca89e 100644
> --- a/stubs/qmp_pc_dimm.c
> +++ b/stubs/qmp_pc_dimm.c
> @@ -2,9 +2,9 @@
>  #include "qom/object.h"
>  #include "hw/mem/pc-dimm.h"
> =20
> -int qmp_pc_dimm_device_list(Object *obj, void *opaque)
> +MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
>  {
> -   return 0;
> +   return NULL;
>  }
> =20
>  uint64_t get_plugged_memory_size(void)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WoqaC9TUMqqIOlla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqg1QsACgkQbDjKyiDZ
s5KLwg//ew6WZu7aZed2rmuEoiAOGQIFxmnDYZCe+nTUDlaQ5fogv6r+fesn371Q
uuSTmEV0OhfdjYwTIcCVlz+Bn9zglfXDO2nETtVHieI2y2mflfg3AlOotlaPW8xY
6FLQZjbpmaw/W3ifXyntZCZeRHRr+PekKvK1K9/lsGWYrgS0lviMlwWeeFvuoYN0
efgX+FpaVgKVuwYUt+MAmo8U69ky/uonBJfHk/l7ZWiWu2RNGz01ND2PPlVd1QDB
HR3eGKBR3dWPfGORhvmabXmm/+TJmYQuIWvqTK+9Vm15w4ywHzoM0PmEI/7y0aaw
e3ycC4Ge4pq6fIYV6D/5GFN9FMk8Y93LW3hu+RLrjKeSQq/K0oUu55b26riSq7+7
MXj2876nNs2KHDoklDeAsBA/A54cpL/y3PiRv0oL8HN29ZaikI8quOv0NmplPB1A
6x1g7Q25nl9DP8t+c/A+NstUL32v61fphX2zJPZHHUS3Tm7NHVsUpDnVk2qQdVX7
f3MkdwtEvSyiD1FiM+90xw7TF4yDZcNTZSu7sbhnikjInZuglUxSfzqWoPfemiw4
A+ZVRIKWNW97M8LdbhAvnqMyU4IVPfxyhz3JhJb9+4V2+ovRQETXdz09fABXWvYY
M+SF8mB7iOuNtAaMfTxLUM+C6jlHoZA3YQg/0nR7Qe6XOLAriOI=
=tcF0
-----END PGP SIGNATURE-----

--WoqaC9TUMqqIOlla--
