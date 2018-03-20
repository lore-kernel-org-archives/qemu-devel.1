Received: from eggs.gnu.org ([2001:4830:134:3::10]:42021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyGV5-0006Ew-4F
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyGUy-0001Eu-KQ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:36:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43312 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyGUy-0001ER-Cv
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 08:36:16 -0400
Date: Tue, 20 Mar 2018 14:35:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320142957-mutt-send-email-mst@kernel.org>
References: <1520241169-22892-1-git-send-email-jianjay.zhou@huawei.com>
	<20180320033051-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473ABF2941@DGGEMM505-MBS.china.huawei.com>
	<20180320044456-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473ABF2E24@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2D15215269B544CADD246097EACE7473ABF2E24@DGGEMM505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH v9] vhost: used_memslots refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>

On Tue, Mar 20, 2018 at 03:39:17AM +0000, Zhoujian (jay) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, March 20, 2018 10:51 AM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> > <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gonglei
> > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.com>
> > Subject: Re: [PATCH v9] vhost: used_memslots refactoring
> > 
> > On Tue, Mar 20, 2018 at 02:09:34AM +0000, Zhoujian (jay) wrote:
> > > Hi Michael,
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > > Sent: Tuesday, March 20, 2018 9:34 AM
> > > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > > Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> > > > <weidong.huang@huawei.com>; wangxin (U)
> > > > <wangxinxin.wang@huawei.com>; Gonglei
> > > > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler)
> > > > <liuzhe13@huawei.com>
> > > > Subject: Re: [PATCH v9] vhost: used_memslots refactoring
> > > >
> > > > On Mon, Mar 05, 2018 at 05:12:49PM +0800, Jay Zhou wrote:
> > > > > Used_memslots is shared by vhost kernel and user, it is equal to
> > > > > dev->mem->nregions, which is correct for vhost kernel, but not for
> > > > > vhost user, the latter one uses memory regions that have file
> > > > > descriptor. E.g. a VM has a vhost-user NIC and 8(vhost user
> > > > > memslot upper limit) memory slots, it will be failed to hotplug a
> > > > > new DIMM device since vhost_has_free_slot() finds no free slot
> > > > > left. It should be successful if only part of memory slots have
> > > > > file descriptor, so setting used memslots for vhost-user and vhost-
> > kernel respectively.
> > > >
> > > >
> > > > Below should go after ---
> > >
> > > Thanks for reminding.
> > >
> > > >
> > > > > v7 ... v9:
> > > > >  - rebased on the master
> > > > > v2 ... v6:
> > > > >  - delete the "used_memslots" global variable, and add it
> > > > >    for vhost-user and vhost-kernel separately
> > > > >  - refine the function, commit log
> > > > >  - used_memslots refactoring
> > > > >
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > > > Signed-off-by: Liuzhe <liuzhe13@huawei.com>
> > > >
> > > > When built with clang this causes runtime warnings (during make
> > > > check) about misaligned access to structures.
> > > >
> > > > The issue is that vhost_user_prepare_msg requests VhostUserMemory
> > > > which compiler assumes but is then used with a pointer into a packed
> > > > structure - where fields are not aligned.
> > >
> > > Sorry I missed the patch you have sent to fix the alignment, I have
> > > replied to that thread.
> > >
> > > >
> > > >
> > > > > ---
> > > > >  hw/virtio/vhost-backend.c         | 15 +++++++-
> > > > >  hw/virtio/vhost-user.c            | 77 ++++++++++++++++++++++++++-----
> > ----
> > > > ----
> > > > >  hw/virtio/vhost.c                 | 13 +++----
> > > > >  include/hw/virtio/vhost-backend.h |  6 ++-
> > > > >  4 files changed, 75 insertions(+), 36 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > > > index 7f09efa..59def69 100644
> > > > > --- a/hw/virtio/vhost-backend.c
> > > > > +++ b/hw/virtio/vhost-backend.c
> > > > > @@ -15,6 +15,8 @@
> > > > >  #include "hw/virtio/vhost-backend.h"
> > > > >  #include "qemu/error-report.h"
> > > > >
> > > > > +static unsigned int vhost_kernel_used_memslots;
> > > > > +
> > > > >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long
> > > > > int
> > > > request,
> > > > >                               void *arg)  { @@ -62,6 +64,11 @@
> > > > > static int vhost_kernel_memslots_limit(struct vhost_dev *dev)
> > > > >      return limit;
> > > > >  }
> > > > >
> > > > > +static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev) {
> > > > > +    return vhost_kernel_used_memslots <
> > > > > +vhost_kernel_memslots_limit(dev); }
> > > > > +
> > > > >  static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
> > > > >                                          struct vhost_vring_file
> > > > > *file)  { @@ -233,11 +240,16 @@ static void
> > > > > vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> > > > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > > > > NULL);  }
> > > > >
> > > > > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> > > > > +    vhost_kernel_used_memslots = dev->mem->nregions; }
> > > > > +
> > > > >  static const VhostOps kernel_ops = {
> > > > >          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
> > > > >          .vhost_backend_init = vhost_kernel_init,
> > > > >          .vhost_backend_cleanup = vhost_kernel_cleanup,
> > > > > -        .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
> > > > > +        .vhost_backend_has_free_memslots =
> > > > > + vhost_kernel_has_free_memslots,
> > > > >          .vhost_net_set_backend = vhost_kernel_net_set_backend,
> > > > >          .vhost_scsi_set_endpoint = vhost_kernel_scsi_set_endpoint,
> > > > >          .vhost_scsi_clear_endpoint =
> > > > > vhost_kernel_scsi_clear_endpoint, @@ -264,6 +276,7 @@ static const
> > > > > VhostOps kernel_ops = {  #endif /* CONFIG_VHOST_VSOCK */
> > > > >          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
> > > > >          .vhost_send_device_iotlb_msg =
> > > > > vhost_kernel_send_device_iotlb_msg,
> > > > > +        .vhost_set_used_memslots =
> > > > > + vhost_kernel_set_used_memslots,
> > > > >  };
> > > > >
> > > > >  int vhost_set_backend_type(struct vhost_dev *dev,
> > > > > VhostBackendType
> > > > > backend_type) diff --git a/hw/virtio/vhost-user.c
> > > > > b/hw/virtio/vhost-user.c index 41ff5cf..ef14249 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -163,6 +163,8 @@ static VhostUserMsg m __attribute__
> > > > > ((unused));
> > > > >  /* The version of the protocol we support */
> > > > >  #define VHOST_USER_VERSION    (0x1)
> > > > >
> > > > > +static bool vhost_user_free_memslots = true;
> > > > > +
> > > > >  struct vhost_user {
> > > > >      CharBackend *chr;
> > > > >      int slave_fd;
> > > > > @@ -330,12 +332,43 @@ static int vhost_user_set_log_base(struct
> > > > > vhost_dev
> > > > *dev, uint64_t base,
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +static int vhost_user_prepare_msg(struct vhost_dev *dev,
> > > > > +VhostUserMemory
> > > > *mem,
> > > > > +                                  int *fds) {
> > > > > +    int i, fd;
> > > > > +
> > > > > +    vhost_user_free_memslots = true;
> > > > > +    for (i = 0, mem->nregions = 0; i < dev->mem->nregions; ++i) {
> > > > > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > > > +        ram_addr_t offset;
> > > > > +        MemoryRegion *mr;
> > > > > +
> > > > > +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > > > > +        mr = memory_region_from_host((void *)(uintptr_t)reg-
> > > > >userspace_addr,
> > > > > +                                     &offset);
> > > > > +        fd = memory_region_get_fd(mr);
> > > > > +        if (fd > 0) {
> > > > > +            if (mem->nregions == VHOST_MEMORY_MAX_NREGIONS) {
> > > > > +                vhost_user_free_memslots = false;
> > > > > +                return -1;
> > > > > +            }
> > > > > +
> > > > > +            mem->regions[mem->nregions].userspace_addr = reg-
> > > > >userspace_addr;
> > > > > +            mem->regions[mem->nregions].memory_size = reg->memory_size;
> > > > > +            mem->regions[mem->nregions].guest_phys_addr = reg-
> > > > >guest_phys_addr;
> > > > > +            mem->regions[mem->nregions].mmap_offset = offset;
> > > > > +            fds[mem->nregions++] = fd;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >  static int vhost_user_set_mem_table(struct vhost_dev *dev,
> > > > >                                      struct vhost_memory *mem)  {
> > > > >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > > > -    int i, fd;
> > > > > -    size_t fd_num = 0;
> > > > > +    size_t fd_num;
> > > > >      bool reply_supported =
> > > > > virtio_has_feature(dev->protocol_features,
> > > > >
> > > > > VHOST_USER_PROTOCOL_F_REPLY_ACK);
> > > > >
> > > > > @@ -348,29 +381,12 @@ static int vhost_user_set_mem_table(struct
> > > > > vhost_dev
> > > > *dev,
> > > > >          msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> > > > >      }
> > > > >
> > > > > -    for (i = 0; i < dev->mem->nregions; ++i) {
> > > > > -        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > > > -        ram_addr_t offset;
> > > > > -        MemoryRegion *mr;
> > > > > -
> > > > > -        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> > > > > -        mr = memory_region_from_host((void *)(uintptr_t)reg-
> > > > >userspace_addr,
> > > > > -                                     &offset);
> > > > > -        fd = memory_region_get_fd(mr);
> > > > > -        if (fd > 0) {
> > > > > -            if (fd_num == VHOST_MEMORY_MAX_NREGIONS) {
> > > > > -                error_report("Failed preparing vhost-user memory table
> > > > msg");
> > > > > -                return -1;
> > > > > -            }
> > > > > -            msg.payload.memory.regions[fd_num].userspace_addr = reg-
> > > > >userspace_addr;
> > > > > -            msg.payload.memory.regions[fd_num].memory_size  = reg-
> > > > >memory_size;
> > > > > -            msg.payload.memory.regions[fd_num].guest_phys_addr = reg-
> > > > >guest_phys_addr;
> > > > > -            msg.payload.memory.regions[fd_num].mmap_offset = offset;
> > > > > -            fds[fd_num++] = fd;
> > > > > -        }
> > > > > +    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
> > > > > +        error_report("Failed preparing vhost-user memory table msg");
> > > > > +        return -1;
> > > > >      }
> > > > >
> > > > > -    msg.payload.memory.nregions = fd_num;
> > > > > +    fd_num = msg.payload.memory.nregions;
> > > > >
> > > > >      if (!fd_num) {
> > > > >          error_report("Failed initializing vhost-user memory map, "
> > > > > @@ -886,9 +902,9 @@ static int vhost_user_get_vq_index(struct
> > > > > vhost_dev
> > > > *dev, int idx)
> > > > >      return idx;
> > > > >  }
> > > > >
> > > > > -static int vhost_user_memslots_limit(struct vhost_dev *dev)
> > > > > +static bool vhost_user_has_free_memslots(struct vhost_dev *dev)
> > > > >  {
> > > > > -    return VHOST_MEMORY_MAX_NREGIONS;
> > > > > +    return vhost_user_free_memslots;
> > > > >  }
> > > > >
> > > > >  static bool vhost_user_requires_shm_log(struct vhost_dev *dev) @@
> > > > > -1156,11 +1172,19 @@ vhost_user_crypto_close_session(struct
> > > > > vhost_dev *dev,
> > > > uint64_t session_id)
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > > > > +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > > > +    VhostUserMsg msg;
> > > > > +
> > > > > +    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
> > > >
> > > > Oops.  This is something I don't understand.
> > > >
> > > > Why is the message prepared here and then discarded?
> > > >
> > >
> > > The purpose of vhost_user_set_used_memslots() is to set the boolean
> > > value of vhost_user_free_memslots, which indicating whether there're
> > > free memeslots for vhost user. Since there're code duplicating inside
> > > vhost_user_set_used_memslots() and vhost_user_set_mem_table(), Igor
> > > suggested that we could create a new function to avoid duplicating.
> > > Here, the value of VhostUserMsg is not needed by the caller
> > > vhost_user_set_used_memslots(), so we just discarded.
> > >
> > > Regards,
> > > Jay
> > 
> > 
> > I think I misunderstood the meaning of that variable.
> > It seems to be set when there are more slots than supported.
> 
> Yes.
> 
> > 
> > What vhost_user_free_memslots implies is that it is set when there are no
> > free slots, even if existing config fits.
> > 
> > A better name would be vhost_user_out_of_memslots maybe?
> 
> vhost_user_free_memslots is set TRUE by default, if there are more slots
> than supported it is set to FALSE.
> vhost_user_out_of_memslots is another option, I think it should be set
> FALSE by default, if there are more slots than supported it is set to TRUE.
> 
> Since two functions vhost_has_free_slot() and the callback
> vhost_backend_has_free_memslots() are using this variable,
> the name vhost_user_free_memslots seems a little matching to these
> function names.

So vhost_has_free_slot is actually slightly wrong after
your patch too.


> If you still prefer vhost_user_out_of_memslots, pls let me know.
> 
> > 
> > 
> > And I missed the fact that it (as well as the prepare call) can actually fail
> > when out of slots.
> > Shouldn't it return status too?
> 
> vhost_user_free_memslots is always set to false when prepare call failed, this
> is what vhost_user_set_used_memslots() wants to do, so e.g. when we hotplug memory
> DIMM devices, it will return false while calling vhost_has_free_slot().
> 
> So, I think vhost_user_set_used_memslots() doesn't need to handle or care about
> the return status of vhost_user_prepare_msg(), the return value is only useful to
> another caller vhost_user_set_mem_table()
> 
> Regards,
> Jay

So function names are a problem here I think.  If the function has an
important side effect it should be reflected in the name.  Or we
could add a wrapper which does the right thing.

-- 
MST
