Received: from eggs.gnu.org ([209.51.188.92]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmOjg-0007Dl-Fu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 15:02:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmOfi-0003wO-Ng
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:58:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmOfh-0003uy-99
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:58:50 -0500
Message-ID: <9f388b0c9942916783f385db34034a4e28bb82c6.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 23 Jan 2019 20:58:33 +0100
In-Reply-To: <20190123125608.439c31da@w520.home>
References: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
	<b6e8edb21e6cc5f616383cb733c2d5f75d89953e.1548266832.git-series.knut.omang@oracle.com>
	<20190123120422.36273dd1@w520.home>
	<f2428ca469285f98f823edf2d270ba3ff52d4582.camel@oracle.com>
	<20190123125608.439c31da@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] pcie: Add a simple PCIe ACS (Access
 Control Services) helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, qemu-devel@nongnu.org, Tal Attaly <talat@mellanox.com>

On Wed, 2019-01-23 at 12:56 -0700, Alex Williamson wrote:
> On Wed, 23 Jan 2019 20:46:14 +0100
> Knut Omang <knut.omang@oracle.com> wrote:
> 
> > On Wed, 2019-01-23 at 12:04 -0700, Alex Williamson wrote:
> > > On Wed, 23 Jan 2019 19:27:59 +0100
> > > Knut Omang <knut.omang@oracle.com> wrote:
> > >   
> > > > Add a helper function to add PCIe capability for Access Control Services (ACS)
> > > > ACS support in the associated root port is a prerequisite to be able to do useful
> > > > passthrough with VFIO without Alex Williamson's pcie_acs_override kernel patch.  
> > > 
> > > Define "useful".  We can certainly still assign single function PFs to
> > > an L2 guest, or multi-function so long as all the functions are
> > > assigned.  I won't deny that it's problematic, but it's a virtual
> > > topology that can be adjusted, so I think this is overstating things a
> > > bit.
> > >   
> > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > ---
> > > >  hw/pci/pcie.c              | 14 ++++++++++++++
> > > >  include/hw/pci/pcie.h      |  1 +
> > > >  include/hw/pci/pcie_regs.h |  4 ++++
> > > >  3 files changed, 19 insertions(+)
> > > > 
> > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > index 230478f..18feff5 100644
> > > > --- a/hw/pci/pcie.c
> > > > +++ b/hw/pci/pcie.c
> > > > @@ -906,3 +906,17 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
> > > >  
> > > >      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
> > > >  }
> > > > +
> > > > +/* Add an ACS (Access Control Services) capability */
> > > > +void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz)
> > > > +{
> > > > +    int ectrl_words = (egress_ctrl_vec_sz + 31) & ~31;
> > > > +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER,
> > > > +                        offset, PCI_ACS_SIZEOF + ectrl_words);  
> > > 
> > > The egress control vector is only valid if the egress control
> > > capability is enabled, which is not set below, so this just seems to
> > > waste config space and introduces a meaningless function arg.  
> > 
> > I think my intention way back when I implemented this was to provide it as a skeleton
> > for further detailing later, I use it with ectrl_words = 0 in the root port.
> > 
> > > > +    pci_set_word(dev->config + offset + PCI_ACS_CAP,
> > > > +                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF);  
> > > 
> > > Some of these bits are only valid for downstream ports, it would
> > > violate the spec to set them on and endpoint.  
> > 
> > I must admit I haven't really dived deep here - I just set the cap bits that one of my
> > servers sets for it's root ports - this is the one I used as model:
> > 
> > 00:02.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1
> (rev
> > 22) (prog-if 00 [Normal decode])
> > 00:02.0 0604: 8086:3409 (rev 22)
> > 
> > > > +    pci_set_word(dev->config + offset + PCI_ACS_CTRL,
> > > > +                 PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF);  
> > > 
> > > The default values of the control register bits is zero, so we
> > > shouldn't be setting it here and we should have a reset hook to clear
> > > it.  
> > 
> > I agree - I'll implement it,
> > thanks!
> > 
> > Knut
> > 
> > >   
> > > > +    /* Make CTRL register writable */
> > > > +    memset(dev->wmask + offset + PCI_ACS_CTRL, 0xff, 2);
> 
> While you're at it, it doesn't make sense to set unimplemented control
> bits as writable, this should match the bits set in the capabilities
> register.  Thanks,

Good point, I'll fix that as well,

Thanks!
Knut

> 
> Alex
> 
> > > > +}
> > > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > > > index 5b82a0d..c2da148 100644
> > > > --- a/include/hw/pci/pcie.h
> > > > +++ b/include/hw/pci/pcie.h
> > > > @@ -129,6 +129,7 @@ void pcie_add_capability(PCIDevice *dev,
> > > >  void pcie_sync_bridge_lnk(PCIDevice *dev);
> > > >  
> > > >  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> > > > +void pcie_acs_init(PCIDevice *dev, uint16_t offset, uint8_t egress_ctrl_vec_sz);
> > > >  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
> > > >  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
> > > >  
> > > > diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> > > > index ad4e780..5e7409c 100644
> > > > --- a/include/hw/pci/pcie_regs.h
> > > > +++ b/include/hw/pci/pcie_regs.h
> > > > @@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
> > > >                                           PCI_ERR_COR_INTERNAL |         \
> > > >                                           PCI_ERR_COR_HL_OVERFLOW)
> > > >  
> > > > +/* ACS */
> > > > +#define PCI_ACS_VER			0x2
> > > > +#define PCI_ACS_SIZEOF                  8
> > > > +
> > > >  #endif /* QEMU_PCIE_REGS_H */  
> > >   
> > 
> > 
> 
