Received: from eggs.gnu.org ([2001:4830:134:3::10]:39378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eWYHI-00051p-7Y
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 20:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eWYHD-0001Ks-Q8
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 20:55:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2303 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eWYHC-0001IH-QJ
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 20:55:31 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Wed, 3 Jan 2018 01:53:56 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB210D3@DGGEMM505-MBS.china.huawei.com>
References: <1514615811-29468-1-git-send-email-jianjay.zhou@huawei.com>
	<20180102164557.51a0b090@redhat.com>
In-Reply-To: <20180102164557.51a0b090@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND v4] vhost: set used memslots for
 vhost-user and vhost-kernel respectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Tuesday, January 02, 2018 11:46 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; Huangweidong (C) <weidong.huang@huawei.com>;
> mst@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH RESEND v4] vhost: set used memslots for
> vhost-user and vhost-kernel respectively
>=20
> On Sat, 30 Dec 2017 14:36:51 +0800
> Jay Zhou <jianjay.zhou@huawei.com> wrote:
>=20
> > Used_memslots is equal to dev->mem->nregions now, it is true for vhost
> > kernel, but not for vhost user, which uses the memory regions that
> > have file descriptor. In fact, not all of the memory regions have file
> > descriptor.
>=20
> > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > 5 memory slots can be used by vhost user, it is failed to hotplug a
> > new DIMM memory because vhost_has_free_slot just returned false,
> > however we can hotplug it safely in fact.
> It's too long sentence. Please, split and rephrase it so it would be clea=
r
> what is happening.

Will do.

>=20
> > Meanwhile, instead of asserting in vhost_user_set_mem_table(), error
> > number is used to gracefully prevent device to start. This fixed the
> > VM crash issue.
> Fix should be in separate patch as I mentioned in previous review.
> It would useful for stable tree, so you should CC it as well.
>=20

OK.

