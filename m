Received: from eggs.gnu.org ([209.51.188.92]:47059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtbdx-0002JF-Qn
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gtbdn-0007sI-WE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gtbdh-0007aR-GS
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:14:34 -0500
Date: Tue, 12 Feb 2019 10:14:23 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190212101423.341d4582@w520.home>
In-Reply-To: <87444301667aa0ec379a0a6285ce55b63b3f2ed6.camel@oracle.com>
References: <cover.d651a232d750c6f53cbe8d483b665d638f7a0c0a.1549779509.git-series.knut.omang@oracle.com>
	<636bd37834daa1cc4c42462aeccd0de17aa370bf.1549779509.git-series.knut.omang@oracle.com>
	<20190211160910.2be92b59@w520.home>
	<11bd769693e64619e3b1386797255b5a8e56bfd4.camel@oracle.com>
	<20190212085921.3e25a2cb@x1.home>
	<87444301667aa0ec379a0a6285ce55b63b3f2ed6.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] pcie: Add a simple PCIe ACS (Access
 Control Services) helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Knut Omang <knut.omang@oracle.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahsh@mellanox.com>, Tal Attaly <talat@mellanox.com>

On Tue, 12 Feb 2019 17:25:46 +0100
Knut Omang <knut.omang@oracle.com> wrote:

