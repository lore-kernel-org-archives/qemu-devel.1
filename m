Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ds7Bo-0003xY-1h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ds7Bi-00045o-3f
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:54:48 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ds7Bh-000447-VG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 08:54:42 -0400
Received: by mail-io0-x242.google.com with SMTP id n69so340041ioi.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 05:54:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504879106-2225-3-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1504879106-2225-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1504879106-2225-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 13 Sep 2017 14:54:19 +0200
Message-ID: <CACXAS8Apwr-337oqLW3eLLwYn7YsV8LDSv9_XL_-S469iFsR6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] sun4u: use sunhme as default on-board
 NIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Sep 8, 2017 at 3:58 PM, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  hw/sparc64/sun4u.c |   25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 5e59269..c3280aa 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -427,7 +427,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      unsigned int i;
>      uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
> -    PCIDevice *ebus;
> +    PCIDevice *ebus, *pci_dev;
>      ISABus *isa_bus;
>      SysBusDevice *s;
>      qemu_irq *ivec_irqs, *pbm_irqs;
> @@ -435,6 +435,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      DriveInfo *fd[MAX_FD];
>      DeviceState *dev;
>      FWCfgState *fw_cfg;
> +    NICInfo *nd;
> +    int onboard_nic_idx;
>
>      /* init CPUs */
>      cpu = sparc64_cpu_devinit(machine->cpu_model, hwdef->default_cpu_model,
> @@ -464,8 +466,23 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      serial_hds_isa_init(isa_bus, i, MAX_SERIAL_PORTS);
>      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
>
> -    for(i = 0; i < nb_nics; i++)
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +    onboard_nic_idx = -1;
> +    for (i = 0; i < nb_nics; i++) {
> +        nd = &nd_table[i];
> +
> +        if (onboard_nic_idx == -1 &&
> +                (!nd->model || strcmp(nd->model, "sunhme") == 0)) {
> +            pci_dev = pci_create(pci_bus, -1, "sunhme");
> +            dev = &pci_dev->qdev;
> +            qdev_set_nic_properties(dev, nd);
> +            qdev_init_nofail(dev);
> +
> +            onboard_nic_idx = i;
> +        } else {
> +            pci_nic_init_nofail(nd, pci_bus, "ne2k_pci", NULL);
> +        }
> +    }
> +    onboard_nic_idx = MAX(onboard_nic_idx, 0);
>
>      ide_drive_get(hd, ARRAY_SIZE(hd));
>
> @@ -510,7 +527,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                             /* XXX: need an option to load a NVRAM image */
>                             0,
>                             graphic_width, graphic_height, graphic_depth,
> -                           (uint8_t *)&nd_table[0].macaddr);
> +                           (uint8_t *)&nd_table[onboard_nic_idx].macaddr);
>
>      dev = qdev_create(NULL, TYPE_FW_CFG_IO);
>      qdev_prop_set_bit(dev, "dma_enabled", false);
> --
> 1.7.10.4
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
