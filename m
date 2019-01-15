Received: from eggs.gnu.org ([209.51.188.92]:54369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFSC-0005u6-4l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFSA-0005Hw-IC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:31:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjFSA-0005HQ-9H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:31:50 -0500
Date: Mon, 14 Jan 2019 22:31:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114222122-mutt-send-email-mst@kernel.org>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
	<eb386264e7015f0a14c0c9686193555b3d2285e0.1546399191.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb386264e7015f0a14c0c9686193555b3d2285e0.1546399191.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V8 5/5] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com

On Wed, Jan 02, 2019 at 01:26:34PM +0800, Zhang Yi wrote:
> This option controls will mmap the memory backend file with MAP_SYNC flag,
> which can ensure filesystem metadata consistent even after a system crash
> or power failure, if MAP_SYNC flag is supported by the host kernel(Linux
> kernel 4.15 and later) and the backend is a file supporting DAX (e.g.,
> file on ext4/xfs file system mounted with '-o dax').
> 
> It can take one of following values:
>  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
>         'share=off' or 'pmem!=on', QEMU will not pass this flags to
> 	mmap(2)
>  - off: default, never pass MAP_SYNC to mmap(2)
> 
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>


So we introduce all of the above complexity and then I am pretty sure go
on and teach management tools to just always, without exception, set
sync=on to avoid data corruption.

So how about we give up on a bit of flexibility, and just say
pmem=on forces MAP_SYNC?

OTOH if you really really want a fast memory then why set pmem=on at
all?

Or, if you have some data that shows how disabling synchronous
pagefaults helps performance a lot, maybe we should introduce
a "crash-unsafe" flag.



