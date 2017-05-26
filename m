Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE8ur-00004u-M9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE8up-0001Rs-H4
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:40:05 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dE8up-0001RI-2E
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:40:03 -0400
Received: by mail-lf0-x244.google.com with SMTP id 99so174097lfu.2
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 23:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20170526023213.18741-1-haozhong.zhang@intel.com>
	<20170526023213.18741-2-haozhong.zhang@intel.com>
In-Reply-To: <20170526023213.18741-2-haozhong.zhang@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 06:39:50 +0000
Message-ID: <CAJ+F1C+9o_vv4m7q47gPiaUjmQy7ag_J5ZKaHA9oagxZG2Q5Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RESEND PATCH 2/2] hostmem-file: add an attribute
 'align' to set its alignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, May 26, 2017 at 6:34 AM Haozhong Zhang <haozhong.zhang@intel.com>
wrote:

> file_ram_alloc() currently maps the backend file via mmap to a virtual
> address aligned to the value returned by qemu_fd_getpagesize(). When a
> DAX device (e.g. /dev/dax0.0) is used as the backend file, its kernel
> mmap implementation may require an alignment larger than what
> qemu_fd_get_pagesize() returns (e.g. 2MB vs. 4KB), and mmap may fail.
>

How is the accepted value queried? Any chance to configure it
automatically?



> This commit adds an attribute 'align' to hostmem-file, so that users
> can specify a proper alignment that satisfies the kernel requirement.
>
> If 'align' is not specified or is 0, the value returned by
> qemu_fd_get_pagesize() will be used as before.
>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Xiao Guangrong <guangrong.xiao@gmail.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
> Resend because the wrong maintainer email address was used.
> ---
>  backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  exec.c                  |  8 +++++++-
>  include/exec/memory.h   |  2 ++
>  memory.c                |  2 ++
>  numa.c                  |  2 +-
>  5 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index fc4ef46d11..d44fb41b55 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -33,6 +33,7 @@ struct HostMemoryBackendFile {
>
>      bool share;
>      char *mem_path;
> +    uint64_t align;
>  };
>
>  static void
> @@ -57,7 +58,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend,
> Error **errp)
>          path =3D object_get_canonical_path(OBJECT(backend));
>          memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
>                                   path,
> -                                 backend->size, fb->share,
> +                                 backend->size, fb->align, fb->share,
>                                   fb->mem_path, errp);
>          g_free(path);
>      }
> @@ -104,6 +105,40 @@ static void file_memory_backend_set_share(Object *o,
> bool value, Error **errp)
>  }
>
>  static void
> +file_memory_backend_get_align(Object *o, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
> +    uint64_t val =3D fb->align;
> +
> +    visit_type_size(v, name, &val, errp);
> +}
> +
> +static void
> +file_memory_backend_set_align(Object *o, Visitor *v, const char *name,
> +                              void *opaque, Error **errp)
> +{
> +    HostMemoryBackend *backend =3D MEMORY_BACKEND(o);
> +    HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
> +    Error *local_err =3D NULL;
> +    uint64_t val;
> +
> +    if (host_memory_backend_mr_inited(backend)) {
> +        error_setg(&local_err, "cannot change property value");
> +        goto out;
> +    }
> +
> +    visit_type_size(v, name, &val, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +    fb->align =3D val;
> +
> + out:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void
>  file_backend_class_init(ObjectClass *oc, void *data)
>  {
>      HostMemoryBackendClass *bc =3D MEMORY_BACKEND_CLASS(oc);
> @@ -116,6 +151,10 @@ file_backend_class_init(ObjectClass *oc, void *data)
>      object_class_property_add_str(oc, "mem-path",
>          get_mem_path, set_mem_path,
>          &error_abort);
> +    object_class_property_add(oc, "align", "int",
>

It would make sense to make it "size" instead of "int"


> +        file_memory_backend_get_align,
> +        file_memory_backend_set_align,
> +        NULL, NULL, &error_abort);
>  }
>
>  static void file_backend_instance_finalize(Object *o)
> diff --git a/exec.c b/exec.c
> index ff16f04f2b..5bb62e2e98 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1549,7 +1549,13 @@ static void *file_ram_alloc(RAMBlock *block,
>      }
>
>      block->page_size =3D qemu_fd_getpagesize(fd);
> -    block->mr->align =3D block->page_size;
> +    if (block->mr->align % block->page_size) {
> +        error_setg(errp, "alignment 0x%" PRIx64 " must be "
> +                   "multiple of page size 0x%" PRIx64,
> +                   block->mr->align, block->page_size);
> +        goto error;
> +    }
> +    block->mr->align =3D MAX(block->page_size, block->mr->align);
>  #if defined(__s390x__)
>      if (kvm_enabled()) {
>          block->mr->align =3D MAX(block->mr->align, QEMU_VMALLOC_ALIGN);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 99e0f54d86..05d3d0da3b 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -441,6 +441,7 @@ void memory_region_init_resizeable_ram(MemoryRegion
> *mr,
>   * @name: Region name, becomes part of RAMBlock name used in migration
> stream
>   *        must be unique within any device
>   * @size: size of the region.
> + * @align: alignment of the region.
>   * @share: %true if memory must be mmaped with the MAP_SHARED flag
>   * @path: the path in which to allocate the RAM.
>   * @errp: pointer to Error*, to store an error if it happens.
> @@ -449,6 +450,7 @@ void memory_region_init_ram_from_file(MemoryRegion *m=
r,
>                                        struct Object *owner,
>                                        const char *name,
>                                        uint64_t size,
> +                                      uint64_t align,
>                                        bool share,
>                                        const char *path,
>                                        Error **errp);
> diff --git a/memory.c b/memory.c
> index b727f5ec0e..5165b9aa08 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1386,6 +1386,7 @@ void memory_region_init_ram_from_file(MemoryRegion
> *mr,
>                                        struct Object *owner,
>                                        const char *name,
>                                        uint64_t size,
> +                                      uint64_t align,
>                                        bool share,
>                                        const char *path,
>                                        Error **errp)
> @@ -1394,6 +1395,7 @@ void memory_region_init_ram_from_file(MemoryRegion
> *mr,
>      mr->ram =3D true;
>      mr->terminates =3D true;
>      mr->destructor =3D memory_region_destructor_ram;
> +    mr->align =3D align;
>      mr->ram_block =3D qemu_ram_alloc_from_file(size, mr, share, path, er=
rp);
>      mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
>  }
> diff --git a/numa.c b/numa.c
> index ca731455e9..39a25aa1d2 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -541,7 +541,7 @@ static void
> allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>      if (mem_path) {
>  #ifdef __linux__
>          Error *err =3D NULL;
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, fals=
e,
> +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
> false,
>                                           mem_path, &err);
>          if (err) {
>              error_report_err(err);
> --
> 2.11.0
>
>
otherwise, looks good to me
--=20
Marc-Andr=C3=A9 Lureau
