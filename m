Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B34206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Jt8bmjjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B34206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs9WD-0008MN-QB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 13:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42569)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hs9VU-0007tf-2Q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hs9VS-000861-U8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:32:20 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:45082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hs9VS-00083O-NJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:32:18 -0400
Received: by mail-io1-xd36.google.com with SMTP id g20so121811018ioc.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O2HTUKYvHlRqmkm0dGzs7uXFFIWYFCO+j7nCy0iZr+Y=;
 b=Jt8bmjjDBUyPEIQDTjb3JJUwMG4vN3vCLFDnLSQXlygo6NIfinEp3cLjInQU7r9g2u
 CZJkWjKNbSYPov8R/Es667P/7DWMJVKwN45nRnWYKa0u992sQ4lAA2uQHa/ZW5wu6cgr
 l/ooypM/dGlhGqv8YeneBCHCQJtP+5XdTYnajGfyYq8EPwiRVFofO5eEN6ub3W1SvG4j
 ctcJnP2K0oLsrY1LqB9G5/TrenahRHec4seVp5QA8syh59JCzmFcFykFbBOg9jYp9iSW
 t98w2ZQjd2eXsYNkXbP+qXfUgp1Xi3NpNOpArMapoTCV7lluA8OMI/CEI/sY/8AK5h3z
 /rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O2HTUKYvHlRqmkm0dGzs7uXFFIWYFCO+j7nCy0iZr+Y=;
 b=lWlD2gL8wT/LV64n0mNpm7v4DY5ntHb6riSFEQ3NOCCf/PnA9etjueFwROWNbxpGlU
 dSIcQs2U0/q/g7RHSNUYFvWJdmtmR7I0E4XucZYvS+2DPn0U9hLGwU0S5PEAcfTMZbis
 fAQnd1BfgmlI0kbnZMdvUN4pHczqqqOCSb65TLUyNnPq2V5Opq/Kw3Erz+nfefQ8TbSc
 sS7746cbmy8h4On+CpWl1SiNcGvIrlFqZUVMASzgaW+gw0zfF5Y+iawlfDFinnmVXC1T
 +0DbeUguuqJhSN1TiIExJdxWWEpH4QF90cuWYZEpPJjIxyn/b/IlpNWFcPkHc+BEIC1B
 Y6Ug==
X-Gm-Message-State: APjAAAXPPAAUCkK+4uJp/sAn/h7lhIFXgzVm4XanTFq1Jun5vxzDvPY7
 1ZuKnR5CwZWjcwE4w+l0iM/A59MC5+fI0Oxl9OuAhA==
X-Google-Smtp-Source: APXvYqx7vQww1lnLSXxVrSaztwX3rwhtlgRsyRFAHjX26zQblXRZh4Wo/Bbm/m2yUPiZC8yClhN3qURtTla4uIFgYcY=
X-Received: by 2002:a05:6638:5:: with SMTP id z5mr43147299jao.58.1564421537790; 
 Mon, 29 Jul 2019 10:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564080680.git.alistair.francis@wdc.com>
 <50c1c6a3ace8b40f7b9d5395a2c3457cf1852721.1564080680.git.alistair.francis@wdc.com>
In-Reply-To: <50c1c6a3ace8b40f7b9d5395a2c3457cf1852721.1564080680.git.alistair.francis@wdc.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Tue, 30 Jul 2019 01:32:06 +0800
Message-ID: <CAEiOBXVO1W1p_K_ETC_x==9t0pZ2sctvp820M8FYwpXsXGuFgQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-4.2 v1 3/6] riscv: plic: Remove unused
 interrupt functions
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 26, 2019 at 2:55 AM Alistair Francis <alistair.francis@wdc.com>
wrote:

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_plic.c         | 12 ------------
>  include/hw/riscv/sifive_plic.h |  3 ---
>  2 files changed, 15 deletions(-)
>
> diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
> index 0950e89e15..864a1bed42 100644
> --- a/hw/riscv/sifive_plic.c
> +++ b/hw/riscv/sifive_plic.c
> @@ -161,18 +161,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
>      }
>  }
>
> -void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
> -{
> -    sifive_plic_set_pending(plic, irq, true);
> -    sifive_plic_update(plic);
> -}
> -
> -void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
> -{
> -    sifive_plic_set_pending(plic, irq, false);
> -    sifive_plic_update(plic);
> -}
> -
>  static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
>  {
>      int i, j;
> diff --git a/include/hw/riscv/sifive_plic.h
> b/include/hw/riscv/sifive_plic.h
> index ce8907f6aa..3b8a623919 100644
> --- a/include/hw/riscv/sifive_plic.h
> +++ b/include/hw/riscv/sifive_plic.h
> @@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
>      uint32_t aperture_size;
>  } SiFivePLICState;
>
> -void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
> -void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
> -
>  DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
>      uint32_t num_sources, uint32_t num_priorities,
>      uint32_t priority_base, uint32_t pending_base,
> --
> 2.22.0
>
>
Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com>
