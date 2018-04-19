Received: from eggs.gnu.org ([2001:4830:134:3::10]:50589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9CSS-0001JA-LG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f9CSN-00086N-JQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:30:52 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:59093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f9CSN-00084w-EM
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:30:47 -0400
Received: from player791.ha.ovh.net (unknown [10.109.120.69])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9C1871436B
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 18:30:45 +0200 (CEST)
Date: Thu, 19 Apr 2018 18:30:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180419183037.21826f8a@bahia.lan>
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
Cc: pbonzini@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

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

s/that expected/than expected/

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
