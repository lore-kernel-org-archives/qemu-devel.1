Received: from eggs.gnu.org ([2001:4830:134:3::10]:33690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BaP-00060B-98
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f3BaM-0001GX-5e
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:22:13 -0400
Date: Mon, 2 Apr 2018 23:22:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180403022206.GK5046@localhost.localdomain>
References: <20180329052537.32163-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329052537.32163-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH for-2.13] Add
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
Cc: imammedo@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Thu, Mar 29, 2018 at 04:25:37PM +1100, David Gibson wrote:
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

qemu_mempath_getpagesize() returns size_t.  Why are you using
long here?

> +{
> +    const char *path = NULL;
> +
> +#ifdef __linux__
> +    if (memdev) {
> +        path = object_property_get_str(OBJECT(memdev), "mem-path", NULL);
> +    } else {
> +        path = mem_path;
> +    }
> +#endif
> +
> +    if (path) {
> +        return qemu_mempath_getpagesize(path);
> +    } else {
> +        return getpagesize();

Isn't it simpler to make qemu_mempath_getpagesize() handle
path==NULL?


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
> -            if (hpsize < *hpsize_min) {
> -                *hpsize_min = hpsize;
> -            }
> -        } else {
> -            *hpsize_min = getpagesize();
> +        long hpsize = host_memory_backend_pagesize(MEMORY_BACKEND(obj));

So in this caller, `backend` is always non-NULL...

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

...on this caller `backend` is always NULL...


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
[...]
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
> -    } else {
> -        pagesize = getpagesize();
> -    }
> +    long pagesize = host_memory_backend_pagesize(MEMORY_BACKEND(mem_obj));
>  

...and here `backend` is always non-NULL.

If there's no caller that relies on both code paths, why overload
a single function for two different operations?

I would simply make qemu_mempath_getpagesize() work if path is
NULL, use qemu_mempath_getpagesize(mem_path) at
qemu_getrampagesize(), and make host_memory_backend_pagesize()
assume require a non-NULL `memdev`.



> +long host_memory_backend_pagesize(HostMemoryBackend *memdev)

Why is the code duplicated in target/ppc/kvm.c?


> +{
> +    const char *path = NULL;
> +
> +#ifdef __linux__
> +    if (memdev) {
> +        path = object_property_get_str(OBJECT(memdev), "mem-path", NULL);
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
>      return pagesize >= max_cpu_page_size;
>  }
> -- 
> 2.14.3
> 

-- 
Eduardo
