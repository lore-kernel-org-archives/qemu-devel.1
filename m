Received: from eggs.gnu.org ([2001:4830:134:3::10]:41832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9gu-0004KI-9Y
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9gt-0005CM-Bj
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:18:56 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dN9gt-0005CI-7O
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 23:18:55 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so21768983qtg.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 20:18:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <36f76b27-f90a-ab22-76dd-4024d34ee31a@amsat.org>
Date: Tue, 20 Jun 2017 00:18:49 -0300
MIME-Version: 1.0
In-Reply-To: <1497877149-19253-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv6 2/5] fw_cfg: move setting of
 FW_CFG_VERSION_DMA bit to fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 06/19/2017 09:59 AM, Mark Cave-Ayland wrote:
> The setting of the FW_CFG_VERSION_DMA bit is the same across both the
> TYPE_FW_CFG_MEM and TYPE_FW_CFG_IO devices, so unify the logic in
> fw_cfg_init1().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/nvram/fw_cfg.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 4e4f71a..99bdbc2 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -913,6 +913,7 @@ static void fw_cfg_init1(DeviceState *dev)
>  {
>      FWCfgState *s = FW_CFG(dev);
>      MachineState *machine = MACHINE(qdev_get_machine());
> +    uint32_t version = FW_CFG_VERSION;
>
>      assert(!object_resolve_path(FW_CFG_PATH, NULL));
>
> @@ -927,6 +928,12 @@ static void fw_cfg_init1(DeviceState *dev)
>      fw_cfg_bootsplash(s);
>      fw_cfg_reboot(s);
>
> +    if (s->dma_enabled) {
> +        version |= FW_CFG_VERSION_DMA;
> +    }
> +
> +    fw_cfg_add_i32(s, FW_CFG_ID, version);
> +
>      s->machine_ready.notify = fw_cfg_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
>  }
> @@ -938,7 +945,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      SysBusDevice *sbd;
>      FWCfgIoState *ios;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
>
>      dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> @@ -959,12 +965,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
>          sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
> -
> -        version |= FW_CFG_VERSION_DMA;
>      }
>
> -    fw_cfg_add_i32(s, FW_CFG_ID, version);
> -
>      return s;
>  }
>
> @@ -980,7 +982,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_addr && dma_as;
>
>      dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
> @@ -1001,11 +1002,8 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
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
