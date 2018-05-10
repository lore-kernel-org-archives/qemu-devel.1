Received: from eggs.gnu.org ([2001:4830:134:3::10]:34132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fGsnZ-0002ny-1l
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1fGsnV-0000E7-Qe
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:08:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56356
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1fGsnV-0000Dp-JR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 17:08:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4AL51Wx004970
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:08:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hvsh6tuw3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 17:08:19 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Thu, 10 May 2018 17:08:18 -0400
Date: Thu, 10 May 2018 18:08:10 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<1525918138-6189-2-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525918138-6189-2-git-send-email-junyan.he@gmx.com>
Message-Id: <20180510210810.GA28333@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [PATCH 1/9 V5] memory,
 exec: switch file ram allocation functions to 'flags' parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net

On Thu, May 10, 2018 at 10:08:50AM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
> 
> As more flag parameters besides the existing 'share' are going to be
> added to following functions
>   memory_region_init_ram_from_file
>   qemu_ram_alloc_from_fd
>   qemu_ram_alloc_from_file
> let's switch them to use the 'flags' parameters so as to ease future
> flag additions.
> 
> The existing 'share' flag is converted to the QEMU_RAM_SHARE bit in
> flags, and other flag bits are ignored by above functions right now.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  backends/hostmem-file.c |  3 ++-
>  exec.c                  |  7 ++++---
>  include/exec/memory.h   | 10 ++++++++--
>  include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
>  memory.c                |  8 +++++---
>  numa.c                  |  2 +-
>  6 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 134b08d..30df843 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -58,7 +58,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          path = object_get_canonical_path(OBJECT(backend));
>          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>                                   path,
> -                                 backend->size, fb->align, backend->share,
> +                                 backend->size, fb->align,
> +                                 backend->share ? QEMU_RAM_SHARE : 0,
>                                   fb->mem_path, errp);
>          g_free(path);
>      }
> diff --git a/exec.c b/exec.c
> index c7fcefa..fa33c29 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2030,12 +2030,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>  
>  #ifdef __linux__
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 uint64_t flags, int fd,
>                                   Error **errp)
>  {
>      RAMBlock *new_block;
>      Error *local_err = NULL;
>      int64_t file_size;
> +    bool share = flags & QEMU_RAM_SHARE;
>  
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
> @@ -2091,7 +2092,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>  
>  
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> +                                   uint64_t flags, const char *mem_path,
>                                     Error **errp)
>  {
>      int fd;
> @@ -2103,7 +2104,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    block = qemu_ram_alloc_from_fd(size, mr, flags, fd, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 31eae0a..0460313 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -507,6 +507,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                         void *host),
>                                         Error **errp);
>  #ifdef __linux__
> +
> +#define QEMU_RAM_SHARE      (1UL << 0)
> +

Hi, Junyan.

How does this differ from RAM_SHARED in exec.c?

>  /**
>   * memory_region_init_ram_from_file:  Initialize RAM memory region with a
>   *                                    mmap-ed backend.
> @@ -518,7 +521,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>   * @size: size of the region.
>   * @align: alignment of the region base address; if 0, the default alignment
>   *         (getpagesize()) will be used.
> - * @share: %true if memory must be mmaped with the MAP_SHARED flag
> + * @flags: specify properties of this memory region, which can be one or bit-or
> + *         of following values:
> + *         - QEMU_RAM_SHARE: memory must be mmaped with the MAP_SHARED flag
> + *         Other bits are ignored.
>   * @path: the path in which to allocate the RAM.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
> @@ -530,7 +536,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        const char *name,
>                                        uint64_t size,
>                                        uint64_t align,
> -                                      bool share,
> +                                      uint64_t flags,
>                                        const char *path,
>                                        Error **errp);
>  
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index cf2446a..b8b01d1 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -72,12 +72,33 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
>  
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
> +
> +/**
> + * qemu_ram_alloc_from_file,
> + * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified back
> + *                          file or device
> + *
> + * Parameters:
> + *  @size: the size in bytes of the ram block
> + *  @mr: the memory region where the ram block is
> + *  @flags: specify the properties of the ram block, which can be one
> + *          or bit-or of following values
> + *          - QEMU_RAM_SHARE: mmap the back file or device with MAP_SHARED
> + *          Other bits are ignored.
> + *  @mem_path or @fd: specify the back file or device
> + *  @errp: pointer to Error*, to store an error if it happens
> + *
> + * Return:
> + *  On success, return a pointer to the ram block.
> + *  On failure, return NULL.
> + */
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> +                                   uint64_t flags, const char *mem_path,
>                                     Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 uint64_t flags, int fd,
>                                   Error **errp);
> +
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
> diff --git a/memory.c b/memory.c
> index e70b64b..3522518 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1552,7 +1552,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        const char *name,
>                                        uint64_t size,
>                                        uint64_t align,
> -                                      bool share,
> +                                      uint64_t flags,
>                                        const char *path,
>                                        Error **errp)
>  {
> @@ -1561,7 +1561,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
> +    mr->ram_block = qemu_ram_alloc_from_file(size, mr, flags, path, errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  
> @@ -1577,7 +1577,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
> +                                           share ? QEMU_RAM_SHARE : 0,
> +                                           fd, errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  #endif
> diff --git a/numa.c b/numa.c
> index 78a869e..d5b1578 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -457,7 +457,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>      if (mem_path) {
>  #ifdef __linux__
>          Error *err = NULL;
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
> +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
>                                           mem_path, &err);
>          if (err) {
>              error_report_err(err);
> -- 
> 2.7.4
> 
> 

-- 
Murilo
