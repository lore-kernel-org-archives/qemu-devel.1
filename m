Received: from eggs.gnu.org ([2001:4830:134:3::10]:43799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f45VX-0003se-2U
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f45VR-0002Tg-8l
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:04:55 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:59974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f45VR-0002Sm-1v
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 10:04:49 -0400
Received: from player693.ha.ovh.net (unknown [10.109.108.30])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9B2FFD2FEC
	for <qemu-devel@nongnu.org>; Thu,  5 Apr 2018 16:04:46 +0200 (CEST)
Date: Thu, 5 Apr 2018 16:04:39 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180405160439.436cb61d@bahia.lan>
In-Reply-To: <20180405022002.17809-3-david@gibson.dropbear.id.au>
References: <20180405022002.17809-1-david@gibson.dropbear.id.au>
	<20180405022002.17809-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 for-2.13 2/2] Add
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

On Thu,  5 Apr 2018 12:20:02 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> There are a couple places (one generic, one target specific) where we need
> to get the host page size associated with a particular memory backend.  I
> have some upcoming code which will add another place which wants this.  So,
> for convenience, add a helper function to calculate this.
> 
> host_memory_backend_pagesize() returns the host pagesize for a given
> HostMemoryBackend object.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  backends/hostmem.c       | 11 +++++++++++
>  exec.c                   |  5 ++---
>  include/sysemu/hostmem.h |  2 ++
>  target/ppc/kvm.c         |  6 +-----
>  4 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index f61093654e..ff2bb0489c 100644
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
> @@ -262,6 +263,16 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend)
>      return backend->is_mapped;
>  }
>  
> +size_t host_memory_backend_pagesize(HostMemoryBackend *memdev)
> +{
> +    Object *obj = OBJECT(memdev);
> +    char *path = object_property_get_str(obj, "mem-path", NULL);
> +    size_t pagesize = qemu_mempath_getpagesize(path);
> +
> +    g_free(path);
> +    return pagesize;
> +}
> +
>  static void
>  host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>  {
> diff --git a/exec.c b/exec.c
> index b38b004563..c7fcefa851 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1491,9 +1491,8 @@ static int find_max_supported_pagesize(Object *obj, void *opaque)
>      long *hpsize_min = opaque;
>  
>      if (object_dynamic_cast(obj, TYPE_MEMORY_BACKEND)) {
> -        char *mem_path = object_property_get_str(obj, "mem-path", NULL);
> -        long hpsize = qemu_mempath_getpagesize(mem_path);
> -        g_free(mem_path);
> +        long hpsize = host_memory_backend_pagesize(MEMORY_BACKEND(obj));
> +
>          if (hpsize < *hpsize_min) {
>              *hpsize_min = hpsize;
>          }
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index 47bc9846ac..bc36899bb8 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -68,4 +68,6 @@ MemoryRegion *host_memory_backend_get_memory(HostMemoryBackend *backend,
>  
>  void host_memory_backend_set_mapped(HostMemoryBackend *backend, bool mapped);
>  bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
> +size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
> +
>  #endif
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index f393eae127..1ab9cf3a8a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -493,11 +493,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>  bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>  {
>      Object *mem_obj = object_resolve_path(obj_path, NULL);
> -    char *mempath = object_property_get_str(mem_obj, "mem-path", NULL);
> -    long pagesize;
> -
> -    pagesize = qemu_mempath_getpagesize(mempath);
> -    g_free(mempath);
> +    long pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(mem_obj));
>  
>      return pagesize >= max_cpu_page_size;
>  }
