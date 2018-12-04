Received: from eggs.gnu.org ([2001:4830:134:3::10]:46622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gU5Gv-0000MN-Dd
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.z.zhang@linux.intel.com>) id 1gU5Cv-00049d-O1
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:33:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:48787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.z.zhang@linux.intel.com>)
	id 1gU5Ct-00043x-P7
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 02:33:25 -0500
Date: Tue, 4 Dec 2018 15:32:59 +0800
From: Yi Zhang <yi.z.zhang@linux.intel.com>
Message-ID: <20181204073259.GB74594@tiger-server>
References: <cover.1542699775.git.yi.z.zhang@linux.intel.com>
	<cb65ee91dd31df303dcb7c0e28143542678c9891.1542699775.git.yi.z.zhang@linux.intel.com>
	<1649439383.36010013.1543222010591.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649439383.36010013.1543222010591.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5_resend 7/7] hostmem-file: add 'sync'
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, dan j williams <dan.j.williams@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, yu c zhang <yu.c.zhang@linux.intel.com>, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com

On 2018-11-26 at 03:46:50 -0500, Pankaj Gupta wrote:
> 
> > 
> > This option controls whether QEMU mmap(2) the memory backend file with
> > MAP_SYNC flag, which can fully guarantee the guest write persistence
> 
> Not sure 'persistence' is the right word here. I think it should be
> something like 'consistent filesystem metadata for every guest write' just 
> to avoid any confusion.

Yes, Agree, the main porpurse of this flag is "*consistent filesystem
metadata", I will improve that comments in next version

Regards
Yi.

