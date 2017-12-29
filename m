Received: from eggs.gnu.org ([2001:4830:134:3::10]:53750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUr0e-0001A1-11
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUr0a-0007sZ-Hg
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:31:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUr0a-0007rR-8N
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:31:20 -0500
Date: Fri, 29 Dec 2017 10:31:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171229103110.40407706@igors-macbook-pro.local>
In-Reply-To: <1514514911-15596-1-git-send-email-jianjay.zhou@huawei.com>
References: <1514514911-15596-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, mst@redhat.com, wangxinxin.wang@huawei.com, Zhe Liu <gary.liuzhe@huawei.com>, arei.gonglei@huawei.com

On Fri, 29 Dec 2017 10:35:11 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

> Used_memslots is equal to dev->mem->nregions now, it is true for
> vhost kernel, but not for vhost user, which uses the memory regions
> that have file descriptor. In fact, not all of the memory regions
> have file descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hotplug
> a new DIMM memory because vhost_has_free_slot just returned false,
> however we can hotplug it safely in fact.
> 
> Meanwhile, instead of asserting in vhost_user_set_mem_table(),
> error number is used to gracefully prevent device to start. This
> fixed the VM crash issue.

below mostly style related comments,
otherwise patch looks good to me

> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
> ---
>  hw/virtio/vhost-backend.c         | 14 +++++++
>  hw/virtio/vhost-user.c            | 84 +++++++++++++++++++++++++++++----------
>  hw/virtio/vhost.c                 | 16 ++++----
>  include/hw/virtio/vhost-backend.h |  4 ++
>  4 files changed, 91 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 7f09efa..866718c 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -15,6 +15,8 @@
>  #include "hw/virtio/vhost-backend.h"
>  #include "qemu/error-report.h"
>  
> +static unsigned int vhost_kernel_used_memslots;
> +
>  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
>                               void *arg)
>  {
> @@ -233,6 +235,16 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
>          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
>  }
>  
> +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
> +{
> +    vhost_kernel_used_memslots = dev->mem->nregions;
> +}
> +
> +static unsigned int vhost_kernel_get_used_memslots(void)
> +{
> +    return vhost_kernel_used_memslots;
> +}
> +
>  static const VhostOps kernel_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
>          .vhost_backend_init = vhost_kernel_init,
> @@ -264,6 +276,8 @@ static const VhostOps kernel_ops = {
>  #endif /* CONFIG_VHOST_VSOCK */
>          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
> +        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
> +        .vhost_get_used_memslots = vhost_kernel_get_used_memslots,
>  };
>  
>  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 093675e..0f913be 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
>  /* The version of the protocol we support */
>  #define VHOST_USER_VERSION    (0x1)
>  
> +static unsigned int vhost_user_used_memslots;
> +
>  struct vhost_user {
>      CharBackend *chr;
>      int slave_fd;
> @@ -289,12 +291,53 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>      return 0;
>  }
>  
> +static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMsg *msg,
> +                                  int *fds)
> +{
> +    int r = 0;
> +    int i, fd;
> +    size_t fd_num = 0;
fd_num is redundant
you can use msg->payload.memory.nregions as a counter

> +
> +    for (i = 0; i < dev->mem->nregions; ++i) {
       for (i = 0, msg->payload.memory.nregions = 0; ...

> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> +                                     &offset);
> +        fd = memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            if (fd_num < VHOST_MEMORY_MAX_NREGIONS) {
instead of shifting below block to the right, I'd write it like this:

               if (msg->payload.memory.nregions == VHOST_MEMORY_MAX_NREGIONS) {
                   return -1;
               }

> +                msg->payload.memory.nregions++;
> +                msg->payload.memory.regions[fd_num].userspace_addr =
> +                                                    reg->userspace_addr;
> +                msg->payload.memory.regions[fd_num].memory_size =
> +                                                    reg->memory_size;
> +                msg->payload.memory.regions[fd_num].guest_phys_addr =
> +                                                    reg->guest_phys_addr;
> +                msg->payload.memory.regions[fd_num].mmap_offset = offset;
> +                fds[fd_num] = fd;
> +            } else {
> +                r = -1;
> +            }
> +            fd_num++;
> +        }
> +    }
> +
> +    /* Save the number of memory slots available for vhost user,
> +     * vhost_user_get_used_memslots() can use it next time
> +     */
> +    vhost_user_used_memslots = fd_num;
> +
> +    return r;
> +}
> +
>  static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                      struct vhost_memory *mem)
>  {
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> -    int i, fd;
> -    size_t fd_num = 0;
> +    size_t fd_num;
>      bool reply_supported = virtio_has_feature(dev->protocol_features,
>                                                VHOST_USER_PROTOCOL_F_REPLY_ACK);
>  
> @@ -307,26 +350,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>          msg.flags |= VHOST_USER_NEED_REPLY_MASK;
>      }
>  
> -    for (i = 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg = dev->mem->regions + i;
> -        ram_addr_t offset;
> -        MemoryRegion *mr;
> -
> -        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> -        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> -                                     &offset);
> -        fd = memory_region_get_fd(mr);
> -        if (fd > 0) {
> -            msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
> -            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
> -            msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
> -            msg.payload.memory.regions[fd_num].mmap_offset = offset;
> -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> -            fds[fd_num++] = fd;
> -        }
> +    if (vhost_user_prepare_msg(dev, &msg, fds) < 0) {
> +        error_report("Failed preparing vhost-user memory table msg");
> +        return -1;
>      }
>  
> -    msg.payload.memory.nregions = fd_num;
> +    fd_num = msg.payload.memory.nregions;
>  
>      if (!fd_num) {
>          error_report("Failed initializing vhost-user memory map, "
> @@ -922,6 +951,19 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
>      /* No-op as the receive channel is not dedicated to IOTLB messages. */
>  }
>  
> +static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> +{
> +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    VhostUserMsg msg;
> +
> +    vhost_user_prepare_msg(dev, &msg, fds);
> +}
> +
> +static unsigned int vhost_user_get_used_memslots(void)
> +{
> +    return vhost_user_used_memslots;
> +}
> +
>  const VhostOps user_ops = {
>          .backend_type = VHOST_BACKEND_TYPE_USER,
>          .vhost_backend_init = vhost_user_init,
> @@ -948,4 +990,6 @@ const VhostOps user_ops = {
>          .vhost_net_set_mtu = vhost_user_net_set_mtu,
>          .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
>          .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
> +        .vhost_set_used_memslots = vhost_user_set_used_memslots,
> +        .vhost_get_used_memslots = vhost_user_get_used_memslots,
>  };
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e4290ce..59a32e9 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -43,20 +43,21 @@
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
>  
> -static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>  
>  bool vhost_has_free_slot(void)
>  {
> -    unsigned int slots_limit = ~0U;
>      struct vhost_dev *hdev;
>  
>      QLIST_FOREACH(hdev, &vhost_devices, entry) {
> -        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -        slots_limit = MIN(slots_limit, r);
> +        if (hdev->vhost_ops->vhost_get_used_memslots() >=
> +            hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +            return false;
> +        }
>      }
> -    return slots_limit > used_memslots;
> +
> +    return true;
>  }
>  
>  static void vhost_dev_sync_region(struct vhost_dev *dev,
> @@ -606,7 +607,7 @@ static void vhost_set_memory(MemoryListener *listener,
>      dev->mem_changed_start_addr = MIN(dev->mem_changed_start_addr, start_addr);
>      dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr, start_addr + size - 1);
>      dev->memory_changed = true;
> -    used_memslots = dev->mem->nregions;
> +    dev->vhost_ops->vhost_set_used_memslots(dev);
>  }
>  
>  static bool vhost_section(MemoryRegionSection *section)
> @@ -1251,7 +1252,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>          goto fail;
>      }
>  
> -    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
> +    if (hdev->vhost_ops->vhost_get_used_memslots() >
> +        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
>          error_report("vhost backend memory slots limit is less"
>                  " than current number of present memory slots");
>          r = -1;
> diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> index a7a5f22..19961b5 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -84,6 +84,8 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
>                                             int enabled);
>  typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
>                                                struct vhost_iotlb_msg *imsg);
> +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
> +typedef unsigned int (*vhost_get_used_memslots_op)(void);
>  
>  typedef struct VhostOps {
>      VhostBackendType backend_type;
> @@ -118,6 +120,8 @@ typedef struct VhostOps {
>      vhost_vsock_set_running_op vhost_vsock_set_running;
>      vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
>      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> +    vhost_set_used_memslots_op vhost_set_used_memslots;
> +    vhost_get_used_memslots_op vhost_get_used_memslots;
>  } VhostOps;
>  
>  extern const VhostOps user_ops;