>=20
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > Signed-off-by: Liuzhe <liuzhe13@huawei.com>
> > ---
> >  hw/virtio/vhost-backend.c         | 15 +++++++-
> >  hw/virtio/vhost-user.c            | 74 +++++++++++++++++++++++++++----=
-
> -------
> >  hw/virtio/vhost.c                 | 18 +++++-----
> >  include/hw/virtio/vhost-backend.h |  6 ++--
> >  4 files changed, 78 insertions(+), 35 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 7f09efa..59def69 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -15,6 +15,8 @@
> >  #include "hw/virtio/vhost-backend.h"
> >  #include "qemu/error-report.h"
> >
> > +static unsigned int vhost_kernel_used_memslots;
> > +
> >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int
> request,
> >                               void *arg)  { @@ -62,6 +64,11 @@ static
> > int vhost_kernel_memslots_limit(struct vhost_dev *dev)
> >      return limit;
> >  }
> >
> > +static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev) {
> > +    return vhost_kernel_used_memslots <
> > +vhost_kernel_memslots_limit(dev); }
> > +
> >  static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
> >                                          struct vhost_vring_file
> > *file)  { @@ -233,11 +240,16 @@ static void
> > vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > NULL);  }
> >
> > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> > +    vhost_kernel_used_memslots =3D dev->mem->nregions; }
> > +
> >  static const VhostOps kernel_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> >          .vhost_backend_init =3D vhost_kernel_init,
> >          .vhost_backend_cleanup =3D vhost_kernel_cleanup,
> > -        .vhost_backend_memslots_limit =3D vhost_kernel_memslots_limit,
> > +        .vhost_backend_has_free_memslots =3D
> > + vhost_kernel_has_free_memslots,
> >          .vhost_net_set_backend =3D vhost_kernel_net_set_backend,
> >          .vhost_scsi_set_endpoint =3D vhost_kernel_scsi_set_endpoint,
> >          .vhost_scsi_clear_endpoint =3D
> > vhost_kernel_scsi_clear_endpoint, @@ -264,6 +276,7 @@ static const
> > VhostOps kernel_ops =3D {  #endif /* CONFIG_VHOST_VSOCK */
> >          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D
> > vhost_kernel_send_device_iotlb_msg,
> > +        .vhost_set_used_memslots =3D vhost_kernel_set_used_memslots,
> >  };
> >
> >  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType
> > backend_type) diff --git a/hw/virtio/vhost-user.c
> > b/hw/virtio/vhost-user.c index 093675e..11c7d52 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
> >  /* The version of the protocol we support */
> >  #define VHOST_USER_VERSION    (0x1)
> >
> > +static bool vhost_user_free_memslots =3D true;
> > +
> >  struct vhost_user {
> >      CharBackend *chr;
> >      int slave_fd;
> > @@ -289,12 +291,43 @@ static int vhost_user_set_log_base(struct
> vhost_dev *dev, uint64_t base,
> >      return 0;
> >  }
> >
> > +static int vhost_user_prepare_msg(struct vhost_dev *dev,
> VhostUserMemory *mem,
> > +                                  int *fds) {
> > +    int i, fd;
> > +
> > +    vhost_user_free_memslots =3D true;
> > +    for (i =3D 0, mem->nregions =3D 0; i < dev->mem->nregions; ++i) {
> > +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> > +        ram_addr_t offset;
> > +        MemoryRegion *mr;
> > +
> > +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_ad=
dr);
> > +        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> >userspace_addr,
> > +                                     &offset);
> > +        fd =3D memory_region_get_fd(mr);
> > +        if (fd > 0) {
> > +            if (mem->nregions =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > +                vhost_user_free_memslots =3D false;
> > +                return -1;
> > +            }
> > +
> > +            mem->regions[mem->nregions].userspace_addr =3D reg-
> >userspace_addr;
> > +            mem->regions[mem->nregions].memory_size =3D reg->memory_si=
ze;
> > +            mem->regions[mem->nregions].guest_phys_addr =3D reg-
> >guest_phys_addr;
> > +            mem->regions[mem->nregions].mmap_offset =3D offset;
> > +            fds[mem->nregions++] =3D fd;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int vhost_user_set_mem_table(struct vhost_dev *dev,
> >                                      struct vhost_memory *mem)  {
> >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > -    int i, fd;
> > -    size_t fd_num =3D 0;
> > +    size_t fd_num;
> >      bool reply_supported =3D virtio_has_feature(dev->protocol_features=
,
> >
> > VHOST_USER_PROTOCOL_F_REPLY_ACK);
> >
> > @@ -307,26 +340,12 @@ static int vhost_user_set_mem_table(struct
> vhost_dev *dev,
> >          msg.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >      }
> >
> > -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> > -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> > -        ram_addr_t offset;
> > -        MemoryRegion *mr;
> > -
> > -        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_ad=
dr);
> > -        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> >userspace_addr,
> > -                                     &offset);
> > -        fd =3D memory_region_get_fd(mr);
> > -        if (fd > 0) {
> > -            msg.payload.memory.regions[fd_num].userspace_addr =3D reg-
> >userspace_addr;
> > -            msg.payload.memory.regions[fd_num].memory_size  =3D reg-
> >memory_size;
> > -            msg.payload.memory.regions[fd_num].guest_phys_addr =3D reg=
-
> >guest_phys_addr;
> > -            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> > -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> > -            fds[fd_num++] =3D fd;
> > -        }
> > +    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> > +        error_report("Failed preparing vhost-user memory table msg");
> > +        return -1;
> >      }
> >
> > -    msg.payload.memory.nregions =3D fd_num;
> > +    fd_num =3D msg.payload.memory.nregions;
> >
> >      if (!fd_num) {
> >          error_report("Failed initializing vhost-user memory map, "
> > @@ -815,9 +834,9 @@ static int vhost_user_get_vq_index(struct vhost_dev
> *dev, int idx)
> >      return idx;
> >  }
> >
> > -static int vhost_user_memslots_limit(struct vhost_dev *dev)
> > +static bool vhost_user_has_free_memslots(struct vhost_dev *dev)
> >  {
> > -    return VHOST_MEMORY_MAX_NREGIONS;
> > +    return vhost_user_free_memslots;
> >  }
> >
> >  static bool vhost_user_requires_shm_log(struct vhost_dev *dev) @@
> > -922,11 +941,19 @@ static void vhost_user_set_iotlb_callback(struct
> vhost_dev *dev, int enabled)
> >      /* No-op as the receive channel is not dedicated to IOTLB
> > messages. */  }
> >
> > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    VhostUserMsg msg;
> > +
> > +    vhost_user_prepare_msg(dev, &msg.payload.memory, fds); }
> > +
> >  const VhostOps user_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >          .vhost_backend_init =3D vhost_user_init,
> >          .vhost_backend_cleanup =3D vhost_user_cleanup,
> > -        .vhost_backend_memslots_limit =3D vhost_user_memslots_limit,
> > +        .vhost_backend_has_free_memslots =3D
> > + vhost_user_has_free_memslots,
> >          .vhost_set_log_base =3D vhost_user_set_log_base,
> >          .vhost_set_mem_table =3D vhost_user_set_mem_table,
> >          .vhost_set_vring_addr =3D vhost_user_set_vring_addr, @@ -948,4
> > +975,5 @@ const VhostOps user_ops =3D {
> >          .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
> >          .vhost_set_iotlb_callback =3D vhost_user_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D
> > vhost_user_send_device_iotlb_msg,
> > +        .vhost_set_used_memslots =3D vhost_user_set_used_memslots,
> >  };
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> > e4290ce..1e52825 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -43,20 +43,20 @@
> >  static struct vhost_log *vhost_log;
> >  static struct vhost_log *vhost_log_shm;
> >
> > -static unsigned int used_memslots;
> >  static QLIST_HEAD(, vhost_dev) vhost_devices =3D
> >      QLIST_HEAD_INITIALIZER(vhost_devices);
> >
> >  bool vhost_has_free_slot(void)
> >  {
> > -    unsigned int slots_limit =3D ~0U;
> >      struct vhost_dev *hdev;
> >
> >      QLIST_FOREACH(hdev, &vhost_devices, entry) {
> > -        unsigned int r =3D hdev->vhost_ops-
> >vhost_backend_memslots_limit(hdev);
> > -        slots_limit =3D MIN(slots_limit, r);
> > +        if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
> > +            return false;
> > +        }
> >      }
> > -    return slots_limit > used_memslots;
> > +
> > +    return true;
> >  }
> >
> >  static void vhost_dev_sync_region(struct vhost_dev *dev, @@ -606,7
> > +606,7 @@ static void vhost_set_memory(MemoryListener *listener,
> >      dev->mem_changed_start_addr =3D MIN(dev->mem_changed_start_addr,
> start_addr);
> >      dev->mem_changed_end_addr =3D MAX(dev->mem_changed_end_addr,
> start_addr + size - 1);
> >      dev->memory_changed =3D true;
> > -    used_memslots =3D dev->mem->nregions;
> > +    dev->vhost_ops->vhost_set_used_memslots(dev);
> >  }
> >
> >  static bool vhost_section(MemoryRegionSection *section) @@ -1251,9
> > +1251,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >          goto fail;
> >      }
> >
> > -    if (used_memslots > hdev->vhost_ops-
> >vhost_backend_memslots_limit(hdev)) {
> > -        error_report("vhost backend memory slots limit is less"
> > -                " than current number of present memory slots");
> > +    if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
> As were noticed in earlier reviews, this check is half working only (in
> current code), and it should happen after memory listener is registered t=
o
> work properly.
> So move it there and add necessary cleanups in case of failure.

I will try to add necessary cleanups to fix the check and not affect the
other things as you mentioned earlier.

>=20
> Also this fix should be a separate patch, so in total you would end up
> with a series of 3 patches:
>   1. fix crash by removing assert
>   2. fix not working check
>   3. used_memslots refactoring.

Will do.

>=20
> > +        error_report("vhost backend memory slots limit is less than "
> > +                     "current number of present memory slots");
> unrelated change

Will drop it.



Regards,
Jay

>=20
> >          r =3D -1;
> >          goto fail;
> >      }
> > diff --git a/include/hw/virtio/vhost-backend.h
> > b/include/hw/virtio/vhost-backend.h
> > index a7a5f22..ea01d5f 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -31,7 +31,7 @@ struct vhost_iotlb_msg;
> >
> >  typedef int (*vhost_backend_init)(struct vhost_dev *dev, void
> > *opaque);  typedef int (*vhost_backend_cleanup)(struct vhost_dev
> > *dev); -typedef int (*vhost_backend_memslots_limit)(struct vhost_dev
> > *dev);
> > +typedef bool (*vhost_backend_has_free_memslots)(struct vhost_dev
> > +*dev);
> >
> >  typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
> >                                  struct vhost_vring_file *file); @@
> > -84,12 +84,13 @@ typedef void (*vhost_set_iotlb_callback_op)(struct
> vhost_dev *dev,
> >                                             int enabled);  typedef int
> > (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
> >                                                struct vhost_iotlb_msg
> > *imsg);
> > +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
> >
> >  typedef struct VhostOps {
> >      VhostBackendType backend_type;
> >      vhost_backend_init vhost_backend_init;
> >      vhost_backend_cleanup vhost_backend_cleanup;
> > -    vhost_backend_memslots_limit vhost_backend_memslots_limit;
> > +    vhost_backend_has_free_memslots vhost_backend_has_free_memslots;
> >      vhost_net_set_backend_op vhost_net_set_backend;
> >      vhost_net_set_mtu_op vhost_net_set_mtu;
> >      vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint; @@ -118,6
> > +119,7 @@ typedef struct VhostOps {
> >      vhost_vsock_set_running_op vhost_vsock_set_running;
> >      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
> >      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> > +    vhost_set_used_memslots_op vhost_set_used_memslots;
> >  } VhostOps;
> >
> >  extern const VhostOps user_ops;
