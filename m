Received: from eggs.gnu.org ([2001:4830:134:3::10]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4Fu-00073J-7d
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4Fp-0002jI-9k
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 10:54:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36350
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dK4Fp-0002gW-1w
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 10:54:13 -0400
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497099616-2615-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20feb578-3a53-5bbf-53a9-f057ed510fd4@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7e2e6bdb-fde3-f4ff-b6b7-977536b51658@ilande.co.uk>
Date: Sun, 11 Jun 2017 15:53:43 +0100
MIME-Version: 1.0
In-Reply-To: <20feb578-3a53-5bbf-53a9-f057ed510fd4@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] sun4u: switch to using qdev to
 instantiate fw_cfg interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/06/17 18:55, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 06/10/2017 10:00 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/sparc64/sun4u.c |   10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index 69f565d..98ee6f5 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -512,7 +512,15 @@ static void sun4uv_init(MemoryRegion
>> *address_space_mem,
>>                             graphic_width, graphic_height, graphic_depth,
>>                             (uint8_t *)&nd_table[0].macaddr);
>>
>> -    fw_cfg = fw_cfg_init_io(BIOS_CFG_IOPORT);
>> +    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
>> +    qdev_prop_set_uint32(dev, "iobase", BIOS_CFG_IOPORT);
>> +    qdev_prop_set_bit(dev, "dma_enabled", false);
>> +    qdev_init_nofail(dev);
>> +    s = SYS_BUS_DEVICE(dev);
>> +    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
>> +                                sysbus_mmio_get_region(s, 0));
> 
> Now that you exported TYPE_FW_CFG_IO I think this might be
> useful/cleaner to have that code in an static inlined function in fw_cfg.h:
> 
> DeviceState *fw_cfg_create(uint32_t iobase[, bool dma_enabled]);
> 
> What do you think?
> 
> Anyway:
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I'd be inclined to leave the patch in its current form unless anyone
strongly needs more wrapper functions. The important part of the
patchset from my perspective is that it brings the fw_cfg MMIO and
ioport implementations a lot closer together.


ATB,

Mark.
