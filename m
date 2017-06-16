Received: from eggs.gnu.org ([2001:4830:134:3::10]:46840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLyLD-00022o-Jc
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLyLA-0006Ee-Ip
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLyLA-0006Dj-9a
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:59:36 -0400
References: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497619387-11333-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f4684d64-afeb-fa47-613f-57ae3658a32c@redhat.com>
Date: Fri, 16 Jun 2017 22:59:26 +0200
MIME-Version: 1.0
In-Reply-To: <1497619387-11333-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 1/5] fw_cfg: don't map the fw_cfg IO
 ports in fw_cfg_io_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 06/16/17 15:23, Mark Cave-Ayland wrote:
> As indicated by Laszlo it is a QOM bug for the realize() method to actually
> map the device. Set up the IO regions within fw_cfg_io_realize() and defer
> the mapping with sysbus_add_io() to the caller, as already done in
> fw_cfg_init_mem_wide().
> 
> This makes the iobase and dma_iobase properties now obsolete so they can be
> removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9..70a0d5f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -936,24 +936,30 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as)
>  {
>      DeviceState *dev;
> +    SysBusDevice *sbd;
> +    FWCfgIoState *ios;
>      FWCfgState *s;
>      uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
>  
>      dev = qdev_create(NULL, TYPE_FW_CFG_IO);
> -    qdev_prop_set_uint32(dev, "iobase", iobase);
> -    qdev_prop_set_uint32(dev, "dma_iobase", dma_iobase);
>      if (!dma_requested) {
>          qdev_prop_set_bit(dev, "dma_enabled", false);
>      }
>  
>      fw_cfg_init1(dev);
> +
> +    sbd = SYS_BUS_DEVICE(dev);
> +    ios = FW_CFG_IO(dev);
> +    sysbus_add_io(sbd, iobase, &ios->comb_iomem);
> +
>      s = FW_CFG(dev);
>  
>      if (s->dma_enabled) {
>          /* 64 bits for the address field */
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
> +        sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
>  
>          version |= FW_CFG_VERSION_DMA;
>      }
> @@ -1059,8 +1065,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>  }
>  
>  static Property fw_cfg_io_properties[] = {
> -    DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
> -    DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
>                       true),
>      DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
> @@ -1071,7 +1075,6 @@ static Property fw_cfg_io_properties[] = {
>  static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>  {
>      FWCfgIoState *s = FW_CFG_IO(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      Error *local_err = NULL;
>  
>      fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> @@ -1085,13 +1088,11 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>       * of the i/o region used is FW_CFG_CTL_SIZE */
>      memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
>                            FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
> -    sysbus_add_io(sbd, s->iobase, &s->comb_iomem);
>  
>      if (FW_CFG(s)->dma_enabled) {
>          memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
>                                sizeof(dma_addr_t));
> -        sysbus_add_io(sbd, s->dma_iobase, &FW_CFG(s)->dma_iomem);
>      }
>  }
>  
> 

This patch looks good to me, but I think you should also remove the
"FWCfgIoState.iobase" and "FWCfgIoState.dma_iobase" fields altogether;
that is, from the definition of the "FWCfgIoState" structure. The fields
are no longer used after this patch. (And they are irrelevant for
migration too.)

With that update, you can add my

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
