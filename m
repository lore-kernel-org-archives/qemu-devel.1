Received: from eggs.gnu.org ([2001:4830:134:3::10]:36003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f999P-0003F5-07
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f999L-0001YH-TH
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:58:59 -0400
Date: Thu, 19 Apr 2018 14:58:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180419145840.324602ff.cohuck@redhat.com>
In-Reply-To: <20180419143318.4e24edaf@redhat.com>
References: <20180419072123.682-1-david@gibson.dropbear.id.au>
	<20180419143318.4e24edaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-2.13] Clear mem_path if we
 fall back to anonymous RAM allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, David Hildenbrand <david@redhat.com>, groug@kaod.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, pbonzini@redhat.com

On Thu, 19 Apr 2018 14:33:18 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 19 Apr 2018 17:21:23 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > If the -mem-path option is set, we attempt to map the guest's RAM from a
> > file in the given path; it's usually used to back guest RAM with hugepages.
> > If we're unable to (e.g. not enough free hugepages) then we fall back to
> > allocating normal anonymous pages.  This behaviour can be surprising, but a
> > comment in allocate_system_memory_nonnuma() suggests it's legacy behaviour
> > we can't change.
> > 
> > What really isn't ok, though, is that in this case we leave mem_path set.
> > That means functions which attempt to determine the pagesize of main RAM
> > can erroneously think it is hugepage based on the requested path, even
> > though it's not.
> > 
> > This is particular bad for the pseries machine type.  KVM HV limitations
> > mean the guest can't use pagesizes larger than the host page size used to
> > back RAM.  That means that such a fallback, rather than merely giving
> > poorer performance that expected will cause the guest to freeze up early in
> > boot as it attempts to use large page mappings that can't work.
> > 
> > This patch addresses the problem by clearing the mem_path variable when we
> > fall back to anonymous pages, meaning that subsequent attempts to
> > determine the RAM page size will get an accurate result.
> > 
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  numa.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Paolo et al, as with my earlier patches adding some extensions to the
> > helpers for determining backing page sizes, if there are no objections
> > can I get an ack to merge this via my ppc tree?
> > 
> > diff --git a/numa.c b/numa.c
> > index 1116c90af9..78a869e598 100644
> > --- a/numa.c
> > +++ b/numa.c
> > @@ -469,6 +469,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
> >              /* Legacy behavior: if allocation failed, fall back to
> >               * regular RAM allocation.
> >               */
> > +            mem_path = NULL;
> >              memory_region_init_ram_nomigrate(mr, owner, name, ram_size, &error_fatal);
> >          }
> >  #else  
> 
> mem_path is also used by kvm_s390_apply_cpu_model(),
> and in ccw_init() memory is initialized before CPUs are
> so if QEM was started with -mem-path, then before patch
> created CPU won't have CMM enabled and print warning:
>   
>  "CMM will not be enabled because it is not compatible with hugetlbfs."
> 
> and after patch it might enable CMM if we clear mem_path.
> So question is do we care about this?

I don't quite remember the cmm semantics here -- Christian?
