Received: from eggs.gnu.org ([2001:4830:134:3::10]:52390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKCE-0004qr-Jm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKCB-0003cf-FI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:44:38 -0500
Received: from smtp.citrix.com ([66.165.176.89]:7911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5992e33b8=anthony.perard@citrix.com>)
	id 1euKCB-0003bc-7S
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:44:35 -0500
Date: Fri, 9 Mar 2018 15:44:31 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180309154431.GJ1921@perard.uk.xensource.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-11-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1520535787-6223-11-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH 10/12] xen: Use newly added dmops for
 mapping VGA memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Mar 08, 2018 at 07:03:05PM +0000, Ian Jackson wrote:
> From: Ross Lagerwall <ross.lagerwall@citrix.com>
> 
> Xen unstable (to be in 4.11) has two new dmops, relocate_memory and
> pin_memory_cacheattr. Use these to set up the VGA memory, replacing the
> previous calls to libxc. This allows the VGA console to work properly
> when QEMU is running restricted (-xen-domid-restrict).
> 
> Wrapper functions are provided to allow QEMU to work with older versions
> of Xen.
> 
> Tweak the error handling while making this change:
> * Report pin_memory_cacheattr errors.
> * Report errors even when DEBUG_HVM is not set. This is useful for
> trying to understand why VGA is not working, since otherwise it just
> fails silently.
> * Fix the return values when an error occurs. The functions now
> consistently return -1 and set errno.
> 
> CC: Ian Jackson <ian.jackson@eu.citrix.com>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Reviewed-by: Ian Jackson <ian.jackson@eu.citrix.com>
> Signed-off-by: Ian Jackson <ian.jackson@eu.citrix.com>
> ---
> v6.1: Fix printf formats to match types in error_report messages
>       Fix spurious \n in error_report messages
>       Fix { } style issue
> v6: New patch in this version of the series
> ---
>  configure                   | 19 +++++++++++++++++
>  hw/i386/xen/xen-hvm.c       | 50 ++++++++++++++++++++++++---------------------
>  include/hw/xen/xen_common.h | 32 +++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index fb727bc..caa563b 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -347,7 +347,7 @@ static int xen_add_to_physmap(XenIOState *state,
>                                MemoryRegion *mr,
>                                hwaddr offset_within_region)
>  {
> -    unsigned long i = 0;
> +    unsigned long nr_pages;
>      int rc = 0;
>      XenPhysmap *physmap = NULL;
>      hwaddr pfn, start_gpfn;
> @@ -396,22 +396,26 @@ go_physmap:
>  
>      pfn = phys_offset >> TARGET_PAGE_BITS;
>      start_gpfn = start_addr >> TARGET_PAGE_BITS;
> -    for (i = 0; i < size >> TARGET_PAGE_BITS; i++) {
> -        unsigned long idx = pfn + i;
> -        xen_pfn_t gpfn = start_gpfn + i;
> -
> -        rc = xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE_gmfn, idx, gpfn);

This patch seems to remove the last users of
xen_xc_domain_add_to_physmap(). Can it be remove from xen_common.h?

With that:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks.

> -        if (rc) {
> -            DPRINTF("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
> -                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
> -            return -rc;
> -        }
> +    nr_pages = size >> TARGET_PAGE_BITS;
> +    rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
> +                                        start_gpfn);
> +    if (rc) {
> +        int saved_errno = errno;
> +
> +        error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
> +                     " to GFN %"HWADDR_PRIx" failed: %s",
> +                     nr_pages, pfn, start_gpfn, strerror(saved_errno));
> +        errno = saved_errno;
> +        return -1;
>      }
>  


-- 
Anthony PERARD
