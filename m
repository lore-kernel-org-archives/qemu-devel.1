Received: from eggs.gnu.org ([2001:4830:134:3::10]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1delIL-00033l-B6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1delIF-00006v-KC
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1delIF-00006b-A9
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 12:54:15 -0400
References: <1501964858-5159-1-git-send-email-zuban32s@gmail.com>
	<1501964858-5159-3-git-send-email-zuban32s@gmail.com>
	<da985ed6-f3ae-3767-6bc5-ec9e72701df0@redhat.com>
	<CAKSfGUBPWqUnWkUdJxDj5ih=uZpXdgoXiixrn-VvbhE3W8mGMg@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bdb9d7ce-d88f-1082-cb1e-0ad28bc9fc45@redhat.com>
Date: Mon, 7 Aug 2017 19:54:07 +0300
MIME-Version: 1.0
In-Reply-To: <CAKSfGUBPWqUnWkUdJxDj5ih=uZpXdgoXiixrn-VvbhE3W8mGMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/5] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org

On 07/08/2017 19:42, Alexander Bezzubikov wrote:
> 2017-08-07 19:39 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
>> On 05/08/2017 23:27, Aleksandr Bezzubikov wrote:
>>>
>>> Introduce a new PCIExpress-to-PCI Bridge device,
>>> which is a hot-pluggable PCI Express device and
>>> supports devices hot-plug with SHPC.
>>>
>>
>>
>> Hi Aleksandr,
>>
>>> This device is intended to replace the DMI-to-PCI
>>> Bridge in an overwhelming majority of use-cases.
>>
>>
>> Please drop the last line ( ... majority...)
>> It simply replaces it.
>>
>>
>>
>>
>>
>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>> ---
>>>    hw/pci-bridge/Makefile.objs     |   2 +-
>>>    hw/pci-bridge/pcie_pci_bridge.c | 212
>>> ++++++++++++++++++++++++++++++++++++++++
>>>    include/hw/pci/pci.h            |   1 +
>>>    3 files changed, 214 insertions(+), 1 deletion(-)
>>>    create mode 100644 hw/pci-bridge/pcie_pci_bridge.c
>>>
>>> diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
>>> index c4683cf..666db37 100644
>>> --- a/hw/pci-bridge/Makefile.objs
>>> +++ b/hw/pci-bridge/Makefile.objs
>>> @@ -1,4 +1,4 @@
>>> -common-obj-y += pci_bridge_dev.o
>>> +common-obj-y += pci_bridge_dev.o pcie_pci_bridge.o
>>>    common-obj-$(CONFIG_PCIE_PORT) += pcie_root_port.o gen_pcie_root_port.o
>>>    common-obj-$(CONFIG_PXB) += pci_expander_bridge.o
>>>    common-obj-$(CONFIG_XIO3130) += xio3130_upstream.o xio3130_downstream.o
>>> diff --git a/hw/pci-bridge/pcie_pci_bridge.c
>>> b/hw/pci-bridge/pcie_pci_bridge.c
>>> new file mode 100644
>>> index 0000000..4127725
>>> --- /dev/null
>>> +++ b/hw/pci-bridge/pcie_pci_bridge.c
>>> @@ -0,0 +1,212 @@
>>> +/*
>>> + * QEMU Generic PCIE-PCI Bridge
>>> + *
>>> + * Copyright (c) 2017 Aleksandr Bezzubikov
>>> + *
>>
>>
>> Please replace the below license with:
>>
>> " This work is licensed under the terms of the GNU GPL, version 2
>>    or later. See the COPYING file in the top-level directory."
>>
>> to be sure it matches QEMU's license.
>>
>>
>>
>>> + * Permission is hereby granted, free of charge, to any person obtaining
>>> a copy
>>> + * of this software and associated documentation files (the "Software"),
>>> to deal
>>> + * in the Software without restriction, including without limitation the
>>> rights
>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
>>> sell
>>> + * copies of the Software, and to permit persons to whom the Software is
>>> + * furnished to do so, subject to the following conditions:
>>> + *
>>> + * The above copyright notice and this permission notice shall be
>>> included in
>>> + * all copies or substantial portions of the Software.
>>> + *
>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> EXPRESS OR
>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>> MERCHANTABILITY,
>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
>>> SHALL
>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
>>> OTHER
>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>>> ARISING FROM,
>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>>> IN
>>> + * THE SOFTWARE.
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/pci/pci.h"
>>> +#include "hw/pci/pci_bus.h"
>>> +#include "hw/pci/pci_bridge.h"
>>> +#include "hw/pci/msi.h"
>>> +#include "hw/pci/shpc.h"
>>> +#include "hw/pci/slotid_cap.h"
>>> +
>>> +typedef struct PCIEPCIBridge {
>>> +    /*< private >*/
>>> +    PCIBridge parent_obj;
>>> +
>>> +    OnOffAuto msi;
>>> +    MemoryRegion shpc_bar;
>>> +    /*< public >*/
>>> +} PCIEPCIBridge;
>>> +
>>> +#define TYPE_PCIE_PCI_BRIDGE_DEV      "pcie-pci-bridge"
>>> +#define PCIE_PCI_BRIDGE_DEV(obj) \
>>> +        OBJECT_CHECK(PCIEPCIBridge, (obj), TYPE_PCIE_PCI_BRIDGE_DEV)
>>> +
>>> +static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
>>> +{
>>> +    PCIBridge *br = PCI_BRIDGE(d);
>>> +    PCIEPCIBridge *pcie_br = PCIE_PCI_BRIDGE_DEV(d);
>>> +    int rc, pos;
>>> +
>>> +    pci_bridge_initfn(d, TYPE_PCI_BUS);
>>> +
>>> +    d->config[PCI_INTERRUPT_PIN] = 0x1;
>>> +    memory_region_init(&pcie_br->shpc_bar, OBJECT(d), "shpc-bar",
>>> +                       shpc_bar_size(d));
>>> +    rc = shpc_init(d, &br->sec_bus, &pcie_br->shpc_bar, 0, errp);
>>> +    if (rc) {
>>> +        goto error;
>>> +    }
>>> +
>>> +    rc = pcie_cap_init(d, 0, PCI_EXP_TYPE_PCI_BRIDGE, 0, errp);
>>> +    if (rc < 0) {
>>> +        goto cap_error;
>>> +    }
>>> +
>>> +    pos = pci_add_capability(d, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF, errp);
>>> +    if (pos < 0) {
>>> +        goto pm_error;
>>> +    }
>>> +    d->exp.pm_cap = pos;
>>> +    pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
>>> +
>>> +    pcie_cap_arifwd_init(d);
>>> +    pcie_cap_deverr_init(d);
>>> +
>>> +    rc = pcie_aer_init(d, PCI_ERR_VER, 0x100, PCI_ERR_SIZEOF, errp);
>>> +    if (rc < 0) {
>>> +        goto aer_error;
>>> +    }
>>> +
>>> +    if (pcie_br->msi != ON_OFF_AUTO_OFF) {
>>> +        rc = msi_init(d, 0, 1, true, true, errp);
>>> +        if (rc < 0) {
>>> +            goto msi_error;
>>> +        }
>>> +    }
>>> +    pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>>> +                     PCI_BASE_ADDRESS_MEM_TYPE_64, &pcie_br->shpc_bar);
>>> +    return;
>>> +
>>> +msi_error:
>>> +    pcie_aer_exit(d);
>>> +aer_error:
>>> +pm_error:
>>> +    pcie_cap_exit(d);
>>> +cap_error:
>>> +    shpc_free(d);
>>> +error:
>>> +    pci_bridge_exitfn(d);
>>> +}
>>> +
>>> +static void pcie_pci_bridge_exit(PCIDevice *d)
>>> +{
>>> +    PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
>>> +    pcie_cap_exit(d);
>>> +    shpc_cleanup(d, &bridge_dev->shpc_bar);
>>> +    pci_bridge_exitfn(d);
>>> +}
>>> +
>>> +static void pcie_pci_bridge_reset(DeviceState *qdev)
>>> +{
>>> +    PCIDevice *d = PCI_DEVICE(qdev);
>>> +    pci_bridge_reset(qdev);
>>> +    msi_reset(d);
>>> +    shpc_reset(d);
>>> +}
>>> +
>>> +static void pcie_pci_bridge_write_config(PCIDevice *d,
>>> +        uint32_t address, uint32_t val, int len)
>>> +{
>>> +    pci_bridge_write_config(d, address, val, len);
>>> +    msi_write_config(d, address, val, len);
>>> +    shpc_cap_write_config(d, address, val, len);
>>> +}
>>> +
>>> +static Property pcie_pci_bridge_dev_properties[] = {
>>> +        DEFINE_PROP_ON_OFF_AUTO("msi", PCIEPCIBridge, msi,
>>> ON_OFF_AUTO_ON),
>>> +        DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static bool pcie_pci_bridge_shpc_present(void *opaque, int version_id)
>>> +{
>>> +    return true;
>>> +}
>>
>>
>> Already commented on this, you don't need the shpc
>> present check, it is always there (you don't have code to disable
>> it).
>>
>> Please check previous comments before posting a new version.
>> It makes it hard to follow.
> 
> I've seen it, and in the cover letter I've posted the reason why I still
> have this function - SHPC_VMSTATE takes function as the third arg,
> so either I refactor SHPC_VMSTATE (and all its usages, and it needs
> new SHPC_VMSTATE and SHPC_VMSTATE_TEST macros) or
> I leave it as it is.
> 

You can just pass NULL to SHPC_VMSTATE
instead of a function that returns TRUE


Sorry for not paying attention.
Thanks,
Marcel




>>
>> Thanks,
>> Marcel
>>
>>
>>> +
>>> +static const VMStateDescription pcie_pci_bridge_dev_vmstate = {
>>> +        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
>>> +        .fields = (VMStateField[]) {
>>> +            VMSTATE_PCI_DEVICE(parent_obj, PCIBridge),
>>> +            SHPC_VMSTATE(shpc, PCIDevice, pcie_pci_bridge_shpc_present),
>>> +            VMSTATE_END_OF_LIST()
>>> +        }
>>> +};
>>> +
>>> +static void pcie_pci_bridge_hotplug_cb(HotplugHandler *hotplug_dev,
>>> +                                      DeviceState *dev, Error **errp)
>>> +{
>>> +    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>>> +
>>> +    if (!shpc_present(pci_hotplug_dev)) {
>>> +        error_setg(errp, "standard hotplug controller has been disabled
>>> for "
>>> +                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>>> +        return;
>>> +    }
>>> +    shpc_device_hotplug_cb(hotplug_dev, dev, errp);
>>> +}
>>> +
>>> +static void pcie_pci_bridge_hot_unplug_request_cb(HotplugHandler
>>> *hotplug_dev,
>>> +                                                 DeviceState *dev,
>>> +                                                 Error **errp)
>>> +{
>>> +    PCIDevice *pci_hotplug_dev = PCI_DEVICE(hotplug_dev);
>>> +
>>> +    if (!shpc_present(pci_hotplug_dev)) {
>>> +        error_setg(errp, "standard hotplug controller has been disabled
>>> for "
>>> +                   "this %s", TYPE_PCIE_PCI_BRIDGE_DEV);
>>> +        return;
>>> +    }
>>> +    shpc_device_hot_unplug_request_cb(hotplug_dev, dev, errp);
>>> +}
>>> +
>>> +static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>>> +
>>> +    k->is_express = 1;
>>> +    k->is_bridge = 1;
>>> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
>>> +    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
>>> +    k->realize = pcie_pci_bridge_realize;
>>> +    k->exit = pcie_pci_bridge_exit;
>>> +    k->config_write = pcie_pci_bridge_write_config;
>>> +    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
>>> +    dc->props = pcie_pci_bridge_dev_properties;
>>> +    dc->vmsd = &pcie_pci_bridge_dev_vmstate;
>>> +    dc->reset = &pcie_pci_bridge_reset;
>>> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>> +    hc->plug = pcie_pci_bridge_hotplug_cb;
>>> +    hc->unplug_request = pcie_pci_bridge_hot_unplug_request_cb;
>>> +}
>>> +
>>> +static const TypeInfo pcie_pci_bridge_info = {
>>> +        .name = TYPE_PCIE_PCI_BRIDGE_DEV,
>>> +        .parent = TYPE_PCI_BRIDGE,
>>> +        .instance_size = sizeof(PCIEPCIBridge),
>>> +        .class_init = pcie_pci_bridge_class_init,
>>> +        .interfaces = (InterfaceInfo[]) {
>>> +            { TYPE_HOTPLUG_HANDLER },
>>> +            { },
>>> +        }
>>> +};
>>> +
>>> +static void pciepci_register(void)
>>> +{
>>> +    type_register_static(&pcie_pci_bridge_info);
>>> +}
>>> +
>>> +type_init(pciepci_register);
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index e598b09..b33a34f 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -98,6 +98,7 @@
>>>    #define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
>>>    #define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
>>>    #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
>>> +#define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
>>>    #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>>>      #define FMT_PCIBUS                      PRIx64
>>>
>>
> 
> 
> 
