Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EE3C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5149021D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrkgh/Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5149021D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCzyw-0000xm-6l
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iCzxz-0000UU-7g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iCzxy-00077G-1A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:35:55 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iCzxx-00076p-Rk; Wed, 25 Sep 2019 01:35:53 -0400
Received: by mail-yb1-xb42.google.com with SMTP id v6so609442ybe.9;
 Tue, 24 Sep 2019 22:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6NUtFDJkUYFhjAoik14TZg3QphBVZGiIHkbmpHm+oQ=;
 b=Lrkgh/TqUL7J5ITZtE2lgw4bhjIAVn5aAxOWNPmyHOvGttyHyRIHIi2hfSxExpxeu0
 HVnJDr+31QxzZuJD75QPuYz75yGC8P4O9ZhBTvFc5DcYcqxO7MuoF/e1DiP5fQZT/J6h
 Yqyp26mKS14WyvdO4yTIt8JoH6QT1Pplx0tBRv3MOR1BrgaH+FhfLRbrvx0DR5hjLoRy
 l2M5yzUltDHt8zr0UYCf5+eJk15Xtve12Y9Pqucanm6pEY9tqTy9OcR7y2PkASOuggHz
 HCMNubXa3wNcmaj2ttozAkPgMFf+eLs37LM/YARUbE2cy7YJKDkQzLyXIjMX9BBi1o8D
 zaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6NUtFDJkUYFhjAoik14TZg3QphBVZGiIHkbmpHm+oQ=;
 b=Bn0WbnkUIKlYDsQoiTvdpbEkOKHx8FU+KUNJhn8ny2RFQHNJmrx1zaADAV8piLfZpy
 teCxQcEtqVHJoeKwfN4C0qshYaeRqeUPTmDa+S4uBkijcZz9JTsr9onHpxEWzGWN0sS8
 8MUFUOKYKcWBEa3EgUgtm9aUfK6bzEPmN0aq+9kH0HVqGPNGkCMIORVFLBAM76t8CgAu
 SmKPgFiml5FCu+ckWOPt8P3eBX5EWQlU2orv4ne9udX2KHXsxrTQNXG1xOp8LBlFdYrL
 UvBULk6uyayuwaGarpA99g5UKi6JW03Xa6vSJ9RBT+Y8CEdo7mApMyeFWnvvRXaIOaZG
 /GDw==
X-Gm-Message-State: APjAAAVS8bSVXLVSnF7LvrSg0eoEU5vPN4vItUOctLHGdWnrsZUVGMv2
 0lIYYskGUB7ExQ+jcSX78p9UCmHFxQeb9f4xI14=
X-Google-Smtp-Source: APXvYqyNIo/1LAS+Bw0ztwsHAxlOLSUzV3PTwMfkatlkcC1VHdrLfir+Mz9GkTzusXdQ3JdUpQWE0rZb4Nr4nUxzBqs=
X-Received: by 2002:a25:a87:: with SMTP id 129mr1709457ybk.203.1569389752973; 
 Tue, 24 Sep 2019 22:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569386895-8726-1-git-send-email-guoren@kernel.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 25 Sep 2019 13:35:41 +0800
Message-ID: <CAEUhbmW2SB9xak88XQ2LdKL6jtHoLWTQY+j-WFGvgO2tExh4pg@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 12:49 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>

nits: the title is probably better to be rephrased to: Ignore reserved
bits when calculating PPN for RV64

> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They can not be a part of ppn.

nits: cannot

>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_bits.h   | 3 +++
>  target/riscv/cpu_helper.c | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> ---
> Changelog V3:

nits: normally we put changelog before the changed file summary above,
and there is no need to put another ---

>  - Use UUL define for PTE_RESERVED.
>  - Keep ppn >> PTE_PPN_SHIFT
>
> Changelog V2:
>  - Bugfix pte destroyed cause boot fail
>  - Change to AND with a mask instead of shifting both directions
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index e998348..cdc62a8 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -470,6 +470,9 @@
>  #define PTE_D               0x080 /* Dirty */
>  #define PTE_SOFT            0x300 /* Reserved for Software */
>
> +/* Reserved highest 10 bits in PTE */
> +#define PTE_RESERVED        0xFFC0000000000000ULL

Can we define the macro for RV32 too, so that (see below)

> +
>  /* Page table PPN shift amount */
>  #define PTE_PPN_SHIFT       10
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6..7e04ff5 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -258,10 +258,12 @@ restart:
>          }
>  #if defined(TARGET_RISCV32)
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
> +        hwaddr ppn = pte;
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
> +        hwaddr ppn = pte & ~PTE_RESERVED;
>  #endif
> -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> +        ppn = ppn >> PTE_PPN_SHIFT;

we can just do this in this single line?

>
>          if (!(pte & PTE_V)) {
>              /* Invalid PTE */
> --

Regards,
Bin

