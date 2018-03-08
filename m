Received: from eggs.gnu.org ([2001:4830:134:3::10]:32905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1etqWo-0001RR-Ej
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1etqWk-0004dT-H0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:03:54 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:48458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1etqWk-0004d1-Au
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:03:50 -0500
References: <1520414644-11535-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <2235ed4c-ae60-84e4-4d11-7f2aa0283e3c@reactos.org>
Date: Thu, 8 Mar 2018 09:03:40 +0100
MIME-Version: 1.0
In-Reply-To: <1520414644-11535-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/mips/jazz: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>

Le 07/03/2018 à 10:24, Thomas Huth a écrit :
> The global hack for creating SCSI devices has recently been removed,
> but this apparently broke SCSI devices on some boards that were not
> ready for this change yet. For the pica61 machine you now get:
> 
> $ mips64-softmmu/qemu-system-mips64 -M pica61 -cdrom x.iso
> qemu-system-mips64: -cdrom x.iso: machine type does not support if=scsi,bus=0,unit=2
> 
> Fix it by calling scsi_bus_legacy_handle_cmdline() after creating the
> corresponding SCSI controller.
> 
> Fixes: 1454509726719e0933c800fad00d6999752688ea
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

> ---
>   hw/mips/mips_jazz.c   |  7 ++++---
>   hw/scsi/esp.c         | 12 +++++++-----
>   include/hw/scsi/esp.h | 10 +++++-----
>   3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index b09871a..bde2c9b 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -147,6 +147,7 @@ static void mips_jazz_init(MachineState *machine,
>       MemoryRegion *ram = g_new(MemoryRegion, 1);
>       MemoryRegion *bios = g_new(MemoryRegion, 1);
>       MemoryRegion *bios2 = g_new(MemoryRegion, 1);
> +    ESPState *esp;
>   
>       /* init CPUs */
>       cpu = MIPS_CPU(cpu_create(machine->cpu_type));
> @@ -278,9 +279,9 @@ static void mips_jazz_init(MachineState *machine,
>       }
>   
>       /* SCSI adapter */
> -    esp_init(0x80002000, 0,
> -             rc4030_dma_read, rc4030_dma_write, dmas[0],
> -             qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
> +    esp = esp_init(0x80002000, 0, rc4030_dma_read, rc4030_dma_write, dmas[0],
> +                   qdev_get_gpio_in(rc4030, 5), &esp_reset, &dma_enable);
> +    scsi_bus_legacy_handle_cmdline(&esp->bus);
>   
>       /* Floppy */
>       for (n = 0; n < MAX_FD; n++) {
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 45975c2..64ec285 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -618,11 +618,11 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
>       .valid.accepts = esp_mem_accepts,
>   };
>   
> -void esp_init(hwaddr espaddr, int it_shift,
> -              ESPDMAMemoryReadWriteFunc dma_memory_read,
> -              ESPDMAMemoryReadWriteFunc dma_memory_write,
> -              void *dma_opaque, qemu_irq irq, qemu_irq *reset,
> -              qemu_irq *dma_enable)
> +ESPState *esp_init(hwaddr espaddr, int it_shift,
> +                   ESPDMAMemoryReadWriteFunc dma_memory_read,
> +                   ESPDMAMemoryReadWriteFunc dma_memory_write,
> +                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
> +                   qemu_irq *dma_enable)
>   {
>       DeviceState *dev;
>       SysBusDevice *s;
> @@ -644,6 +644,8 @@ void esp_init(hwaddr espaddr, int it_shift,
>       sysbus_mmio_map(s, 0, espaddr);
>       *reset = qdev_get_gpio_in(dev, 0);
>       *dma_enable = qdev_get_gpio_in(dev, 1);
> +
> +    return esp;
>   }
>   
>   static const struct SCSIBusInfo esp_scsi_info = {
> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
> index 3b160f8..93fdace 100644
> --- a/include/hw/scsi/esp.h
> +++ b/include/hw/scsi/esp.h
> @@ -7,11 +7,6 @@
>   /* esp.c */
>   #define ESP_MAX_DEVS 7
>   typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
> -void esp_init(hwaddr espaddr, int it_shift,
> -              ESPDMAMemoryReadWriteFunc dma_memory_read,
> -              ESPDMAMemoryReadWriteFunc dma_memory_write,
> -              void *dma_opaque, qemu_irq irq, qemu_irq *reset,
> -              qemu_irq *dma_enable);
>   
>   #define ESP_REGS 16
>   #define TI_BUFSZ 16
> @@ -136,6 +131,11 @@ typedef struct {
>   #define TCHI_FAS100A 0x4
>   #define TCHI_AM53C974 0x12
>   
> +ESPState *esp_init(hwaddr espaddr, int it_shift,
> +                   ESPDMAMemoryReadWriteFunc dma_memory_read,
> +                   ESPDMAMemoryReadWriteFunc dma_memory_write,
> +                   void *dma_opaque, qemu_irq irq, qemu_irq *reset,
> +                   qemu_irq *dma_enable);
>   void esp_dma_enable(ESPState *s, int irq, int level);
>   void esp_request_cancelled(SCSIRequest *req);
>   void esp_command_complete(SCSIRequest *req, uint32_t status, size_t resid);
> 
