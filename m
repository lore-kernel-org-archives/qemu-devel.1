Received: from eggs.gnu.org ([2001:4830:134:3::10]:44716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foXQ4-0008HU-9p
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1foXPz-0000wD-8w
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:11:16 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1foXPy-0000vh-V6
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 13:11:11 -0400
Received: by mail-ed1-x542.google.com with SMTP id s24-v6so6254115edr.8
	for <qemu-devel@nongnu.org>; Sat, 11 Aug 2018 10:11:10 -0700 (PDT)
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <7a853f8b-60b3-f165-387b-95f9243ac4b6@gmail.com>
Date: Sat, 11 Aug 2018 20:10:59 +0300
MIME-Version: 1.0
In-Reply-To: <893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Laszlo Ersek <lersek@redhat.com>, Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, pbonzini@redhat.com

Hi,

On 08/07/2018 03:19 PM, Laszlo Ersek wrote:
> On 08/07/18 09:04, Jing Liu wrote:
>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>> IO/MEM/PREF spaces for legacy pci-pci bridge, to enable
>> some pci devices hotplugging whose IO/MEM/PREF spaces
>> requests are larger than the ones in pci-pci bridge set
>> by firmware.
>>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>> ---
>>   hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
>> index b2d861d..8e9afbd 100644
>> --- a/hw/pci-bridge/pci_bridge_dev.c
>> +++ b/hw/pci-bridge/pci_bridge_dev.c
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
> (1) Please evaluate the following idea:
>
> - Factor the "bus_reserve", "io_reserve", "mem_reserve",
> "pref32_reserve" and "pref64_reserve" fiels of the "GenPCIERootPort"
> structure out to another structure.
>
> - I think this new structure type should be defined in
> "include/hw/pci/pci_bridge.h", just before the declaration of the
> pci_bridge_qemu_reserve_cap_init() function.

+1

> - Note that the PCIBridgeQemuCap structure should *not* be modified
> (i.e. it should not be rebased to the new sub-structure) -- the fields
> are not identical!
>
> - The GenPCIERootPort structure should embed this new sub-structure; the
> field name could be "res_reserve".
>
> - The parameter list of pci_bridge_qemu_reserve_cap_init() should be
> updated to take a pointer to a constant sub-structure.
>
> - gen_rp_realize() can simply pass &grp->res_reserve.
>
> - gen_rp_props should be updated accordingly. The property names should
> stay the same, but they should reference fields of the "res_reserve" field.
>
> (2) Then, in a separate patch, you can add another "res_reserve" field
> to "PCIBridgeDev". (As a consequence, "bus_reserve" will also be added,
> which I think is the right thing to do.)

It looks like a good implementation idea to me.

> (3) There is a class that is derived from TYPE_PCI_BRIDGE_DEV:
> TYPE_PCI_BRIDGE_SEAT_DEV. Is it correct to add the new properties /
> fields to the latter as well?

I see no problem with that, as long as the defaults will not create the 
vendor capability.

Thanks,
Marcel

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
> (4) This error handler doesn't look entirely correct; we can reach it
> without having initialized MSI. (MSI setup is conditional; and even if
> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
> msi_uninit() should be wrapped into "if (msi_present())", same as you
> see in pci_bridge_dev_exitfn().
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
> (5) Similarly to (2), this property list should cover "bus-reserve" too.
> If we are exposing the same capability in PCI config space, then I think
> we should let the user control all fields of it as well.
>
> (6) Please clarify the capability ID in the subject line of the patch.
> For example:
>
>    hw/pci: support resource reservation capability on "pci-bridge"
>
> Thanks
> Laszlo