> On Tue, 2019-02-12 at 08:59 -0700, Alex Williamson wrote:
> > On Tue, 12 Feb 2019 09:07:43 +0100
> > Knut Omang <knut.omang@oracle.com> wrote:
> >   
> > > On Mon, 2019-02-11 at 16:09 -0700, Alex Williamson wrote:  
> > > > On Sun, 10 Feb 2019 07:52:59 +0100
> > > > Knut Omang <knut.omang@oracle.com> wrote:
> > > >     
> > > > > Add a helper function to add PCIe capability for Access Control Services
> > > > > (ACS)
> > > > > ACS support in the associated root port is a prerequisite to be able to
> > > > > do
> > > > > passthrough of individual functions of a device with VFIO
> > > > > without Alex Williamson's pcie_acs_override kernel patch or similar
> > > > > in the guest.    
> > > > 
> > > > This is still incorrect, the ACS override patch is only required for
> > > > separating multifunction endpoints or multifunction root ports.  Single
> > > > function endpoints are assignable without ACS simply by placing them
> > > > downstream of a single function root port or directly on the root
> > > > complex.    
> > > 
> > > Hmm - that was the intended meaning of the comment, but I'll see if I can
> > > make
> > > it more clear by saying it explicitly.  
> > 
> > "ACS support... is a prerequisite".  Prerequisite: a thing that is
> > required as a prior condition for something else to happen or exist.
> > 
> > Assignment of individual functions exists today, as is, by using QEMU
> > to define a PCIe topology that allows the desired grouping.  The code
> > here enables specific topologies, it is clearly not a prerequisite.
> >   
> > > > > Endpoints may also implement an ACS capability, but with
> > > > > limited features.
> > > > > 
> > > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > > ---
> > > > >  hw/pci/pcie.c              | 29 +++++++++++++++++++++++++++++
> > > > >  include/hw/pci/pcie.h      |  6 ++++++
> > > > >  include/hw/pci/pcie_regs.h |  4 ++++
> > > > >  3 files changed, 39 insertions(+)
> > > > > 
> > > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > > index 230478f..509632f 100644
> > > > > --- a/hw/pci/pcie.c
> > > > > +++ b/hw/pci/pcie.c
> > > > > @@ -742,6 +742,14 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice
> > > > > *dev)
> > > > >          PCI_EXP_DEVCTL2_ARI;
> > > > >  }
> > > > >  
> > > > > +/* Access Control Services (ACS) */
> > > > > +void pcie_cap_acs_reset(PCIDevice *dev)
> > > > > +{
> > > > > +    if (dev->exp.acs_cap) {
> > > > > +        pci_set_word(dev->config + dev->exp.acs_cap + PCI_ACS_CTRL, 0);
> > > > > +    }
> > > > > +}
> > > > > +
> > > > >  /**********************************************************************
> > > > > ****
> > > > >   * pci express extended capability list management functions
> > > > >   * uint16_t ext_cap_id (16 bit)
> > > > > @@ -906,3 +914,24 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
> > > > >  
> > > > >      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
> > > > >  }
> > > > > +
> > > > > +/* ACS (Access Control Services) */
> > > > > +void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> > > > > +{
> > > > > +    bool is_pcie_slot = !!object_dynamic_cast(OBJECT(dev),
> > > > > TYPE_PCIE_SLOT);
> > > > > +    uint16_t cap_bits = 0;
> > > > > +
> > > > > +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER, offset,
> > > > > +                        PCI_ACS_SIZEOF);
> > > > > +    dev->exp.acs_cap = offset;
> > > > > +
> > > > > +    if (is_pcie_slot) {
> > > > > +        /* Endpoints may also implement ACS, but these capabilities are
> > > > > */
> > > > > +        /* only valid for slots: */    
> > > > 
> > > > Not quite, SV, TB, and UF must not be implemented by endpoints, but RR
> > > > and CR must be implemented by multifunction endpoints that support p2p
> > > > if they provide an ACS capability.      
> > > 
> > > Hmm - are you ok with setting 0 here as I have done, just amending your 
> > > description to the comment? Then any future emulation that do support p2p 
> > > would have to set the needed bits after calling the init function.  
> > 
> > The comment definitely needs work, but I don't know what to do about
> > single function, non-SR-IOV capable devices calling into this.    
> 
> I agree - I have only been thinking about multifunction devices, I should 
> probably assert on not multifunction (or SR/IOV with my SR/IOV patch set) 
> to avoid misuse.

Be sure to check both for (dev->cap_present &
QEMU_PCI_CAP_MULTIFUNCTION) and PCI_FUNC(dev->devfn) since only
function 0 is required to have the header bit set.

> And what about someone passing a PF for SR/IOV through to a VM - 
> Has that use case showed up (yet) ? 
> I have so far only tested with my emulated SR/IOV.

The SR-IOV capability is masked to the L1 guest.  The issue is that an
assigned SR-IOV PF could create VFs *on the host* which has security
implications unless those VFs can be quarantined from general use by
the host kernel.  There have been patches and proposals, but none yet
that sufficiently address this issue.  Thanks,

Alex

> > Per the
> > spec, these devices cannot implement an ACS capability at all, but will
> > anyone care if they do?  Maybe endpoints need a different init
> > function.  Maybe the capability ID needs to be obscured until
> > additional functions or an SR-IOV capability are added.  I'm not really
> > concerned that this helper can only indicate lack of p2p between
> > functions for endpoints, other than the comments being wrong.  
> 
> Ok, I think I am in the clear then with my v4 comment :-)
> 
> > > After your previous comments on this, I had a look at Mellanox CX4 and CX5
> > > which
> > > are the only devices I could find in the lab that are endpoints and
> > > implement an
> > > ACS capability, and neither seems to implement any extra capabilities:
> > > 
> > >         Capabilities: [230 v1] Access Control Services
> > >                 ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir-
> > > UpstreamFwd- EgressCtrl- DirectTrans-
> > >                 ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
> > > UpstreamFwd- EgressCtrl- DirectTrans-
> > > 
> > > that was the reason for my choice of value here - after skimming through the
> > > spec (with my still very limited understanding of the details)  
> > 
> > If the above device is a multifunction device or SR-IOV capable device,
> > this is the correct way to indicate there is no p2p between functions.
> > This takes advantage of the wording in the spec that certain
> > capabilities must be implemented by functions that support p2p
> > traffic.  Therefore if the capability is not implemented then p2p is
> > not supported and requires no control.  
> 
> I see, that makes sense, and corresponds with the way the device I know best 
> worked.
> 
> > > > Linux therefore infers that if ACS
> > > > is supported by an endpoint and RR and CR are not implemented, the
> > > > device does not support p2p.      
> > > 
> > > Interesting - I thought the CX5 supported p2p, but I have not kept up with
> > > what
> > > happens on the RDMA list on that front.  
> > 
> > ACS can only indicate p2p capabilities within the device reporting it.
> > The above example indicates that the device does not do p2p internally
> > between functions.  It does not preclude p2p between devices or even
> > functions, but it does require that the p2p traffic occurs on the link
> > and therefore allows routing to be managed through the ACS capabilities
> > of the interconnect components.
> > 
> > For instance if we have a multifunction endpoint with the above
> > capability, we know that a DMA from function 1 targeting an address
> > range on function 0 will not complete the DMA internally, it will go
> > through the egress port to the downstream port above the endpoint.  The
> > ACS capability on that downstream port then controls whether that DMA
> > request is redirected back to the ingress port of the endpoint or
> > forwarded upstream.  If a redirect occurs here then the IOMMU is not
> > fully in control of the IOVA space of the device and the IOMMU group is
> > extended to indicate this.  
> 
> Thanks, this definitely clarifies!
> 
> > > > We could just say that nothing supports
> > > > p2p yet, but single function endpoints (except those implementing
> > > > SR-IOV) must not implement an ACS capability per the spec, which could
> > > > be difficult to exclude since the multifunction bit is handled
> > > > separately from the device model.    
> > > 
> > > Hmm - the older SR/IOV devices I know of, some Intel Ethernet devices and
> > > any of
> > > the older Mellanox devices, and our own cancelled Infiniband device, all
> > > seem
> > > not to implement ACS?  
> > 
> > Linux effectively assumes that there is no p2p between VFs or between
> > the PF and VF, so the result is that a multifunction endpoint without
> > ACS supporting SR-IOV would have the PFs grouped together, but the VFs
> > would be grouped individually, assuming the upstream topology provides
> > isolation.  Intel has since provided verification that nearly none of
> > their multi-port NICs implement internal p2p and they now use quirks to
> > provide the ACS equivalent information for grouping for those older
> > devices.  Newer Intel NICs implement ACS capabilities as in your
> > example above to indicate this without the need for quirks.  Thanks,  
> 
> Yes, so for devices like the CX4 and CX5 which exposes more than one PF,
> they need the ACS capability to indicate that individual PFs are isolated from 
> each other, while the single PF SR/IOV devices can do without.
> 
> Thanks for the excellent explanations, this makes it all much clearer!
> Knut
> 
> > Alex
> >   
> > > > Also comment style:
> > > > https://git.qemu.org/?p=qemu.git;a=blob;f=CODING_STYLE;#l127    
> > > 
> > > I see - will fix,
> > >   
> > > > > +        cap_bits =
> > > > > +            PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> > > > > PCI_ACS_UF;
> > > > > +    }
> > > > > +
> > > > > +    pci_set_word(dev->config + offset + PCI_ACS_CAP, cap_bits);
> > > > > +    pci_set_word(dev->wmask + offset + PCI_ACS_CTRL, cap_bits);
> > > > > +}
> > > > > diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> > > > > index 5b82a0d..4c40711 100644
> > > > > --- a/include/hw/pci/pcie.h
> > > > > +++ b/include/hw/pci/pcie.h
> > > > > @@ -79,6 +79,9 @@ struct PCIExpressDevice {
> > > > >  
> > > > >      /* Offset of ATS capability in config space */
> > > > >      uint16_t ats_cap;
> > > > > +
> > > > > +    /* ACS */
> > > > > +    uint16_t acs_cap;
> > > > >  };
> > > > >  
> > > > >  #define COMPAT_PROP_PCP "power_controller_present"
> > > > > @@ -116,6 +119,8 @@ void pcie_cap_flr_init(PCIDevice *dev);
> > > > >  void pcie_cap_flr_write_config(PCIDevice *dev,
> > > > >                             uint32_t addr, uint32_t val, int len);
> > > > >  
> > > > > +void pcie_cap_acs_reset(PCIDevice *dev);
> > > > > +
> > > > >  /* ARI forwarding capability and control */
> > > > >  void pcie_cap_arifwd_init(PCIDevice *dev);
> > > > >  void pcie_cap_arifwd_reset(PCIDevice *dev);
> > > > > @@ -129,6 +134,7 @@ void pcie_add_capability(PCIDevice *dev,
> > > > >  void pcie_sync_bridge_lnk(PCIDevice *dev);
> > > > >  
> > > > >  void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
> > > > > +void pcie_acs_init(PCIDevice *dev, uint16_t offset);    
> > > > 
> > > > nit, why aren't the reset and init declarations together?    
> > > 
> > > Good point, will fix.
> > > 
> > > Thanks!
> > > Knut
> > >   
> > > > >  void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t
> > > > > ser_num);
> > > > >  void pcie_ats_init(PCIDevice *dev, uint16_t offset);
> > > > >  
> > > > > diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> > > > > index ad4e780..1db86b0 100644
> > > > > --- a/include/hw/pci/pcie_regs.h
> > > > > +++ b/include/hw/pci/pcie_regs.h
> > > > > @@ -175,4 +175,8 @@ typedef enum PCIExpLinkWidth {
> > > > >                                           PCI_ERR_COR_INTERNAL
> > > > > |         \
> > > > >                                           PCI_ERR_COR_HL_OVERFLOW)
> > > > >  
> > > > > +/* ACS */
> > > > > +#define PCI_ACS_VER                     0x1
> > > > > +#define PCI_ACS_SIZEOF                  8
> > > > > +
> > > > >  #endif /* QEMU_PCIE_REGS_H */    
> 
