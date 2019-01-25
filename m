Received: from eggs.gnu.org ([209.51.188.92]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gmuVT-0004Le-4E
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 00:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gmuMK-0007vX-0W
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 00:48:57 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<20181102152257.20637-6-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <839269a0-4b07-a084-8e9a-fcffa76bc658@tuxfamily.org>
Date: Fri, 25 Jan 2019 06:48:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181102152257.20637-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 05/10] esp: add pseudo-DMA as used by
 Macintosh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 2018-11-02 16:22, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>

I'd suggest to add a patch description that contains the text that
Laurent provided as a reply to this patch in v5:

---------------------------- 8< --------------------------------------
There is no DMA in Quadra 800, so the CPU reads/writes the data from the
PDMA register (offset 0x100, ESP_PDMA in hw/m68k/q800.c) and copies them
to/from the memory.

There is a nice assembly loop in the kernel to do that, see
linux/drivers/scsi/mac_esp.c:MAC_ESP_PDMA_LOOP().

The start of the transfer is triggered by the DREQ interrupt (see linux
mac_esp_send_pdma_cmd()), the CPU polls on the IRQ flag to start the
transfer after a SCSI command has been sent (in Quadra 800 it goes
through the VIA2, the via2-irq line and the vIFR register)

The Macintosh hardware includes hardware handshaking to prevent the CPU
from reading invalid data or writing data faster than the peripheral
device can accept it.

This is the "blind mode", and from the doc:
"Approximate maximum SCSI transfer rates within a blocks are 1.4 MB per
second for blind transfers in the Macintosh II"

Some references can be found in:
  Apple Macintosh Family Hardware Reference, ISBN 0-201-19255-1
  Guide to the Macintosh Family Hardware, ISBN-0-201-52405-8
---------------------------- >8 --------------------------------------

?

> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/scsi/esp.c         | 291 +++++++++++++++++++++++++++++++++++++++++++++-----
>  include/hw/scsi/esp.h |   7 ++
>  2 files changed, 269 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 630d923623..8e9e27e479 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
[...]
> @@ -356,8 +511,7 @@ static void handle_ti(ESPState *s)
>          s->dma_left = minlen;
>          s->rregs[ESP_RSTAT] &= ~STAT_TC;
>          esp_do_dma(s);
> -    }
> -    if (s->do_cmd) {
> +    } else if (s->do_cmd) {

I'm not sure about this change... is it required? It could also change
the behavior of the other users of this device...?

>          trace_esp_handle_ti_cmd(s->cmdlen);
>          s->ti_size = 0;
>          s->cmdlen = 0;
> @@ -384,6 +538,7 @@ void esp_hard_reset(ESPState *s)
>  static void esp_soft_reset(ESPState *s)
>  {
>      qemu_irq_lower(s->irq);
> +    qemu_irq_lower(s->irq_data);
>      esp_hard_reset(s);
>  }
>  
> @@ -619,6 +774,80 @@ static const MemoryRegionOps sysbus_esp_mem_ops = {
>      .valid.accepts = esp_mem_accepts,
>  };
>  
> +static void sysbus_esp_pdma_write(void *opaque, hwaddr addr,
> +                                  uint64_t val, unsigned int size)
> +{
> +    SysBusESPState *sysbus = opaque;
> +    ESPState *s = &sysbus->esp;
> +    uint32_t dmalen;
> +
> +    dmalen = s->rregs[ESP_TCLO];
> +    dmalen |= s->rregs[ESP_TCMID] << 8;
> +    dmalen |= s->rregs[ESP_TCHI] << 16;
> +    if (dmalen == 0 || s->pdma_len == 0) {
> +        return;
> +    }
> +    switch (size) {
> +    case 1:
> +        *s->pdma_cur++ = val;
> +        s->pdma_len--;
> +        dmalen--;
> +        break;
> +    case 2:
> +        *s->pdma_cur++ = val >> 8;
> +        *s->pdma_cur++ = val;

Is there any chance that we could end up here with pdma_len == 1 or
dmalen == 1 ? If yes, the following two lines will trigger a wrap-around
with likely very bad side effects in the future...

Maybe assert(s->pdma_len >= 2 && dmalen >= 2) at least?

> +        s->pdma_len -= 2;
> +        dmalen -= 2;
> +        break;
> +    }
> +    s->rregs[ESP_TCLO] = dmalen & 0xff;
> +    s->rregs[ESP_TCMID] = dmalen >> 8;
> +    s->rregs[ESP_TCHI] = dmalen >> 16;
> +    if (s->pdma_len == 0 && s->pdma_cb) {
> +        esp_lower_drq(s);
> +        s->pdma_cb(s);
> +        s->pdma_cb = NULL;
> +    }
> +}
> +
> +static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    SysBusESPState *sysbus = opaque;
> +    ESPState *s = &sysbus->esp;
> +    uint64_t val = 0;
> +
> +    if (s->pdma_len == 0) {
> +        return 0;
> +    }
> +    switch (size) {
> +    case 1:
> +        val = *s->pdma_cur++;
> +        s->pdma_len--;
> +        break;
> +    case 2:

assert(s->pdma_len >= 2) ?

> +        val = *s->pdma_cur++;
> +        val = (val << 8) | *s->pdma_cur++;
> +        s->pdma_len -= 2;
> +        break;
> +    }
> +
> +    if (s->pdma_len == 0 && s->pdma_cb) {
> +        esp_lower_drq(s);
> +        s->pdma_cb(s);
> +        s->pdma_cb = NULL;
> +    }
> +    return val;
> +}
> +
> +static const MemoryRegionOps sysbus_esp_pdma_ops = {
> +    .read = sysbus_esp_pdma_read,
> +    .write = sysbus_esp_pdma_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 2,
> +};
> +
>  static const struct SCSIBusInfo esp_scsi_info = {
>      .tcq = false,
>      .max_target = ESP_MAX_DEVS,
> @@ -651,12 +880,16 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
>      ESPState *s = &sysbus->esp;
>  
>      sysbus_init_irq(sbd, &s->irq);
> +    sysbus_init_irq(sbd, &s->irq_data);
>      assert(sysbus->it_shift != -1);
>  
>      s->chip_id = TCHI_FAS100A;
>      memory_region_init_io(&sysbus->iomem, OBJECT(sysbus), &sysbus_esp_mem_ops,
> -                          sysbus, "esp", ESP_REGS << sysbus->it_shift);
> +                          sysbus, "esp-regs", ESP_REGS << sysbus->it_shift);
>      sysbus_init_mmio(sbd, &sysbus->iomem);
> +    memory_region_init_io(&sysbus->pdma, OBJECT(sysbus), &sysbus_esp_pdma_ops,
> +                          sysbus, "esp-pdma", 2);
> +    sysbus_init_mmio(sbd, &sysbus->pdma);
>  
>      qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
>  
> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
> index 682a0d2de0..5e94917ef8 100644
> --- a/include/hw/scsi/esp.h
> +++ b/include/hw/scsi/esp.h
> @@ -18,6 +18,7 @@ struct ESPState {
>      uint8_t rregs[ESP_REGS];
>      uint8_t wregs[ESP_REGS];
>      qemu_irq irq;
> +    qemu_irq irq_data;
>      uint8_t chip_id;
>      bool tchi_written;
>      int32_t ti_size;
> @@ -46,6 +47,11 @@ struct ESPState {
>      ESPDMAMemoryReadWriteFunc dma_memory_write;
>      void *dma_opaque;
>      void (*dma_cb)(ESPState *s);
> +    uint8_t pdma_buf[32];
> +    uint32_t pdma_len;
> +    uint8_t *pdma_start;
> +    uint8_t *pdma_cur;
> +    void (*pdma_cb)(ESPState *s);
>  };
>  
>  #define TYPE_ESP "esp"
> @@ -57,6 +63,7 @@ typedef struct {
>      /*< public >*/
>  
>      MemoryRegion iomem;
> +    MemoryRegion pdma;
>      uint32_t it_shift;
>      ESPState esp;
>  } SysBusESPState;

 Thomas
