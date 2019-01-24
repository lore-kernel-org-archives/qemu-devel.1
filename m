Received: from eggs.gnu.org ([209.51.188.92]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmltx-0005ji-1W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmljl-0008Qr-Ou
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:36:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmlji-0008Om-9B
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:36:32 -0500
Message-ID: <145f1c9d17296d8050f04211c7e1a5b6275cae3f.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Thu, 24 Jan 2019 21:36:18 +0100
In-Reply-To: <20190124103353.569de985@w520.home>
References: <cover.4fe3faa2cc295ab1e178284b738e33b940ab9312.1548323393.git-series.knut.omang@oracle.com>
	<b9ae6eabc2a87fb27e969c9d095263f4a097b740.1548323393.git-series.knut.omang@oracle.com>
	<20190124103353.569de985@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] gen_pcie_root_port: Add ACS (Access
 Control Services) capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, Tal Attaly <talat@mellanox.com>

On Thu, 2019-01-24 at 10:33 -0700, Alex Williamson wrote:
> On Thu, 24 Jan 2019 11:12:53 +0100
> Knut Omang <knut.omang@oracle.com> wrote:
> 
> > Claim ACS support in the generic PCIe root port to allow
> > passthrough of individual functions of a device to different
> > guests (in a nested virt.setting) with VFIO.
> > Without this patch, all functions of a device, such as all VFs of
> > an SR/IOV device, will end up in the same IOMMU group.
> > A similar situation occurs on Windows with Hyper-V.
> > 
> > In the single function device case, it also has a small cosmetic
> > benefit in that the root port itself is not grouped with
> > the device. VFIO handles that situation in that binding rules
> > only apply to endpoints, so it does not limit passthrough in
> > those cases.
> > 
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  hw/pci-bridge/gen_pcie_root_port.c | 2 ++
> >  hw/pci-bridge/pcie_root_port.c     | 4 ++++
> >  include/hw/pci/pcie_port.h         | 1 +
> >  3 files changed, 7 insertions(+)
> > 
> > diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> > index 9766edb..b5a5ecc 100644
> > --- a/hw/pci-bridge/gen_pcie_root_port.c
> > +++ b/hw/pci-bridge/gen_pcie_root_port.c
> > @@ -20,6 +20,7 @@
> >          OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
> >  
> >  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> > +#define GEN_PCIE_ROOT_PORT_ACS_OFFSET           0x148
> 
> So you prefer that everyone passing through here decode these to figure
> out that ACS_OFFSET is (AER_OFFSET + ERR_SIZEOF) since my comment on v1
> was ignored?

Sorry, not at all - I managed to overlook your comment - will fix it,

> >  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
> >  
> >  typedef struct GenPCIERootPort {
> > @@ -149,6 +150,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
> >      rpc->interrupts_init = gen_rp_interrupts_init;
> >      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
> >      rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> > +    rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
> >  }
> >  
> >  static const TypeInfo gen_rp_dev_info = {
> > diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> > index 34ad767..a0b4cf7 100644
> > --- a/hw/pci-bridge/pcie_root_port.c
> > +++ b/hw/pci-bridge/pcie_root_port.c
> > @@ -47,6 +47,7 @@ static void rp_reset(DeviceState *qdev)
> >      pcie_cap_deverr_reset(d);
> >      pcie_cap_slot_reset(d);
> >      pcie_cap_arifwd_reset(d);
> > +    pcie_cap_acs_reset(d);
> 
> Only the generic root port initializes acs_offset to enable an ACS
> capability, but all members of the device class call the reset function
> which does no checking that an ACS capability exists.  We've just
> corrupted config space for the device.

Ouch! Not good at all, sorry!
Will look at it (after a good night's sleep this time..)

Thanks!
Knut

> >      pcie_aer_root_reset(d);
> >      pci_bridge_reset(qdev);
> >      pci_bridge_disable_base_limit(d);
> > @@ -106,6 +107,9 @@ static void rp_realize(PCIDevice *d, Error **errp)
> >      pcie_aer_root_init(d);
> >      rp_aer_vector_update(d);
> >  
> > +    if (rpc->acs_offset) {
> > +        pcie_acs_init(d, rpc->acs_offset);
> > +    }
> >      return;
> >  
> >  err:
> > diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> > index df242a0..09586f4 100644
> > --- a/include/hw/pci/pcie_port.h
> > +++ b/include/hw/pci/pcie_port.h
> > @@ -78,6 +78,7 @@ typedef struct PCIERootPortClass {
> >      int exp_offset;
> >      int aer_offset;
> >      int ssvid_offset;
> > +    int acs_offset;    /* If nonzero, optional ACS capability offset */
> >      int ssid;
> >  } PCIERootPortClass;
> >  
> 
