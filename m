Received: from eggs.gnu.org ([2001:4830:134:3::10]:59337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdt9-0001ch-Hj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdt6-0001GV-A4
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:29:35 -0400
Received: from smtp.citrix.com ([66.165.176.89]:5998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctdt6-0001GL-2D
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:29:32 -0400
Date: Thu, 30 Mar 2017 18:29:29 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170330172929.GD1864@perard.uk.xensource.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-5-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1489750157-17401-5-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] msi: taking interrupt format into
 consideration during judging a pirq is binded with a event channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xensource.com, chao.gao@intel.com, kevin.tian@intel.com, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org

On Fri, Mar 17, 2017 at 07:29:17PM +0800, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> Subject: msi: taking interrupt format into consideration during
> judging a pirq is binded with a event channel

This is quite a long title, I think we can make it shorter. Maybe "msi:
Handle MSI remapping format.

> 
> As remapping format interrupt has been introduced, the vector in msi remapping
> format can also be 0, same as a interrupt is binded with a event channel.
> So we can't just use whether vector is 0 or not to judge a msi is binded
> to a event channel or not.
> 
> This patch takes the msi interrupt format into consideration.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/pci/msi.c         | 5 +++--
>  hw/pci/msix.c        | 4 +++-
>  hw/xen/xen_pt_msi.c  | 2 +-
>  include/hw/xen/xen.h | 2 +-
>  xen-hvm-stub.c       | 2 +-
>  xen-hvm.c            | 7 ++++++-
>  6 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci/msi.c b/hw/pci/msi.c
> index a87b227..8d1ac9e 100644
> --- a/hw/pci/msi.c
> +++ b/hw/pci/msi.c
> @@ -289,7 +289,7 @@ void msi_reset(PCIDevice *dev)
>  static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
>  {
>      uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
> -    uint32_t mask, data;
> +    uint32_t mask, data, addr_lo;
>      bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
>      assert(vector < PCI_MSI_VECTORS_MAX);
>  
> @@ -298,7 +298,8 @@ static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
>      }
>  
>      data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
> -    if (xen_is_pirq_msi(data)) {
> +    addr_lo = pci_get_word(dev->config + msi_address_lo_off(dev));

This could be get_long, so addr_lo will actually have the all low bits
of the addr.

> +    if (xen_is_pirq_msi(data, addr_lo)) {
>          return false;
>      }
>  
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 0ec1cb1..6b8045a 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -81,9 +81,11 @@ static bool msix_vector_masked(PCIDevice *dev, unsigned int vector, bool fmask)
>  {
>      unsigned offset = vector * PCI_MSIX_ENTRY_SIZE;
>      uint8_t *data = &dev->msix_table[offset + PCI_MSIX_ENTRY_DATA];
> +    uint8_t *addr_lo = &dev->msix_table[offset + PCI_MSIX_ENTRY_LOWER_ADDR];
>      /* MSIs on Xen can be remapped into pirqs. In those cases, masking
>       * and unmasking go through the PV evtchn path. */
> -    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data))) {
> +    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data),
> +                                         pci_get_long(addr_lo))) {
>          return false;
>      }
>      return fmask || dev->msix_table[offset + PCI_MSIX_ENTRY_VECTOR_CTRL] &
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index 8b0d7fc..f799fed 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -114,7 +114,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
>  
>      assert((!is_msix && msix_entry == 0) || is_msix);
>  
> -    if (xen_is_pirq_msi(data)) {
> +    if (xen_is_pirq_msi(data, (uint32_t)(addr & 0xffffffff))) {

I don't think the cast is necessary. Also the & 0xffffffff is probably
not needed as well.

>          *ppirq = msi_ext_dest_id(addr >> 32) | msi_dest_id(addr);
>          if (!*ppirq) {
>              /* this probably identifies an misconfiguration of the guest,
> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
> index a8f3afb..c15beb5 100644
> --- a/include/hw/xen/xen.h
> +++ b/include/hw/xen/xen.h
> @@ -33,7 +33,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>  void xen_piix3_set_irq(void *opaque, int irq_num, int level);
>  void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
>  void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
> -int xen_is_pirq_msi(uint32_t msi_data);
> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo);
>  
>  qemu_irq *xen_interrupt_controller_init(void);
>  
> diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
> index c500325..dae421c 100644
> --- a/xen-hvm-stub.c
> +++ b/xen-hvm-stub.c
> @@ -31,7 +31,7 @@ void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
>  {
>  }
>  
> -int xen_is_pirq_msi(uint32_t msi_data)
> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
>  {
>      return 0;
>  }
> diff --git a/xen-hvm.c b/xen-hvm.c
> index 2f348ed..9e78b23 100644
> --- a/xen-hvm.c
> +++ b/xen-hvm.c
> @@ -146,8 +146,13 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
>      }
>  }
>  
> -int xen_is_pirq_msi(uint32_t msi_data)
> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
>  {
> +    /* If msi address is configurate to remapping format, the msi will not
> +     * remapped into a pirq.
> +     */
> +    if ( msi_addr_lo & 0x10 )

That's a magic number, is 0x10 MSI_ADDR_IM_MASK?

Thanks,

-- 
Anthony PERARD
