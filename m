Received: from eggs.gnu.org ([2001:4830:134:3::10]:45500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfAv2-0007XE-5X
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dfAuy-0003Kv-3j
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dfAux-0003Ke-Q6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:15:56 -0400
Date: Tue, 8 Aug 2017 23:15:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170808231236-mutt-send-email-mst@kernel.org>
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-5-git-send-email-zuban32s@gmail.com>
	<20170808225149-mutt-send-email-mst@kernel.org>
	<CAKSfGUCUhpBi8NxSAW434pxQ_aVA5AHioK8TwCsBGMOt13T0yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKSfGUCUhpBi8NxSAW434pxQ_aVA5AHioK8TwCsBGMOt13T0yg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] hw/pci: add QEMU-specific PCI
 capability to the Generic PCI Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org

On Tue, Aug 08, 2017 at 11:10:58PM +0300, Aleksandr Bezzubikov wrote:
> 2017-08-08 22:54 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
> > On Sat, Aug 05, 2017 at 11:27:37PM +0300, Aleksandr Bezzubikov wrote:
> >> To enable hotplugging of a newly created pcie-pci-bridge,
> >> we need to tell firmware (SeaBIOS in this case)
> >
> > Why SeaBIOS is this case?
> >
> 
> It is the default BIOS for QEMU and therefore it is the best place to
> try out a new feature like this reservation cap.

So "e.g. SeaBIOS" would be more appropriate then.


> >> to reserve
> >> additional buses or IO/MEM/PREF space for pcie-root-port.
> >> Additional bus reservation allows us to hotplug pcie-pci-bridge into this root port.
> >> The number of buses to reserve is provided to the device via a corresponding
> >> property, and to the firmware via new PCI capability.
> >> The properties' default value is -1 to keep default behavior unchanged.
> >>
> >> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> >> ---
> >>  hw/pci-bridge/gen_pcie_root_port.c | 33 +++++++++++++++++++++++++++++++++
> >>  include/hw/pci/pcie_port.h         |  1 +
> >>  2 files changed, 34 insertions(+)
> >>
> >> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> >> index cb694d6..ff8d04c 100644
> >> --- a/hw/pci-bridge/gen_pcie_root_port.c
> >> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> >> @@ -16,6 +16,8 @@
> >>  #include "hw/pci/pcie_port.h"
> >>
> >>  #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
> >> +#define GEN_PCIE_ROOT_PORT(obj) \
> >> +        OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
> >>
> >>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
> >>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
> >> @@ -26,6 +28,12 @@ typedef struct GenPCIERootPort {
> >>      /*< public >*/
> >>
> >>      bool migrate_msix;
> >> +
> >> +    /* additional buses to reserve on firmware init */
> >> +    uint32_t bus_reserve;
> >> +    uint64_t io_reserve;
> >> +    uint64_t mem_reserve;
> >> +    uint64_t pref_reserve;
> >>  } GenPCIERootPort;
> >>
> >>  static uint8_t gen_rp_aer_vector(const PCIDevice *d)
> >> @@ -60,6 +68,23 @@ static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
> >>      return rp->migrate_msix;
> >>  }
> >>
> >> +static void gen_rp_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    PCIDevice *d = PCI_DEVICE(dev);
> >> +    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
> >> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
> >> +
> >> +    rpc->parent_realize(dev, errp);
> >> +
> >> +    int rc = pci_bridge_qemu_reserve_cap_init(d, 0, grp->bus_reserve,
> >> +            grp->io_reserve, grp->mem_reserve, grp->pref_reserve, errp);
> >
> > You have to skip adding this capability by default to avoid
> > breaking migration to/from old QEMU. A simple way to do this is
> > to check whether any have been specified as != -1.
> >
> 
> Agreed, I can't understand how the capability that is brand new
> and unused by another code except mine can break migration.

Any guest-visible behaviour change across the migration boundary
is prohibited. In this case, any code that walks a capability list
while you migrate will end up in the wrong place in config space.


> >> +
> >> +    if (rc < 0) {
> >> +        rpc->parent_class.exit(d);
> >> +        return;
> >> +    }
> >> +}
> >> +
> >>  static const VMStateDescription vmstate_rp_dev = {
> >>      .name = "pcie-root-port",
> >>      .version_id = 1,
> >> @@ -78,6 +103,10 @@ static const VMStateDescription vmstate_rp_dev = {
> >>
> >>  static Property gen_rp_props[] = {
> >>      DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
> >> +    DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort, bus_reserve, -1),
> >> +    DEFINE_PROP_UINT64("io-reserve", GenPCIERootPort, io_reserve, -1),
> >> +    DEFINE_PROP_UINT64("mem-reserve", GenPCIERootPort, mem_reserve, -1),
> >> +    DEFINE_PROP_UINT64("pref-reserve", GenPCIERootPort, pref_reserve, -1),
> >>      DEFINE_PROP_END_OF_LIST()
> >>  };
> >>
> >> @@ -92,6 +121,10 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
> >>      dc->desc = "PCI Express Root Port";
> >>      dc->vmsd = &vmstate_rp_dev;
> >>      dc->props = gen_rp_props;
> >> +
> >> +    rpc->parent_realize = dc->realize;
> >> +    dc->realize = gen_rp_realize;
> >> +
> >>      rpc->aer_vector = gen_rp_aer_vector;
> >>      rpc->interrupts_init = gen_rp_interrupts_init;
> >>      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
> >> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> >> index 1333266..0736014 100644
> >> --- a/include/hw/pci/pcie_port.h
> >> +++ b/include/hw/pci/pcie_port.h
> >> @@ -65,6 +65,7 @@ void pcie_chassis_del_slot(PCIESlot *s);
> >>
> >>  typedef struct PCIERootPortClass {
> >>      PCIDeviceClass parent_class;
> >> +    DeviceRealize parent_realize;
> >>
> >>      uint8_t (*aer_vector)(const PCIDevice *dev);
> >>      int (*interrupts_init)(PCIDevice *dev, Error **errp);
> >> --
> >> 2.7.4
> 
> 
> 
> -- 
> Aleksandr Bezzubikov
