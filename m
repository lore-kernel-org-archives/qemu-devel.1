Received: from eggs.gnu.org ([2001:4830:134:3::10]:37637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUsjw-0002mm-K7
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 06:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUsjs-0002Fv-KS
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 06:22:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUsjs-0002Es-8M
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 06:22:12 -0500
Date: Fri, 29 Dec 2017 12:22:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171229122201.5817d070@igors-macbook-pro.local>
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB1E285@DGGEMM505-MBS.china.huawei.com>
References: <1514514911-15596-1-git-send-email-jianjay.zhou@huawei.com>
	<20171229103110.40407706@igors-macbook-pro.local>
	<B2D15215269B544CADD246097EACE7473AB1E285@DGGEMM505-MBS.china.huawei.com>
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
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin
	(U)" <wangxinxin.wang@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Fri, 29 Dec 2017 10:37:40 +0000
"Zhoujian (jay)" <jianjay.zhou@huawei.com> wrote:

> Hi Igor,
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Friday, December 29, 2017 5:31 PM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; Huangweidong (C) <weidong.huang@huawei.com>;
> > mst@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>; Liuzhe (Cloud
> > Open Labs, NFV) <gary.liuzhe@huawei.com>; Gonglei (Arei)
> > <arei.gonglei@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number for
> > vhost-user and vhost-kernel separately
> > 
> > On Fri, 29 Dec 2017 10:35:11 +0800
> > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > 
> > > Used_memslots is equal to dev->mem->nregions now, it is true for vhost
> > > kernel, but not for vhost user, which uses the memory regions that
> > > have file descriptor. In fact, not all of the memory regions have file
> > > descriptor.
> > > It is usefully in some scenarios, e.g. used_memslots is 8, and only
> > > 5 memory slots can be used by vhost user, it is failed to hotplug a
> > > new DIMM memory because vhost_has_free_slot just returned false,
> > > however we can hotplug it safely in fact.
> > >
> > > Meanwhile, instead of asserting in vhost_user_set_mem_table(), error
> > > number is used to gracefully prevent device to start. This fixed the
> > > VM crash issue.
> > 
> > below mostly style related comments,
> > otherwise patch looks good to me
> > >
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
> > > ---
> > >  hw/virtio/vhost-backend.c         | 14 +++++++
> > >  hw/virtio/vhost-user.c            | 84 +++++++++++++++++++++++++++++---
> > -------
> > >  hw/virtio/vhost.c                 | 16 ++++----
> > >  include/hw/virtio/vhost-backend.h |  4 ++
> > >  4 files changed, 91 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > index 7f09efa..866718c 100644
> > > --- a/hw/virtio/vhost-backend.c
> > > +++ b/hw/virtio/vhost-backend.c
> > > @@ -15,6 +15,8 @@
> > >  #include "hw/virtio/vhost-backend.h"
> > >  #include "qemu/error-report.h"
> > >
> > > +static unsigned int vhost_kernel_used_memslots;
> > > +
> > >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int
> > request,
> > >                               void *arg)  { @@ -233,6 +235,16 @@
> > > static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > > NULL);  }
> > >
> > > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> > > +    vhost_kernel_used_memslots = dev->mem->nregions; }
> > > +
> > > +static unsigned int vhost_kernel_get_used_memslots(void)
> > > +{
> > > +    return vhost_kernel_used_memslots; }
> > > +
> > >  static const VhostOps kernel_ops = {
> > >          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
> > >          .vhost_backend_init = vhost_kernel_init, @@ -264,6 +276,8 @@
> > > static const VhostOps kernel_ops = {  #endif /* CONFIG_VHOST_VSOCK */
> > >          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
> > >          .vhost_send_device_iotlb_msg =
> > > vhost_kernel_send_device_iotlb_msg,
> > > +        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
> > > +        .vhost_get_used_memslots = vhost_kernel_get_used_memslots,
> > >  };
> > >
> > >  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType
> > > backend_type) diff --git a/hw/virtio/vhost-user.c
> > > b/hw/virtio/vhost-user.c index 093675e..0f913be 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
> > >  /* The version of the protocol we support */
> > >  #define VHOST_USER_VERSION    (0x1)
> > >
> > > +static unsigned int vhost_user_used_memslots;
> > > +
> > >  struct vhost_user {
> > >      CharBackend *chr;
> > >      int slave_fd;
> > > @@ -289,12 +291,53 @@ static int vhost_user_set_log_base(struct
> > vhost_dev *dev, uint64_t base,
> > >      return 0;
> > >  }
> > >
> > > +static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMsg
> > *msg,
> > > +                                  int *fds) {
> > > +    int r = 0;
> > > +    int i, fd;
> > > +    size_t fd_num = 0;
> > fd_num is redundant
> > you can use msg->payload.memory.nregions as a counter
> 
> If using msg->payload.memory.nregions as a counter, referencing
> the member of msg->payload.memory.regions will be like this:
> 
>    msg->payload.memory.regions[msg->payload.memory.nregions].userspace_addr = ...
>    msg->payload.memory.regions[msg->payload.memory.nregions].memory_size = ...
> 
> which will make the line more longer...
> 
> > 
> > > +
> > > +    for (i = 0; i < dev->mem->nregions; ++i) {
> >        for (i = 0, msg->payload.memory.nregions = 0; ...
> > 
> > > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > +        ram_addr_t offset;
> > > +        MemoryRegion *mr;
> > > +
> > > +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > > +        mr = memory_region_from_host((void *)(uintptr_t)reg-
> > >userspace_addr,
> > > +                                     &offset);
> > > +        fd = memory_region_get_fd(mr);
> > > +        if (fd > 0) {
> > > +            if (fd_num < VHOST_MEMORY_MAX_NREGIONS) {
> > instead of shifting below block to the right, I'd write it like this:
> 
> Without this patch, the number of characters for these two lines
> 
>         msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
>         msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
> 
> are more than 80 already...
> 
> > 
> >                if (msg->payload.memory.nregions ==
> > VHOST_MEMORY_MAX_NREGIONS) {
> >                    return -1;
> >                }
> 
> msg->payload.memory.nregions as a counter for vhost-user setting mem table,
> while fd_num as a counter for vhost_user_used_memslots, IIUC they can not be
> merged into one counter.
> 
> If return -1 when
> msg->payload.memory.nregions == VHOST_MEMORY_MAX_NREGIONS, the
> vhost_user_used_memslots maybe not assigned correctly. fd_num should
> be added by one if fd > 0 regardless of whether msg->payload.memory.nregions
> equals to or larger than VHOST_MEMORY_MAX_NREGIONS.

why do you need to continue counting beyond VHOST_MEMORY_MAX_NREGIONS?

[...]
