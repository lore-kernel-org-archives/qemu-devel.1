Received: from eggs.gnu.org ([2001:4830:134:3::10]:33467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1csT4K-0007lk-MK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1csT4H-0002uT-Hm
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:44:16 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1csT4H-0002u3-Bl
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:44:13 -0400
Received: by mail-wr0-x231.google.com with SMTP id l43so52518292wre.1
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 04:44:12 -0700 (PDT)
Date: Mon, 27 Mar 2017 13:44:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170327114410.GE9606@toto>
References: <20160822161740.4252-1-prem.mallappa@broadcom.com>
	<465528b8-332b-083e-fc04-5613fadc57fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465528b8-332b-083e-fc04-5613fadc57fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] SMMUv3 Emulation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Prem Mallappa <prem.mallappa@broadcom.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Wed, Mar 08, 2017 at 06:46:13PM +0100, Auger Eric wrote:
> Hi,
> On 22/08/2016 18:17, Prem Mallappa wrote:
> > v1 -> v2:
> > 	- Adopted review comments from Eric Auger
> > 		- Make SMMU_DPRINTF to internally call qemu_log
> > 	            (since translation requests are too many, we need control
> > 		     on the type of log we want)
> > 		- SMMUTransCfg modified to suite simplicity
> > 		- Change RegInfo to uint64 register array
> > 		- Code cleanup
> > 		- Test cleanups
> > 	- Reshuffled patches
> > 
> > RFC -> v1:
> > 	- As per SMMUv3 spec 16.0 (only is_ste_consistant() is noticeable)
> > 	- Reworked register access/update logic
> > 	- Factored out translation code for
> > 		- single point bug fix
> > 		- sharing/removal in future
> > 	- (optional) Unit tests added, with PCI test device
> > 		- S1 with 4k/64k, S1+S2 with 4k/64k
> > 		- (S1 or S2) only can be verified by Linux 4.7 driver
> > 	- (optional) Priliminary ACPI support
> > 
> > RFC:
> > 	- Implements SMMUv3 spec 11.0
> > 	- Supported for PCIe devices, 
> > 	- Command Queue and Event Queue supported
> > 	- LPAE only, S1 is supported and Tested, S2 not tested
> > 	- BE mode Translation not supported
> > 	- IRQ support (legacy, no MSI)
> > 	- Tested with DPDK and e1000 
> > 
> > Patch 1: Add new log type for IOMMU transactions
> > 
> > Patch 2: Adds support in virt.c to create both SMMUv3 device and dts entries
> > 
> > Patch 2: Adds SMMUv3 model to QEMU
> > 	Multiple files, big ones, translate functionality is split across to
> > 	accomodate SMMUv2 model, and to remove when common translation feature
> > 	(if) becomes available.
> > 
> > Patch 3: Adds SMMU build support
> > 
> > Patch 4: Some devicetree function to add support for SMMU's multiple interrupt
> > 	 assignment with names
> > 
> > << optional patches >>
> > Optional patches are posted for completeness or for those who wants to test.
> > 
> > Patch 5: A simple PCI device which does DMA from 'src' to 'dst' given
> > 	 src_addr, dst_addr and size, and is used by unit test, uses
> > 	 pci_dma_read and pci_dma_write in a crude way but serves the purpose.
> > 
> > Patch 6: Current libqos PCI helpers are x86 only, this addes a generic interface
> > 
> > Patch 7: Unit tests for SMMU, 
> > 		- initializes SMMU device 
> > 		- initializes Test device
> > 		- allocates page tables 1:1 mapping va == pa
> > 		- allocates STE/CD accordingly for S1, S2, S1+S2
> > 		- initiates DMA via PCI test device
> > 		- verifies transfered data
> > 
> > Patch 8: Added ACPI IORT tables, was needed for internal project purpose, but 
> > 	 posting here for anyone looking for testing ACPI on ARM platforms.
> > 	 (P.S: Linux side IORT patches are WIP)
> > 
> > Repo:
> > https://github.com/pmallappa/qemu/tree/upstream/smmuv3/v2
> > 
> > To Test:
> > $ make tests/smmuv3-test
> > $ QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64 tests/smmuv3-test
> > << expect lot of prints >>
> > 
> > Any comments welcome..
> As Prem was forced to stop his activity on this series, I volunteer to
> pursue his work. Prior to starting the work, I just would like to check
> nobody works on this already or objects.
> 
> If not, I intend to rebase and will do my utmost to align, when sensible
> with what was done on Xilinx vsmmuv2/intel iommu.


That would be awesome! Sorry for the late reply.

I had some comments on the PCI integration that Prem did but I'm not sure
it matters now if you're going to go through the work. We can do a review
of your future patches instead.

Cheers,
Edgar
