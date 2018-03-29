Received: from eggs.gnu.org ([2001:4830:134:3::10]:35327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1RWI-0004f2-JV
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 02:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f1RWF-0005Ys-Ha
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 02:58:46 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:48677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f1RWF-0005YD-73
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 02:58:43 -0400
Received: from player729.ha.ovh.net (unknown [10.109.108.23])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5F0E514E20C
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 08:58:40 +0200 (CEST)
Date: Thu, 29 Mar 2018 08:37:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180329083748.15264f31@bahia.lan>
In-Reply-To: <20180329052537.32163-1-david@gibson.dropbear.id.au>
References: <20180329052537.32163-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13] Add
 host_memory_backend_pagesize() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 29 Mar 2018 16:25:37 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> There are a couple places (one generic, one target specific) where we need
> to get the host page size associated with a particular memory backend.  I
> have some upcoming code which will add another place which wants this.  So,
> for convenience, add a helper function to calculate this.
> 
> host_memory_backend_pagesize() returns the host pagesize for a given
> HostMemoryBackend object, or for the default backend (-mem-path) if passed
> NULL.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

The idea is good but there's a small issue. See below.

>  backends/hostmem.c       | 20 ++++++++++++++++++++
>  exec.c                   | 21 +++++----------------
>  include/sysemu/hostmem.h |  2 ++
>  target/ppc/kvm.c         | 10 +---------
>  4 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index f61093654e..b6a60cfc5d 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -18,6 +18,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/config-file.h"
>  #include "qom/object_interfaces.h"
> +#include "qemu/mmap-alloc.h"
>  
>  #ifdef CONFIG_NUMA
>  #include <numaif.h>
> @@ -262,6 +263,25 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend)
>      return backend->is_mapped;
>  }
>  
> +long host_memory_backend_pagesize(HostMemoryBackend *memdev)
> +{
> +    const char *path = NULL;
> +
> +#ifdef __linux__
> +    if (memdev) {
> +        path = object_property_get_str(OBJECT(memdev), "mem-path", NULL);

object_property_get_str() returns an allocated string. It should be freed
before returning.

> +    } else {
> +        path = mem_path;
> +    }
> +#endif
> +
> +    if (path) {
> +        return qemu_mempath_getpagesize(path);
> +    } else {
> +        return getpagesize();
> +    }
> +}
> +
>  static void
>  host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>  {
> diff --git a/exec.c b/exec.c
> index c09bd93df3..04856c2402 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1488,18 +1488,13 @@ void ram_block_dump(Monitor *mon)
>   */
>  static int find_max_supported_pagesize(Object *obj, void *opaque)
>  {
> -    char *mem_path;
>      long *hpsize_min = opaque;
>  
>      if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> -        mem_path = object_property_get_str(obj, "mem-path", NULL);
> -        if (mem_path) {
> -            long hpsize = qemu_mempath_getpagesize(mem_path);

... ie, this code currently leaks mem_path. This should be fixed in 2.12...

> -            if (hpsize < *hpsize_min) {
> -                *hpsize_min = hpsize;
> -            }
> -        } else {
> -            *hpsize_min = getpagesize();
> +        long hpsize = host_memory_backend_pagesize(MEMORY_BACKEND(obj));
> +
> +        if (hpsize < *hpsize_min) {
> +            *hpsize_min = hpsize;
>          }
>      }
>  
> @@ -1509,15 +1504,9 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
>  long qemu_getrampagesize(void)
>  {
>      long hpsize = LONG_MAX;
> -    long mainrampagesize;
> +    long mainrampagesize = host_memory_backend_pagesize(NULL);
>      Object *memdev_root;
>  
> -    if (mem_path) {
> -        mainrampagesize = qemu_mempath_getpagesize(mem_path);
> -    } else {
> -        mainrampagesize = getpagesize();
> -    }
> -
>      /* it's possible we have memory-backend objects with
>       * hugepage-backed RAM. these may get mapped into system
>       * address space via -numa parameters or memory hotplug
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 47bc9846ac..f474ef97f6 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -68,4 +68,6 @@ MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
>  
>  void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped);
>  bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
> +long host_memory_backend_pagesize(HostMemoryBackend *memdev);
> +
>  #endif
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b329cd8173..0adcf18c9f 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -493,15 +493,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      Object *mem_obj = object_resolve_path(obj_path, NULL);
> -    char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
> -    long pagesize;
> -
> -    if (mempath) {
> -        pagesize = qemu_mempath_getpagesize(mempath);
> -        g_free(mempath);

... but this code is ok. No leak :)

> -    } else {
> -        pagesize = getpagesize();
> -    }
> +    long pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(mem_obj));
>  
>      return pagesize >= max_cpu_page_size;
>  }
