Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj6tP-0003bw-9Z
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj6tL-0004h8-Um
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:14:19 -0500
Received: from smtp.citrix.com ([66.165.176.89]:12661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2261f5a76=anthony.perard@citrix.com>)
	id 1cj6tL-0004gL-Kw
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:14:15 -0500
Date: Wed, 1 Mar 2017 16:13:41 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170301161340.GD1760@perard.uk.xensource.com>
References: <1487861635-17560-1-git-send-email-paul.durrant@citrix.com>
	<1487861635-17560-4-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1487861635-17560-4-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] xen: create wrappers for all other
 uses of xc_hvm_XXX() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Feb 23, 2017 at 02:53:53PM +0000, Paul Durrant wrote:
> This patch creates inline wrapper functions in xen_common.h for all open
> coded calls to xc_hvm_XXX() functions outside of xen_common.h so that use
> of xen_xc can be made implicit. This again is in preparation for the move
> to using libxendevicemodel.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 1e08b98..31cf25f 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -26,6 +26,50 @@ extern xc_interface *xen_xc;
>   * We don't support Xen prior to 4.2.0.
>   */
>  
> +static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t type,
> +                                   uint64_t first_pfn, uint32_t nr)
> +{

I don't know if it matters from where the functions are called, but
here, xc_hvm_set_mem_type takes a "uint64_t nr" (and not uint32_t).

> +    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
> +}
> +
> +static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segment,
> +                                         uint8_t bus, uint8_t device,
> +                                         uint8_t intx, unsigned int level)
> +{
> +    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus, device,
> +                                     intx, level);
> +}
> +
> +static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
> +                                         uint8_t irq)
> +{
> +    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
> +}
> +
> +static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
> +                                 uint32_t msi_data)
> +{
> +    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
> +}
> +
> +static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
> +                                        unsigned int level)
> +{
> +    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
> +}
> +
> +static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_pfn,
> +                                       uint32_t nr, unsigned long *bitmap)
> +{

Same here.

> +    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitmap);
> +}
> +
> +static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
> +                                      uint32_t nr)
> +{

And here.

> +    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
> +}
> +
>  /* Xen 4.2 through 4.6 */
>  #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 471
>  

The rest looks good.

-- 
Anthony PERARD
