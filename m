Received: from eggs.gnu.org ([2001:4830:134:3::10]:58053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1foEjL-0000FQ-Vo
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 17:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1foEjK-0004wf-Tm
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 17:13:55 -0400
References: <20180810120418.6695-1-mark.cave-ayland@ilande.co.uk>
	<a9a1a60a-a521-7150-a2df-8813046a1b65@reactos.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8c6b0b0b-c189-3f6f-08f3-bbe79ef3474e@ilande.co.uk>
Date: Fri, 10 Aug 2018 22:13:35 +0100
MIME-Version: 1.0
In-Reply-To: <a9a1a60a-a521-7150-a2df-8813046a1b65@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 40p: don't use legacy fw_cfg_init_mem()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 10/08/18 21:18, Hervé Poussineau wrote:

> Le 10/08/2018 à 14:04, Mark Cave-Ayland a écrit :
>> Instead initialise the device via qdev to allow us to set device
>> properties
>> directly as required.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/ppc/prep.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
>> index 3401570d98..9cf4a2adc3 100644
>> --- a/hw/ppc/prep.c
>> +++ b/hw/ppc/prep.c
>> @@ -706,7 +706,7 @@ static void ibm_40p_init(MachineState *machine)
>>       uint16_t cmos_checksum;
>>       PowerPCCPU *cpu;
>>       DeviceState *dev;
>> -    SysBusDevice *pcihost;
>> +    SysBusDevice *pcihost, *s;
>>       Nvram *m48t59 = NULL;
>>       PCIBus *pci_bus;
>>       ISABus *isa_bus;
>> @@ -799,7 +799,16 @@ static void ibm_40p_init(MachineState *machine)
>>       }
>>         /* Prepare firmware configuration for OpenBIOS */
>> -    fw_cfg = fw_cfg_init_mem(CFG_ADDR, CFG_ADDR + 2);
>> +    dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
>> +    fw_cfg = FW_CFG(dev);
>> +    qdev_prop_set_uint32(dev, "data_width", 1);
>> +    qdev_prop_set_bit(dev, "dma_enabled", false);
>> +    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
>> +                              OBJECT(fw_cfg), NULL);
>> +    qdev_init_nofail(dev);
>> +    s = SYS_BUS_DEVICE(dev);
>> +    sysbus_mmio_map(s, 0, CFG_ADDR);
>> +    sysbus_mmio_map(s, 1, CFG_ADDR + 2);
>>         if (machine->kernel_filename) {
>>           /* load kernel */
>>
> 
> So, you're inlining fw_cfg_init_mem() and resolving parameters and
> conditions.
> Any reason to do this, as this function is also used in other places?

Well, not any more as I've sent patches to remove just about all of the
others.

The problem with using *_init() functions is that you end up needing one
for every combination of parameters that you need, or having to map
function parameters to qdev parameters. And if you're doing that, you
might as well use the qdev parameters directly.

> However,
> Acked-by: Hervé Poussineau <hpoussin@reactos.org>


ATB,

Mark.
