Received: from eggs.gnu.org ([2001:4830:134:3::10]:39077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKXrs-0003QH-EB
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKXrn-0004vM-Dc
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dKXrn-0004vF-5F
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:31:23 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5bb9a39e-64b9-556e-e5ac-140d160c4c17@redhat.com>
Date: Tue, 13 Jun 2017 00:31:17 +0200
MIME-Version: 1.0
In-Reply-To: <1497302470-10776-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 2/4] fw_cfg: move setting of
 FW_CFG_VERSION_DMA bit to fw_cfg_init1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On 06/12/17 23:21, Mark Cave-Ayland wrote:
> The setting of the FW_CFG_VERSION_DMA bit is the same across both the
> TYPE_FW_CFG_MEM and TYPE_FW_CFG_IO devices, so unify the logic in
> fw_cfg_init1().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index be5b04e..e1aa4fc 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -914,6 +914,7 @@ static void fw_cfg_init1(DeviceState *dev)
>  {
>      FWCfgState *s = FW_CFG(dev);
>      MachineState *machine = MACHINE(qdev_get_machine());
> +    uint32_t version = FW_CFG_VERSION;
>  
>      assert(!object_resolve_path(FW_CFG_PATH, NULL));
>  
> @@ -928,6 +929,12 @@ static void fw_cfg_init1(DeviceState *dev)
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
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
>  
>      dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> @@ -960,12 +966,8 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
>          sysbus_add_io(sbd, dma_iobase, sysbus_mmio_get_region(sbd, 1));
> -
> -        version |= FW_CFG_VERSION_DMA;
>      }
>  
> -    fw_cfg_add_i32(s, FW_CFG_ID, version);
> -
>      return s;
>  }
>  
> @@ -981,7 +983,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      FWCfgState *s;
> -    uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_addr && dma_as;
>  
>      dev = qdev_create(NULL, TYPE_FW_CFG_MEM);
> @@ -1002,11 +1003,8 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
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

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
