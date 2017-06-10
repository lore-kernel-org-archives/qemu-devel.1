Received: from eggs.gnu.org ([2001:4830:134:3::10]:43827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkbW-0004sI-71
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkbT-0001zM-5s
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:55:18 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkbT-0001zF-1Y
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 13:55:15 -0400
Received: by mail-qt0-x243.google.com with SMTP id s33so20080537qtg.3
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 10:55:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497099616-2615-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497099616-2615-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20feb578-3a53-5bbf-53a9-f057ed510fd4@amsat.org>
Date: Sat, 10 Jun 2017 14:55:11 -0300
MIME-Version: 1.0
In-Reply-To: <1497099616-2615-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

Hi Mark,

On 06/10/2017 10:00 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc64/sun4u.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 69f565d..98ee6f5 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -512,7 +512,15 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                             graphic_width, graphic_height, graphic_depth,
>                             (uint8_t *)&nd_table[0].macaddr);
>
> -    fw_cfg = fw_cfg_init_io(BIOS_CFG_IOPORT);
> +    dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> +    qdev_prop_set_uint32(dev, "iobase", BIOS_CFG_IOPORT);
> +    qdev_prop_set_bit(dev, "dma_enabled", false);
> +    qdev_init_nofail(dev);
> +    s = SYS_BUS_DEVICE(dev);
> +    memory_region_add_subregion(get_system_io(), BIOS_CFG_IOPORT,
> +                                sysbus_mmio_get_region(s, 0));

Now that you exported TYPE_FW_CFG_IO I think this might be 
useful/cleaner to have that code in an static inlined function in fw_cfg.h:

DeviceState *fw_cfg_create(uint32_t iobase[, bool dma_enabled]);

What do you think?

Anyway:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +
> +    fw_cfg = FW_CFG(dev);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
>
