Received: from eggs.gnu.org ([2001:4830:134:3::10]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJqJl-0005Ft-Al
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 19:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eJqJi-0001HC-2i
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 19:33:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:48851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eJqJh-0001Gu-K5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 19:33:34 -0500
Date: Wed, 29 Nov 2017 08:33:29 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20171129003329.g562dwn233rftyty@hz-desktop>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
	<20171127043517.22441-2-haozhong.zhang@intel.com>
	<20171128010713.GC3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128010713.GC3037@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hostmem-file: add "align" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On 11/27/17 23:07 -0200, Eduardo Habkost wrote:
> On Mon, Nov 27, 2017 at 12:35:15PM +0800, Haozhong Zhang wrote:
> > When mmap(2) the backend files, QEMU uses the host page size
> > (getpagesize(2)) by default as the alignment of mapping address.
> > However, some backends may require alignments different than the page
> > size. For example, mmap a device DAX (e.g., /dev/dax0.0) on Linux
> > kernel 4.13 to an address, which is 4K-aligned but not 2M-aligned,
> > fails with a kernel message like
> > 
> > [617494.969768] dax dax0.0: qemu-system-x86: dax_mmap: fail, unaligned vma (0x7fa37c579000 - 0x7fa43c579000, 0x1fffff)
> > 
> > Because there is no common approach to get such alignment requirement,
> > we add the 'align' option to 'memory-backend-file', so that users or
> > management utils, which have enough knowledge about the backend, can
> > specify a proper alignment via this option.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> 
> The new option needs to be documented on qemu-options.hx.

will add in the next version.

Thanks,
Haozhong

> 
> Except for that, the patch looks good to me.
> 
> 
> > ---
> >  backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  docs/nvdimm.txt         | 16 ++++++++++++++++
> >  exec.c                  |  8 +++++++-
> >  include/exec/memory.h   |  3 +++
> >  memory.c                |  2 ++
> >  numa.c                  |  2 +-
> >  6 files changed, 69 insertions(+), 3 deletions(-)
> > 
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index e44c319915..e319ec1ad8 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -34,6 +34,7 @@ struct HostMemoryBackendFile {
> >      bool share;
> >      bool discard_data;
> >      char *mem_path;
> > +    uint64_t align;
> >  };
> >  
> >  static void
> > @@ -58,7 +59,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
> >          path = object_get_canonical_path(OBJECT(backend));
> >          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
> >                                   path,
> > -                                 backend->size, fb->share,
> > +                                 backend->size, fb->align, fb->share,
> >                                   fb->mem_path, errp);
> >          g_free(path);
> >      }
> > @@ -115,6 +116,40 @@ static void file_memory_backend_set_discard_data(Object *o, bool value,
> >      MEMORY_BACKEND_FILE(o)->discard_data = value;
> >  }
> >  
> > +static void file_memory_backend_get_align(Object *o, Visitor *v,
> > +                                          const char *name, void *opaque,
> > +                                          Error **errp)
> > +{
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> > +    uint64_t val = fb->align;
> > +
> > +    visit_type_size(v, name, &val, errp);
> > +}
> > +
> > +static void file_memory_backend_set_align(Object *o, Visitor *v,
> > +                                          const char *name, void *opaque,
> > +                                          Error **errp)
> > +{
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
> > +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
> > +    Error *local_err = NULL;
> > +    uint64_t val;
> > +
> > +    if (host_memory_backend_mr_inited(backend)) {
> > +        error_setg(&local_err, "cannot change property value");
> > +        goto out;
> > +    }
> > +
> > +    visit_type_size(v, name, &val, &local_err);
> > +    if (local_err) {
> > +        goto out;
> > +    }
> > +    fb->align = val;
> > +
> > + out:
> > +    error_propagate(errp, local_err);
> > +}
> > +
> >  static void file_backend_unparent(Object *obj)
> >  {
> >      HostMemoryBackend *backend = MEMORY_BACKEND(obj);
> > @@ -145,6 +180,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
> >      object_class_property_add_str(oc, "mem-path",
> >          get_mem_path, set_mem_path,
> >          &error_abort);
> > +    object_class_property_add(oc, "align", "int",
> > +        file_memory_backend_get_align,
> > +        file_memory_backend_set_align,
> > +        NULL, NULL, &error_abort);
> >  }
> >  
> >  static void file_backend_instance_finalize(Object *o)
> > diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
> > index 2d9f8c0e8c..21249dd062 100644
> > --- a/docs/nvdimm.txt
> > +++ b/docs/nvdimm.txt
> > @@ -122,3 +122,19 @@ Note:
> >       M >= size of RAM devices +
> >            size of statically plugged vNVDIMM devices +
> >            size of hotplugged vNVDIMM devices
> > +
> > +Alignment
> > +---------
> > +
> > +QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
> > +address to the page size (getpagesize(2)) by default. However, some
> > +types of backends may require an alignment different than the page
> > +size. In that case, QEMU v2.12.0 and later provide 'align' option to
> > +memory-backend-file to allow users to specify the proper alignment.
> > +
> > +For example, device dax require the 2 MB alignment, so we can use
> > +following QEMU command line options to use it (/dev/dax0.0) as the
> > +backend of vNVDIMM:
> > +
> > + -object memory-backend-file,id=mem1,share=on,mem-path=/dev/dax0.0,size=4G,align=2M
> > + -device nvdimm,id=nvdimm1,memdev=mem1
> > diff --git a/exec.c b/exec.c
> > index 03238a3449..90440efecd 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -1600,7 +1600,13 @@ static void *file_ram_alloc(RAMBlock *block,
> >      void *area;
> >  
> >      block->page_size = qemu_fd_getpagesize(fd);
> > -    block->mr->align = block->page_size;
> > +    if (block->mr->align % block->page_size) {
> > +        error_setg(errp, "aligment 0x%" PRIx64
> > +                   " must be multiples of page size 0x%" PRIx64,
> > +                   block->mr->align, block->page_size);
> > +        return NULL;
> > +    }
> > +    block->mr->align = MAX(block->page_size, block->mr->align);
> >  #if defined(__s390x__)
> >      if (kvm_enabled()) {
> >          block->mr->align = MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index 5ed4042f87..a1be8b06d3 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -465,6 +465,8 @@ void memory_region_init_resizeable_ram(MemoryRegion *mr,
> >   * @name: Region name, becomes part of RAMBlock name used in migration stream
> >   *        must be unique within any device
> >   * @size: size of the region.
> > + * @align: alignment of the region base address; if 0, the default alignment
> > + *         (getpagesize()) will be used.
> >   * @share: %true if memory must be mmaped with the MAP_SHARED flag
> >   * @path: the path in which to allocate the RAM.
> >   * @errp: pointer to Error*, to store an error if it happens.
> > @@ -476,6 +478,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
> >                                        struct Object *owner,
> >                                        const char *name,
> >                                        uint64_t size,
> > +                                      uint64_t align,
> >                                        bool share,
> >                                        const char *path,
> >                                        Error **errp);
> > diff --git a/memory.c b/memory.c
> > index e26e5a3b1d..2c80656e39 100644
> > --- a/memory.c
> > +++ b/memory.c
> > @@ -1570,6 +1570,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
> >                                        struct Object *owner,
> >                                        const char *name,
> >                                        uint64_t size,
> > +                                      uint64_t align,
> >                                        bool share,
> >                                        const char *path,
> >                                        Error **errp)
> > @@ -1578,6 +1579,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
> >      mr->ram = true;
> >      mr->terminates = true;
> >      mr->destructor = memory_region_destructor_ram;
> > +    mr->align = align;
> >      mr->ram_block = qemu_ram_alloc_from_file(size, mr, share, path, errp);
> >      mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
> >  }
> > diff --git a/numa.c b/numa.c
> > index 7151b24d1c..b0fe22a60c 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -551,7 +551,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
> >      if (mem_path) {
> >  #ifdef __linux__
> >          Error *err = NULL;
> > -        memory_region_init_ram_from_file(mr, owner, name, ram_size, false,
> > +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, false,
> >                                           mem_path, &err);
> >          if (err) {
> >              error_report_err(err);
> > -- 
> > 2.14.1
> > 
> 
> -- 
> Eduardo
