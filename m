Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D55C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1149020836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk/Cd+6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1149020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6HHe-0004jR-8z
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6HBP-0005wV-98
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6HBL-0006tV-DD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:06:15 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:41163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6HBL-0006st-4c; Mon, 24 Feb 2020 12:06:11 -0500
Received: by mail-lf1-x12f.google.com with SMTP id y17so4211099lfe.8;
 Mon, 24 Feb 2020 09:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K2lollYogFHHyQXa6uhkLeqNvv20M9DV6fI1nPg7JwE=;
 b=Yk/Cd+6FGemSVmolvlJHIejsAfaqYwBuI0JdTENk+WUg3hXEUu3ow3VOvOL5wZwBfq
 WgKeZBzAd+SZhvu1CkPRN8cRG/boBU2Xf4kituY7ZRHTE0Ax/l7ylrrU4gl3lBcpPFzQ
 535p1B+yqXhHBHaveXPXdAsDMzfW2c1qX4NYpBz0ltuRVnlOVvocugfeSRzzmvu63wGh
 GNVEaFHtfqVwz1LSq74jwCjWlOWvuzGsFVlwuPVwQUs05VYIfEAPFeOAHSkCNGyCmnhp
 wr7fADzFRA/SCkx22p/Axwm9vj9KaTY4KDjmTrm8NQd2EU1UJFF4uv0Lnf/tpn69hd6E
 hcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K2lollYogFHHyQXa6uhkLeqNvv20M9DV6fI1nPg7JwE=;
 b=S52IZP8H2Bd4qDGpI3IKV3aYNk2lCQTed5L6CWQeYfIh6p1PURxAe04iypfm1TCyhv
 /QoCrm6nqvE4NZvtQeMoweCmomNxyxJH+OePGBBnwRQo4PpS5cXTm0yuJ0bcf4xqTywQ
 vxgtNf7N5ZqG3Ce4PqSV0GRo+2yR5dOtmWWOemT7F98WT+HuyHHqYbJjsb070iYsXje/
 SULJ4t4+DWogvuGVY8/3B1QS+Sb3FiWIyxwa5aK7kdCkblJ49w/KsC3YaoGdxCPGDa4J
 DL7zzv3MGXN33Vsay5L6sbXuFKKwV9OyqZbTL/WFfe1rWkaMmQeI5HXITFuq1PvLUOuM
 kjPA==
X-Gm-Message-State: APjAAAXFrkc9WOQRdRuvQBItbhI6hUUsvITOX5ZzWeQxa86nAt6Mc4u9
 NB9c3/I9ZlFmae2XgHNguMmUVO4bB7nunmu30BM=
X-Google-Smtp-Source: APXvYqxWqEXT4KmnVn+jPODSrVz6t+5FztMWikPw5gBDdsPO/NSm7KWNyMovMho8x5AIIjX8UF9VxmTyBgOWj1LoPOk=
X-Received: by 2002:a19:4a:: with SMTP id 71mr28015241lfa.50.1582563968755;
 Mon, 24 Feb 2020 09:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1582551584-20093-1-git-send-email-bmeng.cn@gmail.com>
 <1582551584-20093-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1582551584-20093-2-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2020 08:58:35 -0800
