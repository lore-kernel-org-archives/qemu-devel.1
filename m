Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AACC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDDF2087B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glaipJGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDDF2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrHB-0003YC-Mm
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrGO-00030Y-Ui
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrGN-0000Nm-Md
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:04:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrGN-0000N0-HJ; Sun, 11 Aug 2019 13:04:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id k18so18848766otr.3;
 Sun, 11 Aug 2019 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zzHT6qv1dYLP1m5ri+3nIqCxqiuteq20GShCXqtxsOc=;
 b=glaipJGjBCy7bezDw3+WQa8Nx45PAI5tnJQmXwTbJR9NygSoTYYsa8PB37+NpXazrr
 /E7mPbv52EXEi2Ft/1DTqEpHsbjSu4r14zzHqN4i3zt9TZS2jtsDE3LlTjcw/7cIDfAP
 pfH83d5lAJWVpgBA1MV3efslPqKpe8yWLMsF9+PlO83iA6bzp+n+DO/zJoaUsfo0OkR2
 jlEBl8gLdWgimVphcUx+6d12vBz6E0brmR3fF/1/WnYFTkBQgKNT73+Lje1h2PJZIfDV
 Ero1X7VpHyJvveATyS2Yh+/ki6pEYhWzbbtMEtrqyrf0i5diZ/lrn+SA2GXS6+7x5n5H
 5smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zzHT6qv1dYLP1m5ri+3nIqCxqiuteq20GShCXqtxsOc=;
 b=Jz/ndfY4BHXApDWUUp35WEO2hw64Aij42i+FASgmxNF4ZwLCxXDtXUSL5zaw8+B/Bx
 vti6rBg5FgTp1ANP6ClwqM5Fhwps/Ikgz/nEf8lmo37krHnGNvN0I2BCkw80mXwcBpLQ
 pqZgmgd8A0+U4xm0AVstJmqLZdLiSa46BqyZnA6zH58P80qqZzagaulcJ4Iu0XQLPAPE
 vFBSOp0BTEEMNXTBHrvA+1Bt3Jm4bcgKvy983tH8BK6YWN4HZAePjJk1l6eihsB511xM
 8/xoKp4jJSLHA0o8dOToxQ9wpLHFLFuxxiK+tpteHwaECFmXy0FWW5lbdPEMRgaeo4ip
 iJBw==
X-Gm-Message-State: APjAAAVs81PiAt7G+RlPVANjtuQDqVM/l2zTXprDLYdKZ/HQQ7TmmID+
 2iZU527UNdP//1y/Vxqzd6P/L8BEzsfYLYNQYPY=
X-Google-Smtp-Source: APXvYqy2zO4pvaxGtODELd6+wgJYFFgWmhhZsmYd5hErHsyiBGWsNVo0ukhDgUhBgZV2ZBxW4JYyrQuTudqK0beT2vM=
X-Received: by 2002:a02:942c:: with SMTP id a41mr16452029jai.92.1565543050896; 
 Sun, 11 Aug 2019 10:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
 <1565510821-3927-8-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1565510821-3927-8-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:03:43 -0700
Message-ID: <CAKmqyKO3=wOjrGzY-bXJ+Lkx9Hg6X063Fb6HPyp8NDJ=nOQ8Wg@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 07/28] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 11, 2019 at 1:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> It is not useful if we only have one management CPU.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> Changes in v3:
> - use management cpu count + 1 for the min_cpus
>
> Changes in v2:
> - update the file header to indicate at least 2 harts are created
>
>  hw/riscv/sifive_u.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 295ca77..f8ffc0b 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -10,8 +10,8 @@
>   * 1) CLINT (Core Level Interruptor)
>   * 2) PLIC (Platform Level Interrupt Controller)
>   *
> - * This board currently generates devicetree dynamically that indicates at most
> - * five harts.
> + * This board currently generates devicetree dynamically that indicates at least
> + * two harts and up to five harts.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -425,6 +425,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V Board compatible with SiFive U SDK";
>      mc->init = riscv_sifive_u_init;
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
> +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
>  }
>
>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> --
> 2.7.4
>
>

