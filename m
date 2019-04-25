Received: from eggs.gnu.org ([209.51.188.92]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdnL-0007Pm-8h
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdnJ-0002le-TA
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:48:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJdnJ-0002kk-JB
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:48:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id j13so9196978wmh.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:48:05 -0700 (PDT)
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
	<1556194715-24427-2-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a22bcec4-8701-55e6-0370-b25eb8a62a7c@redhat.com>
Date: Thu, 25 Apr 2019 14:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <1556194715-24427-2-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] leon3: add a little bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, chouteau@adacore.com

On 4/25/19 2:18 PM, KONRAD Frederic wrote:
> This adds a little bootloader to the leon3_machine when a ram image is
> given through the kernel parameter and no bios are provided:
>   * The UART transmiter is enabled.
>   * The TIMER is initialized.
> 
> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/sparc/leon3.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 774639a..f25432c 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU Leon3 System Emulator
>   *
> - * Copyright (c) 2010-2011 AdaCore
> + * Copyright (c) 2010-2019 AdaCore
>   *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
> @@ -44,6 +44,8 @@
>  #define CPU_CLK (40 * 1000 * 1000)
>  
>  #define PROM_FILENAME        "u-boot.bin"
> +#define LEON3_PROM_OFFSET    (0x00000000)
> +#define LEON3_RAM_OFFSET     (0x40000000)
>  
>  #define MAX_PILS 16
>  
> @@ -53,6 +55,59 @@ typedef struct ResetData {
>      target_ulong sp;            /* initial stack pointer */
>  } ResetData;
>  
> +static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
> +{
> +    stl_p(code++, 0x82100000); /* mov %g0, %g1                */
> +    stl_p(code++, 0x84100000); /* mov %g0, %g2                */
> +    stl_p(code++, 0x03000000 +
> +      extract32(addr, 10, 22));
> +                               /* sethi %hi(addr), %g1        */
> +    stl_p(code++, 0x82106000 +
> +      extract32(addr, 0, 10));
> +                               /* or %g1, addr, %g1           */
> +    stl_p(code++, 0x05000000 +
> +      extract32(val, 10, 22));
> +                               /* sethi %hi(val), %g2         */
> +    stl_p(code++, 0x8410a000 +
> +      extract32(val, 0, 10));
> +                               /* or %g2, val, %g2            */
> +    stl_p(code++, 0xc4204000); /* st %g2, [ %g1 ]             */
> +
> +    return code;
> +}
> +
> +/*
> + * When loading a kernel in RAM the machine is expected to be in a different
> + * state (eg: initialized by the bootloader). This little code reproduces
> + * this behavior.
> + */
> +static void write_bootloader(CPUSPARCState *env, uint8_t *base,
> +                             hwaddr kernel_addr)
> +{
> +    uint32_t *p = (uint32_t *) base;
> +
> +    /* Initialize the UARTs                                        */
> +    /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
> +    p = gen_store_u32(p, 0x80000108, 3);
> +
> +    /* Initialize the TIMER 0                                      */
> +    /* *GPTIMER_SCALER_RELOAD = 40 - 1;                            */
> +    p = gen_store_u32(p, 0x80000304, 39);
> +    /* *GPTIMER0_COUNTER_RELOAD = 0xFFFE;                          */
> +    p = gen_store_u32(p, 0x80000314, 0xFFFFFFFE);
> +    /* *GPTIMER0_CONFIG = GPTIMER_ENABLE | GPTIMER_RESTART;        */
> +    p = gen_store_u32(p, 0x80000318, 3);

Thanks for adding the comments :)

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +
> +    /* JUMP to the entry point                                     */
> +    stl_p(p++, 0x82100000); /* mov %g0, %g1 */
> +    stl_p(p++, 0x03000000 + extract32(kernel_addr, 10, 22));
> +                            /* sethi %hi(kernel_addr), %g1 */
> +    stl_p(p++, 0x82106000 + extract32(kernel_addr, 0, 10));
> +                            /* or kernel_addr, %g1 */
> +    stl_p(p++, 0x81c04000); /* jmp  %g1 */
> +    stl_p(p++, 0x01000000); /* nop */
> +}
> +
>  static void main_cpu_reset(void *opaque)
>  {
>      ResetData *s   = (ResetData *)opaque;
> @@ -131,11 +186,12 @@ static void leon3_generic_hw_init(MachineState *machine)
>      /* Reset data */
>      reset_info        = g_malloc0(sizeof(ResetData));
>      reset_info->cpu   = cpu;
> -    reset_info->sp    = 0x40000000 + ram_size;
> +    reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>      qemu_register_reset(main_cpu_reset, reset_info);
>  
>      /* Allocate IRQ manager */
> -    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS, &leon3_set_pil_in);
> +    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS,
> +                       &leon3_set_pil_in);
>  
>      env->qemu_irq_ack = leon3_irq_manager;
>  
> @@ -148,13 +204,13 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      memory_region_allocate_system_memory(ram, NULL, "leon3.ram", ram_size);
> -    memory_region_add_subregion(address_space_mem, 0x40000000, ram);
> +    memory_region_add_subregion(address_space_mem, LEON3_RAM_OFFSET, ram);
>  
>      /* Allocate BIOS */
>      prom_size = 8 * MiB;
>      memory_region_init_ram(prom, NULL, "Leon3.bios", prom_size, &error_fatal);
>      memory_region_set_readonly(prom, true);
> -    memory_region_add_subregion(address_space_mem, 0x00000000, prom);
> +    memory_region_add_subregion(address_space_mem, LEON3_PROM_OFFSET, prom);
>  
>      /* Load boot prom */
>      if (bios_name == NULL) {
> @@ -174,7 +230,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>      }
>  
>      if (bios_size > 0) {
> -        ret = load_image_targphys(filename, 0x00000000, bios_size);
> +        ret = load_image_targphys(filename, LEON3_PROM_OFFSET, bios_size);
>          if (ret < 0 || ret > prom_size) {
>              error_report("could not load prom '%s'", filename);
>              exit(1);
> @@ -198,10 +254,18 @@ static void leon3_generic_hw_init(MachineState *machine)
>              exit(1);
>          }
>          if (bios_size <= 0) {
> -            /* If there is no bios/monitor, start the application.  */
> -            env->pc = entry;
> -            env->npc = entry + 4;
> -            reset_info->entry = entry;
> +            /*
> +             * If there is no bios/monitor just start the application but put
> +             * the machine in an initialized state through a little
> +             * bootloader.
> +             */
> +            uint8_t *bootloader_entry;
> +
> +            bootloader_entry = memory_region_get_ram_ptr(prom);
> +            write_bootloader(env, bootloader_entry, entry);
> +            env->pc = LEON3_PROM_OFFSET;
> +            env->npc = LEON3_PROM_OFFSET + 4;
> +            reset_info->entry = LEON3_PROM_OFFSET;
>          }
>      }
>  
> 
