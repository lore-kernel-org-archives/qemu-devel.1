Received: from eggs.gnu.org ([2001:4830:134:3::10]:52795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dCdRA-00053n-80
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dCdR7-0002EV-5l
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:51:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dCdR6-0002EF-QO
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:51:09 -0400
References: <1495085580-10631-1-git-send-email-tianyu.lan@intel.com>
	<1495085580-10631-3-git-send-email-tianyu.lan@intel.com>
	<20170519115733.GB3260@perard.uk.xensource.com>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <9fbefbf2-e06a-b2a5-bd7a-f2d9168a3a9b@intel.com>
Date: Mon, 22 May 2017 10:41:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170519115733.GB3260@perard.uk.xensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH V2 2/2] msi: Handle remappable format
 interrupt request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Chao Gao <chao.gao@intel.com>, mst@redhat.com, marcel@redhat.com, sstabellini@kernel.org, kevin.tian@intel.com

Hi Anthony:
	Thanks for your review.

On 2017年05月19日 19:57, Anthony PERARD wrote:
> On Thu, May 18, 2017 at 01:33:00AM -0400, Lan Tianyu wrote:
>> From: Chao Gao <chao.gao@intel.com>
>>
>> According to VT-d spec Interrupt Remapping and Interrupt Posting ->
>> Interrupt Remapping -> Interrupt Request Formats On Intel 64
>> Platforms, fields of MSI data register have changed. This patch
>> avoids wrongly regarding a remappable format interrupt request as
>> an interrupt binded with an event channel.
>>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  hw/pci/msi.c         | 5 +++--
>>  hw/pci/msix.c        | 4 +++-
>>  hw/xen/xen_pt_msi.c  | 2 +-
>>  include/hw/xen/xen.h | 2 +-
>>  xen-hvm-stub.c       | 2 +-
>>  xen-hvm.c            | 7 ++++++-
>>  6 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/pci/msi.c b/hw/pci/msi.c
>> index a87b227..199cb47 100644
>> --- a/hw/pci/msi.c
>> +++ b/hw/pci/msi.c
>> @@ -289,7 +289,7 @@ void msi_reset(PCIDevice *dev)
>>  static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
>>  {
>>      uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
>> -    uint32_t mask, data;
>> +    uint32_t mask, data, addr_lo;
>>      bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
>>      assert(vector < PCI_MSI_VECTORS_MAX);
>>  
>> @@ -298,7 +298,8 @@ static bool msi_is_masked(const PCIDevice *dev, unsigned int vector)
>>      }
>>  
>>      data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
>> -    if (xen_is_pirq_msi(data)) {
>> +    addr_lo = pci_get_long(dev->config + msi_address_lo_off(dev));
>> +    if (xen_is_pirq_msi(data, addr_lo)) {
>>          return false;
>>      }
>>  
>> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
>> index bb54e8b..efe2982 100644
>> --- a/hw/pci/msix.c
>> +++ b/hw/pci/msix.c
>> @@ -82,9 +82,11 @@ static bool msix_vector_masked(PCIDevice *dev, unsigned int vector, bool fmask)
>>  {
>>      unsigned offset = vector * PCI_MSIX_ENTRY_SIZE;
>>      uint8_t *data = &dev->msix_table[offset + PCI_MSIX_ENTRY_DATA];
>> +    uint8_t *addr_lo = &dev->msix_table[offset + PCI_MSIX_ENTRY_LOWER_ADDR];
>>      /* MSIs on Xen can be remapped into pirqs. In those cases, masking
>>       * and unmasking go through the PV evtchn path. */
>> -    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data))) {
>> +    if (xen_enabled() && xen_is_pirq_msi(pci_get_long(data),
>> +                                         pci_get_long(addr_lo))) {
>>          return false;
>>      }
>>      return fmask || dev->msix_table[offset + PCI_MSIX_ENTRY_VECTOR_CTRL] &
>> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
>> index 5fab95e..45a9e9f 100644
>> --- a/hw/xen/xen_pt_msi.c
>> +++ b/hw/xen/xen_pt_msi.c
>> @@ -114,7 +114,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
>>  
>>      assert((!is_msix && msix_entry == 0) || is_msix);
>>  
>> -    if (xen_is_pirq_msi(data)) {
>> +    if (xen_is_pirq_msi(data, addr)) {
>>          *ppirq = msi_ext_dest_id(addr >> 32) | msi_dest_id(addr);
>>          if (!*ppirq) {
>>              /* this probably identifies an misconfiguration of the guest,
>> diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
>> index 09c2ce5..af759bc 100644
>> --- a/include/hw/xen/xen.h
>> +++ b/include/hw/xen/xen.h
>> @@ -33,7 +33,7 @@ int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
>>  void xen_piix3_set_irq(void *opaque, int irq_num, int level);
>>  void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len);
>>  void xen_hvm_inject_msi(uint64_t addr, uint32_t data);
>> -int xen_is_pirq_msi(uint32_t msi_data);
>> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo);
> 
> Maybe inverting the arguments would be better, so the arguments would be
> the address first, then the data, like I think it is often the case.
> What do you think?


That make sense. Will update.

> 
>>  
>>  qemu_irq *xen_interrupt_controller_init(void);
>>  
>> diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
>> index c500325..dae421c 100644
>> --- a/xen-hvm-stub.c
>> +++ b/xen-hvm-stub.c
>> @@ -31,7 +31,7 @@ void xen_hvm_inject_msi(uint64_t addr, uint32_t data)
>>  {
>>  }
>>  
>> -int xen_is_pirq_msi(uint32_t msi_data)
>> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
>>  {
>>      return 0;
>>  }
>> diff --git a/xen-hvm.c b/xen-hvm.c
>> index 5043beb..db29121 100644
>> --- a/xen-hvm.c
>> +++ b/xen-hvm.c
>> @@ -146,8 +146,13 @@ void xen_piix_pci_write_config_client(uint32_t address, uint32_t val, int len)
>>      }
>>  }
>>  
>> -int xen_is_pirq_msi(uint32_t msi_data)
>> +int xen_is_pirq_msi(uint32_t msi_data, uint32_t msi_addr_lo)
>>  {
>> +    /* If msi address is configurate to remapping format, the msi will not
>> +     * remapped into a pirq.
> 
> What do you think of: "If the MSI address is configured in remappable
> format, the MSI will not be remapped into a pirq." ?

Will update.

> 
>> +     */
>> +    if (msi_addr_lo & MSI_ADDR_IF_MASK)
>> +        return 0;
>>      /* If vector is 0, the msi is remapped into a pirq, passed as
>>       * dest_id.
>>       */
> 
> Thanks,
> 


-- 
Best regards
Tianyu Lan
