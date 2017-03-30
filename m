Received: from eggs.gnu.org ([2001:4830:134:3::10]:45519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdIf-0000t8-Cl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdIa-0000wa-Dv
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:51:53 -0400
Received: from smtp.citrix.com ([66.165.176.89]:50012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdIa-0000vg-62
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:51:48 -0400
Date: Thu, 30 Mar 2017 17:51:45 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170330165145.GC1864@perard.uk.xensource.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-4-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1489750157-17401-4-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] xen-pt: bind/unbind interrupt
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
Cc: xen-devel@lists.xensource.com, qemu-devel@nongnu.org, chao.gao@intel.com, kevin.tian@intel.com, sstabellini@kernel.org, mst@redhat.com

On Fri, Mar 17, 2017 at 07:29:16PM +0800, Lan Tianyu wrote:
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
>  hw/xen/xen_pt_msi.c           | 36 ++++++++++++++++++++++++++++--------
>  include/hw/i386/apic-msidef.h |  1 +
>  2 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index 62add06..8b0d7fc 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -161,6 +161,7 @@ static int msi_msix_update(XenPCIPassthroughState *s,
>      uint8_t gvec = msi_vector(data);
>      uint32_t gflags = msi_gflags(data, addr);
>      int rc = 0;
> +    bool ir = !!(addr & MSI_ADDR_IM_MASK);
>      uint64_t table_addr = 0;
>  
>      XEN_PT_LOG(d, "Updating MSI%s with pirq %d gvec %#x gflags %#x"
> @@ -171,8 +172,14 @@ static int msi_msix_update(XenPCIPassthroughState *s,
>          table_addr = s->msix->mmio_base_addr;
>      }
>  
> -    rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
> +    if (ir) {

You could maybe use add&MSI_ADDR_IM_MASK instead of going through a
variable.

> +        rc = xc_domain_update_msi_irq_remapping(xen_xc, xen_domid, pirq,
> +                                    d->devfn, data, addr, table_addr);

Do you also want to update the XEN_PT_LOG above? Since it does not
always reflect the update_msi call anymore.

> +    }
> +    else {
> +        rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
>                                    pirq, gflags, table_addr);
> +    }
>  
>      if (rc) {
>          XEN_PT_ERR(d, "Updating of MSI%s failed. (err: %d)\n",
> @@ -204,13 +211,26 @@ static int msi_msix_disable(XenPCIPassthroughState *s,
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
> +        if ( addr & MSI_ADDR_IM_MASK ) {
> +            XEN_PT_LOG(d, "Unbinding of MSI%s . ( pirq: %d, data: %x, addr: %lx)\n",

For addr, it should be PRIx64 instead of %lx.

> +                       is_msix ? "-X" : "", pirq, data, addr);
> +            rc = xc_domain_unbind_msi_irq_remapping(xen_xc, xen_domid, pirq,
> +                                                    d->devfn, data, addr);
> +            if (rc) {
> +                XEN_PT_ERR(d, "Unbinding of MSI%s . (error: %d, pirq: %d, data: %x, addr: %lx)\n",
> +                           is_msix ? "-X" : "", rc, pirq, data, addr);
> +                return rc;
> +            }
> +
> +        } else {
> +            XEN_PT_LOG(d, "Unbind MSI%s with pirq %d, gvec %#x\n",
> +                       is_msix ? "-X" : "", pirq, gvec);
> +            rc = xc_domain_unbind_msi_irq(xen_xc, xen_domid, gvec, pirq, gflags);
> +            if (rc) {
> +                XEN_PT_ERR(d, "Unbinding of MSI%s failed. (err: %d, pirq: %d, gvec: %#x)\n",
> +                           is_msix ? "-X" : "", errno, pirq, gvec);
> +                return rc;
> +            }
>          }
>      }
>  
> diff --git a/include/hw/i386/apic-msidef.h b/include/hw/i386/apic-msidef.h
> index 8b4d4cc..08b584f 100644
> --- a/include/hw/i386/apic-msidef.h
> +++ b/include/hw/i386/apic-msidef.h
> @@ -27,5 +27,6 @@
>  #define MSI_ADDR_DEST_ID_SHIFT          12
>  #define MSI_ADDR_DEST_IDX_SHIFT         4
>  #define  MSI_ADDR_DEST_ID_MASK          0x00ffff0

Could you add a 0 to dest_id here? So their will be 8 digit and it those
not look weird when compared to the next define.

> +#define  MSI_ADDR_IM_MASK               0x00000010

Is the definition of MSI_ADDR_IM_MASK available somewhere? In the Intel
SDM I've only found this bit to be reserved.

Thanks,

-- 
Anthony PERARD
