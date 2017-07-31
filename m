Received: from eggs.gnu.org ([2001:4830:134:3::10]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dcFhN-0003is-8c
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dcFhM-00068K-5n
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:45:49 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dcFhL-00067Y-Ov
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:45:48 -0400
Received: by mail-pg0-x243.google.com with SMTP id y192so3570973pgd.1
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 11:45:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d400968a-5164-e3e0-abe9-f93d316c8050@redhat.com>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-5-git-send-email-zuban32s@gmail.com>
	<d400968a-5164-e3e0-abe9-f93d316c8050@redhat.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 31 Jul 2017 21:45:46 +0300
Message-ID: <CAKSfGUDFnjUtEx+-WWq=8bD7XnEYu+xu4VBVgvp-Zf3vFBdAgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] hw/pci: add QEMU-specific PCI
 capability to Generic PCI Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin OConnor <kevin@koconnor.net>, lersek@redhat.com, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <abezzubikov@ispras.ru>

2017-07-31 14:43 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
> On 29/07/2017 2:37, Aleksandr Bezzubikov wrote:
>>
>> From: Aleksandr Bezzubikov <abezzubikov@ispras.ru>
>>
>> To enable hotplugging of a newly created pcie-pci-bridge,
>> we need to tell firmware (SeaBIOS in this case)
>
>
> Not only SeaBIOS, also OVMF - so all guest firmware
>

But it can mislead some users - it will look like
we've already implemented this for SeaBIOS and OVMF both,
but we haven't.

>
>  to reserve
>>
>> additional buses for pcie-root-port, that allows us to
>> hotplug pcie-pci-bridge into this root port.
>> The number of buses to reserve is provided to the device via a
>> corresponding
>> property, and to the firmware via new PCI capability.
>> The property's default value is 0 to keep default behavior unchanged.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   hw/pci-bridge/gen_pcie_root_port.c | 23 +++++++++++++++++++++++
>>   hw/pci-bridge/pcie_root_port.c     |  2 +-
>>   include/hw/pci/pcie_port.h         |  2 ++
>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-bridge/gen_pcie_root_port.c
>> b/hw/pci-bridge/gen_pcie_root_port.c
>> index cb694d6..da3caa1 100644
>> --- a/hw/pci-bridge/gen_pcie_root_port.c
>> +++ b/hw/pci-bridge/gen_pcie_root_port.c
>> @@ -16,6 +16,8 @@
>>   #include "hw/pci/pcie_port.h"
>>     #define TYPE_GEN_PCIE_ROOT_PORT                "pcie-root-port"
>> +#define GEN_PCIE_ROOT_PORT(obj) \
>> +        OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
>>     #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>>   #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>> @@ -26,6 +28,9 @@ typedef struct GenPCIERootPort {
>>       /*< public >*/
>>         bool migrate_msix;
>> +
>> +    /* additional buses to reserve on firmware init */
>> +    uint8_t bus_reserve;
>>   } GenPCIERootPort;
>>     static uint8_t gen_rp_aer_vector(const PCIDevice *d)
>> @@ -60,6 +65,21 @@ static bool gen_rp_test_migrate_msix(void *opaque, int
>> version_id)
>>       return rp->migrate_msix;
>>   }
>>   +static void gen_rp_realize(PCIDevice *d, Error **errp)
>> +{
>> +    rp_realize(d, errp);
>> +    PCIESlot *s = PCIE_SLOT(d);
>> +    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
>> +
>> +    int rc = pci_bridge_qemu_cap_init(d, 0, grp->bus_reserve, 0, 0, 0,
>> errp);
>> +    if (rc < 0) {
>> +        pcie_chassis_del_slot(s);
>> +        pcie_cap_exit(d);
>> +        gen_rp_interrupts_uninit(d);
>> +        pci_bridge_exitfn(d);
>> +    }
>> +}
>> +
>>   static const VMStateDescription vmstate_rp_dev = {
>>       .name = "pcie-root-port",
>>       .version_id = 1,
>> @@ -78,6 +98,7 @@ static const VMStateDescription vmstate_rp_dev = {
>>     static Property gen_rp_props[] = {
>>       DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix,
>> true),
>> +    DEFINE_PROP_UINT8("bus-reserve", GenPCIERootPort, bus_reserve, 0),
>>       DEFINE_PROP_END_OF_LIST()
>>   };
>>   @@ -89,6 +110,8 @@ static void gen_rp_dev_class_init(ObjectClass *klass,
>> void *data)
>>         k->vendor_id = PCI_VENDOR_ID_REDHAT;
>>       k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
>> +    k->realize = gen_rp_realize;
>> +
>>       dc->desc = "PCI Express Root Port";
>>       dc->vmsd = &vmstate_rp_dev;
>>       dc->props = gen_rp_props;
>> diff --git a/hw/pci-bridge/pcie_root_port.c
>> b/hw/pci-bridge/pcie_root_port.c
>> index 4d588cb..2f3bcb1 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -52,7 +52,7 @@ static void rp_reset(DeviceState *qdev)
>>       pci_bridge_disable_base_limit(d);
>>   }
>>   -static void rp_realize(PCIDevice *d, Error **errp)
>> +void rp_realize(PCIDevice *d, Error **errp)
>>   {
>>       PCIEPort *p = PCIE_PORT(d);
>>       PCIESlot *s = PCIE_SLOT(d);
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index 1333266..febd96a 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -63,6 +63,8 @@ void pcie_chassis_del_slot(PCIESlot *s);
>>   #define PCIE_ROOT_PORT_GET_CLASS(obj) \
>>        OBJECT_GET_CLASS(PCIERootPortClass, (obj), TYPE_PCIE_ROOT_PORT)
>>   +void rp_realize(PCIDevice *d, Error **errp);
>
>
> This is not how QEMU re-uses parent's realize function.
> You can grep for "parent_realize" in the project, it
> goes something like this:
>  1. You add  "DeviceRealize parent_realize" to GenPCIERootPort class.
>  2. In class_init you save parent's realize and replace it with
>     your own:
>       grpc->parent_realize = dc->realize;
>       dc->realize = gen_rp_realize;
>  3. In gen_rp_realize call first parent_realize:
>       rpc->parent_realize(dev, errp);
>       - your code here -
>       if (err)
>           rpc-> exit()
>

OK, this is really much more pretty.

> Thanks,
> Marcel
>
>
>> +
>>   typedef struct PCIERootPortClass {
>>       PCIDeviceClass parent_class;
>>
>
>



-- 
Alexander Bezzubikov
