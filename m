Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF04C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102C62073E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 04:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="YyAN4NJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102C62073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV6Pl-0006Nh-5Q
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 00:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6P6-0005Pi-KL
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:39:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1jV6P5-0003pC-At
 for qemu-devel@nongnu.org; Sun, 03 May 2020 00:39:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id v4so12802892wme.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J7dhoF+USGP5XyNnyjDmxKjt2P5W3J9UKjTaRpyy924=;
 b=YyAN4NJa40ncja/DhPH1n7hR/DkW9Y9rxL1bVEzdrON50v42vC3v4kN6bffAfolbRP
 eNkwt7g0VWN0/5P4bKdLUGyJgK1fpLOO3sQNY1nA9EXM/fOdF1MxGHiNSkcsJNGmFV08
 liudGgh3sSQspGvCd+kvLZRxU+yi4eqgiRJXDJwGILeKWS7Y+wo0EayRt0P02UJrNTa7
 aLI0rlsD5QvCNVh/y6EzCBP/7/zkdEXr7DmKJnL9PNRVFxkQKSUlvJHhMxSXA56UXgAu
 twWpcfxvR4939JJiygUAJ4NF+rkEIXPag2HOeYbWfnVfpX0FirN3bS7uHEwzNW7TCVIQ
 qHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J7dhoF+USGP5XyNnyjDmxKjt2P5W3J9UKjTaRpyy924=;
 b=EHLmc7h/AVkXQRf4eFkW6llawteTDIAftceuVZdD4iC0YbF6AI2YE7Wk+LvIY2fxXX
 477Z+4+2IJ06isO/WxBd/g/p5AMlINJ9wDhvYMCEjmPCGv/HPEGz7wk+RpHPX1Y590aO
 ZF8XNg0CBpfN7o5nbznOd9Sg+TGlvrMf0PiR6G+iKvmeoakrwgIxqXbLk8KwR/Xdzrzz
 HU2zJh5vsBi+o8PLKlNrWDnR+QILtPQKMGJlM2XfNt0sk30yqBMRmTxxmARksEnyBS1/
 6lnbDQC9QISX/UqOkM/E9eifvTY7T8GO9cRLhcEeS9M7ipR8eKnvY8vs3A7aUCcc0bZ6
 RRSg==
X-Gm-Message-State: AGi0PubOlYiD9DBXVklRm5L/IdNlqKQaOFW9p8+IeA0oru0rw5cbhWCe
 yDvJM0AdpvD60kjj2huMeiHJBlAm+qIkuZA8Puw3tg==
X-Google-Smtp-Source: APiQypIILzYJJDnIeqgZww69ISi4Iv658b/v982xMXz3llFs3irV2TSeHaWAbgB72ZnOFsEGGme2pfDjksNOD/GDsnM=
X-Received: by 2002:a1c:9d0d:: with SMTP id g13mr7945183wme.102.1588480737232; 
 Sat, 02 May 2020 21:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
 <1588348254-7241-2-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588348254-7241-2-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 3 May 2020 10:08:44 +0530
