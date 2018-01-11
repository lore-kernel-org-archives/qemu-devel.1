Received: from eggs.gnu.org ([2001:4830:134:3::10]:39497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZj7M-0001Op-5L
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZj7I-0004ob-Q9
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZj7I-0004nc-Eh
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:24 -0500
Date: Thu, 11 Jan 2018 20:06:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111200610.GE13422@work-vm>
References: <20180111142208.17617-1-haozhong.zhang@intel.com>
	<20180111142208.17617-3-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180111142208.17617-3-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>

* Haozhong Zhang (haozhong.zhang@intel.com) wrote:
> This option controls whether QEMU mmap(2) the memory backend file with
> MAP_SYNC flag, which can fully guarantee the guest write persistence
> to the backend, if MAP_SYNC flag is supported by the host kernel
> (Linux kernel 4.15 and later) and the backend is a file supporting
> DAX (e.g., file on ext4/xfs file system mounted with '-o dax').
> 
> It can take one of following values:
>  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
>         'share=off', QEMU will abort
>  - off: never pass MAP_SYNC to mmap(2)
>  - auto (default): if MAP_SYNC is supported and 'share=on', work as if
>         'sync=on'; otherwise, work as if 'sync=off'

I don't know anything about MAP_SYNC but see two minor comments below:

> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Sugguested-by: Eduardo Habkost <ehabkost@redhat.com>
      ^ typo!

> ---
>  backends/hostmem-file.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 15 ++++++++++++++-
>  exec.c                  | 13 ++++++++-----
>  include/exec/memory.h   |  4 ++++
>  include/exec/ram_addr.h |  6 +++---
>  memory.c                |  6 ++++--
>  numa.c                  |  2 +-
>  qemu-options.hx         | 21 ++++++++++++++++++++-
>  8 files changed, 92 insertions(+), 14 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index e319ec1ad8..52fdc0a48a 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -15,6 +15,7 @@
>  #include "sysemu/hostmem.h"
>  #include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
> +#include "qapi-visit.h"
>  
>  /* hostmem-file.c */
>  /**
> @@ -35,6 +36,7 @@ struct HostMemoryBackendFile {
>      bool discard_data;
>      char *mem_path;
>      uint64_t align;
> +    OnOffAuto sync;
>  };
>  
>  static void
> @@ -60,7 +62,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>                                   path,
>                                   backend->size, fb->align, fb->share,
> -                                 fb->mem_path, errp);
> +                                 fb->sync, fb->mem_path, errp);
>          g_free(path);
>      }
>  #endif
> @@ -150,6 +152,38 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
>      error_propagate(errp, local_err);
>  }
>  
> +static void file_memory_backend_get_sync(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> +    OnOffAuto value = fb->sync;
> +
> +    visit_type_OnOffAuto(v, name, &value, errp);
> +}
> +
> +static void file_memory_backend_set_sync(
> +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> +    Error *local_err = NULL;
> +    OnOffAuto value;
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(&local_err, "cannot change property value");

Please make this error clearer; if I was helping someone and saw
this error message in a log, I wouldn't know what type of property it
was on what device.   Please at least include something saying it's
memory backend related and sync related; even just including a %s and
__func__ would help;  even better if you include the name of the object
so if you had multiple backend files and one failed you could see which
one.

Dave

> +        goto out;
> +    }
> +
> +    visit_type_OnOffAuto(v, name, &value, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    fb->sync = value;
> +
> + out:
> +    error_propagate(errp, local_err);
> +}
> +
>  static void file_backend_unparent(Object *obj)
>  {
>      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> @@ -184,6 +218,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
>          file_memory_backend_get_align,
>          file_memory_backend_set_align,
>          NULL, NULL, &error_abort);
> +    object_class_property_add(oc, "sync", "OnOffAuto",
> +        file_memory_backend_get_sync, file_memory_backend_set_sync,
> +        NULL, NULL, &error_abort);
>  }
>  
>  static void file_backend_instance_finalize(Object *o)
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index e903d8bb09..49b174fe66 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -143,10 +143,23 @@ Guest Data Persistence
>  ----------------------
>  
>  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> -currently the only one that can guarantee the guest write persistence
> +if MAP_SYNC is not supported by the host kernel and the backends,
> +the only backend that can guarantee the guest write persistence
>  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
>  which all guest access do not involve any host-side kernel cache.
>  
> +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can
> +guarantee the guest write persistence to vNVDIMM. Besides the host
> +kernel support, enabling MAP_SYNC in QEMU also requires:
> +
> + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> +   xfs file system mounted with "-o dax",
> +
> + - 'sync' option of memory-backend-file is not 'off', and
> +
> + - 'share' option of memory-backend-file is 'on'.
> +
>  When using other types of backends, it's suggested to set 'unarmed'
>  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
>  guest NVDIMM region mapping structure.  This unarmed flag indicates
> diff --git a/exec.c b/exec.c
> index f4254cb6d3..ce13f8cb21 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1600,6 +1600,7 @@ static void *file_ram_alloc(RAMBlock *block,
>                              ram_addr_t memory,
>                              int fd,
>                              bool truncate,
> +                            OnOffAuto sync,
>                              Error **errp)
>  {
>      void *area;
> @@ -1646,7 +1647,7 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
>  
>      area = qemu_ram_mmap(fd, memory, block->mr->align,
> -                         block->flags & RAM_SHARED, ON_OFF_AUTO_OFF);
> +                         block->flags & RAM_SHARED, sync);
>      if (area == MAP_FAILED) {
>          error_setg_errno(errp, errno,
>                           "unable to map backing store for guest RAM");
> @@ -1974,7 +1975,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>  
>  #ifdef __linux__
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 bool share, OnOffAuto sync, int fd,
>                                   Error **errp)
>  {
>      RAMBlock *new_block;
> @@ -2017,7 +2018,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      new_block->used_length = size;
>      new_block->max_length = size;
>      new_block->flags = share ? RAM_SHARED : 0;
> -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
> +    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, sync,
> +                                     errp);
>      if (!new_block->host) {
>          g_free(new_block);
>          return NULL;
> @@ -2035,7 +2037,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>  
>  
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> +                                   bool share, OnOffAuto sync,
> +                                   const char *mem_path,
>                                     Error **errp)
>  {
>      int fd;
> @@ -2047,7 +2050,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>          return NULL;
>      }
>  
> -    block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    block = qemu_ram_alloc_from_fd(size, mr, share, sync, fd, errp);
>      if (!block) {
>          if (created) {
>              unlink(mem_path);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 07c5d6d597..ff3cd583e9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -468,6 +468,9 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
>   * @align: alignment of the region base address; if 0, the default alignment
>   *         (getpagesize()) will be used.
>   * @share: %true if memory must be mmaped with the MAP_SHARED flag
> + * @sync: %ON_OFF_AUTO_ON if memory must be mapped with MAP_SYNC flag;
> + *        %ON_OFF_AUTO_OFF if memory cannot be mapped with MAP_SYNC flag;
> + *        %ON_OFF_AUTO_AUTO directs QEMU to mmap with MAP_SYNC flag if possible
>   * @path: the path in which to allocate the RAM.
>   * @errp: pointer to Error*, to store an error if it happens.
>   *
> @@ -480,6 +483,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        uint64_t size,
>                                        uint64_t align,
>                                        bool share,
> +                                      OnOffAuto sync,
>                                        const char *path,
>                                        Error **errp);
>  
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 6cbc02aa0f..4494ae9132 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -73,10 +73,10 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
>  long qemu_getrampagesize(void);
>  unsigned long last_ram_page(void);
>  RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> -                                   bool share, const char *mem_path,
> -                                   Error **errp);
> +                                   bool share, OnOffAuto sync,
> +                                   const char *mem_path, Error **errp);
>  RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> -                                 bool share, int fd,
> +                                 bool share, OnOffAuto sync, int fd,
>                                   Error **errp);
>  RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
>                                    MemoryRegion *mr, Error **errp);
> diff --git a/memory.c b/memory.c
> index 449a1429b9..e22f51394e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1572,6 +1572,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>                                        uint64_t size,
>                                        uint64_t align,
>                                        bool share,
> +                                      OnOffAuto sync,
>                                        const char *path,
>                                        Error **errp)
>  {
> @@ -1580,7 +1581,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->align = align;
> -    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
> +    mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, sync, path, errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  
> @@ -1596,7 +1597,8 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
>      mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
> -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, fd, errp);
> +    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, share, ON_OFF_AUTO_OFF, fd,
> +                                           errp);
>      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
>  #endif
> diff --git a/numa.c b/numa.c
> index 83675a03f3..93180510a4 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -457,7 +457,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>  #ifdef __linux__
>          Error *err = NULL;
>          memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
> -                                         mem_path, &err);
> +                                         ON_OFF_AUTO_OFF, mem_path, &err);
>          if (err) {
>              error_report_err(err);
>              if (mem_prealloc) {
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5ff741a4af..3ee423e6a8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3974,7 +3974,7 @@ property must be set.  These objects are placed in the
>  
>  @table @option
>  
> -@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
> +@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off|auto}
>  
>  Creates a memory file backend object, which can be used to back
>  the guest RAM with huge pages.
> @@ -4034,6 +4034,25 @@ requires an alignment different than the default one used by QEMU, eg
>  the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
>  such cases, users can specify the required alignment via this option.
>  
> +The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
> +with MAP_SYNC flag, which can fully guarantee the guest write
> +persistence to @option{mem-path}. MAP_SYNC requires supports from both
> +the host kernel (since Linux kernel 4.15) and @option{mem-path} (only
> +files supporting DAX). It can take one of following values:
> +
> +@table @option
> +@item @var{on}
> +try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> +@option{share}=@var{off}, QEMU will abort
> +
> +@item @var{off}
> +never pass MAP_SYNC to mmap(2)
> +
> +@item @var{auto} (default)
> +if MAP_SYNC is supported and @option{share}=@var{on}, work as if
> +@option{sync}=@var{on}; otherwise, work as if @option{sync}=@var{off}
> +@end table
> +
>  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
>  
>  Creates a memory backend object, which can be used to back the guest RAM.
> -- 
> 2.15.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
