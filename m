Received: from eggs.gnu.org ([2001:4830:134:3::10]:49936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJknG-00014g-QQ
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJknB-0006su-Ss
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:07:26 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJknB-0006sk-OF
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:07:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id j126so1818594qkj.2
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 11:07:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f939e3a7-9b4c-4679-f184-226ea4d2fe98@amsat.org>
Date: Sat, 10 Jun 2017 15:07:16 -0300
MIME-Version: 1.0
In-Reply-To: <1497097821-32754-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] fw_cfg: move setting of FW_CFG_ID into
 fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 06/10/2017 09:30 AM, Mark Cave-Ayland wrote:
> The dma_enabled property enables us to set the FW_CFG_ID version
> accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/nvram/fw_cfg.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 1313bfd..f7b78a9 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -914,12 +914,19 @@ static void fw_cfg_init1(DeviceState *dev)
>  {
>      FWCfgState *s = FW_CFG(dev);
>      MachineState *machine = MACHINE(qdev_get_machine());
> +    uint32_t version = FW_CFG_VERSION;
>
>      assert(!object_resolve_path(FW_CFG_PATH, NULL));
>
>      object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
>
>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
> +
> +    if (s->dma_enabled) {
> +        version |= FW_CFG_VERSION_DMA;
> +    }
> +
> +    fw_cfg_add_i32(s, FW_CFG_ID, version);
>      fw_cfg_add_bytes(s, FW_CFG_UUID, &qemu_uuid, 16);
>      fw_cfg_add_i16(s, FW_CFG_NOGRAPHIC, (uint16_t)!machine->enable_graphics);
>      fw_cfg_add_i16(s, FW_CFG_BOOT_MENU, (uint16_t)boot_menu);
> @@ -935,7 +942,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>  {
>      DeviceState *dev;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
>
>      dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> @@ -954,12 +960,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>          /* 64 bits for the address field */
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
> -
> -        version |= FW_CFG_VERSION_DMA;
>      }
>
> -    fw_cfg_add_i32(s, FW_CFG_ID, version);
> -
>      return s;
>  }
>
> @@ -975,7 +977,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_addr && dma_as;
>
>      dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
> @@ -997,11 +998,8 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
>          sysbus_mmio_map(sbd, 2, dma_addr);
> -        version |= FW_CFG_VERSION_DMA;
>      }
>
> -    fw_cfg_add_i32(s, FW_CFG_ID, version);
> -
>      return s;
>  }
>
>
