Received: from eggs.gnu.org ([2001:4830:134:3::10]:37618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1duq2L-0006Fy-Kp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1duq2G-0007W1-J1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1duq2G-0007Uu-Az
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:12:12 -0400
Date: Wed, 20 Sep 2017 18:12:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.10.1709201759580.2968@sstabellini-ThinkPad-X260>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<59A9A6260200007800176A6A@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] xen: use vMSI related #define-s from
 public interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>

On Fri, 1 Sep 2017, Jan Beulich wrote:
> Xen and qemu having identical #define-s (with different names) is a
> strong hint that these should have been part of the public interface
> from the very start. Use them if they're available, falling back to
> privately defined values only when using older headers.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Hi Jan,

Thanks for the patch and sorry for the delay in reviewing it.


> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -18,6 +18,11 @@
>  
>  #define XEN_PT_AUTO_ASSIGN -1
>  
> +#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
> +#if XEN_DOMCTL_INTERFACE_VERSION >= 0x0000000e
> +#error vMSI defines missing from domctl.h
> +#endif

All the version compatibility stuff goes to
include/hw/xen/xen_common.h. Please move it there.

We usually assume that the Xen version we are building against is
"sane", so we don't do #error's typically.


> +
>  /* shift count for gflags */
>  #define XEN_PT_GFLAGS_SHIFT_DEST_ID        0
>  #define XEN_PT_GFLAGS_SHIFT_RH             8
> @@ -26,6 +31,16 @@
>  #define XEN_PT_GFLAGSSHIFT_TRG_MODE       15
>  #define XEN_PT_GFLAGSSHIFT_UNMASKED       16
>  
> +#define XEN_DOMCTL_VMSI_X86_DEST_ID_MASK (0xffU << XEN_PT_GFLAGS_SHIFT_DEST_ID)
> +#define XEN_DOMCTL_VMSI_X86_RH_MASK      (1U << XEN_PT_GFLAGS_SHIFT_RH)
> +#define XEN_DOMCTL_VMSI_X86_DM_MASK      (1U << XEN_PT_GFLAGS_SHIFT_DM)
> +#define XEN_DOMCTL_VMSI_X86_DELIV_MASK   (7U << XEN_PT_GFLAGSSHIFT_DELIV_MODE)
> +#define XEN_DOMCTL_VMSI_X86_TRIG_MASK    (1U << XEN_PT_GFLAGSSHIFT_TRG_MODE)
> +#define XEN_DOMCTL_VMSI_X86_UNMASKED     (1U << XEN_PT_GFLAGSSHIFT_UNMASKED)
> +#endif
> +
> +#define MASK_INSR(v, m) (((v) * ((m) & -(m))) & (m))

MASK_INSR can stay in this file.


>  #define latch(fld) latch[PCI_MSIX_ENTRY_##fld / sizeof(uint32_t)]
>  
>  /*
> @@ -49,21 +64,18 @@ static inline uint32_t msi_ext_dest_id(u
>  
>  static uint32_t msi_gflags(uint32_t data, uint64_t addr)
>  {
> -    uint32_t result = 0;
> -    int rh, dm, dest_id, deliv_mode, trig_mode;
> +    int rh, dm, deliv_mode, trig_mode;
>  
>      rh = (addr >> MSI_ADDR_REDIRECTION_SHIFT) & 0x1;
>      dm = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
> -    dest_id = msi_dest_id(addr);
>      deliv_mode = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
>      trig_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
>  
> -    result = dest_id | (rh << XEN_PT_GFLAGS_SHIFT_RH)
> -        | (dm << XEN_PT_GFLAGS_SHIFT_DM)
> -        | (deliv_mode << XEN_PT_GFLAGSSHIFT_DELIV_MODE)
> -        | (trig_mode << XEN_PT_GFLAGSSHIFT_TRG_MODE);
> -
> -    return result;
> +    return MASK_INSR(msi_dest_id(addr), XEN_DOMCTL_VMSI_X86_DEST_ID_MASK) |
> +           MASK_INSR(rh, XEN_DOMCTL_VMSI_X86_RH_MASK) |
> +           MASK_INSR(dm, XEN_DOMCTL_VMSI_X86_DM_MASK) |
> +           MASK_INSR(deliv_mode, XEN_DOMCTL_VMSI_X86_DELIV_MASK) |
> +           MASK_INSR(trig_mode, XEN_DOMCTL_VMSI_X86_TRIG_MASK);
>  }
>  
>  static inline uint64_t msi_addr64(XenPTMSI *msi)
> @@ -173,7 +185,7 @@ static int msi_msix_update(XenPCIPassthr
>          table_addr = s->msix->mmio_base_addr;
>      }
>  
> -    gflags |= masked ? 0 : (1u << XEN_PT_GFLAGSSHIFT_UNMASKED);
> +    gflags |= masked ? 0 : XEN_DOMCTL_VMSI_X86_UNMASKED;
>  
>      rc = xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
>                                    pirq, gflags, table_addr);
