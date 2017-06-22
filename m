Received: from eggs.gnu.org ([2001:4830:134:3::10]:56838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNw1r-00056x-Ns
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNw1n-0000gn-On
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:55:47 -0400
Received: from [59.151.112.132] (port=37395 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dNw1l-0000gH-Vz
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 02:55:43 -0400
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
	<755cb5b3a23be771f27ab9c2cd020fa002d197d4.1497272778.git.maozy.fnst@cn.fujitsu.com>
	<2730d545-ece5-adf1-7e9e-5c08ba2a8e58@redhat.com>
	<56493212-a1e6-bdda-1c17-1e2e02be037a@cn.fujitsu.com>
	<757e97cb-8f6b-7feb-8a34-7f6779153829@redhat.com>
	<9e0cbbe0-5834-9cd5-cbed-7f558db29b55@cn.fujitsu.com>
	<93f727f1-fd37-38f1-a112-31a8a642745f@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <633f614f-01a7-3570-bda9-c3d6a6cbea70@cn.fujitsu.com>
Date: Thu, 22 Jun 2017 14:55:22 +0800
MIME-Version: 1.0
In-Reply-To: <93f727f1-fd37-38f1-a112-31a8a642745f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 7/9] pci: Convert shpc_init() to Error
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



On 06/22/2017 02:29 PM, Marcel Apfelbaum wrote:
> On 22/06/2017 6:47, Mao Zhongyi wrote:
>>
>>
>> On 06/21/2017 03:39 PM, Marcel Apfelbaum wrote:
>>> On 20/06/2017 6:51, Mao Zhongyi wrote:
>>>> Hi, Marcel
>>>>
>>>> On 06/19/2017 08:05 PM, Marcel Apfelbaum wrote:
>>>>> On 12/06/2017 16:48, Mao Zhongyi wrote:
>>>>>> In order to propagate error message better, convert shpc_init() to
>>>>>> Error also convert the pci_bridge_dev_initfn() to realize.
>>>>>>
>>>>>> Cc: mst@redhat.com
>>>>>> Cc: marcel@redhat.com
>>>>>> Cc: armbru@redhat.com
>>>>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>>>>> ---
>>>>>>   hw/pci-bridge/pci_bridge_dev.c | 21 ++++++++-------------
>>>>>>   hw/pci/shpc.c                  | 11 +++++------
>>>>>>   hw/pci/slotid_cap.c            | 11 +++++------
>>>>>>   include/hw/pci/shpc.h          |  3 ++-
>>>>>>   include/hw/pci/slotid_cap.h    |  3 ++-
>>>>>>   5 files changed, 22 insertions(+), 27 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
>>>>>> index 5dbd933..30c4186 100644
>>>>>> --- a/hw/pci-bridge/pci_bridge_dev.c
>>>>>> +++ b/hw/pci-bridge/pci_bridge_dev.c
>>>>>> @@ -49,12 +49,11 @@ struct PCIBridgeDev {
>>>>>>   };
>>>>>>   typedef struct PCIBridgeDev PCIBridgeDev;
>>>>>>   -static int pci_bridge_dev_initfn(PCIDevice *dev)
>>>>>> +static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>>>>>>   {
>>>>>>       PCIBridge *br = PCI_BRIDGE(dev);
>>>>>>       PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
>>>>>>       int err;
>>>>>> -    Error *local_err = NULL;
>>>>>>         pci_bridge_initfn(dev, TYPE_PCI_BUS);
>>>>>>   @@ -62,7 +61,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>>>>>           dev->config[PCI_INTERRUPT_PIN] = 0x1;
>>>>>>           memory_region_init(&bridge_dev->bar, OBJECT(dev), "shpc-bar",
>>>>>>                              shpc_bar_size(dev));
>>>>>> -        err = shpc_init(dev, &br->sec_bus, &bridge_dev->bar, 0);
>>>>>> +        err = shpc_init(dev, &br->sec_bus, &bridge_dev->bar, 0, errp);
>>>>>>           if (err) {
>>>>>>               goto shpc_error;
>>>>>>           }
>>>>>> @@ -71,7 +70,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>>>>>           bridge_dev->msi = ON_OFF_AUTO_OFF;
>>>>>>       }
>>>>>>   -    err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0);
>>>>>> +    err = slotid_cap_init(dev, 0, bridge_dev->chassis_nr, 0, errp);
>>>>>>       if (err) {
>>>>>>           goto slotid_error;
>>>>>>       }
>>>>>> @@ -79,20 +78,18 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>>>>>       if (bridge_dev->msi != ON_OFF_AUTO_OFF) {
>>>>>>           /* it means SHPC exists, because MSI is needed by SHPC */
>>>>>>   -        err = msi_init(dev, 0, 1, true, true, &local_err);
>>>>>> +        err = msi_init(dev, 0, 1, true, true, errp);
>>>>>>           /* Any error other than -ENOTSUP(board's MSI support is broken)
>>>>>>            * is a programming error */
>>>>>>           assert(!err || err == -ENOTSUP);
>>>>>>           if (err && bridge_dev->msi == ON_OFF_AUTO_ON) {
>>>>>>               /* Can't satisfy user's explicit msi=on request, fail */
>>>>>> -            error_append_hint(&local_err, "You have to use msi=auto (default) "
>>>>>> +            error_append_hint(errp, "You have to use msi=auto (default) "
>>>>>>                       "or msi=off with this machine type.\n");
>>>>>> -            error_report_err(local_err);
>>>>>>               goto msi_error;
>>>>>>           }
>>>>>> -        assert(!local_err || bridge_dev->msi == ON_OFF_AUTO_AUTO);
>>>>>> +        assert(bridge_dev->msi == ON_OFF_AUTO_AUTO);
>>>>>
>>>>> I am not sure we can drop the !local_err assert.
>>>>> We don't have a local_err anymore, but the error
>>>>> is stored now in errp.
>>>>>
>>>>
>>>> I think it's OK if we drop the !local_err assert; even if we don't store the error
>>>> message to errp.
>>>>
>>>> Because the code can go to assert(!local_err || bridge_dev->msi == ON_OFF_AUTO_AUTO)
>>>> only if the return value of msi_init is 0(success), then the local_err is NULL,
>>>
>>> I think I am missing something.
>>> What if msi_init returns with  -ENOTSUP and
>>>   bridge_dev->msi == ON_OFF_AUTO_AUTO ?
>>> We do reach the assert with an err.
>>> Previously it was a asserted "error allowed only on auto mode",
>>> now we assert only "auto mode".
>>
>> Hi, Marcel
>>
>> Thanks for your explanation, you are right, I am missing something.
>> We can do reach the assert in the next three cases:
>>
>>   ------------------------------------------------------------------------------------------------------------------------------------------------------------------
>> |      |                                     |                     previous                                |                   now                       |         |
>> | case |           condition                 |-------------------------------------------------------------|---------------------------------------------| result  |
>> |      |                                     |  assert(!local_err || bridge_dev->msi == ON_OFF_AUTO_AUTO)  | assert(bridge_dev->msi == ON_OFF_AUTO_AUTO) |         |
>> |------|-------------------------------------|-------------------------------------------------------------|---------------------------------------------|---------|
>> |      | err ==  -ENOTSUP                    |  local_err != NULL, is equivalent to:                       |                                             |         |
>> |   1  | bridge_dev->msi == ON_OFF_AUTO_AUTO |  assert(bridge_dev->msi == ON_OFF_AUTO_AUTO)                | assert(bridge_dev->msi == ON_OFF_AUTO_AUTO) |  same   |
>> |------|-------------------------------------|-------------------------------------------------------------|---------------------------------------------|---------|
>> |      | err == 0                            |  local_err == NULL, is equivalent to:                       |                                             |         |
>> |   2  | bridge_dev->msi == ON_OFF_AUTO_AUTO |  assert(!local_err)                                         | assert(bridge_dev->msi == ON_OFF_AUTO_AUTO) |  same   |
>> |------|-------------------------------------|-------------------------------------------------------------|---------------------------------------------|---------|
>> |      | err == 0                            |  local_err == NULL, is equivalent to:                       |                                             |         |
>> |   3  | bridge_dev->msi != ON_OFF_AUTO_AUTO |  assert(!local_err)                                         | assert(bridge_dev->msi == ON_OFF_AUTO_AUTO) |different|
>>   ------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>
>> In the case 1 & 2, the code runs the same path as before,
>> but in case 3 does not, it will be abort after the patch,
>> So drop the !local_err assert is really not appropriate,
>> will revert it in the v7. :)
>
>
> Thanks for looking into it and sorry for the late review.
> Marcel

That's all right. :)
Mao



>>> Thanks,
>>> Marcel
>>>
>>>
>>>
>>>
>>>
>>>  no
>>>> error message in it. So the assertation of local_err is always superfluous.
>>>>
>>>
>>>
>>>> Thanks
>>>> Mao
>>>>
>>>>
>>>>> Other than that, the patch looks OK to me.
>>>>>
>>>>> Thanks,
>>>>> Marcel
>>>>>
>>>>>>           /* With msi=auto, we fall back to MSI off silently */
>>>>>> -        error_free(local_err);
>>>>>>       }
>>>>>>         if (shpc_present(dev)) {
>>>>>> @@ -101,7 +98,7 @@ static int pci_bridge_dev_initfn(PCIDevice *dev)
>>>>>>           pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
>>>>>>                            PCI_BASE_ADDRESS_MEM_TYPE_64, &bridge_dev->bar);
>>>>>>       }
>>>>>> -    return 0;
>>>>>> +    return;
>>>>>>     msi_error:
>>>>>>       slotid_cap_cleanup(dev);
>>>>>> @@ -111,8 +108,6 @@ slotid_error:
>>>>>>       }
>>>>>>   shpc_error:
>>>>>>       pci_bridge_exitfn(dev);
>>>>>> -
>>>>>> -    return err;
>>>>>>   }
>>>>>>     static void pci_bridge_dev_exitfn(PCIDevice *dev)
>>>>>> @@ -216,7 +211,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>>>>>>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>>>>>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>>>>>>   -    k->init = pci_bridge_dev_initfn;
>>>>>> +    k->realize = pci_bridge_dev_realize;
>>>>>>       k->exit = pci_bridge_dev_exitfn;
>>>>>>       k->config_write = pci_bridge_dev_write_config;
>>>>>>       k->vendor_id = PCI_VENDOR_ID_REDHAT;
>>>>>> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
>>>>>> index d72d5e4..69fc14b 100644
>>>>>> --- a/hw/pci/shpc.c
>>>>>> +++ b/hw/pci/shpc.c
>>>>>> @@ -446,16 +446,14 @@ static void shpc_cap_update_dword(PCIDevice *d)
>>>>>>   }
>>>>>>     /* Add SHPC capability to the config space for the device. */
>>>>>> -static int shpc_cap_add_config(PCIDevice *d)
>>>>>> +static int shpc_cap_add_config(PCIDevice *d, Error **errp)
>>>>>>   {
>>>>>>       uint8_t *config;
>>>>>>       int config_offset;
>>>>>> -    Error *local_err = NULL;
>>>>>>       config_offset = pci_add_capability(d, PCI_CAP_ID_SHPC,
>>>>>>                                          0, SHPC_CAP_LENGTH,
>>>>>> -                                       &local_err);
>>>>>> +                                       errp);
>>>>>>       if (config_offset < 0) {
>>>>>> -        error_report_err(local_err);
>>>>>>           return config_offset;
>>>>>>       }
>>>>>>       config = d->config + config_offset;
>>>>>> @@ -584,13 +582,14 @@ void shpc_device_hot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>>>>>   }
>>>>>>     /* Initialize the SHPC structure in bridge's BAR. */
>>>>>> -int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar, unsigned offset)
>>>>>> +int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRegion *bar,
>>>>>> +              unsigned offset, Error **errp)
>>>>>>   {
>>>>>>       int i, ret;
>>>>>>       int nslots = SHPC_MAX_SLOTS; /* TODO: qdev property? */
>>>>>>       SHPCDevice *shpc = d->shpc = g_malloc0(sizeof(*d->shpc));
>>>>>>       shpc->sec_bus = sec_bus;
>>>>>> -    ret = shpc_cap_add_config(d);
>>>>>> +    ret = shpc_cap_add_config(d, errp);
>>>>>>       if (ret) {
>>>>>>           g_free(d->shpc);
>>>>>>           return ret;
>>>>>> diff --git a/hw/pci/slotid_cap.c b/hw/pci/slotid_cap.c
>>>>>> index bdca205..36d021b 100644
>>>>>> --- a/hw/pci/slotid_cap.c
>>>>>> +++ b/hw/pci/slotid_cap.c
>>>>>> @@ -9,14 +9,14 @@
>>>>>>     int slotid_cap_init(PCIDevice *d, int nslots,
>>>>>>                       uint8_t chassis,
>>>>>> -                    unsigned offset)
>>>>>> +                    unsigned offset,
>>>>>> +                    Error **errp)
>>>>>>   {
>>>>>>       int cap;
>>>>>> -    Error *local_err = NULL;
>>>>>>         if (!chassis) {
>>>>>> -        error_report("Bridge chassis not specified. Each bridge is required "
>>>>>> -                     "to be assigned a unique chassis id > 0.");
>>>>>> +        error_setg(errp, "Bridge chassis not specified. Each bridge is required"
>>>>>> +                   " to be assigned a unique chassis id > 0.");
>>>>>>           return -EINVAL;
>>>>>>       }
>>>>>>       if (nslots < 0 || nslots > (PCI_SID_ESR_NSLOTS >> SLOTID_NSLOTS_SHIFT)) {
>>>>>> @@ -25,9 +25,8 @@ int slotid_cap_init(PCIDevice *d, int nslots,
>>>>>>       }
>>>>>>         cap = pci_add_capability(d, PCI_CAP_ID_SLOTID, offset,
>>>>>> -                             SLOTID_CAP_LENGTH, &local_err);
>>>>>> +                             SLOTID_CAP_LENGTH, errp);
>>>>>>       if (cap < 0) {
>>>>>> -        error_report_err(local_err);
>>>>>>           return cap;
>>>>>>       }
>>>>>>       /* We make each chassis unique, this way each bridge is First in Chassis */
>>>>>> diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
>>>>>> index 71e836b..ee19fec 100644
>>>>>> --- a/include/hw/pci/shpc.h
>>>>>> +++ b/include/hw/pci/shpc.h
>>>>>> @@ -38,7 +38,8 @@ struct SHPCDevice {
>>>>>>     void shpc_reset(PCIDevice *d);
>>>>>>   int shpc_bar_size(PCIDevice *dev);
>>>>>> -int shpc_init(PCIDevice *dev, PCIBus *sec_bus, MemoryRegion *bar, unsigned off);
>>>>>> +int shpc_init(PCIDevice *dev, PCIBus *sec_bus, MemoryRegion *bar,
>>>>>> +              unsigned off, Error **errp);
>>>>>>   void shpc_cleanup(PCIDevice *dev, MemoryRegion *bar);
>>>>>>   void shpc_free(PCIDevice *dev);
>>>>>>   void shpc_cap_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len);
>>>>>> diff --git a/include/hw/pci/slotid_cap.h b/include/hw/pci/slotid_cap.h
>>>>>> index 70db047..a777ea0 100644
>>>>>> --- a/include/hw/pci/slotid_cap.h
>>>>>> +++ b/include/hw/pci/slotid_cap.h
>>>>>> @@ -5,7 +5,8 @@
>>>>>>     int slotid_cap_init(PCIDevice *dev, int nslots,
>>>>>>                       uint8_t chassis,
>>>>>> -                    unsigned offset);
>>>>>> +                    unsigned offset,
>>>>>> +                    Error **errp);
>>>>>>   void slotid_cap_cleanup(PCIDevice *dev);
>>>>>>     #endif
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>>
>>
>
>
>
>
