Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f98ko-0002Jv-FX
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f98kj-0000Nb-SI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:33:34 -0400
Date: Thu, 19 Apr 2018 14:33:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180419143318.4e24edaf@redhat.com>
In-Reply-To: <20180419072123.682-1-david@gibson.dropbear.id.au>
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13] Clear mem_path if we fall back to
 anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, clg@kaod.org, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On Thu, 19 Apr 2018 17:21:23 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> If the -mem-path option is set, we attempt to map the guest's RAM from a
> file in the given path; it's usually used to back guest RAM with hugepages.
> If we're unable to (e.g. not enough free hugepages) then we fall back to
> allocating normal anonymous pages.  This behaviour can be surprising, but a
> comment in allocate_system_memory_nonnuma() suggests it's legacy behaviour
> we can't change.
> 
> What really isn't ok, though, is that in this case we leave mem_path set.
> That means functions which attempt to determine the pagesize of main RAM
> can erroneously think it is hugepage based on the requested path, even
> though it's not.
> 
> This is particular bad for the pseries machine type.  KVM HV limitations
> mean the guest can't use pagesizes larger than the host page size used to
> back RAM.  That means that such a fallback, rather than merely giving
> poorer performance that expected will cause the guest to freeze up early in
> boot as it attempts to use large page mappings that can't work.
> 
> This patch addresses the problem by clearing the mem_path variable when we
> fall back to anonymous pages, meaning that subsequent attempts to
> determine the RAM page size will get an accurate result.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  numa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> Paolo et al, as with my earlier patches adding some extensions to the
> helpers for determining backing page sizes, if there are no objections
> can I get an ack to merge this via my ppc tree?
> 
> diff --git a/numa.c b/numa.c
> index 1116c90af9..78a869e598 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -469,6 +469,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>              /* Legacy behavior: if allocation failed, fall back to
>               * regular RAM allocation.
>               */
> +            mem_path = NULL;
>              memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
>          }
>  #else

mem_path is also used by kvm_s390_apply_cpu_model(),
and in ccw_init() memory is initialized before CPUs are
so if QEM was started with -mem-path, then before patch
created CPU won't have CMM enabled and print warning:
  
 "CMM will not be enabled because it is not compatible with hugetlbfs."

and after patch it might enable CMM if we clear mem_path.
So question is do we care about this?

PS:
CCing s390 folks.
