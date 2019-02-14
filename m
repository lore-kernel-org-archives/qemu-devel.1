Received: from eggs.gnu.org ([209.51.188.92]:50487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1guKHk-0006ce-Qu
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1guKHX-0003Ir-7n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:54:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1guKHW-00038w-D3
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:54:38 -0500
Message-ID: <ec13ef9f4b4807887c68d5087dd46b3d0e22d900.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Thu, 14 Feb 2019 17:54:12 +0100
In-Reply-To: <20190214085131.0b6d8d37@x1.home>
References: <cover.cc19031e8d42f0196630e60c9016d57d8a46e676.1550050121.git-series.knut.omang@oracle.com>
	<3df33b2bd332259dc548751b3c3c5eaa297428b0.1550050121.git-series.knut.omang@oracle.com>
	<20190213121346.384ebbab@w520.home>
	<80eacdbd99faa60d761951e9321a998764cd73ce.camel@oracle.com>
	<20190214085131.0b6d8d37@x1.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/2] pcie: Add a simple PCIe ACS (Access
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahsh@mellanox.com>, Tal Attaly <talat@mellanox.com>

On Thu, 2019-02-14 at 08:51 -0700, Alex Williamson wrote:
> On Thu, 14 Feb 2019 08:07:33 +0100
> Knut Omang <knut.omang@oracle.com> wrote:
> 
> > On Wed, 2019-02-13 at 12:13 -0700, Alex Williamson wrote:
> > > On Wed, 13 Feb 2019 10:29:58 +0100
> > > Knut Omang <knut.omang@oracle.com> wrote:
> > >   
> > > > Add a helper function to add PCIe capability for Access Control Services
> > > > (ACS)  
> > > 
> > > This is redundant to the commit title.
> > >   
> > > > ACS support in the associated root port is needed to pass
> > > > through individual functions of a device to different VMs with VFIO
> > > > without Alex Williamson's pcie_acs_override kernel patch or similar
> > > > in the guest.  
> > > 
> > > This is overly subtle, to work backwards that individual functions
> > > (plural!) of a device (singular!) must imply a multifunction endpoint
> > > in the same hierarchy split to different L2 VMs.  Perhaps I only
> > > finally realized this subtly on v4.
> > >   
> > > > Single function devices, or multifunction devices
> > > > that all goes to the same VM works fine even without ACS, as VFIO
> > > > will avoid putting the root port itself into the IOMMU group
> > > > even without ACS support in the port.  
> > > 
> > > Also confusing and incorrectly states that a) VFIO is responsible for
> > > IOMMU grouping, it's not, and b) that the root port would not be
> > > included in such a group, it would.  The latter was I thought the
> > > impetus for this series.  
> > 
> > that wasn't the intention but I can see that it looks that way now
> > 
> > > > Multifunction endpoints may also implement an ACS capability,
> > > > only on function 0, and with more limited features.  
> > > 
> > > "only on function 0" is incorrect, each function of a multifunction
> > > device should (not must) implement an ACS capability if any of them do.
> > > 
> > > Can't we just say something like:
> > > 
> > > "Implementing an ACS capability on downstream ports and multifuction
> > > endpoints indicates isolation and IOMMU visibility to a finer
> > > granularity thereby creating smaller IOMMU groups in the guest and thus
> > > more flexibility in assigning endpoints to guest userspace or an L2
> > > guest."  
> > 
> > sure - will use this - and remove my confusing attempt to 
> > credit to your override patch and VFIO :)
> > 
> > > (I avoided including SR-IOV with multifunction since that's not
> > > implemented here)  
> > 
> > I agree
> > 
> > > > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > > > ---
> > > >  hw/pci/pcie.c              | 39
> > > > +++++++++++++++++++++++++++++++++++++++-
> > > >  include/hw/pci/pcie.h      |  6 ++++++-
> > > >  include/hw/pci/pcie_regs.h |  4 ++++-
> > > >  3 files changed, 49 insertions(+)
> > > > 
> > > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > > index 230478f..6e87994 100644
> > > > --- a/hw/pci/pcie.c
> > > > +++ b/hw/pci/pcie.c
> > > > @@ -906,3 +906,42 @@ void pcie_ats_init(PCIDevice *dev, uint16_t offset)
> > > >  
> > > >      pci_set_word(dev->wmask + dev->exp.ats_cap + PCI_ATS_CTRL, 0x800f);
> > > >  }
> > > > +
> > > > +/* ACS (Access Control Services) */
> > > > +void pcie_acs_init(PCIDevice *dev, uint16_t offset)
> > > > +{
> > > > +    bool is_pcie_slot = !!object_dynamic_cast(OBJECT(dev),
> > > > TYPE_PCIE_SLOT);  
> > > 
> > > Perhaps we should be using pci_is_express_downstream_port().  
> > 
> > oh - yes - I forgot that we need to look in pci.h for those kind of 
> > helpers..
> > 
> > > > +    uint16_t cap_bits = 0;
> > > > +
> > > > +    /*
> > > > +     * For endpoints, only multifunction devices may have an
> > > > +     * ACS capability, and only on function 0:  
> > > 
> > > Incorrect
> > >   
> > > > +     */
> > > > +    assert(is_pcie_slot ||
> > > > +           ((dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) &&
> > > > +            PCI_FUNC(dev->devfn)));  
> > > 
> > > The second test should be:
> > > 
> > > ((dev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) ||
> > >  PCI_FUNC(dev->devfn))
> > > 
> > > If the function number is non-zero, then it's clearly a multifunction
> > > device, the multifunction capability is only required on function
> > > zero.  Just as in my previous example, an ACS capability can only
> > > describe/control the DMA flow of the function implementing it, nothing
> > > in the spec that I can see imposes function zero's DMA flow on the
> > > other functions.  
> > 
> > Ah - of course - that makes sense - 
> > was thinking too complicated here, and also my comment didn't match
> > the code at all..
> > 
> > > There's also a gap here that function zero can set the multifunction
> > > capability, but there may be no secondary devices defined.  Not that
> > > we necessarily need to resolve this, but it's a nuance of allowing
> > > arbitrary multifunction configurations as QEMU does.  
> > 
> > Yes, in the SR/IOV case, at least as I have implemented it in QEMU, 
> > with one PF that would be the default - as no VFs are defined at reset, 
> > there's only one function, but it still need to be multifunction 
> > for QEMU to accept more functions appearing later.
> > 
> > > > +
> > > > +    pcie_add_capability(dev, PCI_EXT_CAP_ID_ACS, PCI_ACS_VER, offset,
> > > > +                        PCI_ACS_SIZEOF);
> > > > +    dev->exp.acs_cap = offset;
> > > > +
> > > > +    if (is_pcie_slot) {
> > > > +        /*
> > > > +         * Endpoints may also implement ACS, and optionally RR and CR,
> > > > +         * if they want to support p2p, but only slots may
> > > > +         * implement SV, TB or UF:  
> > > 
> > > Careful using "may" with spec references.  
> > 
> > :-D
> > 
> > > "Downstream ports must implement SV, TB, RR, CR, and UF (with caveats
> > > on the latter three that we ignore for simplicity).  Endpoints may also
> > > implement a subset of ACS capabilities, but these are optional if the
> > > endpoint does not support peer-to-peer between functions and thus
> > > omitted here."  
> > 
> > Thanks - I'll put that in instead
> > 
> > > > +         */
> > > > +        cap_bits =
> > > > +            PCI_ACS_SV | PCI_ACS_TB | PCI_ACS_RR | PCI_ACS_CR |
> > > > PCI_ACS_UF;  
> > > 
> > > PCI_ACS_DT has similar "must be implemented" requirements to RR, RC,
> > > and UF, why is it not included?  For all of these "caveat" ones there
> > > are conditions which can make it optional for root ports, but required
> > > for switch downstream ports, so it seems reasonable that we include
> > > both since that's what our is_pci_slot() test covers.  Thanks,  
> > 
> > That was because my "reference" root ports don't not implement it, taking
> > the
> > conservative approach:
> > 
> > 00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root
> > Port 7 (rev 22) (prog-if 00 [Normal decode])
> >        ...
> >        Capabilities: [150 v1] Access Control Services
> >                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> >                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
> > UpstreamFwd+ EgressCtrl- DirectTrans-
> > 
> > In fact, all gens of servers I have access to supports just the same cap
> > bits in
> > their root ports, in order of release date. The latest gen even have some
> > root
> > ports without an ACS capability.
> > 
> > 00:02.0 PCI bridge: Intel Corporation Xeon E5/Core i7 IIO PCI Express Root
> > Port 2a (rev 07)
> > 00:01.0 PCI bridge: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon
> > D PCI Express Root Port 1 (rev 01) (prog-if 00 [Normal decode])
> > 00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
> > Express Root Port 3 (rev 02) (prog-if 00 [Normal decode])
> > 00:02.0 PCI bridge: Intel Corporation Xeon E7 v2/Xeon E5 v2/Core i7 PCI
> > Express Root Port 2a (rev 04) (prog-if 00 [Normal decode])
> > 17:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A
> > (rev 04) (prog-if 00 [Normal decode])
> > 
> > All of these have DirectTrans- in their ACSCap.
> > 
> > [For reference, the one without ACS cap, in the same server as 17:00.0
> > above:
> > 
> > 00:1c.0 PCI bridge: Intel Corporation Lewisburg PCI Express Root Port #1
> > (rev f9) (prog-if 00 [Normal decode])
> > ]
> > 
> > Do you prefer that we set DT as default anyway, or should we stay within
> > "known
> > territory" for the OSes, at least for now?
> 
> Per the spec:
> 
>   ACS Direct Translated P2P: must be implemented by Root Ports that
>   support Address Translation Services (ATS) and also support
>   peer-to-peer traffic with other Root Ports; must be implemented by
>   Switch Downstream Ports.
> 
> The caveats for root ports here are why your hardware is potentially
> spec compliant without supporting DT.  There are no caveats for switch
> downstream ports, therefore it would not be spec compliant to exclude
> it.  I think your options are either to exclude switch downstream ports
> from the function or to set DT.  Thanks,

Better to set DT then - a future generic switch downstream port would want to
have ACS too.

Knut

> Alex
