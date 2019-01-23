Received: from eggs.gnu.org ([209.51.188.92]:53914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmK2M-0003R3-TU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gmK2G-0002sm-MH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gmK2G-0002sV-DL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:01:48 -0500
Date: Wed, 23 Jan 2019 10:01:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190123100053-mutt-send-email-mst@kernel.org>
References: <cover.1548136274.git.yi.z.zhang@linux.intel.com>
	<b1c0ccd8b18467b6df33e90c8606b184ed866251.1548136274.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c0ccd8b18467b6df33e90c8606b184ed866251.1548136274.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V10 1/4] util/mmap-alloc: switch 'shared'
 to 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhang, Yi" <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Wed, Jan 23, 2019 at 10:59:37AM +0800, Zhang, Yi wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
> 
> As more flag parameters besides the existing 'shared' are going to be
> added to qemu_ram_mmap() and qemu_ram_alloc_from_{file,fd}(), let's
> switch 'shared' to a 'flags' parameter in advance, so as to ease the
> further additions.
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>

There are all of two callers to qemu_ram_mmap.

Please just add a bool parameter for now.

If you want to work on switching to flags afterwards
that needs sparse work for type safety.


> ---
>  exec.c                    |  7 ++++---
>  include/qemu/mmap-alloc.h | 19 ++++++++++++++++++-
>  util/mmap-alloc.c         |  8 +++++---
>  util/oslib-posix.c        |  9 ++++++++-
>  4 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index bb6170d..e92a7da 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1810,6 +1810,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              ram_addr_t memory,
>                              int fd,
>                              bool truncate,
> +                            uint32_t flags,
>                              Error **errp)
>  {
>      void *area;
> @@ -1859,8 +1860,7 @@ static void *file_ram_alloc(RAMBlock *block,
>          perror("ftruncate");
>      }
>  
> -    area = qemu_ram_mmap(fd, memory, block->mr->align,
> -                         block->flags & RAM_SHARED);
> +    area = qemu_ram_mmap(fd, memory, block->mr->align, flags);
>      if (area == MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "unable to map backing store for guest RAM");
> @@ -2279,7 +2279,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->used_length = size;
>      new_block->max_length = size;
>      new_block->flags = ram_flags;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size,
> +            ram_flags, errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index 50385e3..6fe6ed4 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -7,7 +7,24 @@ size_t qemu_fd_getpagesize(int fd);
>  
>  size_t qemu_mempath_getpagesize(const char *mem_path);
>  
> -void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> +/**
> + * qemu_ram_mmap: mmap the specified file or device.
> + *
> + * Parameters:
> + *  @fd: the file or the device to mmap
> + *  @size: the number of bytes to be mmaped
> + *  @align: if not zero, specify the alignment of the starting mapping address;
> + *          otherwise, the alignment in use will be determined by QEMU.
> + *  @flags: specifies additional properties of the mapping, which can be one or
> + *          bit-or of following values
> + *          - RAM_SHARED: mmap with MAP_SHARED flag
> + *          Other bits are ignored.
> + *
> + * Return:
> + *  On success, return a pointer to the mapped area.
> + *  On failure, return MAP_FAILED.
> + */
> +void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags);
>  
>  void qemu_ram_munmap(void *ptr, size_t size);
>  
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index fd329ec..8f0a740 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/mmap-alloc.h"
>  #include "qemu/host-utils.h"
> +#include "exec/memory.h"
>  
>  #define HUGETLBFS_MAGIC       0x958458f6
>  
> @@ -75,7 +76,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>      return getpagesize();
>  }
>  
> -void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> +void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
>  {
>      /*
>       * Note: this always allocates at least one extra page of virtual address
> @@ -92,11 +93,12 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
>       * anonymous memory is OK.
>       */
>      int anonfd = fd == -1 || qemu_fd_getpagesize(fd) == getpagesize() ? -1 : fd;
> -    int flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
> -    void *ptr = mmap(0, total, PROT_NONE, flags | MAP_PRIVATE, anonfd, 0);
> +    int mmap_flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
> +    void *ptr = mmap(0, total, PROT_NONE, mmap_flags | MAP_PRIVATE, anonfd, 0);
>  #else
>      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  #endif
> +    bool shared = flags & RAM_SHARED;
>      size_t offset;
>      void *ptr1;
>  
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index fbd0dc8..75a0171 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -54,6 +54,7 @@
>  #endif
>  
>  #include "qemu/mmap-alloc.h"
> +#include "exec/memory.h"
>  
>  #ifdef CONFIG_DEBUG_STACK_USAGE
>  #include "qemu/error-report.h"
> @@ -203,7 +204,13 @@ void *qemu_memalign(size_t alignment, size_t size)
>  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
>  {
>      size_t align = QEMU_VMALLOC_ALIGN;
> -    void *ptr = qemu_ram_mmap(-1, size, align, shared);
> +    uint32_t flags = 0;
> +    void *ptr;
> +
> +    if (shared) {
> +        flags = RAM_SHARED;
> +    }
> +    ptr = qemu_ram_mmap(-1, size, align, flags);
>  
>      if (ptr == MAP_FAILED) {
>          return NULL;
> -- 
> 2.7.4
