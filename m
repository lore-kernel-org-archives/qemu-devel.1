Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247AC2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNUAJYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247AC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2p3-0001QS-CZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2oM-0000me-6c; Tue, 01 Sep 2020 05:42:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD2oJ-00027u-RP; Tue, 01 Sep 2020 05:42:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id k15so737492wrn.10;
 Tue, 01 Sep 2020 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A0DIGGSMpd5vTgP+aVt1PWfEe+7QUKnt19PEB0luNiM=;
 b=PFNUAJYkZxgPSuyRhS3cW5jZEZLP8ftp6Vucwwe63z1XlhrdGwQCUIyY0C/9T/jFuV
 Wsp1lxIXmnIkw7nkn/lKvqPhEb3NOQvfbZaBCekoA3xvZQuQflh2JdIRKtboaNMdXjw5
 QztdJD2phR0TWNUJzoI70NYt1uNaJPzoxM2nshYC6cVnfr7aXkIfCEUFjvJ7Dfv8vepI
 oSEcFIRKxoh2B+KRHb9b7gIeKh/EQppfN4USzpV6cJkGxMawgmybSi0X3P1ffUT8Lbi1
 dMfxaGZuLRg/Xf7X6b7Kppmb1P221r603A0Te/T0DwgfRyzkSJHGW6UKcE4mtro0Rkz+
 AZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A0DIGGSMpd5vTgP+aVt1PWfEe+7QUKnt19PEB0luNiM=;
 b=sjSXPe22PMRI8sE88aVF0kRKZ8w6EasmKexEZ5H2ip2P+Yud/Mf18Q0vDKIZlyu8Ds
 DnaMPwANirVMwFgKixWXooJEC6lIznvXunlLDEA97jgo3R1hg5PcZccyA6EbsLkYVodd
 GyjYrC/pUhWYi/8PJObCiv0w2MyreRrHoAU4f2ky0Dg4rOMvA85A0biIBq76OXQ5bjL7
 88iFcpQw5yexsXB6J4Yy2D3WxyuTJzfa/H5d7OqG5G1mUpNpA/AGX/pCyxNK49y5fl2E
 fulmAUmDqKpInWcmmoNLFQMbICaEus5rFYqfclYY6mSfy6SzXU1Z+j0xTEXVpvixeGWR
 2JNw==
X-Gm-Message-State: AOAM530l20UZWGQDgYLh22eab7h51SAHGeLonkkpRO7P1NMth63nTz4B
 MQ+beURkmexZvPKKJP2v9QU=
X-Google-Smtp-Source: ABdhPJyNqo/W41ip7xnsIAwC6CIEZ+m9VilRfFSOVUJ74yhmK1JFPNlh2FOv5MOV5/QKrfdQeCQ6cw==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr1017874wrw.149.1598953357751; 
 Tue, 01 Sep 2020 02:42:37 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q12sm1260800wrs.48.2020.09.01.02.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:42:37 -0700 (PDT)
Subject: Re: [PATCH v3 08/16] hw/riscv: microchip_pfsoc: Connect a Cadence
 SDHCI controller and an SD card
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df726657-6bac-dcfb-31b2-9293787957d7@amsat.org>
Date: Tue, 1 Sep 2020 11:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 3:39 AM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Microchip PolarFire SoC integrates one Cadence SDHCI controller.
> On the Icicle Kit board, one eMMC chip and an external SD card
> connect to this controller depending on different configuration.
> 
> As QEMU does not support eMMC yet, we just emulate the SD card
> configuration. To test this, the Hart Software Services (HSS)
> should choose the SD card configuration:
> 
> $ cp boards/icicle-kit-es/def_config.sdcard .config
> $ make BOARD=icicle-kit-es
> 
> The SD card image can be built from the Yocto BSP at:
> https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp
> 
> Note the generated SD card image should be resized before use:
> $ qemu-img resize /path/to/sdcard.img 4G
> 
> Launch QEMU with the following command:
> $ qemu-system-riscv64 -nographic -M microchip-icicle-kit -sd sdcard.img
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
>   instead move that to the cadence_sdhci model
> - do not access generic-sdhci's state directly,
>   instead move that to the cadence_sdhci model
> 
>  include/hw/riscv/microchip_pfsoc.h |  4 ++++
>  hw/riscv/microchip_pfsoc.c         | 23 +++++++++++++++++++++++
>  hw/riscv/Kconfig                   |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index a5efa1d..d810ee8 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -23,6 +23,7 @@
>  #define HW_MICROCHIP_PFSOC_H
>  
>  #include "hw/char/mchp_pfsoc_mmuart.h"
> +#include "hw/sd/cadence_sdhci.h"
>  
>  typedef struct MicrochipPFSoCState {
>      /*< private >*/
> @@ -39,6 +40,7 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial2;
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
> +    CadenceSDHCIState sdhci;
>  } MicrochipPFSoCState;
>  
>  #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
> @@ -74,6 +76,7 @@ enum {
>      MICROCHIP_PFSOC_MMUART0,
>      MICROCHIP_PFSOC_SYSREG,
>      MICROCHIP_PFSOC_MPUCFG,
> +    MICROCHIP_PFSOC_EMMC_SD,
>      MICROCHIP_PFSOC_MMUART1,
>      MICROCHIP_PFSOC_MMUART2,
>      MICROCHIP_PFSOC_MMUART3,
> @@ -85,6 +88,7 @@ enum {
>  };
>  
>  enum {
> +    MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
>      MICROCHIP_PFSOC_MMUART0_IRQ = 90,
>      MICROCHIP_PFSOC_MMUART1_IRQ = 91,
>      MICROCHIP_PFSOC_MMUART2_IRQ = 92,
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index cee959a..0b2e9ca 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -12,6 +12,7 @@
>   * 1) PLIC (Platform Level Interrupt Controller)
>   * 2) eNVM (Embedded Non-Volatile Memory)
>   * 3) MMUARTs (Multi-Mode UART)
> + * 4) Cadence eMMC/SDHC controller and an SD card connected to it
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -75,6 +76,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
>      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
> @@ -111,6 +113,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
>                           TYPE_RISCV_CPU_SIFIVE_U54);
>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
> +
> +    object_initialize_child(obj, "sd-controller", &s->sdhci,
> +                            TYPE_CADENCE_SDHCI);
>  }
>  
>  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> @@ -223,6 +228,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_MPUCFG].base,
>          memmap[MICROCHIP_PFSOC_MPUCFG].size);
>  
> +    /* SDHCI */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
> +
>      /* MMUARTs */
>      s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
>          memmap[MICROCHIP_PFSOC_MMUART0].base,
> @@ -290,6 +302,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +    DriveInfo *dinfo = drive_get_next(IF_SD);

Ideally this part should be in the machine, not the soc.

Maybe you can alias the "drive" property as "sd-drive" in the soc,
and move the card attach to the machine?

Can be done later if you prefer:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>      /* Sanity check on RAM size */
>      if (machine->ram_size < mc->default_ram_size) {
> @@ -312,6 +325,16 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>  
>      /* Load the firmware */
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
> +
> +    /* Attach an SD card */
> +    if (dinfo) {
> +        CadenceSDHCIState *sdhci = &(s->soc.sdhci);
> +        DeviceState *card = qdev_new(TYPE_SD_CARD);
> +
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, sdhci->bus, &error_fatal);
> +    }
>  }
>  
>  static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index ceb7c16..7412db9 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
>      select SIFIVE
>      select UNIMP
>      select MCHP_PFSOC_MMUART
> +    select CADENCE_SDHCI
> 

