Received: from eggs.gnu.org ([2001:4830:134:3::10]:36449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duOFu-0000Jq-Hs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1duOFt-00020W-Aw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 15:32:26 -0400
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-5-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170918203620.GG15823@umbus>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6cc177bf-1e95-056f-35cc-6184065ce3ec@ilande.co.uk>
Date: Tue, 19 Sep 2017 20:31:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170918203620.GG15823@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/8] macio: convert pmac_ide_ops from
 old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org

On 18/09/17 21:36, David Gibson wrote:

> On Sun, Sep 17, 2017 at 06:15:44PM +0100, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Nice, but there are some details I'm not sure about.
> 
>> ---
>>  hw/ide/macio.c |  154 +++++++++++++++++++++-----------------------------------
>>  1 file changed, 56 insertions(+), 98 deletions(-)
>>
>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>> index db5db39..428fbfc 100644
>> --- a/hw/ide/macio.c
>> +++ b/hw/ide/macio.c
>> @@ -255,131 +255,89 @@ static void pmac_ide_flush(DBDMA_io *io)
>>  }
>>  
>>  /* PowerMac IDE memory IO */
>> -static void pmac_ide_writeb (void *opaque,
>> -                             hwaddr addr, uint32_t val)
>> +static uint64_t pmac_ide_read(void *opaque, hwaddr addr, unsigned size)
>>  {
>>      MACIOIDEState *d = opaque;
>> +    uint64_t retval;
>> +    addr = (addr & 0xfff) >> 4;
> 
> Do you need the mask?  Using the new mmio interfaces, the given
> address should already be just an offset within the region.  I also
> dislike re-using the 'addr' name when it's now essentially a register
> index.

Good point, I don't think it is needed anymore since the MemoryRegion
size is 0x1000.

>>  
>> -    addr = (addr & 0xFFF) >> 4;
>>      switch (addr) {
>> -    case 1 ... 7:
>> -        ide_ioport_write(&d->bus, addr, val);
>> -        break;
>> -    case 8:
>> -    case 22:
>> -        ide_cmd_write(&d->bus, 0, val);
>> -        break;
>> -    default:
>> +    case 0x0:
>> +        if (size == 2) {
>> +            retval = ide_data_readw(&d->bus, 0);
>> +        } else if (size == 4) {
>> +            retval = ide_data_readl(&d->bus, 0);
>> +        } else {
>> +            retval = 0xffffffff;
> 
> Are single byte reads not permitted, or will they just return parts of
> the data?

>From what I can tell looking at the IDE core code, the accesses are
effectively the same except for the access size, but ide_portio_list[]
specifies the access sizes as being 2 and 4 respectively.

>> +        }
>>          break;
>> -    }
>> -}
>> -
>> -static uint32_t pmac_ide_readb (void *opaque,hwaddr addr)
>> -{
>> -    uint8_t retval;
>> -    MACIOIDEState *d = opaque;
>> -
>> -    addr = (addr & 0xFFF) >> 4;
>> -    switch (addr) {
>> -    case 1 ... 7:
>> +    case 0x1 ... 0x7:
>>          retval = ide_ioport_read(&d->bus, addr);
>>          break;
>> -    case 8:
>> -    case 22:
>> +    case 0x8:
>> +    case 0x16:
> 
> I think you need some sort of size check for these other registers -
> you've declared yourself as both supporting and implementing 1..4 byte
> accesses, but I don't think these make sense for size != 4.

Yes, agreed.

>>          retval = ide_status_read(&d->bus, 0);
>>          break;
>> +    case 0x20:
>> +        retval = d->timing_reg;
>> +        break;
>> +    case 0x30:
>> +        /* This is an interrupt state register that only exists
>> +         * in the KeyLargo and later variants. Bit 0x8000_0000
>> +         * latches the DMA interrupt and has to be written to
>> +         * clear. Bit 0x4000_0000 is an image of the disk
>> +         * interrupt. MacOS X relies on this and will hang if
>> +         * we don't provide at least the disk interrupt
>> +         */
>> +        retval = d->irq_reg;
>> +        break;
>>      default:
>> -        retval = 0xFF;
>> +        retval = 0xffffffff;
>>          break;
>>      }
>> -    return retval;
>> -}
>> -
>> -static void pmac_ide_writew (void *opaque,
>> -                             hwaddr addr, uint32_t val)
>> -{
>> -    MACIOIDEState *d = opaque;
>> -
>> -    addr = (addr & 0xFFF) >> 4;
>> -    val = bswap16(val);
>> -    if (addr == 0) {
>> -        ide_data_writew(&d->bus, 0, val);
>> -    }
>> -}
>>  
>> -static uint32_t pmac_ide_readw (void *opaque,hwaddr addr)
>> -{
>> -    uint16_t retval;
>> -    MACIOIDEState *d = opaque;
>> -
>> -    addr = (addr & 0xFFF) >> 4;
>> -    if (addr == 0) {
>> -        retval = ide_data_readw(&d->bus, 0);
>> -    } else {
>> -        retval = 0xFFFF;
>> -    }
>> -    retval = bswap16(retval);
>>      return retval;
>>  }
>>  
>> -static void pmac_ide_writel (void *opaque,
>> -                             hwaddr addr, uint32_t val)
>> +
>> +static void pmac_ide_write(void *opaque, hwaddr addr, uint64_t val,
>> +                           unsigned size)
> 
> Similar comments on the write path.
> 
>>  {
>>      MACIOIDEState *d = opaque;
>> +    addr = (addr & 0xfff) >> 4;
>>  
>> -    addr = (addr & 0xFFF) >> 4;
>> -    val = bswap32(val);
>> -    if (addr == 0) {
>> -        ide_data_writel(&d->bus, 0, val);
>> -    } else if (addr == 0x20) {
>> +    switch (addr) {
>> +    case 0x0:
>> +        if (size == 2) {
>> +            ide_data_writew(&d->bus, 0, val);
>> +        } else if (size == 4) {
>> +            ide_data_writel(&d->bus, 0, val);
>> +        }
>> +        break;
>> +    case 0x1 ... 0x7:
>> +        ide_ioport_write(&d->bus, addr, val);
>> +        break;
>> +    case 0x8:
>> +    case 0x16:
>> +        ide_cmd_write(&d->bus, 0, val);
>> +        break;
>> +    case 0x20:
>>          d->timing_reg = val;
>> -    } else if (addr == 0x30) {
>> +        break;
>> +    case 0x30:
>>          if (val & 0x80000000u) {
>>              d->irq_reg &= 0x7fffffff;
>>          }
>> +        break;
>>      }
>>  }
>>  
>> -static uint32_t pmac_ide_readl (void *opaque,hwaddr addr)
>> -{
>> -    uint32_t retval;
>> -    MACIOIDEState *d = opaque;
>> -
>> -    addr = (addr & 0xFFF) >> 4;
>> -    if (addr == 0) {
>> -        retval = ide_data_readl(&d->bus, 0);
>> -    } else if (addr == 0x20) {
>> -        retval = d->timing_reg;
>> -    } else if (addr == 0x30) {
>> -        /* This is an interrupt state register that only exists
>> -         * in the KeyLargo and later variants. Bit 0x8000_0000
>> -         * latches the DMA interrupt and has to be written to
>> -         * clear. Bit 0x4000_0000 is an image of the disk
>> -         * interrupt. MacOS X relies on this and will hang if
>> -         * we don't provide at least the disk interrupt
>> -         */
>> -        retval = d->irq_reg;
>> -    } else {
>> -        retval = 0xFFFFFFFF;
>> -    }
>> -    retval = bswap32(retval);
>> -    return retval;
>> -}
>> -
>>  static const MemoryRegionOps pmac_ide_ops = {
>> -    .old_mmio = {
>> -        .write = {
>> -            pmac_ide_writeb,
>> -            pmac_ide_writew,
>> -            pmac_ide_writel,
>> -        },
>> -        .read = {
>> -            pmac_ide_readb,
>> -            pmac_ide_readw,
>> -            pmac_ide_readl,
>> -        },
>> -    },
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .read = pmac_ide_read,
>> +    .write = pmac_ide_write,
>> +    .valid.min_access_size = 1,
>> +    .valid.max_access_size = 4,
> 
> Remember you can set .impl. different from .valid if you want the mmio
> core to do the work of splitting accesses up.

I'm not sure exactly sure what the behaviour for unaligned accesses is
(or indeed if they are valid), however I've just run an updated version
through my OpenBIOS boot tests and I don't see any regression so I'll
resubmit it shortly.


ATB,

Mark.
