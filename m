Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA2CC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491EC2076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwgerN1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491EC2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPRCT-0007vs-61
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRBV-0006zV-U4
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPRBU-0001tf-Tw
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:33 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43241)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPRBU-0001ss-Ka
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:37:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id j16so2042910oih.10
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mF6t6DrxG448bVneKOHPIF3gBskDqsvioWPmNHSo5OY=;
 b=lwgerN1qaufyGsE408recmf6KgtQlJhLlMhRDWET9+ATM32r1dPzC4OKp4g3sWqRfF
 Dt/m2g/t5wuomW4h2UQ3AP3TIoLoqROepB77u33V++hCnVlLK8Zm/0hWVOYrE4gCXIJ5
 ALWYwZlrY55VQtNPP3nP2FGU5Is7JkBaCYaRF4+GkJLXFPMyKLxf+qNqWqYgRu2BPYoL
 CqKmRRgghADYljMEXRVu6EDWUxDDkg3Wb5ldMHw1eM8m+x5wuhJIPd3OOh3s4ltMo6hL
 ScLMbQ0zGjhlVHfvpqTHubEleosPb9sImyl+v4XKWNhPvgz7F1NfsX+yRkgBLohmzp3P
 KZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mF6t6DrxG448bVneKOHPIF3gBskDqsvioWPmNHSo5OY=;
 b=BSNghPWggn4UTupEQfjQDjhbF1neiO6kEyL/v72A21SdFzE4Jhu8PQhkPd0og/9xVb
 XlMxVrlj31SM2QYZNpyapV6+ArPDaEDrOnjypOwlQaVVjZKOF/3aVJBZXBWXLTyL9MKl
 etykHm7aOCcQeRlRN+eh7SelJH011oyDCHy40/Eihju0VYTyXPooPBZEfIG0FbEUwfRU
 o0iCHpUtZwZx7nlGiFZGOzCIz057meeV1J76JqAOdrPdLiPcZolSUfEGWRIZTcZZyT1R
 qdWO22KzpfDbYVp+uub0DaMzg975NHlhBcVNI7Xty8qbgfB2b67/gN4vuN3ToyAGXdLO
 NWfA==
X-Gm-Message-State: AGi0PuYO9kSNfFnXGvrwHXv490pT7jCJxhl0r5YodN+0stI6jTFEc4A3
 KV/hbOXeJ79hkpoGyh3/SxLBIfZAYzXkMtT8HmNbAg==
X-Google-Smtp-Source: APiQypKDaXqnwNqfpJ9oYIQxG/HuaUhrvoq5EeaXeJk/svXs3ZHilvIfwt0PBLnHtOTqmsyoXefI3936FyfRaUm//uc=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr2047132oia.146.1587130651702; 
 Fri, 17 Apr 2020 06:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200416090247.353414-1-rfried.dev@gmail.com>
In-Reply-To: <20200416090247.353414-1-rfried.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 14:37:20 +0100
Message-ID: <CAFEAcA8kZw_xd-Snogxavyxpo5nyjoExV6DPfyTa3=4RqpTJVA@mail.gmail.com>
Subject: Re: [PATCH] Cadence: gem: fix wraparound in 64bit descriptors
To: Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Apr 2020 at 10:02, Ramon Fried <rfried.dev@gmail.com> wrote:
>
> Wraparound of TX descriptor cyclic buffer only updated
> the low 32 bits of the descriptor.
> Fix that by checking if we're working with 64bit descriptors.
>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  hw/net/cadence_gem.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 51ec5a072d..b8ae21cc0d 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
>              /* read next descriptor */
>              if (tx_desc_get_wrap(desc)) {
>                  tx_desc_set_last(desc);
> -                packet_desc_addr = s->regs[GEM_TXQBASE];
> +
> +            if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
> +                packet_desc_addr = s->regs[GEM_TBQPH];
> +                packet_desc_addr <<= 32;
> +            } else {
> +                packet_desc_addr = 0;
> +            }
> +                packet_desc_addr |= s->regs[GEM_TXQBASE];

The indentation seems to be off here.

You could write this as:

    packet_desc_addr = s->regs[GEM_TXQBASE];
    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
        packet_desc_addr |= (uint64_t)s->regs[GEM_TBQPH] << 32;
    }

which ends up as the same thing but matches the code used
in tx_desc_get_buffer() to assemble an address that's
32 or 64 bits depending on the ADDR_64B flag.

>              } else {
>                  packet_desc_addr += 4 * gem_get_desc_len(s, false);
>              }
> --
> 2.26.0

thanks
-- PMM

