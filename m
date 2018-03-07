Received: from eggs.gnu.org ([2001:4830:134:3::10]:34155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etT5r-0001AV-8g
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etT5m-0000Kt-5Y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 02:02:31 -0500
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-8-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.1803070040490.57076@zero.eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4afbd222-f661-fd24-9b88-29c80b98175f@ilande.co.uk>
Date: Wed, 7 Mar 2018 07:02:14 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1803070040490.57076@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 07/19] uninorth: move PCI mmio
 memory region initialisation into init function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 06/03/18 23:44, BALATON Zoltan wrote:

> On Tue, 6 Mar 2018, Mark Cave-Ayland wrote:
>> Whilst we are here, rename the memory regions to better reflect 
>> whether they
>> belong to either a PCI or an AGP bus.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>> hw/pci-host/uninorth.c | 28 ++++++++++++++++++----------
>> 1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
>> index b081e3c153..5b8fc3aa16 100644
>> --- a/hw/pci-host/uninorth.c
>> +++ b/hw/pci-host/uninorth.c
>> @@ -111,29 +111,39 @@ static const MemoryRegionOps unin_data_ops = {
>>
>> static void pci_unin_main_init(Object *obj)
>> {
>> +    UNINState *s = UNI_NORTH_PCI_HOST_BRIDGE(obj);
>>     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>     PCIHostState *h = PCI_HOST_BRIDGE(obj);
>>
>>     /* Use values found on a real PowerMac */
>>     /* Uninorth main bus */
>>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
>> -                          obj, "pci-conf-idx", 0x1000);
>> +                          obj, "unin-pci-conf-idx", 0x1000);
>>     memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
>> -                          "pci-conf-data", 0x1000);
>> +                          "unin-pci-conf-data", 0x1000);
>> +
>> +    memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
>> +                       0x100000000ULL);
>> +
>>     sysbus_init_mmio(sbd, &h->conf_mem);
>>     sysbus_init_mmio(sbd, &h->data_mem);
>> }
>>
>> static void pci_u3_agp_init(Object *obj)
>> {
>> +    UNINState *s = U3_AGP_HOST_BRIDGE(obj);
>>     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>     PCIHostState *h = PCI_HOST_BRIDGE(obj);
>>
>>     /* Uninorth U3 AGP bus */
>>     memory_region_init_io(&h->conf_mem, OBJECT(h), &pci_host_conf_le_ops,
>> -                          obj, "pci-conf-idx", 0x1000);
>> +                          obj, "unin-pci-conf-idx", 0x1000);
>>     memory_region_init_io(&h->data_mem, OBJECT(h), &unin_data_ops, obj,
>> -                          "pci-conf-data", 0x1000);
>> +                          "unin-pci-conf-data", 0x1000);
>> +
>> +    memory_region_init(&s->pci_mmio, OBJECT(s), "unin-pci-mmio",
> 
> The name of this function and the above comment both suggest this is an 
> AGP bus so did you mean to rename these to unin-agp-* instead of 
> unin-pci-*?

Well this patchset purposely avoids doing anything with the U3 model 
other than the required refactoring to move the wiring to board level as 
really the entire U3 model needs some love - I can't even boot Linux 
without this patchset (I suspect it's probably DT related).

Having said that the wiring changes are such an improvement that I would 
argue for applying this patchset if possible since any future fixes will 
be considerably easier based upon it.


ATB,

Mark.