Message-ID: <CAKmqyKOgUG4cbyjh3YYWcMqTnNU3dqGv_fxgwWp8p6Gzs_vp5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] roms: opensbi: Upgrade from v0.5 to v0.6
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12f
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 5:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Upgrade OpenSBI from v0.5 to v0.6 and the pre-built bios images.
>
> The v0.6 release includes the following commits:
>
> dd8ef28 firmware: Fix compile error for FW_PAYLOAD with latest GCC binutils
> 98f4a20 firmware: Introduce relocation lottery
> f728a0b include: Sync-up encoding with priv v1.12-draft and hypervisor v0.5-draft
> 18897aa include: Use _UL() and _ULL() for defines in riscv_encoding.h
> 7a13beb firmware: Add preferred boot HART field in struct fw_dynamic_info
> 215421c lib: Remove date and time from init message
> 838657c include: Remove ilen member of struct unpriv_trap
> b1d8c98 lib: No need to set VSSTATUS.MXR bit in get_insn()
> 0e1322b lib: Better naming of unpriv APIs for wider use
> 75f903d lib: Simplify trap parameters in sbi_ecall functions
> c96cc03 lib: Fix CPU capabilities detection function
> ab14f94 lib: Fix probe extension
> 813f7f4 lib: Add error detection for misa_extension
> dc40042 include: sbi_platform: fix compilation for GCC-9
> bd732ae include: Add guest external interrupt related defines
> 6590a7d lib: Delegate guest page faults to HS-mode
> 4370f18 include: Extend struct sbi_trap_info for mtval2 and mtinst
> 086dbdf lib: Fix sbi_get_insn() for load guest page fault
> 2be424b lib: Extend trap redirection for hypervisor v0.5 spec
> 7219477 lib: Use MTINST CSR in misaligned load/store emulation
> b8732fe lib: Add replacement extension and function ids
> aa0ed1d lib: Remove redundant IPI types
> 1092663 lib: Add TIME extension in SBI
> 9777aee lib: Add IPI extension in SBI
> 9407202 lib: Add hfence instruction encoding
> 331ff6a lib: Support stage1 and stage2 tlb flushing
> 86a31f5 lib: Implement RFENCE extension
> c7d1b12 firmware: Return real DTB address when FW_xyz_FDT_ADDR is not defined
> 9beb573 firmware: Improve comments for fw_prev_arg1() and fw_next_arg1()
> fc6bd90 docs: Improve docs for FDT address passing
> 46a90d9 lib: utils: Support CLINT with 32bit MMIO access on RV64 system
> c0849cd platform: Add T-head C910 initial support
> e746673 lib: Remove unnecessary checks from init_coldboot() and init_warmboot()
> c3e406f lib: Add initial sbi_exit() API
> 55e191e lib: Add system early_exit and final_exit APIs
> 6469ed1 lib: Add timer exit API
> b325f6b lib: Add ipi exit API
> 1993182 lib: Add irqchip exit API
> 2aa43a1 lib: save/restore MIE CSR in sbi_hart_wait_for_coldboot()
> b0c9787 lib: do sbi_exit() upon halt IPI
> 15ed1e7 lib: improve system reboot and shutdown implementation
> 73c19e6 lib: zero-out memory allocated using sbi_scratch_alloc_offset()
> a67fd68 lib: Add sbi_init_count() API
> 049ad0b build: Use -ffreestanding
> e340bbf include: Add OPENSBI_EXTERNAL_SBI_TYPES in sbi_types.h
> b28b8ac docs: Add description of using OPENSBI_EXTERNAL_SBI_TYPES
> adf8b73 platform: thead/c910: Remove SBI_PLATFORM_HAS_PMP
> f95dd39 docs: platform: Update SiFive FU540 doc as-per U-Boot v2020.01
> 6ffe1be firmware: Fix placement of .align directives
> 7daccae platform: thead/c910: Don't enable L2 cache in warm boot
> a73d45c platform: thead/c910: Don't set plic/clint address in warm boot
> 30cdf00 scripts: Add C910 to platform list in the binary archive script
> 0492c5d include: Typo fix in comment for SBI_SCRATCH_SIZE define
> 046cc16 lib: Move struct sbi_ipi_data definition to sbi_ipi.c
> 3d2aaac lib: Introduce sbi_ipi_send_smode() API
> da9b76b lib: Introduce sbi_ipi_send_halt() API
> a8b4b83 lib: Introduce sbi_tlb_fifo_request() API
> 5f762d1 lib: Introduce sbi_ipi_event_create/destroy() APIs
> 817d50d lib: Drop _fifo from the name of various sbi_tlb_fifo_xyz() functions
> 84cd4fc lib: Initialize TLB management directly from coldboot/warmboot path
> 0a411bf include: Add generic and simple list handling APIs
> 37923c4 lib: Add dynamic registration of SBI extensions
> 7668502 lib: Factor-out SBI legacy extension
> 161b348 lib: Factor-out SBI replacement extensions
> 43ac621 lib: Factor-out SBI vendor extension
> 021b9e7 lib: Factor-out SBI base extension
> 85647a1 platform: template: typo fix in system reboot/shutdown names
> ac1c229 platform: Update UART base addresses for qemu/sifve_u
> d79173b platform: Add an platform ops to return platform specific tlb flush limit
> 2c2bbe7 platform: sifive/fu540: Set tlb range flush limit to zero
> 5ff1ab0 makefile: add support for building on macOS
> 6d0b4c5 platform: Drop qemu/sifive_u support
> 9a717ec platform: sifive: fu540: Add platform specific 'make run' cmd
> d6fa7f9 doc: sifive: fu540: Update QEMU instruction when using U-Boot as the payload
> 179edde lib: sbi_scratch: use bitwise ops in sbi_scratch_alloc_offset()
> 897b8fb lib: Use __builtin_ctzl() in pmp_get()
> 1a8ca08 lib: Initialize out value in SBI calls
> c2bfa2b lib: irqchip/plic: Disable all contexts and IRQs
> c2f23cc platform: Add Spike initial support
> a062200 platform: Remove stale options from config.mk files
> c03c8a1 scripts: Add Spike to platform list of binary archive script
> 29bb2a6 docs: platform: Add documentation for Spike platform
> 48b06ad ThirdPartyNotices: Fix doc styles
> 892e879 doc: coreboot: Fix doc styles
> fdfb533 doc: payload_linux: Fix doc styles
> 44d1296 doc: andes-ae350: Fix doc styles
> a8ef0b5 doc: ariane-fpga: Fix doc styles
> 82fd42f doc: qemu_virt: Fix doc styles
> f8ce996 doc: sifive_fu540: Fix doc styles
> 27a5c7f doc: thead-c910: Fix doc styles
> 0b41453 Revert "lib: Use __builtin_ctzl() in pmp_get()"
> c66543d lib: utils: htif: Fix 32-bit build
> bc874e3 lib: Don't check MIDELEG and MEDELEG at end of delegate_traps()
> 24c3082 lib: Print interrupt and exception delegation in boot prints
> 66fb729 platform: sifive: fu540: Add 32-bit specific fdt/payload addresses
> 3e7d666 platform: qemu: virt: Correct the typo in config.mk
> c3b3b8f lib: Fix typo in atomic exchange functions
> 3936243 lib: Use available hart mask for correct hbase value
> f8b3bb8 lib: Simplify the for-loop in sbi_ipi_send_many()
> ac5e821 include: Bump-up version to 0.6
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v2:
> - new patch: Upgrade opensbi from v0.5 to v0.6
>
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 40984 -> 41280 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 49160 -> 53760 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 45064 -> 49664 bytes
>  roms/opensbi                                 |   2 +-
>  4 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi-riscv32-virt-fw_jump.bin