> ---
>  backends/hostmem-file.c   | 28 ++++++++++++++++++++++++++++
>  docs/nvdimm.txt           | 23 ++++++++++++++++++++++-
>  exec.c                    |  2 +-
>  include/exec/memory.h     |  4 ++++
>  include/exec/ram_addr.h   |  1 +
>  include/qemu/mmap-alloc.h |  1 +
>  qemu-options.hx           | 19 ++++++++++++++++++-
>  util/mmap-alloc.c         |  4 ++--
>  8 files changed, 77 insertions(+), 5 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 0dd7a90..3d39032 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -36,6 +36,7 @@ struct HostMemoryBackendFile {
>      uint64_t align;
>      bool discard_data;
>      bool is_pmem;
> +    bool sync;
>  };
>  
>  static void
> @@ -62,6 +63,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>                                   path,
>                                   backend->size, fb->align,
>                                   (backend->share ? RAM_SHARED : 0) |
> +                                 (fb->sync ? RAM_SYNC : 0) |
>                                   (fb->is_pmem ? RAM_PMEM : 0),
>                                   fb->mem_path, errp);
>          g_free(path);
> @@ -136,6 +138,29 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
>      error_propagate(errp, local_err);
>  }
>  
> +static bool file_memory_backend_get_sync(Object *o, Error **errp)
> +{
> +    return MEMORY_BACKEND_FILE(o)->sync;
> +}
> +
> +static void file_memory_backend_set_sync(
> +    Object *obj, bool value, Error **errp)
> +{
> +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(errp, "cannot change property sync of %s",
> +                   object_get_typename(obj));
> +        goto out;
> +    }
> +
> +    fb->sync = value;
> +
> + out:
> +    return;
> +}
> +
>  static bool file_memory_backend_get_pmem(Object *o, Error **errp)
>  {
>      return MEMORY_BACKEND_FILE(o)->is_pmem;
> @@ -203,6 +228,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "pmem",
>          file_memory_backend_get_pmem, file_memory_backend_set_pmem,
>          &error_abort);
> +    object_class_property_add_bool(oc, "sync",
> +        file_memory_backend_get_sync, file_memory_backend_set_sync,
> +        &error_abort);
>  }
>  
>  static void file_backend_instance_finalize(Object *o)
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index 5f158a6..30db458 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -142,11 +142,32 @@ backend of vNVDIMM:
>  Guest Data Persistence
>  ----------------------
>  
> +vNVDIMM is designed and implemented to guarantee the guest data
> +persistence on the backends even on the host crash and power
> +failures. However, there are still some requirements and limitations
> +as explained below.
> +
>  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> -currently the only one that can guarantee the guest write persistence
> +if MAP_SYNC is not supported by the host kernel and the backends,
> +the only backend that can guarantee the guest write persistence
>  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
>  which all guest access do not involve any host-side kernel cache.
>  
> +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can ensure
> +filesystem metadata consistent even after a system crash or power
> +failure. Besides the host kernel support, enabling MAP_SYNC in QEMU
> +also requires:
> +
> + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> +   xfs file system mounted with '-o dax',
> +
> + - 'sync' option of memory-backend-file is on, and
> +
> + - 'share' option of memory-backend-file is 'on'.
> +
> + - 'pmem' option of memory-backend-file is 'on'
> +
>  When using other types of backends, it's suggested to set 'unarmed'
>  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
>  guest NVDIMM region mapping structure.  This unarmed flag indicates
> diff --git a/exec.c b/exec.c
> index e92a7da..dc4d180 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2241,7 +2241,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      int64_t file_size;
>  
>      /* Just support these ram flags by now. */
> -    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
> +    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_SYNC)) == 0);
>  
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 6e30c23..9297b1c 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -26,6 +26,7 @@
>  #include "qom/object.h"
>  #include "qemu/rcu.h"
>  #include "hw/qdev-core.h"
> +#include "qapi/error.h"
>  
>  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>  
> @@ -136,6 +137,9 @@ typedef unsigned QEMU_BITWISE QemuMmapFlags;
>  /* RAM is a persistent kind memory */
>  #define RAM_PMEM ((QEMU_FORCE QemuMmapFlags) (1 << 5))
>  
> +/* RAM can be mmap by a MAP_SYNC flag */
> +#define RAM_SYNC ((QEMU_FORCE QemuMmapFlags) (1 << 6))
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 9ecd911..d239ce7 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -87,6 +87,7 @@ long qemu_getrampagesize(void);
>   *              or bit-or of following values
>   *              - RAM_SHARED: mmap the backing file or device with MAP_SHARED
>   *              - RAM_PMEM: the backend @mem_path or @fd is persistent memory
> + *              - RAM_SYNC:   mmap with MAP_SYNC flag
>   *              Other bits are ignored.
>   *  @mem_path or @fd: specify the backing file or device
>   *  @errp: pointer to Error*, to store an error if it happens
> diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
> index 6fe6ed4..1755a8b 100644
> --- a/include/qemu/mmap-alloc.h
> +++ b/include/qemu/mmap-alloc.h
> @@ -18,6 +18,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
>   *  @flags: specifies additional properties of the mapping, which can be one or
>   *          bit-or of following values
>   *          - RAM_SHARED: mmap with MAP_SHARED flag
> + *          - RAM_SYNC:   mmap with MAP_SYNC flag
>   *          Other bits are ignored.
>   *
>   * Return:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08f8516..0f51d08 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3928,7 +3928,7 @@ property must be set.  These objects are placed in the
>  
>  @table @option
>  
> -@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
> +@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off}
>  
>  Creates a memory file backend object, which can be used to back
>  the guest RAM with huge pages.
> @@ -4003,6 +4003,23 @@ If @option{pmem} is set to 'on', QEMU will take necessary operations to
>  guarantee the persistence of its own writes to @option{mem-path}
>  (e.g. in vNVDIMM label emulation and live migration).
>  
> +The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
> +with MAP_SYNC flag, which can ensure the file metadata is in sync to
> +@option{mem-path} even on the host crash and power failures. MAP_SYNC
> +requires supports from both the host kernel (since Linux kernel 4.15)
> +and @option{mem-path} (only files supporting DAX). It can take one of
> +following values:
> +
> +@table @option
> +@item @var{on}
> +try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> +@option{share}=@var{off}, @option{pmem}=@var{off} QEMU will not pass
> +this flags to kernel.
> +
> +@item @var{off} (default)
> +never pass MAP_SYNC to mmap(2)
> +@end table
> +
>  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
>  
>  Creates a memory backend object, which can be used to back the guest RAM.
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index a9d5e56..33a7639 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -99,7 +99,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
>      void *ptr = mmap(0, total, PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  #endif
>      bool shared = flags & RAM_SHARED;
> -    bool is_pmem = flags & RAM_PMEM;
> +    bool is_pmemsync = (flags & RAM_PMEM) && (flags & RAM_SYNC);
>      int mmap_xflags = 0;
>      size_t offset;
>      void *ptr1;
> @@ -111,7 +111,7 @@ void *qemu_ram_mmap(int fd, size_t size, size_t align, uint32_t flags)
>      assert(is_power_of_2(align));
>      /* Always align to host page size */
>      assert(align >= getpagesize());
> -    if (shared && is_pmem) {
> +    if (shared && is_pmemsync) {
>          mmap_xflags |= MAP_SYNC;
>      }
>  
> -- 
> 2.7.4
