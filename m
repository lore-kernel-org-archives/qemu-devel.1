Received: from eggs.gnu.org ([2001:4830:134:3::10]:38928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGq52-0003E6-Lu
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGq4x-0000Eq-O9
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:42:00 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:41429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eGq4x-0000ER-Is
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:41:55 -0500
Received: by mail-qk0-x242.google.com with SMTP id f63so8455709qke.8
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 09:41:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-9-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b82ab580-246f-e536-ebe8-cd72f6ef3944@amsat.org>
Date: Mon, 20 Nov 2017 14:41:40 -0300
MIME-Version: 1.0
In-Reply-To: <1510926167-23326-9-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/15] apb: use gpios to wire up the apb
 device to the SPARC CPU IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/pci-host/apb.c          |    6 ++----
>  hw/sparc64/sparc64.c       |    2 ++
>  hw/sparc64/sun4u.c         |   12 ++++++++----
>  include/hw/pci-host/apb.h  |    6 ++++--
>  include/hw/sparc/sparc64.h |    2 ++
>  5 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
> index 0c70999..c0b97e4 100644
> --- a/hw/pci-host/apb.c
> +++ b/hw/pci-host/apb.c
> @@ -79,7 +79,6 @@ do { printf("IOMMU: " fmt , ## __VA_ARGS__); } while (0)
>  #define RESET_WCMASK 0x98000000
>  #define RESET_WMASK  0x60000000
>  
> -#define MAX_IVEC 0x40
>  #define NO_IRQ_REQUEST (MAX_IVEC + 1)
>  
>  static inline void pbm_set_request(APBState *s, unsigned int irq_num)
> @@ -614,7 +613,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
>  
>  APBState *pci_apb_init(hwaddr special_base,
>                         hwaddr mem_base,
> -                       qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
> +                       PCIBus **busA, PCIBus **busB)
>  {
>      DeviceState *dev;
>      SysBusDevice *s;
> @@ -645,8 +644,6 @@ APBState *pci_apb_init(hwaddr special_base,
>      memory_region_init(&d->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
>      memory_region_add_subregion(get_system_memory(), mem_base, &d->pci_mmio);
>  
> -    d->ivec_irqs = ivec_irqs;
> -
>      pci_create_simple(phb->bus, 0, "pbm-pci");
>  
>      /* APB IOMMU */
> @@ -721,6 +718,7 @@ static int pci_pbm_init_device(DeviceState *dev)
>          s->obio_irq_map[i] = ((0x1f << 6) | 0x20) + i;
>      }
>      s->pbm_irqs = qemu_allocate_irqs(pci_apb_set_irq, s, MAX_IVEC);
> +    qdev_init_gpio_out_named(DEVICE(s), s->ivec_irqs, "ivec-irq", MAX_IVEC);
>      s->irq_request = NO_IRQ_REQUEST;
>      s->pci_irq_in = 0ULL;
>  
> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
> index 9453e2c..95a06f0 100644
> --- a/hw/sparc64/sparc64.c
> +++ b/hw/sparc64/sparc64.c
> @@ -350,6 +350,8 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
>      uint32_t hstick_frequency = 100 * 1000000;
>  
>      cpu = SPARC_CPU(cpu_create(cpu_type));
> +    qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
> +                            "ivec-irq", IVEC_MAX);
>      env = &cpu->env;
>  
>      env->tick = cpu_timer_create("tick", cpu, tick_irq,
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index a64ddc5..2afd3f2 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -486,7 +486,6 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      PCIBus *pci_bus, *pci_busA, *pci_busB;
>      PCIDevice *ebus, *pci_dev;
>      SysBusDevice *s;
> -    qemu_irq *ivec_irqs;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      DeviceState *dev;
>      FWCfgState *fw_cfg;
> @@ -502,9 +501,14 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>  
>      prom_init(hwdef->prom_addr, bios_name);
>  
> -    ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
> -    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
> -                       &pci_busB);
> +    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, &pci_busA, &pci_busB);
> +
> +    /* Wire up PCI interrupts to CPU */
> +    for (i = 0; i < IVEC_MAX; i++) {
> +        qdev_connect_gpio_out_named(DEVICE(apb), "ivec-irq", i,
> +            qdev_get_gpio_in_named(DEVICE(cpu), "ivec-irq", i));
> +    }
> +
>      pci_bus = PCI_HOST_BRIDGE(apb)->bus;
>  
>      /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
> diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
> index a4ef51a..f7ead68 100644
> --- a/include/hw/pci-host/apb.h
> +++ b/include/hw/pci-host/apb.h
> @@ -50,6 +50,8 @@ typedef struct IOMMUState {
>      uint64_t regs[IOMMU_NREGS];
>  } IOMMUState;
>  
> +#define MAX_IVEC 0x40
> +
>  #define TYPE_APB "pbm"
>  
>  #define APB_DEVICE(obj) \
> @@ -71,7 +73,7 @@ typedef struct APBState {
>      uint32_t pci_err_irq_map[4];
>      uint32_t obio_irq_map[32];
>      qemu_irq *pbm_irqs;
> -    qemu_irq *ivec_irqs;
> +    qemu_irq ivec_irqs[MAX_IVEC];
>      unsigned int irq_request;
>      uint32_t reset_control;
>      unsigned int nr_resets;
> @@ -91,5 +93,5 @@ typedef struct PBMPCIBridge {
>  
>  APBState *pci_apb_init(hwaddr special_base,
>                         hwaddr mem_base,
> -                       qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
> +                       PCIBus **bus2, PCIBus **bus3);
>  #endif
> diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
> index ca3bb4b..5af4344 100644
> --- a/include/hw/sparc/sparc64.h
> +++ b/include/hw/sparc/sparc64.h
> @@ -1,4 +1,6 @@
>  
> +#define IVEC_MAX             0x40
> +
>  SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
>  
>  void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level);
> 
