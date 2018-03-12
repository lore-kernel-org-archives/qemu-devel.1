Received: from eggs.gnu.org ([2001:4830:134:3::10]:58876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evKDV-00054h-4X
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1evKDS-0006fa-1f
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:58:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1evKDR-0006dg-Rq
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E470BD9E
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:57:56 +0000 (UTC)
Date: Mon, 12 Mar 2018 17:57:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180312095739.GC11787@xz-mi>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-13-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308195811.24894-13-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/29] postcopy+vhost-user: Split
 set_mem_table for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Thu, Mar 08, 2018 at 07:57:54PM +0000, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Split the set_mem_table routines in both qemu and libvhost-user
> because the postcopy versions are going to be quite different
> once changes in the later patches are added.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  contrib/libvhost-user/libvhost-user.c | 53 ++++++++++++++++++++++++
>  hw/virtio/vhost-user.c                | 77 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index beec7695a8..4922b2c722 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -448,6 +448,55 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
>      return false;
>  }
>  
> +static bool
> +vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int i;
> +    VhostUserMemory *memory = &vmsg->payload.memory;
> +    dev->nregions = memory->nregions;
> +    /* TODO: Postcopy specific code */
> +    DPRINT("Nregions: %d\n", memory->nregions);
> +    for (i = 0; i < dev->nregions; i++) {
> +        void *mmap_addr;
> +        VhostUserMemoryRegion *msg_region = &memory->regions[i];
> +        VuDevRegion *dev_region = &dev->regions[i];
> +
> +        DPRINT("Region %d\n", i);
> +        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> +               msg_region->guest_phys_addr);
> +        DPRINT("    memory_size:     0x%016"PRIx64"\n",
> +               msg_region->memory_size);
> +        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
> +               msg_region->userspace_addr);
> +        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
> +               msg_region->mmap_offset);
> +
> +        dev_region->gpa = msg_region->guest_phys_addr;
> +        dev_region->size = msg_region->memory_size;
> +        dev_region->qva = msg_region->userspace_addr;
> +        dev_region->mmap_offset = msg_region->mmap_offset;
> +
> +        /* We don't use offset argument of mmap() since the
> +         * mapped address has to be page aligned, and we use huge
> +         * pages.  */
> +        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
> +                         PROT_READ | PROT_WRITE, MAP_SHARED,
> +                         vmsg->fds[i], 0);
> +
> +        if (mmap_addr == MAP_FAILED) {
> +            vu_panic(dev, "region mmap error: %s", strerror(errno));
> +        } else {
> +            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
> +            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
> +                   dev_region->mmap_addr);
> +        }
> +
> +        close(vmsg->fds[i]);
> +    }
> +
> +    return false;
> +}
> +
>  static bool
>  vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>  {
> @@ -464,6 +513,10 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
>      }
>      dev->nregions = memory->nregions;
>  
> +    if (dev->postcopy_listening) {
> +        return vu_set_mem_table_exec_postcopy(dev, vmsg);
> +    }
> +
>      DPRINT("Nregions: %d\n", memory->nregions);
>      for (i = 0; i < dev->nregions; i++) {
>          void *mmap_addr;
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ee200f703e..311addc33b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -340,15 +340,86 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>      return 0;
>  }
>  
> +static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
> +                                             struct vhost_memory *mem)
> +{
> +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int i, fd;
> +    size_t fd_num = 0;
> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
> +    /* TODO: Add actual postcopy differences */
> +    VhostUserMsg msg = {
> +        .hdr.request = VHOST_USER_SET_MEM_TABLE,
> +        .hdr.flags = VHOST_USER_VERSION,
> +    };
> +
> +    if (reply_supported) {
> +        msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
> +    }
> +
> +    for (i = 0; i < dev->mem->nregions; ++i) {
> +        struct vhost_memory_region *reg = dev->mem->regions + i;
> +        ram_addr_t offset;
> +        MemoryRegion *mr;
> +
> +        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
> +        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
> +                                     &offset);
> +        fd = memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            msg.payload.memory.regions[fd_num].userspace_addr =
> +                reg->userspace_addr;
> +            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
> +            msg.payload.memory.regions[fd_num].guest_phys_addr =
> +                reg->guest_phys_addr;
> +            msg.payload.memory.regions[fd_num].mmap_offset = offset;
> +            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> +            fds[fd_num++] = fd;
> +        }
> +    }
> +
> +    msg.payload.memory.nregions = fd_num;
> +
> +    if (!fd_num) {
> +        error_report("Failed initializing vhost-user memory map, "
> +                     "consider using -object memory-backend-file share=on");
> +        return -1;
> +    }
> +
> +    msg.hdr.size = sizeof(msg.payload.memory.nregions);
> +    msg.hdr.size += sizeof(msg.payload.memory.padding);
> +    msg.hdr.size += fd_num * sizeof(VhostUserMemoryRegion);
> +
> +    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> +        return -1;
> +    }
> +
> +    if (reply_supported) {
> +        return process_message_reply(dev, &msg);
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                      struct vhost_memory *mem)
>  {
> +    struct vhost_user *u = dev->opaque;
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
>      int i, fd;
>      size_t fd_num = 0;
> +    bool do_postcopy = u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported = virtio_has_feature(dev->protocol_features,
>                                                VHOST_USER_PROTOCOL_F_REPLY_ACK);
>  
> +    if (do_postcopy) {
> +        /* Postcopy has enough differences that it's best done in it's own
> +         * version
> +         */
> +        return vhost_user_set_mem_table_postcopy(dev, mem);
> +    }
> +
>      VhostUserMsg msg = {
>          .hdr.request = VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags = VHOST_USER_VERSION,
> @@ -372,9 +443,11 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                  error_report("Failed preparing vhost-user memory table msg");
>                  return -1;
>              }
> -            msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
> +            msg.payload.memory.regions[fd_num].userspace_addr =
> +                reg->userspace_addr;
>              msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
> -            msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
> +            msg.payload.memory.regions[fd_num].guest_phys_addr =
> +                reg->guest_phys_addr;

I would still prefer to generalize things out as shared functions,
since otherwise we are adding somehow duplicate codes, which is IMHO
harder to maintain.  And even if to do the duplication, I would keep
the original code untouched (so these newlines will still not be
needed).

But considering that the series has been there for a long time, I'll
try to be less harsh...  And yes, I know it's a burden to maintain
private trees and keep rebasing.

Feel free to remove the newlines (so at least commit log of those
lines won't be modified), and either way I'll offer mine:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

>              msg.payload.memory.regions[fd_num].mmap_offset = offset;
>              fds[fd_num++] = fd;
>          }
> -- 
> 2.14.3
> 

-- 
Peter Xu