Message-ID: <CAAhSdy06i1zb6_aedLn41rWDzrjyTcJ_T954DcwX7k2bM_VcVw@mail.gmail.com>
Subject: Re: [PATCH 1/5] roms/opensbi: Update to support building bios images
 for generic platform
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=anup@brainfault.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 1, 2020 at 9:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The RISC-V generic platform is a flattened device tree (FDT) based
> platform where all platform specific functionality is provided based
> on FDT passed by previous booting stage. The support was added in
> upstream opensbi recently.
>
> Bring the QEMU roms/opensbi submodule to the upstream opensbi commit:
> commit 4f18c6e55049 ("platform: generic: Add Sifive FU540 TLB flush range limit override")
> with the following changes since v0.7 release:
>
>   1bb00ab lib: No need to provide default PMP region using platform callbacks
>   a9eac67 include: sbi_platform: Combine reboot and shutdown into one callback
>   6585fab lib: utils: Add SiFive test device
>   4781545 platform: Add Nuclei UX600 platform
>   3a326af scripts: adapt binary archive script for Nuclei UX600
>   5bdf022 firmware: fw_base: Remove CSR_MTVEC update check
>   e6c1345 lib: utils/serial: Skip baudrate config if input frequency is zero
>   01a8c8e lib: utils: Improve fdt_parse_uart8250() API
>   0a0093b lib: utils: Add fdt_parse_uart8250_node() function
>   243b0d0 lib: utils: Remove redundant clint_ipi_sync() declaration
>   e3ad7c1 lib: utils: Rename fdt_parse_clint() to fdt_parse_compat_addr()
>   a39cd6f lib: utils: Add FDT match table based node lookup
>   dd33b9e lib: utils: Make fdt_get_node_addr_size() public function
>   66185b3 lib: utils: Add fdt_parse_sifive_uart_node() function
>   19e966b lib: utils: Add fdt_parse_hart_id() function
>   44dd7be lib: utils: Add fdt_parse_max_hart_id() API
>   f0eb503 lib: utils: Add fdt_parse_plic_node() function
>   1ac794c include: Add array_size() macro
>   8ff2b94 lib: utils: Add simple FDT timer framework
>   76f0f81 lib: utils: Add simple FDT ipi framework
>   75322a6 lib: utils: Add simple FDT irqchip framework
>   76a8940 lib: utils: Add simple FDT serial framework
>   7cc6fa4 lib: utils: Add simple FDT reset framework
>   4d06353 firmware: fw_base: Introduce optional fw_platform_init()
>   f1aa9e5 platform: Add generic FDT based platform support
>   1f21b99 lib: sbi: Print platform hart count at boot time
>   2ba7087 scripts: Add generic platform to create-binary-archive.sh
>   4f18c6e platform: generic: Add Sifive FU540 TLB flush range limit override
>
> Update our Makefile to build the generic platform instead of building
> virt and sifive_u separately.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  roms/Makefile | 30 ++++++++----------------------
>  roms/opensbi  |  2 +-
>  2 files changed, 9 insertions(+), 23 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index f9acf39..cb00628 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -64,10 +64,8 @@ default help:
>         @echo "  u-boot.e500        -- update u-boot.e500"
>         @echo "  u-boot.sam460      -- update u-boot.sam460"
>         @echo "  efi                -- update UEFI (edk2) platform firmware"
> -       @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> -       @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> -       @echo "  opensbi32-sifive_u -- update OpenSBI for 32-bit sifive_u machine"
> -       @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> +       @echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
> +       @echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
>         @echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
>         @echo "  clean              -- delete the files generated by the previous" \
>                                       "build targets"
> @@ -170,29 +168,17 @@ skiboot:
>  efi: edk2-basetools
>         $(MAKE) -f Makefile.edk2
>
> -opensbi32-virt:
> +opensbi32-generic:
>         $(MAKE) -C opensbi \
>                 CROSS_COMPILE=$(riscv32_cross_prefix) \
> -               PLATFORM="qemu/virt"
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> +               PLATFORM="generic"
> +       cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-generic-fw_jump.bin

I think you should copy fw_jump.elf as well because QEMU Spike
platform needs it.

>
> -opensbi64-virt:
> +opensbi64-generic:
>         $(MAKE) -C opensbi \
>                 CROSS_COMPILE=$(riscv64_cross_prefix) \
> -               PLATFORM="qemu/virt"
> -       cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> -
> -opensbi32-sifive_u:
> -       $(MAKE) -C opensbi \
> -               CROSS_COMPILE=$(riscv32_cross_prefix) \
> -               PLATFORM="sifive/fu540"
> -       cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
> -
> -opensbi64-sifive_u:
> -       $(MAKE) -C opensbi \
> -               CROSS_COMPILE=$(riscv64_cross_prefix) \
> -               PLATFORM="sifive/fu540"
> -       cp opensbi/build/platform/sifive/fu540/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> +               PLATFORM="generic"
> +       cp opensbi/build/platform/generic/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-generic-fw_jump.bin

Same as above.

>
>  bios-microvm:
>         $(MAKE) -C qboot
> diff --git a/roms/opensbi b/roms/opensbi
> index 9f1b72c..4f18c6e 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit 9f1b72ce66d659e91013b358939e832fb27223f5
> +Subproject commit 4f18c6e55049d858c62e87d2605dd41c06956e4e
> --
> 2.7.4
>
>

Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

