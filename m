Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGD8-0001LU-SZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGD5-0005Ob-GU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:19:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZGD3-0005NY-C8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:18:58 -0500
Date: Tue, 18 Dec 2018 09:18:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218085249-mutt-send-email-mst@kernel.org>
References: <cover.1545120100.git.yi.z.zhang@linux.intel.com>
	<5eb87eb9a389242772375dd52bd97c17564a0829.1545120100.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb87eb9a389242772375dd52bd97c17564a0829.1545120100.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V7 6/6] hostmem-file: add 'sync' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com

On Tue, Dec 18, 2018 at 04:17:39PM +0800, Zhang Yi wrote:
> This option controls whether QEMU mmap(2)

will mmap

> the memory backend file with
> MAP_SYNC flag, which could consistent filesystem metadata

I'm not sure what does "which could consistent" above mean.


> for each guest
> write, if MAP_SYNC flag is supported by the host kernel(Linux kernel 4.15

space before ( here pls.

> and later) and the backend is a file supporting DAX (e.g., file on ext4/xfs
> file system mounted with '-o dax').
> 
> It can take one of following values:
>  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
>         'share=off' or 'pmem!=on', QEMU will abort

Really abort? What if it's added with object_add?
Should just fail not abort in that case ...

Also you know whether it's built into qemu at build time -
how about skipping it in the schema and man page in that case?


>  - off: never pass MAP_SYNC to mmap(2)
>  - auto (default): if MAP_SYNC is supported and 'share=on' 'pmem=on', work as
>         if 'sync=on'; otherwise, work as if 'sync=off'

So this is a mechanism. And users really do not care about
the mechanism. What do users want? See discussion in nvdimm.txt


> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  backends/hostmem-file.c | 39 +++++++++++++++++++++++++++++++++++++++
>  docs/nvdimm.txt         | 22 +++++++++++++++++++++-
>  include/exec/memory.h   |  8 ++++++++
>  qemu-options.hx         | 22 +++++++++++++++++++++-
>  4 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 0dd7a90..73cf181 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -16,6 +16,7 @@
>  #include "sysemu/hostmem.h"
>  #include "sysemu/sysemu.h"
>  #include "qom/object_interfaces.h"
> +#include "qapi/qapi-visit.h"
>  
>  /* hostmem-file.c */
>  /**
> @@ -36,6 +37,7 @@ struct HostMemoryBackendFile {
>      uint64_t align;
>      bool discard_data;
>      bool is_pmem;
> +    OnOffAuto sync;
>  };
>  
>  static void
> @@ -62,6 +64,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>                                   path,
>                                   backend->size, fb->align,
>                                   (backend->share ? RAM_SHARED : 0) |
> +                                 qemu_ram_sync_flags(fb->sync) |
>                                   (fb->is_pmem ? RAM_PMEM : 0),
>                                   fb->mem_path, errp);
>          g_free(path);
> @@ -136,6 +139,39 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
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
> +        error_setg(&local_err, "cannot change property '%s' of %s",
> +                   name, object_get_typename(obj));
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
>  static bool file_memory_backend_get_pmem(Object *o, Error **errp)
>  {
>      return MEMORY_BACKEND_FILE(o)->is_pmem;
> @@ -203,6 +239,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_bool(oc, "pmem",
>          file_memory_backend_get_pmem, file_memory_backend_set_pmem,
>          &error_abort);
> +    object_class_property_add(oc, "sync", "OnOffAuto",
> +        file_memory_backend_get_sync, file_memory_backend_set_sync,
> +        NULL, NULL, &error_abort);
>  }
>  
>  static void file_backend_instance_finalize(Object *o)
> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> index 5f158a6..d86a270 100644
> --- a/docs/nvdimm.txt
> +++ b/docs/nvdimm.txt
> @@ -142,11 +142,31 @@ backend of vNVDIMM:
>  Guest Data Persistence
>  ----------------------

>  
> +vNVDIMM is designed and implemented to guarantee
> the guest data
> +persistence on the backends even on the host crash and power
> +failures. However, there are still some requirements and limitations
> +as explained below.
> +

How about:

nNVDIMM can guarantee guest data persistence in case of a host
failure such as a crash or power failure, but only if the following
conditions are satistied.

>  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> -currently the only one that can guarantee the guest write persistence
> +if MAP_SYNC is not supported by the host kernel and the backends,
> +the only backend that can guarantee the guest write persistence
>  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
>  which all guest access do not involve any host-side kernel cache.

BTW I think this user-facing detail belongs in the man page, not the
source doc.


>  
> +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> +systems, QEMU can mmap(2) the backend with MAP_SYNC, which could

Please check all your uses of "could" and "may" and replace
with stronger wording that matches reality. 
I am guessing it's copied from
some other language and I'm trying not to be a language purist
but it's confusing in English.
E.g. no one wants an implementation that could guarantee consistence -
people want one that does guarantee it.

> +consistent filesystem metadata for each guest write. Besides the host
> +kernel support, enabling MAP_SYNC in QEMU also requires:
> +
> + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> +   xfs file system mounted with '-o dax',

Why list the filesystems here? The list can change with Linux.

> +
> + - 'sync' option of memory-backend-file is not 'off', and
> +
> + - 'share' option of memory-backend-file is 'on'.
> +
> + - 'pmem' option of memory-backend-file is 'on'
> +

Wait isn't this what pmem was supposed to do?
Doesn't it mean "persistent memory"?

Just goes to show that abbreviation is not good in a user interface IMHO.

I think a higher level name like e.g.  "host-failure-persistent"
would be better. Have that set whatever flags you need to
actually be persistent. Thoughts?



>  When using other types of backends, it's suggested to set 'unarmed'
>  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
>  guest NVDIMM region mapping structure.  This unarmed flag indicates
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index c74c467..b398abb 100644
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
> @@ -136,6 +137,13 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  
>  #define RAM_SYNC (RAM_SYNC_ON_OFF_AUTO_ON | RAM_SYNC_ON_OFF_AUTO_AUTO)
>  
> +static inline uint64_t qemu_ram_sync_flags(OnOffAuto v)
> +{
> +    return v == ON_OFF_AUTO_OFF ? RAM_SYNC_ON_OFF_AUTO_OFF :
> +           v == ON_OFF_AUTO_ON ? RAM_SYNC_ON_OFF_AUTO_ON :
> +           RAM_SYNC_ON_OFF_AUTO_AUTO;
> +}
> +

That's pretty confusing.
ON_OFF_AUTO_AUTO is painful enough. I don't think you want
to duplicate this with all prefixes like RAM_SYNC_ON_OFF_AUTO_ON.
Pls avoid doing it.


>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08f8516..624f634 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3928,7 +3928,7 @@ property must be set.  These objects are placed in the
>  
>  @table @option
>  
> -@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
> +@item -object memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off|auto}
>  
>  Creates a memory file backend object, which can be used to back
>  the guest RAM with huge pages.
> @@ -4003,6 +4003,26 @@ If @option{pmem} is set to 'on', QEMU will take necessary operations to
>  guarantee the persistence of its own writes to @option{mem-path}
>  (e.g. in vNVDIMM label emulation and live migration).
>  
> +The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
> +with MAP_SYNC flag, which can guarantee the guest write persistence to
> +@option{mem-path} even on the host crash and power failures. MAP_SYNC
> +requires supports from both the host kernel (since Linux kernel 4.15)
> +and @option{mem-path} (only files supporting DAX). It can take one of
> +following values:
> +
> +@table @option
> +@item @var{on}
> +try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> +@option{share}=@var{off}, @option{pmem}=@var{off} QEMU will abort
> +
> +@item @var{off}
> +never pass MAP_SYNC to mmap(2)
> +
> +@item @var{auto} (default)
> +if MAP_SYNC is supported and @option{share}=@var{on}, @option{pmem}=@var{on}
> +work as if @option{sync}=@var{on}; otherwise, work as if @option{sync}=@var{off}
> +@end table
> +
>  @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
>  
>  Creates a memory backend object, which can be used to back the guest RAM.
> -- 
> 2.7.4
