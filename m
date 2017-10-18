Received: from eggs.gnu.org ([2001:4830:134:3::10]:50511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4hN2-0005dW-VN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4hMz-0000WN-TM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:58:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:53887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e4hMz-0000VY-JF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:58:21 -0400
Date: Wed, 18 Oct 2017 13:57:55 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171018055755.GB4352@yangzhon-Virtual>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
	<ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
	<0ea87d45-f1c9-21c5-ddc3-c1d5bd0c6df8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea87d45-f1c9-21c5-ddc3-c1d5bd0c6df8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

On Mon, Oct 16, 2017 at 01:58:59PM +0200, Paolo Bonzini wrote:
> On 16/10/2017 12:20, Xiao Guangrong wrote:
> > 
> >> Qemu does not need pin NVDIMM memory for VFIO device during VFIO
> >> hotplug, what's more, if there is no NVDIMM hw in the test machine,
> >> the VFIO hotplug operation will need at least 10 minutes to pin RAM
> >> as the NVDIMM, this time is not accepted. So we add "nopin=on" option
> >> in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.
> > 
> > No.
> > 
> > memory-backed-file does not dedicate for nvdimm only, it can be mapped
> > as normal memory as well. Rather more, this is no way to stop guest to
> > use it as DMA.
> 
> Right, so a better name for the object property could be "dma" rather
> than "nopin".  I'll let others comment on whether MemoryBackend (not
> just memory-backend-file) is the right place for the option.
  
  Paolo, thanks for your comments!
 
  Yes, i can change this property from "nopin" to "dma" in memory-backend
  (not in ,memmory-backed-file). thanks!

  Yang

> I am also not sure whether VFIO is not the right place for the "other
> side" of the hook.  If you add the memory region to the CPU address
> space and not the PCI address space, you can hide it from all PCI devices.
> 
> Paolo
  thanks for your suggestion!

  Your suggestion can avoid DMA target to nvdimm if the nvdimm memory region
  was skipped during VFIO hotplug. It is valuable to try this solution. by the
  way, please share me some clue for PCI address space related with memory region,
  below address_space_mem is right?  Many thanks!

  static void pci_bus_init(PCIBus *bus, DeviceState *parent,
                         MemoryRegion *address_space_mem,
                         MemoryRegion *address_space_io,
                         uint8_t devfn_min)  
  
  Regards,

  Yang
