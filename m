Received: from eggs.gnu.org ([209.51.188.92]:47910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjEd7-0003LC-UD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gjEd6-0002CZ-LE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:39:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:60233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gjEd6-0002Bk-CD
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:39:04 -0500
Date: Tue, 15 Jan 2019 10:39:14 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20190115023914.GA67749@tiger-server>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
	<863b9c951827a05978eddd241b62db4e48294a80.1546399191.git.yi.z.zhang@linux.intel.com>
	<20190114185036.GC28115@habkost.net>
	<20190114140223-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114140223-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V8 2/5] util/mmap-alloc: switch
 qemu_ram_mmap() to 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org

On 2019-01-14 at 14:04:25 -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 04:50:36PM -0200, Eduardo Habkost wrote:
> > On Wed, Jan 02, 2019 at 01:26:06PM +0800, Zhang Yi wrote:
> > > As more flag parameters besides the existing 'shared' are going to be
> > > added to qemu_ram_mmap(), let's switch 'shared' to a 'flags' parameter
> > > in advance, so as to ease the further additions.
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > ---
> > >  exec.c                    |  7 ++++---
> > >  include/exec/memory.h     | 22 ++++++++++++++++------
> > >  include/qemu/mmap-alloc.h | 19 ++++++++++++++++++-
> > >  util/mmap-alloc.c         |  8 +++++---
> > >  util/oslib-posix.c        |  9 ++++++++-
> > >  5 files changed, 51 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/exec.c b/exec.c
> > > index bb6170d..e92a7da 100644
> > > --- a/exec.c
> > > +++ b/exec.c
> > > @@ -1810,6 +1810,7 @@ static void *file_ram_alloc(RAMBlock *block,
> > >                              ram_addr_t memory,
> > >                              int fd,
> > >                              bool truncate,
> > > +                            uint32_t flags,
> > >                              Error **errp)
> > 
> > I suggest documenting on the commit message why you are changing
> > file_ram_alloc() too.  The commit message mentions only
> > qemu_ram_mmap().
> > 
> > >  {
> > >      void *area;
> > > @@ -1859,8 +1860,7 @@ static void *file_ram_alloc(RAMBlock *block,
> > >          perror("ftruncate");
> > >      }
> > >  
> > > -    area = qemu_ram_mmap(fd, memory, block->mr->align,
> > > -                         block->flags & RAM_SHARED);
> > > +    area = qemu_ram_mmap(fd, memory, block->mr->align, flags);
> > >      if (area == MAP_FAILED) {
> > >          error_setg_errno(errp, errno,
> > >                           "unable to map backing store for guest RAM");
> > > @@ -2279,7 +2279,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > >      new_block->used_length = size;
> > >      new_block->max_length = size;
> > >      new_block->flags = ram_flags;
> > > -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> > > +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size,
> > > +            ram_flags, errp);
> > >      if (!new_block->host) {
> > >          g_free(new_block);
> > >          return NULL;
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index 667466b..6e30c23 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -103,28 +103,38 @@ struct IOMMUNotifier {
> > >  };
> > >  typedef struct IOMMUNotifier IOMMUNotifier;
> > >  
> > > +#ifdef __CHECKER__
> > > +#define QEMU_BITWISE __attribute__((bitwise))
> > > +#define QEMU_FORCE   __attribute__((force))
> > > +#else
> > > +#define QEMU_BITWISE
> > > +#define QEMU_FORCE
> > > +#endif
> > > +
> > 
> > I assume this is a sparse feature?
> > 
> > Why is it part of this patch?  I suggest doing this in a separate
> > patch series and in a common header file, so other developers
> > have a better chance to review it and decide how to use this
> > sparse feature in QEMU.
> 
> It's needed for this series but yes, this ifdefery belongs in
> a more central header. Maybe qemu/osdep.h
> And it needs documentation and be a separate patch.
Agree, Thank Michael's explanation, better to doing this in a separate
patch series.
> 
> 
> > 
> > > +typedef unsigned QEMU_BITWISE QemuMmapFlags;
> > > +
> > >  /* RAM is pre-allocated and passed into qemu_ram_alloc_from_ptr */
> > > -#define RAM_PREALLOC   (1 << 0)
> > > +#define RAM_PREALLOC ((QEMU_FORCE QemuMmapFlags) (1 << 0))
> > >  
> > >  /* RAM is mmap-ed with MAP_SHARED */
> > > -#define RAM_SHARED     (1 << 1)
> > > +#define RAM_SHARED ((QEMU_FORCE QemuMmapFlags) (1 << 1))
> > >  
> > >  /* Only a portion of RAM (used_length) is actually used, and migrated.
> > >   * This used_length size can change across reboots.
> > >   */
> > > -#define RAM_RESIZEABLE (1 << 2)
> > > +#define RAM_RESIZEABLE ((QEMU_FORCE QemuMmapFlags) (1 << 2))
> > >  
> > >  /* UFFDIO_ZEROPAGE is available on this RAMBlock to atomically
> > >   * zero the page and wake waiting processes.
> > >   * (Set during postcopy)
> > >   */
> > > -#define RAM_UF_ZEROPAGE (1 << 3)
> > > +#define RAM_UF_ZEROPAGE ((QEMU_FORCE QemuMmapFlags) (1 << 3))
> > >  
> > >  /* RAM can be migrated */
> > > -#define RAM_MIGRATABLE (1 << 4)
> > > +#define RAM_MIGRATABLE ((QEMU_FORCE QemuMmapFlags) (1 << 4))
> > >  
> > >  /* RAM is a persistent kind memory */
> > > -#define RAM_PMEM (1 << 5)
> > > +#define RAM_PMEM ((QEMU_FORCE QemuMmapFlags) (1 << 5))
> > >  
> > >  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> > >                                         IOMMUNotifierFlag flags,
> > > diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> > > index 50385e3..6fe6ed4 100644
> > > --- a/include/qemu/mmap-alloc.h
> > > +++ b/include/qemu/mmap-alloc.h
> > > @@ -7,7 +7,24 @@ size_t qemu_fd_getpagesize(int fd);
> > >  
> > >  size_t qemu_mempath_getpagesize(const char *mem_path);
> > >  
> > > -void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
> > > +/**
> > > + * qemu_ram_mmap: mmap the specified file or device.
> > > + *
> > > + * Parameters:
> > > + *  @fd: the file or the device to mmap
> > > + *  @size: the number of bytes to be mmaped
> > > + *  @align: if not zero, specify the alignment of the starting mapping address;
> > > + *          otherwise, the alignment in use will be determined by QEMU.
> > > + *  @flags: specifies additional properties of the mapping, which can be one or
> > > + *          bit-or of following values
> > > + *          - RAM_SHARED: mmap with MAP_SHARED flag
> > > + *          Other bits are ignored.
> > > + *
> > > + * Return:
> > > + *  On success, return a pointer to the mapped area.
> > > + *  On failure, return MAP_FAILED.
> > > + */
> > > +void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags);
> > >  
> > >  void qemu_ram_munmap(void *ptr, size_t size);
> > >  
> > > diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> > > index fd329ec..8f0a740 100644
> > > --- a/util/mmap-alloc.c
> > > +++ b/util/mmap-alloc.c
> > > @@ -13,6 +13,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qemu/mmap-alloc.h"
> > >  #include "qemu/host-utils.h"
> > > +#include "exec/memory.h"
> > >  
> > >  #define HUGETLBFS_MAGIC       0x958458f6
> > >  
> > > @@ -75,7 +76,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
> > >      return getpagesize();
> > >  }
> > >  
> > > -void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> > > +void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
> > >  {
> > >      /*
> > >       * Note: this always allocates at least one extra page of virtual address
> > > @@ -92,11 +93,12 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
> > >       * anonymous memory is OK.
> > >       */
> > >      int anonfd = fd == -1 || qemu_fd_getpagesize(fd) == getpagesize() ? -1 : fd;
> > > -    int flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
> > > -    void *ptr = mmap(0, total, PROT_NONE, flags | MAP_PRIVATE, anonfd, 0);
> > > +    int mmap_flags = anonfd == -1 ? MAP_ANONYMOUS : MAP_NORESERVE;
> > > +    void *ptr = mmap(0, total, PROT_NONE, mmap_flags | MAP_PRIVATE, anonfd, 0);
> > >  #else
> > >      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > >  #endif
> > > +    bool shared = flags & RAM_SHARED;
> > >      size_t offset;
> > >      void *ptr1;
> > >  
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index fbd0dc8..75a0171 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -54,6 +54,7 @@
> > >  #endif
> > >  
> > >  #include "qemu/mmap-alloc.h"
> > > +#include "exec/memory.h"
> > >  
> > >  #ifdef CONFIG_DEBUG_STACK_USAGE
> > >  #include "qemu/error-report.h"
> > > @@ -203,7 +204,13 @@ void *qemu_memalign(size_t alignment, size_t size)
> > >  void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
> > >  {
> > >      size_t align = QEMU_VMALLOC_ALIGN;
> > > -    void *ptr = qemu_ram_mmap(-1, size, align, shared);
> > > +    uint32_t flags = 0;
> > > +    void *ptr;
> > > +
> > > +    if (shared) {
> > > +        flags = RAM_SHARED;
> > > +    }
> > > +    ptr = qemu_ram_mmap(-1, size, align, flags);
> > >  
> > >      if (ptr == MAP_FAILED) {
> > >          return NULL;
> > > -- 
> > > 2.7.4
> > > 
> > > 
> > 
> > -- 
> > Eduardo
