Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE51C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0E122305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 09:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TnJEJHza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E122305
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHt4-00051b-Ug
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 05:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHse-0004VU-R5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvHsd-0005N1-Jq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:05:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvHsd-0005Mb-Dy
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 05:05:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id n5so101503908otk.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 02:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qNq/VVIozly4mU8URRv7Bc0mAKFdRAYpb0niVPiozRw=;
 b=TnJEJHzarJ+WYBX53OG/C2T06NDVOp32B35WHIOwcRZB1PP2hHWGEN/67tjNTXS50g
 1D945yJHnUfiJHABW3MJKMJiOjtFN+9HtQsku7Qp10hoiIJOr2lNK7IWM5a6IT/Bqsw4
 QHkxOUz7iTcpacpTrBSXBxrrzvsJVDNpp6d4bmOUBM09tAGVWcH6pMAPqWa4qpsf8ruL
 e3H32OQDqUX0P07MjGN/SIv2zmBvH3aCbXcyOdS6SHBexxZar1+SqLcRduAn6DHnEE4J
 F68HEuErXrdde6VXyb9dDgiIVxucH6/1v5A3JcyCh0yZeNSGqN30fHGdkKyzisJu8b0H
 FIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qNq/VVIozly4mU8URRv7Bc0mAKFdRAYpb0niVPiozRw=;
 b=YBmAh2+T4ndUG45DbULjpSORUL7XwvXNn7xrROy12M3L0LEgWiKIu8Hk+9bq0A9X1j
 +cgKfNoXoYhHEw2zhqBAKhJVN/sbE2784f2TlJwotCg3ZwtFofuZr++K2aV7oBkvTmqi
 xXSqhzIGFst8g626jGC6LfXmTKM9ikjXZRqlzklLR0t4nhufkooOTcI8gBcm1ybqOm8Z
 8OvB+87Ih7oRyCebNxllspn+kcuA7IbYiW6rF2BxF+8Pysv/9JsxSBzVveHpVLDS0FA0
 /sqaknILJxICxwBX+8uJYRJ1rRNiTruITcE4Euqs26jHk3+7lNWbNy9xIgLctYtFRyyH
 EKHg==
X-Gm-Message-State: APjAAAVU0X7d3krmWpqzp7bvpqiYnPLW2E7HpIByAxKZC3aWPr4EkRVj
 3W1e+FPrJHgxY46KYxMck0bkM1M08N/D/Pz57VEY5A==
X-Google-Smtp-Source: APXvYqx90EOWpkch2Mnv4OC0JIVdbuQK3ezkcBdWFwl5ju7J2vW0+gBuDU7etJm9fjrscZvDG7voFweUo17WJY3Frcg=
X-Received: by 2002:a5e:a70b:: with SMTP id b11mr3594694iod.286.1565168710141; 
 Wed, 07 Aug 2019 02:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-28-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565163924-18621-28-git-send-email-bmeng.cn@gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Wed, 7 Aug 2019 17:04:59 +0800
Message-ID: <CAEiOBXVzf_+akk3Kz9K8DjJtydUHg47ev-G49mTCpn1iG_ghKw@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v2 27/28] riscv: virt: Change
 create_fdt() to return void
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 3:54 PM Bin Meng <bmeng.cn@gmail.com> wrote:

> There is no need to return fdt at the end of create_fdt() because
> it's already saved in s->fdt. Other machines (sifive_u, spike)
> don't do it neither.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
> Changes in v2: None
>
>  hw/riscv/virt.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2f75195..6bfa721 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -112,7 +112,7 @@ static void create_pcie_irq_map(void *fdt, char
> *nodename,
>                             0x1800, 0, 0, 0x7);
>  }
>
> -static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry
> *memmap,
> +static void create_fdt(RISCVVirtState *s, const struct MemmapEntry
> *memmap,
>      uint64_t mem_size, const char *cmdline)
>  {
>      void *fdt;
> @@ -316,8 +316,6 @@ static void *create_fdt(RISCVVirtState *s, const
> struct MemmapEntry *memmap,
>          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>      }
>      g_free(nodename);
> -
> -    return fdt;
>  }
>
>
> @@ -373,7 +371,6 @@ static void riscv_virt_board_init(MachineState
> *machine)
>      size_t plic_hart_config_len;
>      int i;
>      unsigned int smp_cpus = machine->smp.cpus;
> -    void *fdt;
>
>      /* Initialize SOC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> sizeof(s->soc),
> @@ -392,7 +389,7 @@ static void riscv_virt_board_init(MachineState
> *machine)
>          main_mem);
>
>      /* create device tree */
> -    fdt = create_fdt(s, memmap, machine->ram_size,
> machine->kernel_cmdline);
> +    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>
>      /* boot rom */
>      memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
> @@ -411,9 +408,9 @@ static void riscv_virt_board_init(MachineState
> *machine)
>              hwaddr end = riscv_load_initrd(machine->initrd_filename,
>                                             machine->ram_size,
> kernel_entry,
>                                             &start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen",
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen",
>                                    "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> +            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
>                                    end);
>          }
>      }
> --
> 2.7.4
>
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
