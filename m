Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPIru-0005sz-OW
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPIrq-0001WV-4K
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:31:10 -0400
Received: from [59.151.112.132] (port=25284 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dPIrp-0001Pp-6R
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 21:31:06 -0400
References: <d60b5927063e257e3414864b1ee6c569ac61b712.1497957189.git.maozy.fnst@cn.fujitsu.com>
	<971cab75a0b4e011a18de8afb0ed4eedb7810eb6.1498116042.git.maozy.fnst@cn.fujitsu.com>
	<d2663895-14c6-759b-930f-9f7a295723a7@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <5224fb14-0b9e-4ec0-6038-1b42b3d725a2@cn.fujitsu.com>
Date: Mon, 26 Jun 2017 09:30:42 +0800
MIME-Version: 1.0
In-Reply-To: <d2663895-14c6-759b-930f-9f7a295723a7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 7/9] pci: Convert shpc_init() to Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com



On 06/23/2017 05:56 PM, Marcel Apfelbaum wrote:
> On 22/06/2017 11:14, Mao Zhongyi wrote:
>> In order to propagate error message better, convert shpc_init() to
>> Error also convert the pci_bridge_dev_initfn() to realize.
>>
>> Cc: mst@redhat.com
>> Cc: marcel@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>> v7:
>> * drop the !local_err assert is really not appropriate,
>>    now revert it.            [Marcel Apfelbaum]
>>
>>   hw/pci-bridge/pci_bridge_dev.c | 14 ++++++--------
>>   hw/pci/shpc.c                  | 11 +++++------
>>   hw/pci/slotid_cap.c            | 11 +++++------
>>   include/hw/pci/shpc.h          |  3 ++-
>>   include/hw/pci/slotid_cap.h    |  3 ++-
>>   5 files changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
>> index 5dbd933..4373f1d 100644
>> --- a/hw/pci-bridge/pci_bridge_dev.c
>> +++ b/hw/pci-bridge/pci_bridge_dev.c
>> @@ -49,7 +49,7 @@ struct PCIBridgeDev {
>>   };
>>   typedef struct PCIBridgeDev PCIBridgeDev;
>>   -static int pci_bridge_dev_initfn(PCIDevice *dev)
>> +static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>>   {
>>       PCIBridge *br = PCI_BRIDGE(dev);
>>       PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
>> @@ -62,7 +62,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>           dev->config[PCI_INTERRUPT_PIN] = 0x1;
>>           memory_region_init(&bridge_dev->bar, OBJECT(dev), "shpc-bar",
>>                              shpc_bar_size(dev));
>> -        err = shpc_init(dev, &br->sec_bus, &bridge_dev->bar, 0);
>> +        err = shpc_init(dev, &br->sec_bus, &bridge_dev->bar, 0, errp);
>>           if (err) {
>>               goto shpc_error;
>>           }
>> @@ -71,7 +71,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>           bridge_dev->msi = ON_OFF_AUTO_OFF;
>>       }
>>   -    err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0);
>> +    err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
>>       if (err) {
>>           goto slotid_error;
>>       }
>> @@ -87,7 +87,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>               /* Can't satisfy user's explicit msi=on request, fail */
>>               error_append_hint(&local_err, "You have to use msi=auto (default) "
>>                       "or msi=off with this machine type.\n");
>> -            error_report_err(local_err);
>> +            error_propagate(errp, local_err);
>>               goto msi_error;
>>           }
>>           assert(!local_err || bridge_dev->msi == ON_OFF_AUTO_AUTO);
>> @@ -101,7 +101,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>           pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>>                            PCI_BASE_ADDRESS_MEM_TYPE_64, &bridge_dev->bar);
>>       }
>> -    return 0;
>> +    return;
>>     msi_error:
>>       slotid_cap_cleanup(dev);
>> @@ -111,8 +111,6 @@ slotid_error:
>>       }
>>   shpc_error:
>>       pci_bridge_exitfn(dev);
>> -
>> -    return err;
>>   }
>>     static void pci_bridge_dev_exitfn(PCIDevice *dev)
>> @@ -216,7 +214,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>>   -    k->init = pci_bridge_dev_initfn;
>> +    k->realize = pci_bridge_dev_realize;
>>       k->exit = pci_bridge_dev_exitfn;
>>       k->config_write = pci_bridge_dev_write_config;
>>       k->vendor_id = PCI_VENDOR_ID_REDHAT;
>> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
>> index d72d5e4..69fc14b 100644
>> --- a/hw/pci/shpc.c
>> +++ b/hw/pci/shpc.c
>> @@ -446,16 +446,14 @@ static void shpc_cap_update_dword(PCIDevice *d)
>>   }
>>     /* Add SHPC capability to the config space for the device. */
>> -static int shpc_cap_add_config(PCIDevice *d)
>> +static int shpc_cap_add_config(PCIDevice *d, Error **errp)
>>   {
>>       uint8_t *config;
>>       int config_offset;
>> -    Error *local_err = NULL;
>>       config_offset = pci_add_capability(d, PCI_CAP_ID_SHPC,
>>                                          0, SHPC_CAP_LENGTH,
>> -                                       &local_err);
>> +                                       errp);
>>       if (config_offset < 0) {
>> -        error_report_err(local_err);
>>           return config_offset;
>>       }
>>       config = d->config + config_offset;
>> @@ -584,13 +582,14 @@ void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>   }
>>     /* Initialize the SHPC structure in bridge's BAR. */
>> -int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar, unsigned offset)
>> +int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
>> +              unsigned offset, Error **errp)
>>   {
>>       int i, ret;
>>       int nslots = SHPC_MAX_SLOTS; /* TODO: qdev property? */
>>       SHPCDevice *shpc = d->shpc = g_malloc0(sizeof(*d->shpc));
>>       shpc->sec_bus = sec_bus;
>> -    ret = shpc_cap_add_config(d);
>> +    ret = shpc_cap_add_config(d, errp);
>>       if (ret) {
>>           g_free(d->shpc);
>>           return ret;
>> diff --git a/hw/pci/slotid_cap.c b/hw/pci/slotid_cap.c
>> index bdca205..36d021b 100644
>> --- a/hw/pci/slotid_cap.c
>> +++ b/hw/pci/slotid_cap.c
>> @@ -9,14 +9,14 @@
>>     int slotid_cap_init(PCIDevice *d, int nslots,
>>                       uint8_t chassis,
>> -                    unsigned offset)
>> +                    unsigned offset,
>> +                    Error **errp)
>>   {
>>       int cap;
>> -    Error *local_err = NULL;
>>         if (!chassis) {
>> -        error_report("Bridge chassis not specified. Each bridge is required "
>> -                     "to be assigned a unique chassis id > 0.");
>> +        error_setg(errp, "Bridge chassis not specified. Each bridge is required"
>> +                   " to be assigned a unique chassis id > 0.");
>>           return -EINVAL;
>>       }
>>       if (nslots < 0 || nslots > (PCI_SID_ESR_NSLOTS >> SLOTID_NSLOTS_SHIFT)) {
>> @@ -25,9 +25,8 @@ int slotid_cap_init(PCIDevice *d, int nslots,
>>       }
>>         cap = pci_add_capability(d, PCI_CAP_ID_SLOTID, offset,
>> -                             SLOTID_CAP_LENGTH, &local_err);
>> +                             SLOTID_CAP_LENGTH, errp);
>>       if (cap < 0) {
>> -        error_report_err(local_err);
>>           return cap;
>>       }
>>       /* We make each chassis unique, this way each bridge is First in Chassis */
>> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
>> index 71e836b..ee19fec 100644
>> --- a/include/hw/pci/shpc.h
>> +++ b/include/hw/pci/shpc.h
>> @@ -38,7 +38,8 @@ struct SHPCDevice {
>>     void shpc_reset(PCIDevice *d);
>>   int shpc_bar_size(PCIDevice *dev);
>> -int shpc_init(PCIDevice *dev, PCIBus *sec_bus, MemoryRegion *bar, unsigned off);
>> +int shpc_init(PCIDevice *dev, PCIBus *sec_bus, MemoryRegion *bar,
>> +              unsigned off, Error **errp);
>>   void shpc_cleanup(PCIDevice *dev, MemoryRegion *bar);
>>   void shpc_free(PCIDevice *dev);
>>   void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
>> diff --git a/include/hw/pci/slotid_cap.h b/include/hw/pci/slotid_cap.h
>> index 70db047..a777ea0 100644
>> --- a/include/hw/pci/slotid_cap.h
>> +++ b/include/hw/pci/slotid_cap.h
>> @@ -5,7 +5,8 @@
>>     int slotid_cap_init(PCIDevice *dev, int nslots,
>>                       uint8_t chassis,
>> -                    unsigned offset);
>> +                    unsigned offset,
>> +                    Error **errp);
>>   void slotid_cap_cleanup(PCIDevice *dev);
>>     #endif
>>
>
>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
>
> Michael might ask you to re-post the whole series.

OK, I will. :)

Thanks,
Mao


> Thanks,
> Marcel
>
>
>
