Received: from eggs.gnu.org ([2001:4830:134:3::10]:51476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSP8c-0000nH-NX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSP8Z-0008K7-Jw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fSP8Z-0008Jw-C9
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:53:43 -0400
Date: Mon, 11 Jun 2018 17:53:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180611175333.65745243@redhat.com>
In-Reply-To: <1527840629-18648-3-git-send-email-junyan.he@gmx.com>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-3-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V6 2/7] memory,
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
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Fri,  1 Jun 2018 16:10:24 +0800
junyan.he@gmx.com wrote:

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
> The existing 'share' flag is converted to the RAM_SHARED bit in ram_flags,
> and other flag bits are ignored by above functions right now.
> 
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  backends/hostmem-file.c |  3 ++-
>  exec.c                  | 10 +++++-----
>  include/exec/memory.h   |  8 ++++++--
>  include/exec/ram_addr.h | 25 +++++++++++++++++++++++--
>  memory.c                |  8 +++++---
>  numa.c                  |  2 +-
>  6 files changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 134b08d..34c68bb 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -58,7 +58,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          path = object_get_canonical_path(OBJECT(backend));
>          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>                                   path,
> -                                 backend->size, fb->align, backend->share,
> +                                 backend->size, fb->align,
> +                                 backend->share ? RAM_SHARED : 0,
>                                   fb->mem_path, errp);
>          g_free(path);
>      }
> diff --git a/exec.c b/exec.c
> index 302c04b..f2082fa 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2054,7 +2054,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
>  
>  #ifdef __linux__
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 uint64_t ram_flags, int fd,
>                                   Error **errp)
>  {
>      RAMBlock *new_block;
> @@ -2096,14 +2096,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->mr = mr;
>      new_block->used_length = size;
>      new_block->max_length = size;
> -    new_block->flags = share ? RAM_SHARED : 0;
> +    new_block->flags = ram_flags;
>      new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
>      }
>  
> -    ram_block_add(new_block, &local_err, share);
> +    ram_block_add(new_block, &local_err, ram_flags & RAM_SHARED);
>      if (local_err) {
>          g_free(new_block);
>          error_propagate(errp, local_err);
> @@ -2115,7 +2115,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>  
>  
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> +                                   uint64_t ram_flags, const char *mem_path,
>                                     Error **errp)
>  {
>      int fd;
> @@ -2127,7 +2127,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3da315e..3b68a43 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -596,6 +596,7 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>                                                         void *host),
>                                         Error **errp);
>  #ifdef __linux__
> +
>  /**
>   * memory_region_init_ram_from_file:  Initialize RAM memory region with a
>   *                                    mmap-ed backend.
> @@ -607,7 +608,10 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>   * @size: size of the region.
>   * @align: alignment of the region base address; if 0, the default alignment
>   *         (getpagesize()) will be used.
> - * @share: %true if memory must be mmaped with the MAP_SHARED flag
> + * @ram_flags: specify properties of this memory region, which can be one or
> + *             bit-or of following values:
I'd spell it out as:
 @ram_flags: memory region features:
         

> + *             - RAM_SHARED: memory must be mmaped with the MAP_SHARED flag
> + *             Other bits are ignored.
>   * @path: the path in which to allocate the RAM.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
> @@ -619,7 +623,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        const char *name,
>                                        uint64_t size,
>                                        uint64_t align,
> -                                      bool share,
> +                                      uint64_t ram_flags,
>                                        const char *path,
>                                        Error **errp);
>  
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index cf2446a..b478455 100644
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
s/back file/baking file/
here and in all other places it's added

and maybe s/device/file descriptor/

> + *
> + * Parameters:
> + *  @size: the size in bytes of the ram block
> + *  @mr: the memory region where the ram block is
> + *  @ram_flags: specify the properties of the ram block, which can be one
> + *              or bit-or of following values
> + *              - RAM_SHARED: mmap the back file or device with MAP_SHARED
> + *              Other bits are ignored.
> + *  @mem_path or @fd: specify the back file or device
> + *  @errp: pointer to Error*, to store an error if it happens
> + *
> + * Return:
> + *  On success, return a pointer to the ram block.
> + *  On failure, return NULL.
> + */
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> +                                   uint64_t ram_flags, const char *mem_path,
>                                     Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 uint64_t ram_flags, int fd,
>                                   Error **errp);
> +
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
>  RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
> diff --git a/memory.c b/memory.c
> index 10fa2dd..08acae4 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1554,7 +1554,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        const char *name,
>                                        uint64_t size,
>                                        uint64_t align,
> -                                      bool share,
> +                                      uint64_t ram_flags,
>                                        const char *path,
>                                        Error **errp)
>  {
> @@ -1563,7 +1563,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
> +    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  
> @@ -1579,7 +1579,9 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
> +                                           share ? RAM_SHARED : 0,
> +                                           fd, errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  #endif
> diff --git a/numa.c b/numa.c
> index 33572bf..ba72267 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -479,7 +479,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>      if (mem_path) {
>  #ifdef __linux__
>          Error *err = NULL;
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
> +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
>                                           mem_path, &err);
>          if (err) {
>              error_report_err(err);
