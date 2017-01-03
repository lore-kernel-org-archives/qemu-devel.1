Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cON4t-0005W7-UM
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cON4p-0005Iy-VY
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:16:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cON4p-0005Iu-Mt
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 06:16:23 -0500
Date: Tue, 3 Jan 2017 19:16:16 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170103111616.GI22664@pxdev.xzpeter.org>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
	<1481512100-10380-13-git-send-email-peterx@redhat.com>
	<20170103103326.GA4280@agordeev.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103103326.GA4280@agordeev.lab.eng.brq.redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v8 12/14] x86: intel-iommu:
 add dmar test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, drjones@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com

On Tue, Jan 03, 2017 at 11:33:27AM +0100, Alexander Gordeev wrote:
> On Mon, Dec 12, 2016 at 11:08:18AM +0800, Peter Xu wrote:
> > DMAR test is based on QEMU edu device. A 4B DMA memory copy is carried
> > out as the simplest DMAR test.
> 
> Hi Peter,
> 
> Sorry for missing to provide feedback on your series.
> I did just a cursory review, but did not notice few issue below.
> 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  lib/pci.h             |   5 ++
> >  lib/x86/intel-iommu.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/x86/intel-iommu.h |   4 ++
> >  x86/Makefile.common   |   1 +
> >  x86/intel-iommu.c     |  51 +++++++++++++++++++
> >  5 files changed, 194 insertions(+)
> > 
> > diff --git a/lib/pci.h b/lib/pci.h
> > index d3052ef..26968b1 100644
> > --- a/lib/pci.h
> > +++ b/lib/pci.h
> > @@ -18,6 +18,9 @@ enum {
> >  #define PCI_BAR_NUM                     6
> >  #define PCI_DEVFN_MAX                   256
> >  
> > +#define PCI_BDF_GET_DEVFN(x)            ((x) & 0xff)
> > +#define PCI_BDF_GET_BUS(x)              (((x) >> 8) & 0xff)
> > +
> >  struct pci_dev {
> >  	uint16_t bdf;
> >  	phys_addr_t resource[PCI_BAR_NUM];
> > @@ -28,6 +31,8 @@ extern void pci_scan_bars(struct pci_dev *dev);
> >  extern void pci_cmd_set_clr(struct pci_dev *dev, uint16_t set, uint16_t clr);
> >  extern void pci_enable_defaults(struct pci_dev *dev);
> >  
> > +typedef phys_addr_t iova_t;
> > +
> >  extern bool pci_probe(void);
> >  extern void pci_print(void);
> >  extern bool pci_dev_exists(pcidevaddr_t dev);
> > diff --git a/lib/x86/intel-iommu.c b/lib/x86/intel-iommu.c
> > index 1887998..86b1805 100644
> > --- a/lib/x86/intel-iommu.c
> > +++ b/lib/x86/intel-iommu.c
> > @@ -11,6 +11,42 @@
> >   */
> >  
> >  #include "intel-iommu.h"
> > +#include "libcflat.h"
> > +
> > +/*
> > + * VT-d in QEMU currently only support 39 bits address width, which is
> > + * 3-level translation.
> > + */
> > +#define VTD_PAGE_LEVEL      3
> > +#define VTD_CE_AW_39BIT     0x1
> > +
> > +typedef uint64_t vtd_pte_t;
> > +
> > +struct vtd_root_entry {
> > +	/* Quad 1 */
> > +	uint64_t present:1;
> > +	uint64_t __reserved:11;
> > +	uint64_t context_table_p:52;
> > +	/* Quad 2 */
> > +	uint64_t __reserved_2;
> > +} __attribute__ ((packed));
> > +typedef struct vtd_root_entry vtd_re_t;
> > +
> > +struct vtd_context_entry {
> > +	/* Quad 1 */
> > +	uint64_t present:1;
> > +	uint64_t disable_fault_report:1;
> > +	uint64_t trans_type:2;
> > +	uint64_t __reserved:8;
> > +	uint64_t slptptr:52;
> > +	/* Quad 2 */
> > +	uint64_t addr_width:3;
> > +	uint64_t __ignore:4;
> > +	uint64_t __reserved_2:1;
> > +	uint64_t domain_id:16;
> > +	uint64_t __reserved_3:40;
> > +} __attribute__ ((packed));
> > +typedef struct vtd_context_entry vtd_ce_t;
> >  
> >  #define VTD_RTA_MASK  (PAGE_MASK)
> >  #define VTD_IRTA_MASK (PAGE_MASK)
> > @@ -83,6 +119,103 @@ static void vtd_setup_ir_table(void)
> >  	printf("IR table address: 0x%016lx\n", vtd_ir_table());
> >  }
> >  
> > +static void vtd_install_pte(vtd_pte_t *root, iova_t iova,
> > +			    phys_addr_t pa, int level_target)
> > +{
> > +	int level;
> > +	unsigned int offset;
> > +	void *page;
> > +
> > +	for (level = VTD_PAGE_LEVEL; level > level_target; level--) {
> > +		offset = PGDIR_OFFSET(iova, level);
> > +		if (!(root[offset] & VTD_PTE_RW)) {
> > +			page = alloc_page();
> > +			memset(page, 0, PAGE_SIZE);
> > +			root[offset] = virt_to_phys(page) | VTD_PTE_RW;
> > +		}
> > +		root = (uint64_t *)(phys_to_virt(root[offset] &
> > +						 VTD_PTE_ADDR));
> > +	}
> > +
> > +	offset = PGDIR_OFFSET(iova, level);
> > +	root[offset] = pa | VTD_PTE_RW;
> > +	if (level != 1) {
> > +		/* This is huge page */
> > +		root[offset] |= VTD_PTE_HUGE;
> > +	}
> > +}
> > +
> > +#define  VTD_PHYS_TO_VIRT(x) \
> > +	((void *)(((uint64_t)phys_to_virt(x)) >> VTD_PAGE_SHIFT))
> 
> I would say this macro is rather superfluous.
> 
> > +/**
> > + * vtd_map_range: setup IO address mapping for specific memory range
> > + *
> > + * @sid: source ID of the device to setup
> > + * @iova: start IO virtual address
> > + * @pa: start physical address
> > + * @size: size of the mapping area
> > + */
> > +void vtd_map_range(uint16_t sid, iova_t iova, phys_addr_t pa, size_t size)
> > +{
> > +	uint8_t bus_n, devfn;
> > +	void *slptptr;
> > +	vtd_ce_t *ce;
> > +	vtd_re_t *re = phys_to_virt(vtd_root_table());
> > +
> > +	assert(IS_ALIGNED(iova, SZ_4K));
> > +	assert(IS_ALIGNED(pa, SZ_4K));
> > +	assert(IS_ALIGNED(size, SZ_4K));
> > +
> > +	bus_n = PCI_BDF_GET_BUS(sid);
> > +	devfn = PCI_BDF_GET_DEVFN(sid);
> > +
> > +	/* Point to the correct root entry */
> > +	re += bus_n;
> > +
> > +	if (!re->present) {
> > +		ce = alloc_page();
> > +		memset(ce, 0, PAGE_SIZE);
> > +		memset(re, 0, sizeof(*re));
> > +		re->context_table_p = virt_to_phys(ce) >> VTD_PAGE_SHIFT;
> > +		re->present = 1;
> > +		printf("allocated vt-d root entry for PCI bus %d\n",
> > +		       bus_n);
> > +	} else
> > +		ce = VTD_PHYS_TO_VIRT(re->context_table_p);
> 
> Seems, it should be instead something like:
> 
> 		ce = phys_to_virt(re->context_table_p << VTD_PAGE_SHIFT);

Oops, you are right. It didn't encounter issue since current DMAR test
is too simple and only allocated one single page. :-)

I'll post a fix soon. Thanks!

-- peterx
