Received: from eggs.gnu.org ([2001:4830:134:3::10]:47800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=305c22658=anthony.perard@citrix.com>)
	id 1dBftc-0002GB-Ob
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=305c22658=anthony.perard@citrix.com>)
	id 1dBftV-0007hT-66
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:16:36 -0400
Received: from smtp.citrix.com ([66.165.176.89]:7499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=305c22658=anthony.perard@citrix.com>)
	id 1dBftU-0007YO-8i
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:16:28 -0400
Date: Fri, 19 May 2017 12:16:22 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170519111622.GA3260@perard.uk.xensource.com>
References: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
	<1495085580-10631-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1495085580-10631-2-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH V2 1/2] xen-pt: bind/unbind interrupt
 remapping format MSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com

On Thu, May 18, 2017 at 01:32:59AM -0400, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> If a vIOMMU is exposed to guest, guest will configure the msi to remapping
> format. The original code isn't suitable to the new format. A new pair
> bind/unbind interfaces are added for this usage. This patch recognizes
> this case and use new interfaces to bind/unbind msi.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/xen/xen_pt_msi.c           | 50 ++++++++++++++++++++++++++++++++-----------
>  include/hw/i386/apic-msidef.h |  3 ++-
>  2 files changed, 39 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index 62add06..5fab95e 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -163,16 +163,24 @@ static int msi_msix_update(XenPCIPassthroughState *s,
>      int rc = 0;
>      uint64_t table_addr = 0;
>  
> -    XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
> -               " (entry: %#x)\n",
> -               is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
> -
>      if (is_msix) {
>          table_addr = s->msix->mmio_base_addr;
>      }
>  
> -    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
> -                                  pirq, gflags, table_addr);
> +    if (addr & MSI_ADDR_IF_MASK) {
> +        XEN_PT_LOG(d, "Updating MSI%s with addr %#" PRIx64 "data %#x\n",

With a space before "data", I think it will be easier to read the debug
log.

> +                   is_msix ? "-X": "", addr, data);
> +        rc = xc_domain_update_msi_irq_remapping(xen_xc, xen_domid, pirq,
> +                                             d->devfn, data, addr, table_addr);

We are going to need a stub function for
xc_domain_update_msi_irq_remapping(), when Xen does not have support for
it, so QEMU can compile in any case. (same for unbind version.)

I think the stub can just return -ENOSYS. That going to require changes
in configure to detect newer xen version and the stub can be in
xen_common.h.

> +    }
> +    else {
> +        XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
> +                   " (entry: %#x)\n",
> +                   is_msix ? "-X" : "", pirq, gvec, gflags, msix_entry);
> +
> +        rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
> +                                      pirq, gflags, table_addr);
> +    }
>  
>      if (rc) {
>          XEN_PT_ERR(d, "Updating of MSI%s failed. (err: %d)\n",
> @@ -204,13 +212,29 @@ static int msi_msix_disable(XenPCIPassthroughState *s,
>      }
>  
>      if (is_binded) {
> -        XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
> -                   is_msix ? "-X" : "", pirq, gvec);
> -        rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
> -        if (rc) {
> -            XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
> -                       is_msix ? "-X" : "", errno, pirq, gvec);
> -            return rc;
> +        if ( addr & MSI_ADDR_IF_MASK ) {
> +            XEN_PT_LOG(d, "Unbinding of MSI%s . ( pirq: %d, data: %x, "
> +                       "addr: %#" PRIx64 ")\n",
> +                       is_msix ? "-X" : "", pirq, data, addr);
> +            rc = xc_domain_unbind_msi_irq_remapping(xen_xc, xen_domid, pirq,
> +                                                    d->devfn, data, addr);
> +            if (rc) {
> +                XEN_PT_ERR(d, "Unbinding of MSI%s . (error: %d, pirq: %d, "
> +                           "data: %x, addr: %#" PRIx64 ")\n",
> +                           is_msix ? "-X" : "", rc, pirq, data, addr);
> +                return rc;
> +            }
> +
> +        } else {
> +            XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
> +                       is_msix ? "-X" : "", pirq, gvec);
> +            rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
> +            if (rc) {
> +                XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, "
> +                           "gvec: %#x)\n",
> +                           is_msix ? "-X" : "", errno, pirq, gvec);
> +                return rc;
> +            }
>          }
>      }
>  
> diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
> index 8b4d4cc..2c450f9 100644
> --- a/include/hw/i386/apic-msidef.h
> +++ b/include/hw/i386/apic-msidef.h
> @@ -26,6 +26,7 @@
>  
>  #define MSI_ADDR_DEST_ID_SHIFT          12
>  #define MSI_ADDR_DEST_IDX_SHIFT         4
> -#define  MSI_ADDR_DEST_ID_MASK          0x00ffff0
> +#define  MSI_ADDR_DEST_ID_MASK          0x000fff00

The value of MSI_ADDR_DEST_ID_MASK is changed here. I think the patch
should be:
+#define  MSI_ADDR_DEST_ID_MASK          0x000ffff0


> +#define  MSI_ADDR_IF_MASK               0x00000010
>  
>  #endif /* HW_APIC_MSIDEF_H */

Thanks,

-- 
Anthony PERARD
