Received: from eggs.gnu.org ([2001:4830:134:3::10]:41156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eUs33-0002QE-U0
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 05:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eUs31-00079s-0P
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 05:37:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2365 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eUs30-00071L-2d
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 05:37:54 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Fri, 29 Dec 2017 10:37:40 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB1E285@DGGEMM505-MBS.china.huawei.com>
References: <1514514911-15596-1-git-send-email-jianjay.zhou@huawei.com>
	<20171229103110.40407706@igors-macbook-pro.local>
In-Reply-To: <20171229103110.40407706@igors-macbook-pro.local>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number for
 vhost-user and vhost-kernel separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Hi Igor,

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Friday, December 29, 2017 5:31 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; Huangweidong (C) <weidong.huang@huawei.com>;
> mst@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>; Liuzhe (Cloud
> Open Labs, NFV) <gary.liuzhe@huawei.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>
> Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number for
> vhost-user and vhost-kernel separately
>=20
> On Fri, 29 Dec 2017 10:35:11 +0800
> Jay Zhou <jianjay.zhou@huawei.com> wrote:
>=20
> > Used_memslots is equal to dev->mem->nregions now, it is true for vhost
> > kernel, but not for vhost user, which uses the memory regions that
> > have file descriptor. In fact, not all of the memory regions have file
> > descriptor.
> > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > 5 memory slots can be used by vhost user, it is failed to hotplug a
> > new DIMM memory because vhost_has_free_slot just returned false,
> > however we can hotplug it safely in fact.
> >
> > Meanwhile, instead of asserting in vhost_user_set_mem_table(), error
> > number is used to gracefully prevent device to start. This fixed the
> > VM crash issue.
>=20
> below mostly style related comments,
> otherwise patch looks good to me
> >
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
> > ---
> >  hw/virtio/vhost-backend.c         | 14 +++++++
> >  hw/virtio/vhost-user.c            | 84 +++++++++++++++++++++++++++++--=
-
> -------
> >  hw/virtio/vhost.c                 | 16 ++++----
> >  include/hw/virtio/vhost-backend.h |  4 ++
> >  4 files changed, 91 insertions(+), 27 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 7f09efa..866718c 100644
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
> >                               void *arg)  { @@ -233,6 +235,16 @@
> > static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > NULL);  }
> >
> > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> > +    vhost_kernel_used_memslots =3D dev->mem->nregions; }
> > +
> > +static unsigned int vhost_kernel_get_used_memslots(void)
> > +{
> > +    return vhost_kernel_used_memslots; }
> > +
> >  static const VhostOps kernel_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> >          .vhost_backend_init =3D vhost_kernel_init, @@ -264,6 +276,8 @@
> > static const VhostOps kernel_ops =3D {  #endif /* CONFIG_VHOST_VSOCK */
> >          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D
> > vhost_kernel_send_device_iotlb_msg,
> > +        .vhost_set_used_memslots =3D vhost_kernel_set_used_memslots,
> > +        .vhost_get_used_memslots =3D vhost_kernel_get_used_memslots,
> >  };
> >
> >  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType
> > backend_type) diff --git a/hw/virtio/vhost-user.c
> > b/hw/virtio/vhost-user.c index 093675e..0f913be 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
> >  /* The version of the protocol we support */
> >  #define VHOST_USER_VERSION    (0x1)
> >
> > +static unsigned int vhost_user_used_memslots;
> > +
> >  struct vhost_user {
> >      CharBackend *chr;
> >      int slave_fd;
> > @@ -289,12 +291,53 @@ static int vhost_user_set_log_base(struct
> vhost_dev *dev, uint64_t base,
> >      return 0;
> >  }
> >
> > +static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMsg
> *msg,
> > +                                  int *fds) {
> > +    int r =3D 0;
> > +    int i, fd;
> > +    size_t fd_num =3D 0;
> fd_num is redundant
> you can use msg->payload.memory.nregions as a counter

If using msg->payload.memory.nregions as a counter, referencing
the member of msg->payload.memory.regions will be like this:

   msg->payload.memory.regions[msg->payload.memory.nregions].userspace_addr=
 =3D ...
   msg->payload.memory.regions[msg->payload.memory.nregions].memory_size =
=3D ...

which will make the line more longer...

>=20
> > +
> > +    for (i =3D 0; i < dev->mem->nregions; ++i) {
>        for (i =3D 0, msg->payload.memory.nregions =3D 0; ...
>=20
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
> > +            if (fd_num < VHOST_MEMORY_MAX_NREGIONS) {
> instead of shifting below block to the right, I'd write it like this:

Without this patch, the number of characters for these two lines

        msg.payload.memory.regions[fd_num].userspace_addr =3D reg->userspac=
e_addr;
        msg.payload.memory.regions[fd_num].guest_phys_addr =3D reg->guest_p=
hys_addr;

are more than 80 already...

>=20
>                if (msg->payload.memory.nregions =3D=3D
> VHOST_MEMORY_MAX_NREGIONS) {
>                    return -1;
>                }

msg->payload.memory.nregions as a counter for vhost-user setting mem table,
while fd_num as a counter for vhost_user_used_memslots, IIUC they can not b=
e
merged into one counter.

If return -1 when
msg->payload.memory.nregions =3D=3D VHOST_MEMORY_MAX_NREGIONS, the
vhost_user_used_memslots maybe not assigned correctly. fd_num should
be added by one if fd > 0 regardless of whether msg->payload.memory.nregion=
s
equals to or larger than VHOST_MEMORY_MAX_NREGIONS.

Regards,
Jay

> > +                msg->payload.memory.nregions++;
> > +                msg->payload.memory.regions[fd_num].userspace_addr =3D
> > +                                                    reg->userspace_add=
r;
> > +                msg->payload.memory.regions[fd_num].memory_size =3D
> > +                                                    reg->memory_size;
> > +                msg->payload.memory.regions[fd_num].guest_phys_addr =
=3D
> > +                                                    reg-
> >guest_phys_addr;
> > +                msg->payload.memory.regions[fd_num].mmap_offset =3D
> offset;
> > +                fds[fd_num] =3D fd;
> > +            } else {
> > +                r =3D -1;
> > +            }
> > +            fd_num++;
> > +        }
> > +    }
> > +
> > +    /* Save the number of memory slots available for vhost user,
> > +     * vhost_user_get_used_memslots() can use it next time
> > +     */
> > +    vhost_user_used_memslots =3D fd_num;
> > +
> > +    return r;
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
> > @@ -307,26 +350,12 @@ static int vhost_user_set_mem_table(struct
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
> > +    if (vhost_user_prepare_msg(dev, &msg, fds) < 0) {
> > +        error_report("Failed preparing vhost-user memory table msg");
> > +        return -1;
> >      }
> >
> > -    msg.payload.memory.nregions =3D fd_num;
> > +    fd_num =3D msg.payload.memory.nregions;
> >
> >      if (!fd_num) {
> >          error_report("Failed initializing vhost-user memory map, "
> > @@ -922,6 +951,19 @@ static void vhost_user_set_iotlb_callback(struct
> vhost_dev *dev, int enabled)
> >      /* No-op as the receive channel is not dedicated to IOTLB
> > messages. */  }
> >
> > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    VhostUserMsg msg;
> > +
> > +    vhost_user_prepare_msg(dev, &msg, fds); }
> > +
> > +static unsigned int vhost_user_get_used_memslots(void)
> > +{
> > +    return vhost_user_used_memslots;
> > +}
> > +
> >  const VhostOps user_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_USER,
> >          .vhost_backend_init =3D vhost_user_init, @@ -948,4 +990,6 @@
> > const VhostOps user_ops =3D {
> >          .vhost_net_set_mtu =3D vhost_user_net_set_mtu,
> >          .vhost_set_iotlb_callback =3D vhost_user_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D
> > vhost_user_send_device_iotlb_msg,
> > +        .vhost_set_used_memslots =3D vhost_user_set_used_memslots,
> > +        .vhost_get_used_memslots =3D vhost_user_get_used_memslots,
> >  };
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c index
> > e4290ce..59a32e9 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -43,20 +43,21 @@
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
> > +        if (hdev->vhost_ops->vhost_get_used_memslots() >=3D
> > +            hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> > +            return false;
> > +        }
> >      }
> > -    return slots_limit > used_memslots;
> > +
> > +    return true;
> >  }
> >
> >  static void vhost_dev_sync_region(struct vhost_dev *dev, @@ -606,7
> > +607,7 @@ static void vhost_set_memory(MemoryListener *listener,
> >      dev->mem_changed_start_addr =3D MIN(dev->mem_changed_start_addr,
> start_addr);
> >      dev->mem_changed_end_addr =3D MAX(dev->mem_changed_end_addr,
> start_addr + size - 1);
> >      dev->memory_changed =3D true;
> > -    used_memslots =3D dev->mem->nregions;
> > +    dev->vhost_ops->vhost_set_used_memslots(dev);
> >  }
> >
> >  static bool vhost_section(MemoryRegionSection *section) @@ -1251,7
> > +1252,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
> >          goto fail;
> >      }
> >
> > -    if (used_memslots > hdev->vhost_ops-
> >vhost_backend_memslots_limit(hdev)) {
> > +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> > +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> >          error_report("vhost backend memory slots limit is less"
> >                  " than current number of present memory slots");
> >          r =3D -1;
> > diff --git a/include/hw/virtio/vhost-backend.h
> > b/include/hw/virtio/vhost-backend.h
> > index a7a5f22..19961b5 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -84,6 +84,8 @@ typedef void (*vhost_set_iotlb_callback_op)(struct
> vhost_dev *dev,
> >                                             int enabled);  typedef int
> > (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
> >                                                struct vhost_iotlb_msg
> > *imsg);
> > +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
> > +typedef unsigned int (*vhost_get_used_memslots_op)(void);
> >
> >  typedef struct VhostOps {
> >      VhostBackendType backend_type;
> > @@ -118,6 +120,8 @@ typedef struct VhostOps {
> >      vhost_vsock_set_running_op vhost_vsock_set_running;
> >      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
> >      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> > +    vhost_set_used_memslots_op vhost_set_used_memslots;
> > +    vhost_get_used_memslots_op vhost_get_used_memslots;
> >  } VhostOps;
> >
> >  extern const VhostOps user_ops;