> 
> > to the backend, if MAP_SYNC flag is supported by the host kernel
> > (Linux kernel 4.15 and later) and the backend is a file supporting
> > DAX (e.g., file on ext4/xfs file system mounted with '-o dax').
> > 
> > It can take one of following values:
> >  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> >         'share=off', QEMU will abort
> >  - off: never pass MAP_SYNC to mmap(2)
> >  - auto (default): if MAP_SYNC is supported and 'share=on', work as if
> >         'sync=on'; otherwise, work as if 'sync=off'
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > ---
> >  backends/hostmem-file.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  docs/nvdimm.txt         | 20 +++++++++++++++++++-
> >  include/exec/memory.h   |  8 ++++++++
> >  qemu-options.hx         | 22 +++++++++++++++++++++-
> >  4 files changed, 87 insertions(+), 2 deletions(-)
> > 
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index 0dd7a90..73cf181 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -16,6 +16,7 @@
> >  #include "sysemu/hostmem.h"
> >  #include "sysemu/sysemu.h"
> >  #include "qom/object_interfaces.h"
> > +#include "qapi/qapi-visit.h"
> >  
> >  /* hostmem-file.c */
> >  /**
> > @@ -36,6 +37,7 @@ struct HostMemoryBackendFile {
> >      uint64_t align;
> >      bool discard_data;
> >      bool is_pmem;
> > +    OnOffAuto sync;
> >  };
> >  
> >  static void
> > @@ -62,6 +64,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error
> > **errp)
> >                                   path,
> >                                   backend->size, fb->align,
> >                                   (backend->share ? RAM_SHARED : 0) |
> > +                                 qemu_ram_sync_flags(fb->sync) |
> >                                   (fb->is_pmem ? RAM_PMEM : 0),
> >                                   fb->mem_path, errp);
> >          g_free(path);
> > @@ -136,6 +139,39 @@ static void file_memory_backend_set_align(Object *o,
> > Visitor *v,
> >      error_propagate(errp, local_err);
> >  }
> >  
> > +static void file_memory_backend_get_sync(
> > +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> > +{
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> > +    OnOffAuto value = fb->sync;
> > +
> > +    visit_type_OnOffAuto(v, name, &value, errp);
> > +}
> > +
> > +static void file_memory_backend_set_sync(
> > +    Object *obj, Visitor *v, const char *name, void *opaque, Error **errp)
> > +{
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(obj);
> > +    Error *local_err = NULL;
> > +    OnOffAuto value;
> > +
> > +    if (host_memory_backend_mr_inited(backend)) {
> > +        error_setg(&local_err, "cannot change property '%s' of %s",
> > +                   name, object_get_typename(obj));
> > +        goto out;
> > +    }
> > +
> > +    visit_type_OnOffAuto(v, name, &value, &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +    fb->sync = value;
> > +
> > + out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> >  static bool file_memory_backend_get_pmem(Object *o, Error **errp)
> >  {
> >      return MEMORY_BACKEND_FILE(o)->is_pmem;
> > @@ -203,6 +239,9 @@ file_backend_class_init(ObjectClass *oc, void *data)
> >      object_class_property_add_bool(oc, "pmem",
> >          file_memory_backend_get_pmem, file_memory_backend_set_pmem,
> >          &error_abort);
> > +    object_class_property_add(oc, "sync", "OnOffAuto",
> > +        file_memory_backend_get_sync, file_memory_backend_set_sync,
> > +        NULL, NULL, &error_abort);
> >  }
> >  
> >  static void file_backend_instance_finalize(Object *o)
> > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > index 5f158a6..3d89174 100644
> > --- a/docs/nvdimm.txt
> > +++ b/docs/nvdimm.txt
> > @@ -142,11 +142,29 @@ backend of vNVDIMM:
> >  Guest Data Persistence
> >  ----------------------
> >  
> > +vNVDIMM is designed and implemented to guarantee the guest data
> > +persistence on the backends even on the host crash and power
> > +failures. However, there are still some requirements and limitations
> > +as explained below.
> > +
> >  Though QEMU supports multiple types of vNVDIMM backends on Linux,
> > -currently the only one that can guarantee the guest write persistence
> > +if MAP_SYNC is not supported by the host kernel and the backends,
> > +the only backend that can guarantee the guest write persistence
> >  is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> >  which all guest access do not involve any host-side kernel cache.
> >  
> > +mmap(2) flag MAP_SYNC is added since Linux kernel 4.15. On such
> > +systems, QEMU can mmap(2) the backend with MAP_SYNC, which can
> 
> I think its important to clear about the type of backend. 
> i.e DAX file on real NVDIMM device backend.
> 
> Thanks,
> Pankaj 
> 
> > +guarantee the guest write persistence to vNVDIMM. Besides the host
> > +kernel support, enabling MAP_SYNC in QEMU also requires:
> > +
> > + - the backend is a file supporting DAX, e.g., a file on an ext4 or
> > +   xfs file system mounted with '-o dax',
> > +
> > + - 'sync' option of memory-backend-file is not 'off', and
> > +
> > + - 'share' option of memory-backend-file is 'on'.
> > +
> >  When using other types of backends, it's suggested to set 'unarmed'
> >  option of '-device nvdimm' to 'on', which sets the unarmed flag of the
> >  guest NVDIMM region mapping structure.  This unarmed flag indicates
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index c74c467..b398abb 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -26,6 +26,7 @@
> >  #include "qom/object.h"
> >  #include "qemu/rcu.h"
> >  #include "hw/qdev-core.h"
> > +#include "qapi/error.h"
> >  
> >  #define RAM_ADDR_INVALID (~(ram_addr_t)0)
> >  
> > @@ -136,6 +137,13 @@ typedef struct IOMMUNotifier IOMMUNotifier;
> >  
> >  #define RAM_SYNC (RAM_SYNC_ON_OFF_AUTO_ON | RAM_SYNC_ON_OFF_AUTO_AUTO)
> >  
> > +static inline uint64_t qemu_ram_sync_flags(OnOffAuto v)
> > +{
> > +    return v == ON_OFF_AUTO_OFF ? RAM_SYNC_ON_OFF_AUTO_OFF :
> > +           v == ON_OFF_AUTO_ON ? RAM_SYNC_ON_OFF_AUTO_ON :
> > +           RAM_SYNC_ON_OFF_AUTO_AUTO;
> > +}
> > +
> >  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
> >                                         IOMMUNotifierFlag flags,
> >                                         hwaddr start, hwaddr end,
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 08f8516..77e8810 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3928,7 +3928,7 @@ property must be set.  These objects are placed in the
> >  
> >  @table @option
> >  
> > -@item -object
> > memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align}
> > +@item -object
> > memory-backend-file,id=@var{id},size=@var{size},mem-path=@var{dir},share=@var{on|off},discard-data=@var{on|off},merge=@var{on|off},dump=@var{on|off},prealloc=@var{on|off},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave},align=@var{align},sync=@var{on|off|auto}
> >  
> >  Creates a memory file backend object, which can be used to back
> >  the guest RAM with huge pages.
> > @@ -4003,6 +4003,26 @@ If @option{pmem} is set to 'on', QEMU will take
> > necessary operations to
> >  guarantee the persistence of its own writes to @option{mem-path}
> >  (e.g. in vNVDIMM label emulation and live migration).
> >  
> > +The @option{sync} option specifies whether QEMU mmap(2) @option{mem-path}
> > +with MAP_SYNC flag, which can guarantee the guest write persistence to
> > +@option{mem-path} even on the host crash and power failures. MAP_SYNC
> > +requires supports from both the host kernel (since Linux kernel 4.15)
> > +and @option{mem-path} (only files supporting DAX). It can take one of
> > +following values:
> > +
> > +@table @option
> > +@item @var{on}
> > +try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
> > +@option{share}=@var{off}, QEMU will abort
> > +
> > +@item @var{off}
> > +never pass MAP_SYNC to mmap(2)
> > +
> > +@item @var{auto} (default)
> > +if MAP_SYNC is supported and @option{share}=@var{on}, work as if
> > +@option{sync}=@var{on}; otherwise, work as if @option{sync}=@var{off}
> > +@end table
> > +
> >  @item -object
> >  memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
> >  
> >  Creates a memory backend object, which can be used to back the guest RAM.
> > --
> > 2.7.4
> > 
> > 
> > 
