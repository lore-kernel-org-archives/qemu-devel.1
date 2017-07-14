Received: from eggs.gnu.org ([2001:4830:134:3::10]:40095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVxQA-00009U-47
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dVxQ5-0001gK-98
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:02:02 -0400
Received: from chuckie.co.uk ([82.165.15.123]:41131
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dVxQ5-0001fz-1s
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:01:57 -0400
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499810007-28613-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<CACXAS8CoGeihXR8LDk7QHBr1RJK3j2AJx5TNXTXYwsHTJinoHw@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c5ab0481-9b9a-4bac-ebc9-edf89f2890c9@ilande.co.uk>
Date: Fri, 14 Jul 2017 11:01:48 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8CoGeihXR8LDk7QHBr1RJK3j2AJx5TNXTXYwsHTJinoHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/8] apb: fix endianness for APB and PCI
 config accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 12/07/17 10:09, Artyom Tarasenko wrote:

> On Tue, Jul 11, 2017 at 11:53 PM, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/pci-host/apb.c |    6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
>> index 622c341..5ad7678 100644
>> --- a/hw/pci-host/apb.c
>> +++ b/hw/pci-host/apb.c
>> @@ -561,7 +561,7 @@ static uint64_t apb_config_readl (void *opaque,
>>  static const MemoryRegionOps apb_config_ops = {
>>      .read = apb_config_readl,
>>      .write = apb_config_writel,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_BIG_ENDIAN,
> 
> Is this correct? I thought all the PCI config registers are always
> little-endian.

Yes - these are the registers on the APB itself...

>>  };
>>
>>  static void apb_pci_config_write(void *opaque, hwaddr addr,
>> @@ -570,7 +570,6 @@ static void apb_pci_config_write(void *opaque, hwaddr addr,
>>      APBState *s = opaque;
>>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
>>
>> -    val = qemu_bswap_len(val, size);
>>      APB_DPRINTF("%s: addr " TARGET_FMT_plx " val %" PRIx64 "\n", __func__, addr, val);
>>      pci_data_write(phb->bus, addr, val, size);
>>  }
>> @@ -583,7 +582,6 @@ static uint64_t apb_pci_config_read(void *opaque, hwaddr addr,
>>      PCIHostState *phb = PCI_HOST_BRIDGE(s);
>>
>>      ret = pci_data_read(phb->bus, addr, size);
>> -    ret = qemu_bswap_len(ret, size);
>>      APB_DPRINTF("%s: addr " TARGET_FMT_plx " -> %x\n", __func__, addr, ret);
>>      return ret;
>>  }
>> @@ -744,7 +742,7 @@ static void pci_pbm_reset(DeviceState *d)
>>  static const MemoryRegionOps pci_config_ops = {
>>      .read = apb_pci_config_read,
>>      .write = apb_pci_config_write,
>> -    .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,

... while these are the PCI config registers. It's this endian change
here that makes it possible to remove the qemu_bswap_len() calls
included in the diff above.


ATB,

Mark.
