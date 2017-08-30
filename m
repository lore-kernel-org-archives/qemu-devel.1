Received: from eggs.gnu.org ([2001:4830:134:3::10]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmvuo-0006Px-74
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 01:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmvul-000311-6B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 01:51:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmvuk-00030P-TD
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 01:51:47 -0400
Date: Wed, 30 Aug 2017 13:51:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170830055126.GC5920@pxdev.xzpeter.org>
References: <20170824192730.8440-1-dgilbert@redhat.com>
	<20170824192730.8440-18-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170824192730.8440-18-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 17/32] vhost+postcopy: Stash RAMBlock and
 offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, a.perevalov@samsung.com, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com, felipe@nutanix.com

On Thu, Aug 24, 2017 at 08:27:15PM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Stash the RAMBlock and offset for later use looking up
> addresses.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/trace-events |  1 +
>  hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 63fd4a79cf..5067dee19b 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -3,6 +3,7 @@
>  # hw/virtio/vhost-user.c
>  vhost_user_postcopy_listen(void) ""
>  vhost_user_set_mem_table_postcopy(uint64_t client_addr, uint64_t qhva, int reply_i, int region_i) "client:0x%"PRIx64" for hva: 0x%"PRIx64" reply %d region %d"
> +vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_size, uint64_t guest_phys_addr, uint64_t userspace_addr, uint64_t offset) "%d:%s: size:0x%"PRIx64" GPA:0x%"PRIx64" QVA/userspace:0x%"PRIx64" RB offset:0x%"PRIx64
>  
>  # hw/virtio/virtio.c
>  virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 2e4eb0864a..fbe2743298 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -135,6 +135,14 @@ struct vhost_user {
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
>      uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
> +    /* Length of the region_rb and region_rb_offset arrays */
> +    size_t             region_rb_len;
> +    /* RAMBlock associated with a given region */
> +    RAMBlock         **region_rb;
> +    /* The offset from the start of the RAMBlock to the start of the
> +     * vhost region.
> +     */
> +    ram_addr_t        *region_rb_offset;
>  };
>  
>  static bool ioeventfd_enabled(void)
> @@ -319,6 +327,17 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>          msg.flags |= VHOST_USER_NEED_REPLY_MASK;
>      }
>  
> +    if (u->region_rb_len < dev->mem->nregions) {
> +        u->region_rb = g_renew(RAMBlock*, u->region_rb, dev->mem->nregions);
> +        u->region_rb_offset = g_renew(ram_addr_t, u->region_rb_offset,
> +                                      dev->mem->nregions);
> +        memset(&(u->region_rb[u->region_rb_len]), '\0',
> +               sizeof(RAMBlock *) * (dev->mem->nregions - u->region_rb_len));
> +        memset(&(u->region_rb_offset[u->region_rb_len]), '\0',
> +               sizeof(ram_addr_t) * (dev->mem->nregions - u->region_rb_len));
> +        u->region_rb_len = dev->mem->nregions;
> +    }
> +
>      for (i = 0; i < dev->mem->nregions; ++i) {
>          struct vhost_memory_region *reg = dev->mem->regions + i;
>          ram_addr_t offset;
> @@ -327,8 +346,14 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
>          assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
>          mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
>                                       &offset);
> +        u->region_rb_offset[i] = offset;
> +        u->region_rb[i] = mr->ram_block;

Do we need to record these info even if fd <= 0?

>          fd = memory_region_get_fd(mr);
>          if (fd > 0) {
> +            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
> +                                                  reg->memory_size,
> +                                                  reg->guest_phys_addr,
> +                                                  reg->userspace_addr, offset);
>              msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
>              msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
>              msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
> @@ -992,6 +1017,11 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
>          close(u->slave_fd);
>          u->slave_fd = -1;
>      }
> +    g_free(u->region_rb);
> +    u->region_rb = NULL;
> +    g_free(u->region_rb_offset);
> +    u->region_rb_offset = NULL;
> +    u->region_rb_len = 0;
>      g_free(u);
>      dev->opaque = 0;
>  
> -- 
> 2.13.5
> 

-- 
Peter Xu
