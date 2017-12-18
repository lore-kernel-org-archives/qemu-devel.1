Received: from eggs.gnu.org ([2001:4830:134:3::10]:34064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx6w-0005ST-Ee
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx5I-000820-Tt
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:13:46 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQx5I-0007zu-GC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:12:04 -0500
Received: by mail-qk0-x244.google.com with SMTP id 8so18670695qkj.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:12:04 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-4-f4bug@amsat.org>
	<50504475-91f6-ec30-0129-394c8ae20952@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <295eafbb-f0d5-83e8-7040-34074d0f9616@amsat.org>
Date: Mon, 18 Dec 2017 12:11:59 -0300
MIME-Version: 1.0
In-Reply-To: <50504475-91f6-ec30-0129-394c8ae20952@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/pci-host/xilinx: QOM'ify the
 AXI-PCIe host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paul.burton@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, James Hogan <jhogan@kernel.org>

On 12/18/2017 04:15 AM, Marcel Apfelbaum wrote:
> On 17/12/2017 22:49, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/pci-host/xilinx-pcie.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
>> index 7659253090..756db39fd5 100644
>> --- a/hw/pci-host/xilinx-pcie.c
>> +++ b/hw/pci-host/xilinx-pcie.c
>> @@ -267,24 +267,23 @@ static void
>> xilinx_pcie_root_config_write(PCIDevice *d, uint32_t address,
>>       }
>>   }
>>   -static int xilinx_pcie_root_init(PCIDevice *dev)
>> +static void xilinx_pcie_root_realize(PCIDevice *pci, Error **errp)
>>   {
> 
> Same comment here, if "dev" seems not good enough maybe
> you can use the pci_dev convention.
> 
>> -    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
>> +    DeviceState *dev = DEVICE(pci);
>> +    BusState *bus = qdev_get_parent_bus(dev);
> 
> Not sure the above worth the effort :)
> 
>>       XilinxPCIEHost *s = XILINX_PCIE_HOST(bus->parent);
>>   -    pci_set_word(dev->config + PCI_COMMAND,
>> +    pci_set_word(pci->config + PCI_COMMAND,
>>                    PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>> -    pci_set_word(dev->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
>> -    pci_set_word(dev->config + PCI_MEMORY_LIMIT,
>> +    pci_set_word(pci->config + PCI_MEMORY_BASE, s->mmio_base >> 16);
>> +    pci_set_word(pci->config + PCI_MEMORY_LIMIT,
>>                    ((s->mmio_base + s->mmio_size - 1) >> 16) & 0xfff0);
>>   -    pci_bridge_initfn(dev, TYPE_PCI_BUS);
>> +    pci_bridge_initfn(pci, TYPE_PCI_BUS);
>>   -    if (pcie_endpoint_cap_v1_init(dev, 0x80) < 0) {
>> +    if (pcie_endpoint_cap_v1_init(pci, 0x80) < 0) {
>>           hw_error("Failed to initialize PCIe capability");
> 
> I think here you need to use the error_setg (after/instead hw_error).
> It is supposed to return -1 if pcie capability was not added.

Oops I missed that, I'll fix in v2.

> Thanks,
> Marcel
> 
>>       }
>> -
>> -    return 0;
>>   }
>>     static void xilinx_pcie_root_class_init(ObjectClass *klass, void
>> *data)
>> @@ -300,7 +299,7 @@ static void
>> xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
>>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>>       k->is_express = true;
>>       k->is_bridge = true;
>> -    k->init = xilinx_pcie_root_init;
>> +    k->realize = xilinx_pcie_root_realize;
>>       k->exit = pci_bridge_exitfn;
>>       dc->reset = pci_bridge_reset;
>>       k->config_read = xilinx_pcie_root_config_read;
>>
