Received: from eggs.gnu.org ([2001:4830:134:3::10]:37435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fDQUg-0003JD-KX
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fDQUc-0006DG-FA
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:18:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2391 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fDQUb-00069e-GS
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:18:34 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 1 May 2018 08:18:16 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AC79875@DGGEMM505-MBS.china.huawei.com>
References: <1522124046-34596-1-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1522124046-34596-1-git-send-email-jianjay.zhou@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND v10] vhost: used_memslots refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

Hi Michael and Igor,
I'm afraid this patch has been missed, could you help to review?

PS: In order to avoid side effect, code redundancy does exist between
vhost_user_set_used_memslots(), vhost_user_set_mem_table() and
vhost_user_set_mem_table_postcopy(), I haven't found a good solution to
solve it since my limited knowledge. But the counting for vhost-user
and vhost-kernel's used_memslots are okay now, I think. Pls let me know
if there're issues to be dealt with.

Regards,
Jay

> -----Original Message-----
> From: Zhoujian (jay)
> Sent: Tuesday, March 27, 2018 12:14 PM
> To: qemu-devel@nongnu.org
> Cc: mst@redhat.com; imammedo@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gon=
glei
> (Arei) <arei.gonglei@huawei.com>; Zhoujian (jay) <jianjay.zhou@huawei.com=
>;
> Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
> Subject: [PATCH RESEND v10] vhost: used_memslots refactoring
>=20
> Used_memslots is shared by vhost kernel and user, it is equal to
> dev->mem->nregions, which is correct for vhost kernel, but not for
> vhost user, the latter one uses memory regions that have file descriptor.=
 E.g.
