Received: from eggs.gnu.org ([2001:4830:134:3::10]:38662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKXoE-0002Yg-Sl
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dKXo9-0003sd-On
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dKXo9-0003sW-GO
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 18:27:37 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8028308f-9aac-abb6-25df-599d32d4d0ce@redhat.com>
Date: Tue, 13 Jun 2017 00:27:29 +0200
MIME-Version: 1.0
In-Reply-To: <1497302470-10776-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 1/4] fw_cfg: don't map the fw_cfg IO
 ports in fw_cfg_io_realize()
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
> As indicated by Laszlo it is a QOM bug for the realize() method to actually
> map the device. Set up the IO regions with sysbus_init_mmio() and defer
> the mapping to the caller, as already done in fw_cfg_init_mem_wide().
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9..be5b04e 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -936,6 +936,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as)
>  {
>      DeviceState *dev;
> +    SysBusDevice *sbd;
>      FWCfgState *s;
>      uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
> @@ -948,12 +949,17 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      }
>
>      fw_cfg_init1(dev);
> +
> +    sbd = SYS_BUS_DEVICE(dev);
> +    sysbus_add_io(sbd, iobase, sysbus_mmio_get_region(sbd, 0));
> +
>      s = FW_CFG(dev);
>
>      if (s->dma_enabled) {
>          /* 64 bits for the address field */
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
> +        sysbus_add_io(sbd, dma_iobase, sysbus_mmio_get_region(sbd, 1));
>
>          version |= FW_CFG_VERSION_DMA;
>      }
> @@ -1085,13 +1091,13 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>       * of the i/o region used is FW_CFG_CTL_SIZE */
>      memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
>                            FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
> -    sysbus_add_io(sbd, s->iobase, &s->comb_iomem);
> +    sysbus_init_mmio(sbd, &s->comb_iomem);
>
>      if (FW_CFG(s)->dma_enabled) {
>          memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
>                                &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
>                                sizeof(dma_addr_t));
> -        sysbus_add_io(sbd, s->dma_iobase, &FW_CFG(s)->dma_iomem);
> +        sysbus_init_mmio(sbd, &FW_CFG(s)->dma_iomem);
>      }
>  }
>
>

This does mostly what I had in mind, but why are the sysbus_init_mmio()
"replacements" necessary?

This is what sysbus_init_mmio() does:

    assert(dev->num_mmio < QDEV_MAX_MMIO);
    n = dev->num_mmio++;
    dev->mmio[n].addr = -1;
    dev->mmio[n].memory = memory;

But we don't have MMIO regions here, we have IO ports. This is all what
sysbus_add_io() does:

    memory_region_add_subregion(get_system_io(), addr, mem);

It doesn't do anything related to SysBusDevice.mmio[] and mmio.num_mmio.

This patch, as written, changes "num_mmio" from zero to nonzero, and
that could have a bunch of unexpected consequences for
"hw/core/sysbus.c":
- sysbus_has_mmio() would return true
- sysbus_dev_print() produces different output
- sysbus_get_fw_dev_path() formats a different OpenFW device path
  fragment

Instead, can we just move the sysbus_add_io() function calls *without*
replacements in fw_cfg_io_realize()?

In fw_cfg_init_io_dma(), you know the object type exactly -- you just
created it with TYPE_FW_CFG_IO --, so after device realization, you can
cast the type as narrowly as necessary, and refer to the fields by name.
Something like (build-tested only):

> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9bc1da..a28ce1eacd63 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -96,7 +96,6 @@ struct FWCfgIoState {
>      /*< public >*/
>
>      MemoryRegion comb_iomem;
> -    uint32_t iobase, dma_iobase;
>  };
>
>  struct FWCfgMemState {
> @@ -936,24 +935,29 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                  AddressSpace *dma_as)
>  {
>      DeviceState *dev;
> +    SysBusDevice *sbd;
>      FWCfgState *s;
> +    FWCfgIoState *ios;
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
> +    sbd = SYS_BUS_DEVICE(dev);
>      s = FW_CFG(dev);
> +    ios = FW_CFG_IO(dev);
> +
> +    sysbus_add_io(sbd, iobase, &ios->comb_iomem);
>
>      if (s->dma_enabled) {
>          /* 64 bits for the address field */
>          s->dma_as = dma_as;
>          s->dma_addr = 0;
> +        sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
>
>          version |= FW_CFG_VERSION_DMA;
>      }
> @@ -1059,8 +1063,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>  }
>
>  static Property fw_cfg_io_properties[] = {
> -    DEFINE_PROP_UINT32("iobase", FWCfgIoState, iobase, -1),
> -    DEFINE_PROP_UINT32("dma_iobase", FWCfgIoState, dma_iobase, -1),
>      DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
>                       true),
>      DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
> @@ -1071,7 +1073,6 @@ static Property fw_cfg_io_properties[] = {
>  static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>  {
>      FWCfgIoState *s = FW_CFG_IO(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>      Error *local_err = NULL;
>
>      fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> @@ -1085,13 +1086,11 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
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

It turns out that we introduced the "iobase" and "dma_iobase" properties
*solely* so that we could pass arguments to fw_cfg_io_realize(). But
fw_cfg_io_realize() only needed those parameters for the *wrong* purpose
(namely calling sysbus_add_io()). By eliminating the sysbus_add_io()
calls from fw_cfg_io_realize(), the related properties become
unnecessary too.

(NB, setting the "dma_enabled" property in fw_cfg_init_io_dma(), and
setting "data_width" and "dma_enabled" in fw_cfg_init_mem_wide(), remain
necessary, because those aren't related to region mapping.)

What do you think?

Thanks!
Laszlo
