Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01DC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7563C20782
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 02:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="MagSgohT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7563C20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1karpB-0006ZQ-Ch
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 21:50:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1karo0-00063B-92
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 21:48:48 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1karnx-00022z-Mg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 21:48:47 -0500
Received: by mail-pl1-x643.google.com with SMTP id x23so1744291plr.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 18:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=4tNBPXpR5LvWmBRGv4bnD17lWQmqIfg8358Uwq5hQ9s=;
 b=MagSgohTgwX2kkfl4d082Me2irUtM3Xtl95lGyJRRwOPFsWEXQb4sx03kFqhr2+3Bk
 LCnQUSTm1QKYMRBvvo9lOIlb/XFShcIorLNunz/2/s59SAj+sUG7ol7cuzqhVn2SyNKA
 Oe629l2Y3gFWeiHYW0YjpzOTLBaqMI3ZdbnNBOVKWb5HIERE3m2eBR+HOC99KZc6qK7A
 KG+itDPofbyBkp+J7TnFWxKfnaH78MXTqHEMdu+te5ttB5JnZs7hx44EGDyJ10Cgmlgu
 MimBR30yG/KzDuVLSTTWg8oLqzbbxE3Cok5dCU2UozjotCbVXH66wsQvFARkYEu2pzg4
 M6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=4tNBPXpR5LvWmBRGv4bnD17lWQmqIfg8358Uwq5hQ9s=;
 b=HRf5QYqzZxg7sybUII74ffS0xu+8QwWFzZytnTuzoESbmXq7OQGsdkBRDbHeAccOgw
 tQ2UqGfyTOp7N+TXFWoU1F80b+OtNSvKnVv7Z9jOOKxXiCebJKMZvwAaLfqNVS6AsEXd
 gxjOMm6pt5F0kZhnlucImcoVqfSiyi/lR4Ao1w9J0u4aQhHnqWCoX+JF3mhRhmdMD2Cw
 crp71i/8/5WMxu0/9Zbcd+r3YBNi/JjGFf91w23TOqzEQiLrC6w20X5MJZeTT1RVgoYR
 mzAUZYa/NHmV4pysRqvefQlbOUSkGXrRhsw+R+EwFAcu2hO0Zww741qP28Oke5cG1WeL
 uwMg==
X-Gm-Message-State: AOAM533TLLzs1+1BXYHdxOFkh8Tt2k2ymvQ5YfiIO2yOpFrealHVgXhd
 /2u95kOrCjyyTtmlLR1Q93/Nug==
X-Google-Smtp-Source: ABdhPJxm9wpAwRugjIbXmtTdelmB3ZrEtjIwg3SINP1rp+Fm/D/vmkq7MX4b+IeQN7KagBotKFdhcw==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id
 y9-20020a1709029b89b02900d242a6088fmr29516plp.71.1604630923671; 
 Thu, 05 Nov 2020 18:48:43 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id mt2sm8367pjb.7.2020.11.05.18.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 18:48:43 -0800 (PST)