> a VM has a vhost-user NIC and 8(vhost user memslot upper limit) memory sl=
ots,
> it will be failed to hotplug a new DIMM device since vhost_has_free_slot(=
)
> finds no free slot left. It should be successful if only part of memory s=
lots
> have file descriptor, so setting used memslots for vhost-user and vhost-
> kernel respectively.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> Signed-off-by: Liuzhe <liuzhe13@huawei.com>
> ---
>=20
> v10:
>  - fix misaligned access to structures
>  - refine on setting used_memslots for vhost-user to
>    avoid side effect
>  - distinguish "has free memslots" and "out of memslots"
> v7 ... v9:
>  - rebased on the master
> v2 ... v6:
>  - delete the "used_memslots" global variable, and add it
>    for vhost-user and vhost-kernel separately
>  - refine the function, commit log
>  - used_memslots refactoring
>=20
>  hw/virtio/vhost-backend.c         | 21 ++++++++++++++++++++-
>  hw/virtio/vhost-user.c            | 36 +++++++++++++++++++++++++++++++++=
---
>  hw/virtio/vhost.c                 | 13 ++++++-------
>  include/hw/virtio/vhost-backend.h |  8 ++++++--
>  4 files changed, 65 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c index
> 7f09efa..3539b5f 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -15,6 +15,8 @@
>  #include "hw/virtio/vhost-backend.h"
>  #include "qemu/error-report.h"
>=20
> +static unsigned int vhost_kernel_used_memslots;
> +
>  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int
> request,
>                               void *arg)  { @@ -62,6 +64,21 @@ static int
> vhost_kernel_memslots_limit(struct vhost_dev *dev)
>      return limit;
>  }
>=20
> +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> +    vhost_kernel_used_memslots =3D dev->mem->nregions; }
> +
> +static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev) {
> +    return vhost_kernel_used_memslots <
> +vhost_kernel_memslots_limit(dev); }
> +
> +static bool vhost_kernel_out_of_memslots(struct vhost_dev *dev) {
> +    return vhost_kernel_used_memslots >
> +vhost_kernel_memslots_limit(dev); }
> +
>  static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
>                                          struct vhost_vring_file *file)  =
{ @@
> -237,7 +254,9 @@ static const VhostOps kernel_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
>          .vhost_backend_init =3D vhost_kernel_init,
>          .vhost_backend_cleanup =3D vhost_kernel_cleanup,
> -        .vhost_backend_memslots_limit =3D vhost_kernel_memslots_limit,
> +        .vhost_set_used_memslots =3D vhost_kernel_set_used_memslots,
> +        .vhost_backend_has_free_memslots =3D vhost_kernel_has_free_memsl=
ots,
> +        .vhost_out_of_memslots =3D vhost_kernel_out_of_memslots,
>          .vhost_net_set_backend =3D vhost_kernel_net_set_backend,
>          .vhost_scsi_set_endpoint =3D vhost_kernel_scsi_set_endpoint,
>          .vhost_scsi_clear_endpoint =3D vhost_kernel_scsi_clear_endpoint,=
 diff
> --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> 44aea5c..9691806 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -170,6 +170,8 @@ static VhostUserMsg m __attribute__ ((unused));
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION    (0x1)
>=20
> +static unsigned int vhost_user_used_memslots;
> +
>  struct vhost_user {
>      struct vhost_dev *dev;
>      CharBackend *chr;
> @@ -1289,9 +1291,35 @@ static int vhost_user_get_vq_index(struct vhost_de=
v
> *dev, int idx)
>      return idx;
>  }
>=20
> -static int vhost_user_memslots_limit(struct vhost_dev *dev)
> +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> +    int i, fd;
> +    unsigned int fd_num =3D 0;
> +
> +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> +        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
> +                                     &offset);
> +        fd =3D memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            fd_num++;
> +        }
> +    }
> +    vhost_user_used_memslots =3D fd_num;
> +}
> +
> +static bool vhost_user_has_free_memslots(struct vhost_dev *dev) {
> +    return vhost_user_used_memslots < VHOST_MEMORY_MAX_NREGIONS; }
> +
> +static bool vhost_user_out_of_memslots(struct vhost_dev *dev)
>  {
> -    return VHOST_MEMORY_MAX_NREGIONS;
> +    return vhost_user_used_memslots > VHOST_MEMORY_MAX_NREGIONS;
>  }
>=20
>  static bool vhost_user_requires_shm_log(struct vhost_dev *dev) @@ -1563,=
7
> +1591,9 @@ const VhostOps user_ops =3D {
>          .backend_type =3D VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init =3D vhost_user_init,
>          .vhost_backend_cleanup =3D vhost_user_cleanup,
> -        .vhost_backend_memslots_limit =3D vhost_user_memslots_limit,
> +        .vhost_set_used_memslots =3D vhost_user_set_used_memslots,
> +        .vhost_backend_has_free_memslots =3D vhost_user_has_free_memslot=
s,
> +        .vhost_out_of_memslots =3D vhost_user_out_of_memslots,
>          .vhost_set_log_base =3D vhost_user_set_log_base,
>          .vhost_set_mem_table =3D vhost_user_set_mem_table,
>          .vhost_set_vring_addr =3D vhost_user_set_vring_addr, diff --git
> a/hw/virtio/vhost.c b/hw/virtio/vhost.c index 250f886..706951a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -44,20 +44,19 @@
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
>=20
> -static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =3D
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>=20
>  bool vhost_has_free_slot(void)
>  {
> -    unsigned int slots_limit =3D ~0U;
>      struct vhost_dev *hdev;
>=20
>      QLIST_FOREACH(hdev, &vhost_devices, entry) {
> -        unsigned int r =3D hdev->vhost_ops->vhost_backend_memslots_limit=
(hdev);
> -        slots_limit =3D MIN(slots_limit, r);
> +        if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
> +            return false;
> +        }
>      }
> -    return slots_limit > used_memslots;
> +    return true;
>  }
>=20
>  static void vhost_dev_sync_region(struct vhost_dev *dev, @@ -446,7 +445,=
6 @@
> static void vhost_commit(MemoryListener *listener)
>                         dev->n_mem_sections * sizeof dev->mem->regions[0]=
;
>      dev->mem =3D g_realloc(dev->mem, regions_size);
>      dev->mem->nregions =3D dev->n_mem_sections;
> -    used_memslots =3D dev->mem->nregions;
>      for (i =3D 0; i < dev->n_mem_sections; i++) {
>          struct vhost_memory_region *cur_vmr =3D dev->mem->regions + i;
>          struct MemoryRegionSection *mrs =3D dev->mem_sections + i; @@ -4=
58,6
> +456,7 @@ static void vhost_commit(MemoryListener *listener)
>              mrs->offset_within_region;
>          cur_vmr->flags_padding   =3D 0;
>      }
> +    dev->vhost_ops->vhost_set_used_memslots(dev);
>=20
>      if (!dev->started) {
>          goto out;
> @@ -1248,7 +1247,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memo=
ry);
>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>=20
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hd=
ev))
> {
> +    if (hdev->vhost_ops->vhost_out_of_memslots(hdev)) {
>          error_report("vhost backend memory slots limit is less"
>                  " than current number of present memory slots");
>          r =3D -1;
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-
> backend.h
> index 5dac61f..f7ab82d 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -36,7 +36,9 @@ struct vhost_iotlb_msg;
>=20
>  typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
> typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev); -typedef int
> (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
> +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
> +typedef bool (*vhost_backend_has_free_memslots)(struct vhost_dev *dev);
> +typedef bool (*vhost_out_of_memslots)(struct vhost_dev *dev);
>=20
>  typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
>                                  struct vhost_vring_file *file); @@ -105,=
7
> +107,9 @@ typedef struct VhostOps {
>      VhostBackendType backend_type;
>      vhost_backend_init vhost_backend_init;
>      vhost_backend_cleanup vhost_backend_cleanup;
> -    vhost_backend_memslots_limit vhost_backend_memslots_limit;
> +    vhost_set_used_memslots_op vhost_set_used_memslots;
> +    vhost_backend_has_free_memslots vhost_backend_has_free_memslots;
> +    vhost_out_of_memslots vhost_out_of_memslots;
>      vhost_net_set_backend_op vhost_net_set_backend;
>      vhost_net_set_mtu_op vhost_net_set_mtu;
>      vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
> --
> 1.8.3.1
>=20
