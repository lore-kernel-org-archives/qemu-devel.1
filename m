Received: from eggs.gnu.org ([2001:4830:134:3::10]:35974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZHdP-0002oa-Pg
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZHdM-0001wg-Jz
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:13:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZHdM-0001uE-An
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:13:24 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-6-git-send-email-zuban32s@gmail.com>
	<20170723055006-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b566a69d-a977-bf9f-d567-b742d400b288@redhat.com>
Date: Sun, 23 Jul 2017 17:13:11 +0300
MIME-Version: 1.0
In-Reply-To: <20170723055006-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 5/6] hw/pci: add bus_reserve
 property to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kraxel@redhat.com, seabios@seabios.org

On 23/07/2017 15:22, Michael S. Tsirkin wrote:
> On Sun, Jul 23, 2017 at 01:15:42AM +0300, Aleksandr Bezzubikov wrote:
>> To enable hotplugging of a newly created pcie-pci-bridge,
>> we need to tell firmware (SeaBIOS in this case)
> 

Hi Michael,

> Presumably, EFI would need to support this too?
> 

Sure, Eduardo added to CC, but he is in PTO now.

>> to reserve
>> additional buses for pcie-root-port, that allows us to
>> hotplug pcie-pci-bridge into this root port.
>> The number of buses to reserve is provided to the device via a corresponding
>> property, and to the firmware via new PCI capability (next patch).
>> The property's default value is 1 as we want to hotplug at least 1 bridge.
> 
> If so you should just teach firmware to allocate one bus #
> unconditionally.
> 

That would be a problem for the PCIe machines, since each PCIe
devices is plugged in a different bus and we are already
limited to 256 PCIe devices. Allocating an extra-bus always
would really limit the PCIe devices we can use.

> But why would that be so? What's wrong with a device
> directly in the root port?
> 

First, plugging a legacy PCI device into a PCIe Root Port
looks strange at least, and it can;t be done on real HW anyway.
(incompatible slots)

Second (and more important), if we want 2 or more PCI
devices we would loose both IO ports space and bus numbers.

> 
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   hw/pci-bridge/pcie_root_port.c | 1 +
>>   include/hw/pci/pcie_port.h     | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>> index 4d588cb..b0e49e1 100644
>> --- a/hw/pci-bridge/pcie_root_port.c
>> +++ b/hw/pci-bridge/pcie_root_port.c
>> @@ -137,6 +137,7 @@ static void rp_exit(PCIDevice *d)
>>   static Property rp_props[] = {
>>       DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>>                       QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>> +    DEFINE_PROP_UINT8("bus_reserve", PCIEPort, bus_reserve, 1),
>>       DEFINE_PROP_END_OF_LIST()
>>   };
>>   
>> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
>> index 1333266..1b2dd1f 100644
>> --- a/include/hw/pci/pcie_port.h
>> +++ b/include/hw/pci/pcie_port.h
>> @@ -34,6 +34,9 @@ struct PCIEPort {
>>   
>>       /* pci express switch port */
>>       uint8_t     port;
>> +
>> +    /* additional buses to reserve on firmware init */
>> +    uint8_t     bus_reserve;
>>   };
>>   
>>   void pcie_port_init_reg(PCIDevice *d);
> 
> So here is a property and it does not do anything.
> It makes it easier to work on series maybe, but review
> is harder since we do not see what it does at all.
> Please do not split up patches like this - you can maintain
> it split up in your branch if you like and merge before sending.
>

Agreed, Alexandr please merge patches 4-5-6 for your next submission.

Thanks,
Marcel


>> -- 
>> 2.7.4
