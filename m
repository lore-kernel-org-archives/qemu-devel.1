Received: from eggs.gnu.org ([2001:4830:134:3::10]:56103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSQ8X-00049e-WE
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eSQ8U-0005Nq-L7
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eSQ8U-0005Ms-CP
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 11:25:26 -0500
Date: Fri, 22 Dec 2017 17:25:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171222172513.4157adcc@igors-macbook-pro.local>
In-Reply-To: <1513327555-17520-2-git-send-email-jianjay.zhou@huawei.com>
References: <1513327555-17520-1-git-send-email-jianjay.zhou@huawei.com>
	<1513327555-17520-2-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost: add used memslot number for
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, gary.liuzhe@huawei.com, dgilbert@redhat.com

On Fri, 15 Dec 2017 16:45:54 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

> Used_memslots is equal to dev->mem->nregions now, it is true for
> vhost kernel, but not for vhost user, which uses the memory regions
> that have file descriptor. In fact, not all of the memory regions
> have file descriptor.
> It is usefully in some scenarios, e.g. used_memslots is 8, and only
> 5 memory slots can be used by vhost user, it is failed to hot plug
> a new memory RAM because vhost_has_free_slot just returned false,
> but we can hot plug it safely in fact.

a bit of rant:
it seems vhost is chasing after a tail (1-2 regions that are not
actually RAM), while approach will allow to hotplug 1-2 extra dimms
vhost-user still will be limited to 8 regions max.


vhost-user protocol should be extended to allow qemu query
limit value from backend (which in turn should be tunable),
so that backend could be configured to meet user needs.

Jay,
would you like to look into it?

Otherwise it looks like patch will do its job,
see for a minor suggestion below.
 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
> ---
>  hw/virtio/vhost-backend.c         | 14 ++++++++++++++
>  hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++++++++
>  hw/virtio/vhost.c                 | 16 +++++++++-------
>  include/hw/virtio/vhost-backend.h |  4 ++++
>  4 files changed, 58 insertions(+), 7 deletions(-)
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
> index 093675e..58a4cec 100644
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
> @@ -922,6 +924,33 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
>      /* No-op as the receive channel is not dedicated to IOTLB messages. */
>  }
>  
> +static void vhost_user_set_used_memslots(struct vhost_dev *dev)
> +{
> +    int counter = 0;
> +    int i;
> +
> +    for (i = 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +        int fd;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> +                                    &offset);
> +        fd = memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            counter++;
> +        }
> +    }
vhost_user_set_mem_table() already does the same counting,
there is no point in duplicating it, just drop vhost_set_used_memslots callback

> +    vhost_user_used_memslots = counter;
and update this value from vhost_user_set_mem_table()

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
> @@ -948,4 +977,6 @@ const VhostOps user_ops = {
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