Date: Thu, 05 Nov 2020 18:48:43 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 18:40:57 PST (-0800)
Subject: Re: [PATCH v2 4/4] hw/riscv: Load the kernel after the firmware
In-Reply-To: <CAKmqyKP7KP0RR+mX-+Q9L5uFTELWEikJ+Dw7fOTYRnDr9m3FqQ@mail.gmail.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alistair23@gmail.com
Message-ID: <mhng-6bc48fcd-38b1-445d-afd0-e26db0f2d721@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=palmer@dabbelt.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-riscv@nongnu.org, bmeng.cn@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Oct 2020 08:46:45 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Oct 19, 2020 at 4:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 13 Oct 2020 17:17:33 PDT (-0700), Alistair Francis wrote:
>> > Instead of loading the kernel at a hardcoded start address, let's load
>> > the kernel at the next alligned address after the end of the firmware.
>> >
>> > This should have no impact for current users of OpenSBI, but will
>> > allow loading a noMMU kernel at the start of memory.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  include/hw/riscv/boot.h |  3 +++
>> >  hw/riscv/boot.c         | 19 ++++++++++++++-----
>> >  hw/riscv/opentitan.c    |  3 ++-
>> >  hw/riscv/sifive_e.c     |  3 ++-
>> >  hw/riscv/sifive_u.c     | 10 ++++++++--
>> >  hw/riscv/spike.c        | 11 ++++++++---
>> >  hw/riscv/virt.c         | 11 ++++++++---
>> >  7 files changed, 45 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
>> > index 2975ed1a31..0b01988727 100644
>> > --- a/include/hw/riscv/boot.h
>> > +++ b/include/hw/riscv/boot.h
>> > @@ -25,6 +25,8 @@
>> >
>> >  bool riscv_is_32_bit(MachineState *machine);
>> >
>> > +target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
>> > +                                          target_ulong firmware_end_addr);
>> >  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>> >                                            const char *default_machine_firmware,
>> >                                            hwaddr firmware_load_addr,
>> > @@ -34,6 +36,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
>> >                                   hwaddr firmware_load_addr,
>> >                                   symbol_fn_t sym_cb);
>> >  target_ulong riscv_load_kernel(const char *kernel_filename,
>> > +                               target_ulong firmware_end_addr,
>> >                                 symbol_fn_t sym_cb);
>> >  hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
>> >                           uint64_t kernel_entry, hwaddr *start);
>> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> > index 5dea644f47..9b3fe3fb1e 100644
>> > --- a/hw/riscv/boot.c
>> > +++ b/hw/riscv/boot.c
>> > @@ -33,10 +33,8 @@
>> >  #include <libfdt.h>
>> >
>> >  #if defined(TARGET_RISCV32)
>> > -# define KERNEL_BOOT_ADDRESS 0x80400000
>> >  #define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
>> >  #else
>> > -# define KERNEL_BOOT_ADDRESS 0x80200000
>> >  #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
>> >  #endif
>> >
>> > @@ -49,6 +47,15 @@ bool riscv_is_32_bit(MachineState *machine)
>> >      }
>> >  }
>> >
>> > +target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
>> > +                                          target_ulong firmware_end_addr) {
>> > +    if (riscv_is_32_bit(machine)) {
>> > +        return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
>> > +    } else {
>> > +        return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
>> > +    }
>> > +}
>> > +
>> >  target_ulong riscv_find_and_load_firmware(MachineState *machine,
>> >                                            const char *default_machine_firmware,
>> >                                            hwaddr firmware_load_addr,
>> > @@ -123,7 +130,9 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
>> >      exit(1);
>> >  }
>> >
>> > -target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
>> > +target_ulong riscv_load_kernel(const char *kernel_filename,
>> > +                               target_ulong kernel_start_addr,
>> > +                               symbol_fn_t sym_cb)
>> >  {
>> >      uint64_t kernel_entry;
>> >
>> > @@ -138,9 +147,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
>> >          return kernel_entry;
>> >      }
>> >
>> > -    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
>> > +    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
>> >                                 ram_size, NULL) > 0) {
>> > -        return KERNEL_BOOT_ADDRESS;
>> > +        return kernel_start_addr;
>> >      }
>> >
>> >      error_report("could not load kernel '%s'", kernel_filename);
>> > diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
>> > index 0531bd879b..cc758b78b8 100644
>> > --- a/hw/riscv/opentitan.c
>> > +++ b/hw/riscv/opentitan.c
>> > @@ -75,7 +75,8 @@ static void opentitan_board_init(MachineState *machine)
>> >      }
>> >
>> >      if (machine->kernel_filename) {
>> > -        riscv_load_kernel(machine->kernel_filename, NULL);
>> > +        riscv_load_kernel(machine->kernel_filename,
>> > +                          memmap[IBEX_DEV_RAM].base, NULL);
>> >      }
>> >  }
>> >
>> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> > index fcfac16816..59bac4cc9a 100644
>> > --- a/hw/riscv/sifive_e.c
>> > +++ b/hw/riscv/sifive_e.c
>> > @@ -114,7 +114,8 @@ static void sifive_e_machine_init(MachineState *machine)
>> >                            memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
>> >
>> >      if (machine->kernel_filename) {
>> > -        riscv_load_kernel(machine->kernel_filename, NULL);
>> > +        riscv_load_kernel(machine->kernel_filename,
>> > +                          memmap[SIFIVE_E_DEV_DTIM].base, NULL);
>> >      }
>> >  }
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index 5f3ad9bc0f..b2472c6627 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -415,6 +415,7 @@ static void sifive_u_machine_init(MachineState *machine)
>> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >      MemoryRegion *flash0 = g_new(MemoryRegion, 1);
>> >      target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
>> > +    target_ulong firmware_end_addr, kernel_start_addr;
>> >      uint32_t start_addr_hi32 = 0x00000000;
>> >      int i;
>> >      uint32_t fdt_load_addr;
>> > @@ -474,10 +475,15 @@ static void sifive_u_machine_init(MachineState *machine)
>> >          break;
>> >      }
>> >
>> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
>> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> > +                                                     start_addr, NULL);
>> >
>> >      if (machine->kernel_filename) {
>> > -        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
>> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
>> > +                                                         firmware_end_addr);
>> > +
>> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
>> > +                                         kernel_start_addr, NULL);
>> >
>> >          if (machine->initrd_filename) {
>> >              hwaddr start;
>> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> > index 3fd152a035..facac6e7d2 100644
>> > --- a/hw/riscv/spike.c
>> > +++ b/hw/riscv/spike.c
>> > @@ -195,6 +195,7 @@ static void spike_board_init(MachineState *machine)
>> >      MemoryRegion *system_memory = get_system_memory();
>> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
>> >      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> > +    target_ulong firmware_end_addr, kernel_start_addr;
>> >      uint32_t fdt_load_addr;
>> >      uint64_t kernel_entry;
>> >      char *soc_name;
>> > @@ -261,12 +262,16 @@ static void spike_board_init(MachineState *machine)
>> >      memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
>> >                                  mask_rom);
>> >
>> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> > -                                 memmap[SPIKE_DRAM].base,
>> > -                                 htif_symbol_callback);
>> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> > +                                                     memmap[SPIKE_DRAM].base,
>> > +                                                     htif_symbol_callback);
>> >
>> >      if (machine->kernel_filename) {
>> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
>> > +                                                         firmware_end_addr);
>> > +
>> >          kernel_entry = riscv_load_kernel(machine->kernel_filename,
>> > +                                         kernel_start_addr,
>> >                                           htif_symbol_callback);
>> >
>> >          if (machine->initrd_filename) {
>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> > index 41bd2f38ba..6bfd10dfc7 100644
>> > --- a/hw/riscv/virt.c
>> > +++ b/hw/riscv/virt.c
>> > @@ -493,6 +493,7 @@ static void virt_machine_init(MachineState *machine)
>> >      char *plic_hart_config, *soc_name;
>> >      size_t plic_hart_config_len;
>> >      target_ulong start_addr = memmap[VIRT_DRAM].base;
>> > +    target_ulong firmware_end_addr, kernel_start_addr;
>> >      uint32_t fdt_load_addr;
>> >      uint64_t kernel_entry;
>> >      DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
>> > @@ -602,11 +603,15 @@ static void virt_machine_init(MachineState *machine)
>> >      memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>> >                                  mask_rom);
>> >
>> > -    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> > -                                 memmap[VIRT_DRAM].base, NULL);
>> > +    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
>> > +                                                     start_addr, NULL);
>> >
>> >      if (machine->kernel_filename) {
>> > -        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
>> > +        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
>> > +                                                         firmware_end_addr);
>> > +
>> > +        kernel_entry = riscv_load_kernel(machine->kernel_filename,
>> > +                                         kernel_start_addr, NULL);
>> >
>> >          if (machine->initrd_filename) {
>> >              hwaddr start;
>>
>> It's probably worth going through and making sure we mark the right regions as
>> reserved in the DT, as with these being mobile we might run into latent bugs.
>
> Do you mean mark where the firmware is as reserved?

Ya.  We have some things like Linux assuming that the first page in memory is
reserved for the bootloader, which IIRC never really got written down in any
specifications.  That's an implicit S-mode ABI, so it doesn't apply directly,
but I'd guess there's some of this floating around elsewhere in the stack.

>> I haven't actually looked so maybe we're fine, but IIRC we sort of papered over
>> a handful of memory layout agreements that weren't even in specs (or event
>> meant to be in specs) that have stuck around for quite a while.
>
> For the virt machine or the sifive_u?

My guess is that any of this would apply to both of these, as the issue would
be assumptions within the firmware about the memory image provided to it when
it's entered.  That would be an ABI between the firmware and whatever loads it,
but IIRC for both the virt board and the sifive_u we assume the firmware is
just loaded directly my QEMU.

The sifive_u board may be additionally constrained by SiFive's boot ROM, but I
don't remember it really caring about any of this.  Also not sure it's even
used any more, as it was really just a vehicle to demonstrate initializing the
widgets for which we couldn't release RTL.

>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Thanks
>
> Alistair

