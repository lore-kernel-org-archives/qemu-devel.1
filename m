Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48920C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 17:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103D5206A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 17:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CC2pkCab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103D5206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJLHf-0008Oi-5g
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 13:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iJLH1-0007w4-K4
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 13:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iJLH0-0000SI-7i
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 13:33:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iJLH0-0000Rt-0W
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 13:33:46 -0400
Received: by mail-pf1-x441.google.com with SMTP id q5so7929642pfg.13
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=psV8h+u5vWoAnXsyabIV2bpSIzShrixi22SHQO7dfrQ=;
 b=CC2pkCabbfPYy7B3Rl9m7R8zKAEYmfR0Pg6XDnLBfq0RJFnDZMpBDeqMEjOhonIir1
 chccNmJrVBiGrViyxv5CjiwNpLOSP7K2LNtvZakC8lBfoKk/VyOIP43+4+8rtNaBTMZj
 k2cN+jVdWhaFnKDM/M4tNFpvW9ttW6vuJLtE9sG+kCoaELFphVKZgFj88cLIgegqHi4W
 uXH+2vPc1PwHVDoNyV27kBnTe215gmpBZ/CnjXjXHZLqpvj3gvgSfA/qXPzBSx+Cvgzb
 JR4UN9z9wH5tzXpzT01dffXLdDxrEhB98K0s0tHb5NsW7begGk/mkcWk1cWQ6KQmDYYJ
 Jp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=psV8h+u5vWoAnXsyabIV2bpSIzShrixi22SHQO7dfrQ=;
 b=NOAP8h73SEsyKNe8qMz6qfsi2qYykxxz+x+uXVJ1W52EXb5PEqqS4MNOS+PK8yd/A5
 O8q9GO8WCFY1Sfarjsdg/PtLB9iTh+vnoz2cVaz5LCu18SFkE3aGW67R7YYe8rFYepoL
 pnt3bcvoET0dxwWOarKemEX5tEU6ZIQEHWp9MGceQfKHGI2KrKI1Rxc1afKnZq2kt2Rq
 ctE6gsmyuXcyw/yVvb59cVQANE+nnXVU4+Y7d3n0hdq0nTOXW4tOP+cE2sTEXgMy4gyd
 H+Q52oD4hiuop+WtlxWp8RCG5miZUee201arfEV2QMrpo4M58kNW3KnoTnGfeJauA7L0
 nGqg==
X-Gm-Message-State: APjAAAVH4yh57nBtGJHs01DEEGbZB/rMG3qyJYSNxVxH5s5ACkF8V/Qz
 bxyu7YlfSrFDM35gim8TDh0tQRP5egdIqQ==
X-Google-Smtp-Source: APXvYqzyqjPi/jFFkeVcBNSOVgK6EGcjlbitI4lFHkRXYxOndRrp7aVQpwxjzExoAn2qSUYBw4oV3Q==
X-Received: by 2002:a63:6086:: with SMTP id u128mr5170586pgb.277.1570901624283; 
 Sat, 12 Oct 2019 10:33:44 -0700 (PDT)
Received: from localhost ([192.55.54.60])
 by smtp.gmail.com with ESMTPSA id o15sm11650858pjs.14.2019.10.12.10.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2019 10:33:43 -0700 (PDT)
Date: Sat, 12 Oct 2019 10:33:43 -0700 (PDT)
X-Google-Original-Date: Sat, 12 Oct 2019 10:33:19 PDT (-0700)
Subject: Re: [PATCH V6] target/riscv: Ignore reserved bits in PTE for RV64
In-Reply-To: <1569456861-8502-1-git-send-email-guoren@kernel.org>
From: Palmer Dabbelt <palmer@sifive.com>
To: guoren@kernel.org
Message-ID: <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, ren_guo@c-sky.com,
 alistair23@gmail.com, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 17:14:21 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
>
> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They cannot be a part of ppn.
>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_bits.h   | 7 +++++++
>  target/riscv/cpu_helper.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
>  Changelog V6:
>   - Add Reviewer: Alistair Francis
>
>  Changelog V5:
>   - Add Reviewer and Tester: Bin Meng
>
>  Changelog V4:
>   - Change title to Ignore not Bugfix
>   - Use PTE_PPN_MASK for RV32 and RV64
>
>  Changelog V3:
>   - Use UUL define for PTE_RESERVED
>   - Keep ppn >> PTE_PPN_SHIFT
>
>  Changelog V2:
>   - Bugfix pte destroyed cause boot fail
>   - Change to AND with a mask instead of shifting both directions
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e998348..399c2c6 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -473,6 +473,13 @@
>  /* Page table PPN shift amount */
>  #define PTE_PPN_SHIFT       10
>
> +/* Page table PPN mask */
> +#if defined(TARGET_RISCV32)
> +#define PTE_PPN_MASK        0xffffffffUL
> +#elif defined(TARGET_RISCV64)
> +#define PTE_PPN_MASK        0x3fffffffffffffULL
> +#endif
> +
>  /* Leaf page shift amount */
>  #define PGSHIFT             12
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6..9961b37 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -261,7 +261,7 @@ restart:
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
>  #endif
> -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> +        hwaddr ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
>
>          if (!(pte & PTE_V)) {
>              /* Invalid PTE */

I know I'm a bit late to the party here, but I don't like this.  There's ample 
evidence that wrapping the physical address space is a bad idea, and just 
because the ISA allows implementations to do this doesn't mean we should.

