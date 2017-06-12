Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKOwM-0002Gf-EW
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dKOwJ-0008DG-Bf
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:59:30 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38943
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dKOwJ-0008Cr-4A
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:59:27 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170612141622.32dc55c5@nial.brq.redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3282cd09-e5db-af8c-2836-f9f712e0b220@ilande.co.uk>
Date: Mon, 12 Jun 2017 13:59:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170612141622.32dc55c5@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] fw_cfg: use sysbus_init_mmio() in
 fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 12/06/17 13:16, Igor Mammedov wrote:

> On Sat, 10 Jun 2017 13:30:20 +0100
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> 
>> This brings the function in line with fw_cfg_mem_realize(), deferring the
>> actual mapping until outside of the realize function.
> you are changing used API here, so add to commit message why is that

Okay I can add a comment mentioning that this is so we can wire up the
IO space ourselves?

>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/nvram/fw_cfg.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>> index 87b4392..4159316 100644
>> --- a/hw/nvram/fw_cfg.c
>> +++ b/hw/nvram/fw_cfg.c
>> @@ -941,6 +941,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>                                  AddressSpace *dma_as)
>>  {
>>      DeviceState *dev;
>> +    SysBusDevice *sbd;
>>      FWCfgState *s;
>>      bool dma_requested = dma_iobase && dma_as;
>>  
>> @@ -953,12 +954,16 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>>  
>>      qdev_init_nofail(dev);
>>  
>> +    sbd = SYS_BUS_DEVICE(dev);
>> +    sysbus_add_io(ssysbus_mmio_map_overlapbd, iobase, sysbus_mmio_get_region(sbd, 0));
> sysbus_mmio_map()/sysbus_mmio_map_overlap() is a proper conterpart for sysbus_init_mmio
> so I'd use that if APIs are switched.

Unfortunately we can't use sysbus_mmio_map() here because it maps the
resulting MemoryRegion into memory space instead of IO space.

The reason for using sysbus_init_mmio() here is that despite its name,
we can use sysbus_mmio_get_region() to obtain a reference to the
underlying s->comb_iomem MemoryRegion that the caller can use in order
to map the device into the desired IO space,

Otherwise if we use sysbus_add_io() at realize time as per the existing
code then the ioports are always mapped into system IO space which is
exactly the behaviour I'm trying to customise.

Note that this is how the m48t59 timer device is currently implemented
in hw/timer/m48t59.c.

> 
>> +
>>      s = FW_CFG(dev);
>>  
>>      if (s->dma_enabled) {
>>          /* 64 bits for the address field */
>>          s->dma_as = dma_as;
>>          s->dma_addr = 0;
>> +        sysbus_add_io(sbd, dma_iobase, sysbus_mmio_get_region(sbd, 1));
>>      }
>>  
>>      return s;
>> @@ -1090,13 +1095,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>>       * of the i/o region used is FW_CFG_CTL_SIZE */
>>      memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
>>                            FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
>> -    sysbus_add_io(sbd, s->iobase, &s->comb_iomem);
>> +    sysbus_init_mmio(sbd, &s->comb_iomem);
>>  
>>      if (FW_CFG(s)->dma_enabled) {
>>          memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
>>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
>>                                sizeof(dma_addr_t));
>> -        sysbus_add_io(sbd, s->dma_iobase, &FW_CFG(s)->dma_iomem);
>> +        sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>>      }
>>  }
>>  


ATB,

Mark.
