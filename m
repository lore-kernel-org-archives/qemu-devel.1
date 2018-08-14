Received: from eggs.gnu.org ([2001:4830:134:3::10]:46636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpUrQ-0002s7-L6
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpUrL-0005h5-NH
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:39:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:13650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fpUrL-0005gE-CO
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:39:23 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <43bf022f-6059-8e93-f8c3-61a7ecb72178@linux.intel.com>
Date: Tue, 14 Aug 2018 16:39:14 +0800
MIME-Version: 1.0
In-Reply-To: <893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com

Hi Laszlo,
Sorry for late reply. I missed these mails because of wrong filter.
And thanks very much for comments. My reply as belows.

On 8/7/2018 8:19 PM, Laszlo Ersek wrote:
> On 08/07/18 09:04, Jing Liu wrote:
[...]
>> @@ -46,6 +46,12 @@ struct PCIBridgeDev {
>>       uint32_t flags;
>>   
>>       OnOffAuto msi;
>> +
>> +    /* additional resources to reserve on firmware init */
>> +    uint64_t io_reserve;
>> +    uint64_t mem_reserve;
>> +    uint64_t pref32_reserve;
>> +    uint64_t pref64_reserve;
>>   };
>>   typedef struct PCIBridgeDev PCIBridgeDev;
> 
> (1) Please evaluate the following idea:
> 
This is really good and I'm only not sure if DEFINE_PROP_ like,
DEFINE_PROP_UINT32("bus-reserve", GenPCIERootPort,
res_reserve.bus_reserve, -1), is a right/good way?
I mean the third parameter "_f".

[...]
> 
> - gen_rp_props should be updated accordingly. The property names should
> stay the same, but they should reference fields of the "res_reserve" field.
> 
> (2) Then, in a separate patch, you can add another "res_reserve" field
> to "PCIBridgeDev". (As a consequence, "bus_reserve" will also be added,
> which I think is the right thing to do.)
> 
I consider whether we need limit the bus_reserve of pci-pci bridge. For 
old codes, we could add "unlimited" numbers of devices (but less than 
than max) onto pci-pci bridge.

> (3) There is a class that is derived from TYPE_PCI_BRIDGE_DEV:
> TYPE_PCI_BRIDGE_SEAT_DEV. Is it correct to add the new properties /
> fields to the latter as well?
> 
Umm, I looked into the codes that doesn't have hotplug property?
So do we need add resource reserve for it?

>>   
>> @@ -95,6 +101,13 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>>           error_free(local_err);
>>       }
>>   
>> +    err = pci_bridge_qemu_reserve_cap_init(dev, 0, 0,
>> +          bridge_dev->io_reserve, bridge_dev->mem_reserve,
>> +          bridge_dev->pref32_reserve, bridge_dev->pref64_reserve, errp);
>> +    if (err) {
>> +        goto cap_error;
>> +    }
>> +
>>       if (shpc_present(dev)) {
>>           /* TODO: spec recommends using 64 bit prefetcheable BAR.
>>            * Check whether that works well. */
>> @@ -103,6 +116,8 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>>       }
>>       return;
>>   
>> +cap_error:
>> +    msi_uninit(dev);
> 
> (4) This error handler doesn't look entirely correct; we can reach it
> without having initialized MSI. (MSI setup is conditional; and even if
> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
> msi_uninit() should be wrapped into "if (msi_present())", same as you
> see in pci_bridge_dev_exitfn().

sure, can add a pre-check. But I don't understand why we need that,
msi_uninit() will check msi_present()?

> 
>>   msi_error:
>>       slotid_cap_cleanup(dev);
>>   slotid_error:
>> @@ -162,6 +177,11 @@ static Property pci_bridge_dev_properties[] = {
>>                               ON_OFF_AUTO_AUTO),
>>       DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
>>                       PCI_BRIDGE_DEV_F_SHPC_REQ, true),
>> +    DEFINE_PROP_SIZE("io-reserve", PCIBridgeDev, io_reserve, -1),
>> +    DEFINE_PROP_SIZE("mem-reserve", PCIBridgeDev, mem_reserve, -1),
>> +    DEFINE_PROP_SIZE("pref32-reserve", PCIBridgeDev, pref32_reserve, -1),
>> +    DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev, pref64_reserve, -1),
>> +
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>>
> 
> (5) Similarly to (2), this property list should cover "bus-reserve" too.
> If we are exposing the same capability in PCI config space, then I think
> we should let the user control all fields of it as well.
> 
> (6) Please clarify the capability ID in the subject line of the patch.
OK, will add the details.


Thanks very much.
Jing

> For example:
> 
>    hw/pci: support resource reservation capability on "pci-bridge"
> 
> Thanks
> Laszlo
> 
