Received: from eggs.gnu.org ([209.51.188.92]:41428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNzO-0005Ji-GE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:15:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1gmNzN-0001KV-Kb
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:15:06 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1gmNzN-0001Jo-BY
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 14:15:05 -0500
Message-ID: <ece0262cacd5e1f5bb25f58f9abdf4a3788ee0fd.camel@oracle.com>
From: Knut Omang <knut.omang@oracle.com>
Date: Wed, 23 Jan 2019 20:14:56 +0100
In-Reply-To: <20190123120438.2d47e352@w520.home>
References: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
	<1062e3d54121ff3e19b5a4e821ae178c5387fd9a.1548266832.git-series.knut.omang@oracle.com>
	<20190123120438.2d47e352@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] gen_pcie_root_port: Add ACS (Access
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tal Attaly <talat@mellanox.com>, Elijah Shakkour <elijahs@mellanox.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, 2019-01-23 at 12:04 -0700, Alex Williamson wrote:
> On Wed, 23 Jan 2019 19:28:00 +0100
> Knut Omang <knut.omang@oracle.com> wrote:
> 
> > Claiming ACS support allows passthrough of an emulated device
> > (in a nested virt.setting) with VFIO without Alex Williamson's patch
> > for the pcie_acs_override kernel parameter.
> > A similar need appears on Windows with Hyper-V
> > 
> > Signed-off-by: Knut Omang <knut.omang@oracle.com>
> > ---
> >  hw/pci-bridge/gen_pcie_root_port.c | 2 ++
> >  hw/pci-bridge/ioh3420.c            | 1 -
> >  hw/pci-bridge/pcie_root_port.c     | 3 +++
> >  include/hw/pci/pcie_port.h         | 1 +
> >  4 files changed, 6 insertions(+), 1 deletion(-)
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
> Perhaps (GEN_PCIE_ROOT_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> 
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
> > diff --git a/hw/pci-bridge/ioh3420.c b/hw/pci-bridge/ioh3420.c
> > index 81f2de6..2064939 100644
> > --- a/hw/pci-bridge/ioh3420.c
> > +++ b/hw/pci-bridge/ioh3420.c
> > @@ -71,7 +71,6 @@ static int ioh3420_interrupts_init(PCIDevice *d, Error **errp)
> >      if (rc < 0) {
> >          assert(rc == -ENOTSUP);
> >      }
> > -
> 
> Unrelated

Oops, will fix, thanks.

Knut 

> 
> >      return rc;
> >  }
> >  
> > diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> > index 34ad767..c33a493 100644
> > --- a/hw/pci-bridge/pcie_root_port.c
> > +++ b/hw/pci-bridge/pcie_root_port.c
> > @@ -106,6 +106,9 @@ static void rp_realize(PCIDevice *d, Error **errp)
> >      pcie_aer_root_init(d);
> >      rp_aer_vector_update(d);
> >  
> > +    if (rpc->acs_offset) {
> > +        pcie_acs_init(d, rpc->acs_offset, 0);
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
