Received: from eggs.gnu.org ([2001:4830:134:3::10]:37431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgB2G-0002RF-4e
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <diana.craciun@nxp.com>) id 1dgB2C-0007DA-Nh
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:35:36 -0400
From: Diana Madalina Craciun <diana.craciun@nxp.com>
Date: Fri, 11 Aug 2017 14:35:28 +0000
Message-ID: <AM3PR04MB0616508E7E868475F181AC18FF890@AM3PR04MB0616.eurprd04.prod.outlook.com>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<1495537965-4187-3-git-send-email-diana.craciun@nxp.com>
	<b58ccac8-06f0-d02d-5f65-c2a8d47c229b@redhat.com>
	<20170731151602.GU4859@toto>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add a unique ID in the virt machine
 to be used as device ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Auger Eric <eric.auger@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Mike Caraman <mike.caraman@nxp.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, Bharat
	Bhushan <bharat.bhushan@nxp.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

Hi Edgar,=0A=
=0A=
On 07/31/2017 06:16 PM, Edgar E. Iglesias wrote:=0A=
> On Wed, Jul 26, 2017 at 02:22:28PM +0200, Auger Eric wrote:=0A=
>> Hi Diana,=0A=
>> On 23/05/2017 13:12, Diana Craciun wrote:=0A=
>>> Device IDs are required by the ARM GICv3 ITS for IRQ remapping.=0A=
>>> Currently, for PCI devices, the requester ID was used as device=0A=
>>> ID in the virt machine. If the system has multiple masters that=0A=
>> if the system has multiple root complex?=0A=
>>> use MSIs a unique ID accross the platform is needed.=0A=
>> across=0A=
>>> A static scheme is used and each master is allocated a range of IDs=0A=
>>> with the formula:=0A=
>>> DeviceID =3D zero_extend( RequesterID[15:0] ) + 0x10000*Constant (as=0A=
>>> recommended by SBSA).=0A=
>>>=0A=
>>> This ID will be configured in the machine creation and if not configure=
d=0A=
>>> the PCI requester ID will be used insteead.=0A=
>> instead=0A=
>>> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>=0A=
>>> ---=0A=
>>>  hw/arm/virt.c              | 26 ++++++++++++++++++++++++++=0A=
>>>  hw/pci-host/gpex.c         |  6 ++++++=0A=
>>>  hw/pci/msi.c               |  2 +-=0A=
>>>  hw/pci/pci.c               | 25 +++++++++++++++++++++++++=0A=
>>>  include/hw/arm/virt.h      |  1 +=0A=
>>>  include/hw/pci-host/gpex.h |  2 ++=0A=
>>>  include/hw/pci/pci.h       |  8 ++++++++=0A=
>>>  kvm-all.c                  |  4 ++--=0A=
>>>  8 files changed, 71 insertions(+), 3 deletions(-)=0A=
>>>=0A=
>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c=0A=
>>> index 5f62a03..a969694 100644=0A=
>>> --- a/hw/arm/virt.c=0A=
>>> +++ b/hw/arm/virt.c=0A=
>>> @@ -110,6 +110,8 @@ static ARMPlatformBusSystemParams platform_bus_para=
ms;=0A=
>>>  #define RAMLIMIT_GB 255=0A=
>>>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)=0A=
>>>  =0A=
>>> +#define STREAM_ID_RANGE_SIZE 0x10000=0A=
>>> +=0A=
>>>  /* Addresses and sizes of our components.=0A=
>>>   * 0..128MB is space for a flash device so we can run bootrom code suc=
h as UEFI.=0A=
>>>   * 128MB..256MB is used for miscellaneous device I/O.=0A=
>>> @@ -162,6 +164,22 @@ static const int a15irqmap[] =3D {=0A=
>>>      [VIRT_PLATFORM_BUS] =3D 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS =
-1 */=0A=
>>>  };=0A=
>>>  =0A=
>>> +/* Device IDs are required by the ARM GICV3 ITS for IRQ remapping. Cur=
rently=0A=
>>> + * for PCI devices the requester ID was used as device ID. But if the =
system has=0A=
>>> + * multiple masters that use MSIs, the requester ID may cause deviceID=
 clashes.=0A=
>>> + * So a unique number is  needed accross the system.=0A=
>>> + * We are using the following formula:=0A=
>>> + * DeviceID =3D zero_extend( RequesterID[15:0] ) + 0x10000*Constant=0A=
>>> + * (as recommanded by SBSA). Currently we do not have an SMMU emulatio=
n, but the=0A=
>>> + * same formula can be used for the generation of the streamID as well=
.=0A=
>>> + * For each master the device ID will be derrived from the requester I=
D using=0A=
>>> + * the abovemntione formula.=0A=
>>> + */=0A=
>> I think most of this comment should only be in the commit message. typos=
=0A=
>> in derived and above mentioned.=0A=
>>=0A=
>> stream id is the terminology for the id space at the input of the smmu.=
=0A=
>> device id is the terminology for the id space at the input of the msi=0A=
>> controller I think.=0A=
>>=0A=
>> RID -> deviceID (no IOMMU)=0A=
>> RID -> streamID -> deviceID (IOMMU)=0A=
>>=0A=
>> I would personally get rid of all streamid uses as the smmu is not yet=
=0A=
>> supported and stick to the=0A=
>> Documentation/devicetree/bindings/pci/pci-msi.txt terminology?=0A=
>>=0A=
>>> +=0A=
>>> +static const uint32_t streamidmap[] =3D {=0A=
>>> +    [VIRT_PCIE] =3D 0,         /* currently only one PCI controller */=
=0A=
>>> +};=0A=
>>> +=0A=
>>>  static const char *valid_cpus[] =3D {=0A=
>>>      "cortex-a15",=0A=
>>>      "cortex-a53",=0A=
>>> @@ -980,6 +998,7 @@ static void create_pcie(const VirtMachineState *vms=
, qemu_irq *pic)=0A=
>>>      hwaddr base_ecam =3D vms->memmap[VIRT_PCIE_ECAM].base;=0A=
>>>      hwaddr size_ecam =3D vms->memmap[VIRT_PCIE_ECAM].size;=0A=
>>>      hwaddr base =3D base_mmio;=0A=
>>> +    uint32_t stream_id =3D vms->streamidmap[VIRT_PCIE] * STREAM_ID_RAN=
GE_SIZE;=0A=
>> msi-base?=0A=
>> STREAM_ID_RANGE_SIZE ~ MSI_MAP_LENGTH?=0A=
>>>      int nr_pcie_buses =3D size_ecam / PCIE_MMCFG_SIZE_MIN;=0A=
>>>      int irq =3D vms->irqmap[VIRT_PCIE];=0A=
>>>      MemoryRegion *mmio_alias;=0A=
>>> @@ -992,6 +1011,7 @@ static void create_pcie(const VirtMachineState *vm=
s, qemu_irq *pic)=0A=
>>>      PCIHostState *pci;=0A=
>>>  =0A=
>>>      dev =3D qdev_create(NULL, TYPE_GPEX_HOST);=0A=
>>> +    qdev_prop_set_uint32(dev, "stream-id-base", stream_id);=0A=
>>>      qdev_init_nofail(dev);=0A=
>>>  =0A=
>>>      /* Map only the first size_ecam bytes of ECAM space */=0A=
>>> @@ -1056,6 +1076,11 @@ static void create_pcie(const VirtMachineState *=
vms, qemu_irq *pic)=0A=
>>>      if (vms->msi_phandle) {=0A=
>>>          qemu_fdt_setprop_cells(vms->fdt, nodename, "msi-parent",=0A=
>>>                                 vms->msi_phandle);=0A=
>>> +        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "msi-map",=0A=
>>> +                                     1, 0,=0A=
>>> +                                     1, vms->msi_phandle,=0A=
>>> +                                     1, stream_id,=0A=
>>> +                                     1, STREAM_ID_RANGE_SIZE);=0A=
>>>      }=0A=
>>>  =0A=
>>>      qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",=0A=
>>> @@ -1609,6 +1634,7 @@ static void virt_2_9_instance_init(Object *obj)=
=0A=
>>>  =0A=
>>>      vms->memmap =3D a15memmap;=0A=
>>>      vms->irqmap =3D a15irqmap;=0A=
>>> +    vms->streamidmap =3D streamidmap;=0A=
>>>  }=0A=
>>>  =0A=
>>>  static void virt_machine_2_9_options(MachineClass *mc)=0A=
>>> diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c=0A=
>>> index 66055ee..de72408 100644=0A=
>>> --- a/hw/pci-host/gpex.c=0A=
>>> +++ b/hw/pci-host/gpex.c=0A=
>>> @@ -43,6 +43,11 @@ static void gpex_set_irq(void *opaque, int irq_num, =
int level)=0A=
>>>      qemu_set_irq(s->irq[irq_num], level);=0A=
>>>  }=0A=
>>>  =0A=
>>> +static Property gpex_props[] =3D {=0A=
>>> +    DEFINE_PROP_UINT32("stream-id-base", GPEXHost, stream_id_base, 0),=
=0A=
>> msi_base_base=0A=
>>> +    DEFINE_PROP_END_OF_LIST(),=0A=
>>> +};=0A=
>>> +=0A=
>>>  static void gpex_host_realize(DeviceState *dev, Error **errp)=0A=
>>>  {=0A=
>>>      PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);=0A=
>>> @@ -83,6 +88,7 @@ static void gpex_host_class_init(ObjectClass *klass, =
void *data)=0A=
>>>  =0A=
>>>      hc->root_bus_path =3D gpex_host_root_bus_path;=0A=
>>>      dc->realize =3D gpex_host_realize;=0A=
>>> +    dc->props =3D gpex_props;=0A=
>>>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);=0A=
>>>      dc->fw_name =3D "pci";=0A=
>>>  }=0A=
>>> diff --git a/hw/pci/msi.c b/hw/pci/msi.c=0A=
>>> index 7925851..b60a410 100644=0A=
>>> --- a/hw/pci/msi.c=0A=
>>> +++ b/hw/pci/msi.c=0A=
>>> @@ -336,7 +336,7 @@ void msi_send_message(PCIDevice *dev, MSIMessage ms=
g)=0A=
>>>  {=0A=
>>>      MemTxAttrs attrs =3D {};=0A=
>>>  =0A=
>>> -    attrs.stream_id =3D pci_requester_id(dev);=0A=
>>> +    attrs.stream_id =3D pci_stream_id(dev);=0A=
>>>      address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,=
=0A=
>>>                           attrs, NULL);=0A=
>>>  }=0A=
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c=0A=
>>> index 259483b..92e9a2b 100644=0A=
>>> --- a/hw/pci/pci.c=0A=
>>> +++ b/hw/pci/pci.c=0A=
>>> @@ -951,6 +951,30 @@ uint16_t pci_requester_id(PCIDevice *dev)=0A=
>>>      return pci_req_id_cache_extract(&dev->requester_id_cache);=0A=
>>>  }=0A=
>>>  =0A=
>>> +static uint32_t pci_get_stream_id_base(PCIDevice *dev)=0A=
>>> +{=0A=
>>> +    PCIBus *rootbus =3D pci_device_root_bus(dev);=0A=
>>> +    PCIHostState *host_bridge =3D PCI_HOST_BRIDGE(rootbus->qbus.parent=
);=0A=
>>> +    Error *err =3D NULL;=0A=
>>> +    int64_t stream_id;=0A=
>>> +=0A=
>>> +    stream_id =3D object_property_get_int(OBJECT(host_bridge), "stream=
-id-base",=0A=
>>> +                                        &err);=0A=
>>> +    if (stream_id < 0) {=0A=
>>> +        stream_id =3D 0;=0A=
>>> +    }=0A=
>>> +=0A=
>>> +    return stream_id;=0A=
>>> +}=0A=
>>> +=0A=
>>> +uint32_t pci_stream_id(PCIDevice *dev)=0A=
>>> +{=0A=
>>> +    /* Stream ID =3D RequesterID[15:0] + stream_id_base. stream_id_bas=
e may=0A=
>>> +     * be 0 for devices that are not using any translation between req=
uester_id=0A=
>>> +     * and stream_id */=0A=
>>> +    return  (uint16_t)pci_requester_id(dev) + dev->stream_id_base;=0A=
>>> +}=0A=
>> I think you should split the changes in virt from pci/gpex generic chang=
es.=0A=
>>=0A=
>>> +=0A=
>>>  /* -1 for devfn means auto assign */=0A=
>>>  static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *b=
us,=0A=
>>>                                           const char *name, int devfn,=
=0A=
>>> @@ -1000,6 +1024,7 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,=0A=
>>>  =0A=
>>>      pci_dev->devfn =3D devfn;=0A=
>>>      pci_dev->requester_id_cache =3D pci_req_id_cache_get(pci_dev);=0A=
>>> +    pci_dev->stream_id_base =3D pci_get_stream_id_base(pci_dev);=0A=
>> looks strange to me to store the rid base in the end point as this is=0A=
>> rather a property of the PCI complex. I acknowledge this is much more=0A=
> I agree.=0A=
=0A=
The reason I have changed was to avoid traversing the entire hierarchy=0A=
each time the ID is needed (for example each time when a MSI is sent).=0A=
=0A=
> I think that what we need is to add support for allowing PCI RCs=0A=
> to transform requesterIDs in transactions attributes according to the=0A=
> implementation specifics.=0A=
=0A=
Do you mean that you need more than a linear offset between requesterID=0A=
and whatever other ID?=0A=
=0A=
>=0A=
> The way we did it when modelling the ZynqMP is by adding support for=0A=
> transaction attribute translation in QEMU's IOMMU interface.=0A=
> In our PCI RC, we have an IOMMU covering the entire AS that PCI devs DMA =
into.=0A=
> This IOMMU doesn't do address-translation, only RequesterID -> StreamID=
=0A=
> transforms according to how the ZynqMP PCI RC derives StreamIDs from Requ=
esterIDs.=0A=
=0A=
Are there any patches for this support in order for me to better understand=
?=0A=
=0A=
Thanks,=0A=
=0A=
Diana=0A=
=0A=
=0A=
> This is useful not only to model PCI RequesterID to AXI Master ID mapping=
s but=0A=
> also for modelling things like the ARM TZC (or the Xilinx ZynqMP XMPU/XPP=
Us).=0A=
>=0A=
> Cheers,=0A=
> Edgar=0A=
>=0A=
>=0A=
>> simple than reworking pci_requester_id() though.=0A=
>>>  =0A=
>>>      memory_region_init(&pci_dev->bus_master_container_region, OBJECT(p=
ci_dev),=0A=
>>>                         "bus master container", UINT64_MAX);=0A=
>>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h=0A=
>>> index 33b0ff3..94c007a 100644=0A=
>>> --- a/include/hw/arm/virt.h=0A=
>>> +++ b/include/hw/arm/virt.h=0A=
>>> @@ -99,6 +99,7 @@ typedef struct {=0A=
>>>      struct arm_boot_info bootinfo;=0A=
>>>      const MemMapEntry *memmap;=0A=
>>>      const int *irqmap;=0A=
>>> +    const uint32_t *streamidmap;=0A=
>>>      int smp_cpus;=0A=
>>>      void *fdt;=0A=
>>>      int fdt_size;=0A=
>>> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h=0A=
>>> index 68c9348..47df01a 100644=0A=
>>> --- a/include/hw/pci-host/gpex.h=0A=
>>> +++ b/include/hw/pci-host/gpex.h=0A=
>>> @@ -48,6 +48,8 @@ typedef struct GPEXHost {=0A=
>>>  =0A=
>>>      GPEXRootState gpex_root;=0A=
>>>  =0A=
>>> +    uint32_t stream_id_base;=0A=
>>> +=0A=
>>>      MemoryRegion io_ioport;=0A=
>>>      MemoryRegion io_mmio;=0A=
>>>      qemu_irq irq[GPEX_NUM_IRQS];=0A=
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h=0A=
>>> index a37a2d5..e6e9334 100644=0A=
>>> --- a/include/hw/pci/pci.h=0A=
>>> +++ b/include/hw/pci/pci.h=0A=
>>> @@ -283,6 +283,12 @@ struct PCIDevice {=0A=
>>>       * MSI). For conventional PCI root complex, this field is=0A=
>>>       * meaningless. */=0A=
>>>      PCIReqIDCache requester_id_cache;=0A=
>>> +    /* Some platforms need a unique ID for IOMMU source identification=
=0A=
>>> +     * or MSI source identification. QEMU implements a simple scheme:=
=0A=
>>> +     * stream_id =3D  stream_id_base + requester_id. The stream_id_bas=
e will=0A=
>>> +     * ensure that all the devices in the system have different stream=
 ID=0A=
>>> +     * domains */=0A=
>>> +    uint32_t stream_id_base;=0A=
>> get rid of IOMMU terminology?=0A=
>>=0A=
>> Note that when adding other sub-systems you will need to address the=0A=
>> ACPI side as the IORT table built by hw/arm/virt-acpi-build.c currently=
=0A=
>> defines an RID mapping for the single root complex.=0A=
>>=0A=
>> Thanks=0A=
>>=0A=
>> Eric=0A=
>>>      char name[64];=0A=
>>>      PCIIORegion io_regions[PCI_NUM_REGIONS];=0A=
>>>      AddressSpace bus_master_as;=0A=
>>> @@ -737,6 +743,8 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)=
=0A=
>>>  =0A=
>>>  uint16_t pci_requester_id(PCIDevice *dev);=0A=
>>>  =0A=
>>> +uint32_t pci_stream_id(PCIDevice *dev);=0A=
>>> +=0A=
>>>  /* DMA access functions */=0A=
>>>  static inline AddressSpace *pci_get_address_space(PCIDevice *dev)=0A=
>>>  {=0A=
>>> diff --git a/kvm-all.c b/kvm-all.c=0A=
>>> index 90b8573..5a508c3 100644=0A=
>>> --- a/kvm-all.c=0A=
>>> +++ b/kvm-all.c=0A=
>>> @@ -1280,7 +1280,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int ve=
ctor, PCIDevice *dev)=0A=
>>>      kroute.u.msi.data =3D le32_to_cpu(msg.data);=0A=
>>>      if (kvm_msi_devid_required()) {=0A=
>>>          kroute.flags =3D KVM_MSI_VALID_DEVID;=0A=
>>> -        kroute.u.msi.devid =3D pci_requester_id(dev);=0A=
>>> +        kroute.u.msi.devid =3D pci_stream_id(dev);=0A=
>>>      }=0A=
>>>      if (kvm_arch_fixup_msi_route(&kroute, msg.address, msg.data, dev))=
 {=0A=
>>>          kvm_irqchip_release_virq(s, virq);=0A=
>>> @@ -1317,7 +1317,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int=
 virq, MSIMessage msg,=0A=
>>>      kroute.u.msi.data =3D le32_to_cpu(msg.data);=0A=
>>>      if (kvm_msi_devid_required()) {=0A=
>>>          kroute.flags =3D KVM_MSI_VALID_DEVID;=0A=
>>> -        kroute.u.msi.devid =3D pci_requester_id(dev);=0A=
>>> +        kroute.u.msi.devid =3D pci_stream_id(dev);=0A=
>>>      }=0A=
>>>      if (kvm_arch_fixup_msi_route(&kroute, msg.address, msg.data, dev))=
 {=0A=
>>>          return -EINVAL;=0A=
>>>=0A=
=0A=
