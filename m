Received: from eggs.gnu.org ([209.51.188.92]:40675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghgjN-0003al-5K
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ghgjM-0008Hx-93
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:15:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ghgjM-0008HV-0h
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 15:15:08 -0500
Date: Thu, 10 Jan 2019 20:14:57 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190110201456.GL2589@work-vm>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
	<20190110120120.9943-3-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110120120.9943-3-yury-kotov@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH 2/4] exec: add RAM_EXTERNAL flag to mark
 non-QEMU allocated blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, wrfsh@yandex-team.ru

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> This flag allows to determine whether RAM block is available from the outside.
> E.g. when we use -object memory-backend-file or -mem-path options we have
> a RAM block which is mapped to shared file.
> 
> We need this flag in the following commits.

As I said in the cover letter, why not just use shared?

Dave

> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  backends/hostmem-file.c | 3 ++-
>  exec.c                  | 2 +-
>  include/exec/memory.h   | 3 +++
>  numa.c                  | 4 ++--
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index 7a34e25c43..37fe28f2ac 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -63,7 +63,8 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>                                       name,
>                                       backend->size, fb->align,
>                                       (backend->share ? RAM_SHARED : 0) |
> -                                     (fb->is_pmem ? RAM_PMEM : 0),
> +                                     (fb->is_pmem ? RAM_PMEM : 0) |
> +                                     RAM_EXTERNAL,
>                                       fb->mem_path, errp);
>      g_free(name);
>  #endif
> diff --git a/exec.c b/exec.c
> index 6e875f0640..ef2f29d7cb 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2241,7 +2241,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>      int64_t file_size;
>  
>      /* Just support these ram flags by now. */
> -    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
> +    assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_EXTERNAL)) == 0);
>  
>      if (xen_enabled()) {
>          error_setg(errp, "-mem-path not supported with Xen");
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ffd23ed8d8..3a9cb34f1e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -126,6 +126,9 @@ typedef struct IOMMUNotifier IOMMUNotifier;
>  /* RAM is a persistent kind memory */
>  #define RAM_PMEM (1 << 5)
>  
> +/* RAM is from external source (e.g. from file) */
> +#define RAM_EXTERNAL (1 << 6)
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,
> diff --git a/numa.c b/numa.c
> index 50ec016013..653c5a08de 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -482,8 +482,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>      if (mem_path) {
>  #ifdef __linux__
>          Error *err = NULL;
> -        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
> -                                         mem_path, &err);
> +        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
> +                                         RAM_EXTERNAL, mem_path, &err);
>          if (err) {
>              error_report_err(err);
>              if (mem_prealloc) {
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
