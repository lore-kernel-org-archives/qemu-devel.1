Received: from eggs.gnu.org ([2001:4830:134:3::10]:44653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cEEFH-0003Ek-SW
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cEEFD-0001iq-Q6
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:49:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cEEFD-0001iW-Gf
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 06:49:11 -0500
Date: Tue, 6 Dec 2016 12:49:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161206124906.76a41896@nial.brq.redhat.com>
In-Reply-To: <20161201170624.26496-4-lersek@redhat.com>
References: <20161201170624.26496-1-lersek@redhat.com>
	<20161201170624.26496-4-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/7] fw-cfg: expose "file_slots"
 parameter in fw_cfg_init_io_dma()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu,  1 Dec 2016 18:06:20 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> Accordingly, generalize the "file_slots" minimum calculation in
> fw_cfg_init_io_dma(), and move the constant FW_CFG_FILE_SLOTS_TRAD
> argument to the callers of fw_cfg_init_io_dma().
If I get idea correctly you're extending fw_cfg_init_io_dma() and
setting
 qdev_prop_set_uint32(dev, "file_slots", file_slots);
manually to keep old fw_cfg_init_io() the same without touching
xen/sun4u machines.
That way we would have 2 different ways to set defaults
per machine type/version rather then the single COMPAT property way.

How about dropping this patch and adding
 SET_MACHINE_COMPAT
to xen/sun4u machines instead and dropping fw_cfg_init_io() in
favor of fw_cfg_init_io_dma() along the way.

> 
> Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  docs/specs/fw_cfg.txt     |  4 ++--
>  include/hw/nvram/fw_cfg.h |  2 +-
>  hw/i386/pc.c              |  3 ++-
>  hw/nvram/fw_cfg.c         | 13 ++++++-------
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
> index 84e2978706f5..4a6888b511f4 100644
> --- a/docs/specs/fw_cfg.txt
> +++ b/docs/specs/fw_cfg.txt
> @@ -153,12 +153,12 @@ Selector Reg.    Range Usage
>  0x4000 - 0x7fff  Generic (0x0000 - 0x3fff, RW, ignored in QEMU v2.4+)
>  0x8000 - 0xbfff  Arch. Specific (0x0000 - 0x3fff, generally RO, possibly RW
>                                   through the DMA interface in QEMU v2.9+)
>  0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
>  
> -In practice, the number of allowed firmware configuration items is given
> -by the value (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_TRAD) (see fw_cfg.h).
> +In practice, the number of allowed firmware configuration items depends on the
> +machine type.
machine type/version

>  
>  = Guest-side DMA Interface =
>  
>  If bit 1 of the feature bitmap is set, the DMA interface is present. This does
>  not replace the existing fw_cfg interface, it is an add-on. This interface
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b980cbaebf43..e9a6b6aa968c 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -173,11 +173,11 @@ void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
>   */
>  void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
>                           size_t len);
>  
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> -                                AddressSpace *dma_as);
> +                                AddressSpace *dma_as, uint32_t file_slots);
>  FWCfgState *fw_cfg_init_io(uint32_t iobase);
>  FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>                                   hwaddr data_addr, uint32_t data_width,
>                                   hwaddr dma_addr, AddressSpace *dma_as);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a9e64a88e5e7..5d929d8fc887 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -741,11 +741,12 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
>  {
>      FWCfgState *fw_cfg;
>      uint64_t *numa_fw_cfg;
>      int i, j;
>  
> -    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as);
> +    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as,
> +                                FW_CFG_FILE_SLOTS_TRAD);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
>  
>      /* FW_CFG_MAX_CPUS is a bit confusing/problematic on x86:
>       *
>       * For machine types prior to 1.8, SeaBIOS needs FW_CFG_MAX_CPUS for
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 2e1441c09750..c33c76ab93b1 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -926,11 +926,11 @@ static void fw_cfg_init1(DeviceState *dev)
>      s->machine_ready.notify = fw_cfg_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
>  }
>  
>  FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> -                                AddressSpace *dma_as)
> +                                AddressSpace *dma_as, uint32_t file_slots)
>  {
>      DeviceState *dev;
>      FWCfgState *s;
>      uint32_t version = FW_CFG_VERSION;
>      bool dma_requested = dma_iobase && dma_as;
> @@ -940,15 +940,14 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      qdev_prop_set_uint32(dev, "dma_iobase", dma_iobase);
>      if (!dma_requested) {
>          qdev_prop_set_bit(dev, "dma_enabled", false);
>      }
>  
> -    /* Once we expose the "file_slots" property to callers of
> -     * fw_cfg_init_io_dma(), the following setting should become conditional on
> -     * the input parameter being lower than the current value of the property.
> -     */
> -    qdev_prop_set_uint32(dev, "file_slots", FW_CFG_FILE_SLOTS_TRAD);
> +    if (file_slots < object_property_get_int(OBJECT(dev), "file_slots",
> +                                             &error_abort)) {
> +        qdev_prop_set_uint32(dev, "file_slots", file_slots);
> +    }
>  
>      fw_cfg_init1(dev);
>      s = FW_CFG(dev);
>  
>      if (s->dma_enabled) {
> @@ -964,11 +963,11 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      return s;
>  }
>  
>  FWCfgState *fw_cfg_init_io(uint32_t iobase)
>  {
> -    return fw_cfg_init_io_dma(iobase, 0, NULL);
> +    return fw_cfg_init_io_dma(iobase, 0, NULL, FW_CFG_FILE_SLOTS_TRAD);
>  }
>  
>  FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>                                   hwaddr data_addr, uint32_t data_width,
>                                   hwaddr dma_addr, AddressSpace *dma_as)
