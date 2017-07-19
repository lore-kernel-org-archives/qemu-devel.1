Received: from eggs.gnu.org ([2001:4830:134:3::10]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXq04-0002cV-6R
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXq01-0000Gp-4b
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dXq00-0000B0-Td
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:30:49 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<1500470414-7911-3-git-send-email-zuban32s@gmail.com>
	<20170719135612.GF5722@char.us.oracle.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ff0883c0-ed89-71eb-a322-3c99c20c1db8@redhat.com>
Date: Wed, 19 Jul 2017 17:30:38 +0300
MIME-Version: 1.0
In-Reply-To: <20170719135612.GF5722@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/2] pci: enable RedHat pci bridges to
 reserve more buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org

On 19/07/2017 16:56, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 19, 2017 at 04:20:14PM +0300, Aleksandr Bezzubikov wrote:
>> In case of RedHat PCI bridges reserve additional buses, which number is provided
> 
> It is "Red Hat"
>> in a vendor-specific capability.
> 
> And perhaps also a #define ?

Right, please add it to src/hw/pci_ids.h.

Thanks,
Marcel


>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   src/fw/pciinit.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
>> index 08221e6..b6f3a01 100644
>> --- a/src/fw/pciinit.c
>> +++ b/src/fw/pciinit.c
>> @@ -578,9 +578,17 @@ pci_bios_init_bus_rec(int bus, u8 *pci_bus)
>>           pci_bios_init_bus_rec(secbus, pci_bus);
>>   
>>           if (subbus != *pci_bus) {
>> +            u16 vendor = pci_config_readw(bdf, PCI_VENDOR_ID);
>> +            u8 res_bus = 0;
>> +            if (vendor == 0x1b36) {
>> +                u8 cap = pci_find_capability_bdf(bdf, PCI_CAP_ID_VNDR, 0);
>> +                if (cap) {
>> +                    res_bus = pci_config_readb(bdf, cap + 16);
>> +                }
>> +            }
>>               dprintf(1, "PCI: subordinate bus = 0x%x -> 0x%x\n",
>> -                    subbus, *pci_bus);
>> -            subbus = *pci_bus;
>> +                    subbus, *pci_bus + res_bus);
>> +            subbus = *pci_bus + res_bus;
>>           } else {
>>               dprintf(1, "PCI: subordinate bus = 0x%x\n", subbus);
>>           }
>> -- 
>> 2.7.4
>>
>>
