Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F61C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED942074B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 05:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJdTGGuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED942074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHhO3-00070x-HT
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 01:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhNM-0006Qi-2n
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:50:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHhNK-0000VF-DZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 01:50:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id e11so8096764wme.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MM4QN20OpQleKay+gY9gyk7Q5qZA5CeWW6wFCQ78now=;
 b=PJdTGGuWtZVacFUzY2a1tpNX39rJfOKCUWiPYisWPq6TyVwjT6qPKGon27m4412IWd
 RvVFdd8SCigvicAUyXgKSo3elprst1jBI3DhH7dHjwuUq1H6xgi4Yw354Dt3HPnOjsCQ
 W7JxAvr012qHLPZOvEn44b8wlN7vGXSEJCuZBV/HgyjHg5OHE1nV+tO9zY00ARL9rvjk
 qINbs6d9ExZcbgRZy965gXCz75hx8O3E0ju72GOl4fmyC9rinPJ7/xDjBoml9VmerC0s
 ioqekCMZcQNBpHN3+oYw0wshbRhB16UJtPhNJiS5vp9Y+eb+19Zol0VUTYzsOEvGfqHz
 GhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MM4QN20OpQleKay+gY9gyk7Q5qZA5CeWW6wFCQ78now=;
 b=AJhkzZb59juD8UxSiVKqO1det7etgl7GVRIqNLC/nxe+7ySPCwwF2TywlmqwkJfQj4
 oZlrOz5I6QZOofGEJRq46K8/AF6a71bkk2I3tx+RxwH0dl2890kdEvb3KPWezySDdByV
 WNQC6PSA7xYWbQ8xGAGDUnGRCD93jZqSbwMnbAZRoFZ0S1KUJIWtQmgVkEQYwpzmC9WO
 kHqKrZBS6vWe1w2x22iSdw0U40c25iELXRwQ6tBj2/+K0Y4krzRNi+yLhnU9cr9gsoNn
 ZQz/MFbwB+KM+QAFtPF2pyBXWU9lbQwj7F2791RKD1saN9xFdxXMObzarLzU7ByDjtl+
 gTVA==
X-Gm-Message-State: AOAM5301si61cSQP3AWGaMpBq8eHfmuiR35Kk60v6Vs1Q8RpMGXAUJMI
 QhCL8zpZHE6vi6GHw+qaXmY=
X-Google-Smtp-Source: ABdhPJxfZ/W0J2QXNNlA+cjX/aLEm6O8eEQlRa7QzxLg+P/bE7KDq1dnOgwio33ZB+tkAmtBjM9mBQ==
X-Received: by 2002:a1c:7907:: with SMTP id l7mr13230388wme.89.1600062600622; 
 Sun, 13 Sep 2020 22:50:00 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i3sm18877506wrs.4.2020.09.13.22.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 22:50:00 -0700 (PDT)
Subject: Re: [PATCH 05/11] disas: Use qemu/bswap.h for bfd endian loads
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200914000153.1725632-1-richard.henderson@linaro.org>
 <20200914000153.1725632-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1d157b8d-0295-799b-40cb-e1f36c505bac@amsat.org>
Date: Mon, 14 Sep 2020 07:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914000153.1725632-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 2:01 AM, Richard Henderson wrote:
> Use the routines we have already instead of open-coding.

Yay \o/
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/disas/dis-asm.h | 32 ++++++++++++++++++++----
>  disas.c                 | 55 -----------------------------------------
>  2 files changed, 27 insertions(+), 60 deletions(-)
> 
> diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
> index d2418c977e..8a216ac495 100644
> --- a/include/disas/dis-asm.h
> +++ b/include/disas/dis-asm.h
> @@ -468,11 +468,33 @@ int print_insn_rx(bfd_vma, disassemble_info *);
>  
>  /* from libbfd */
>  
> -bfd_vma bfd_getl64 (const bfd_byte *addr);
> -bfd_vma bfd_getl32 (const bfd_byte *addr);
> -bfd_vma bfd_getb32 (const bfd_byte *addr);
> -bfd_vma bfd_getl16 (const bfd_byte *addr);
> -bfd_vma bfd_getb16 (const bfd_byte *addr);
> +#include "qemu/bswap.h"
> +
> +static inline bfd_vma bfd_getl64(const bfd_byte *addr)
> +{
> +    return ldq_le_p(addr);
> +}
> +
> +static inline bfd_vma bfd_getl32(const bfd_byte *addr)
> +{
> +    return (uint32_t)ldl_le_p(addr);
> +}
> +
> +static inline bfd_vma bfd_getl16(const bfd_byte *addr)
> +{
> +    return lduw_le_p(addr);
> +}
> +
> +static inline bfd_vma bfd_getb32(const bfd_byte *addr)
> +{
> +    return (uint32_t)ldl_be_p(addr);
> +}
> +
> +static inline bfd_vma bfd_getb16(const bfd_byte *addr)
> +{
> +    return lduw_be_p(addr);
> +}
> +
>  typedef bool bfd_boolean;
>  
>  #endif /* DISAS_DIS_ASM_H */
> diff --git a/disas.c b/disas.c
> index 50b5677930..20fad6aabb 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -85,61 +85,6 @@ generic_symbol_at_address (bfd_vma addr, struct disassemble_info *info)
>    return 1;
>  }
>  
> -bfd_vma bfd_getl64 (const bfd_byte *addr)
> -{
> -  unsigned long long v;
> -
> -  v = (unsigned long long) addr[0];
> -  v |= (unsigned long long) addr[1] << 8;
> -  v |= (unsigned long long) addr[2] << 16;
> -  v |= (unsigned long long) addr[3] << 24;
> -  v |= (unsigned long long) addr[4] << 32;
> -  v |= (unsigned long long) addr[5] << 40;
> -  v |= (unsigned long long) addr[6] << 48;
> -  v |= (unsigned long long) addr[7] << 56;
> -  return (bfd_vma) v;
> -}
> -
> -bfd_vma bfd_getl32 (const bfd_byte *addr)
> -{
> -  unsigned long v;
> -
> -  v = (unsigned long) addr[0];
> -  v |= (unsigned long) addr[1] << 8;
> -  v |= (unsigned long) addr[2] << 16;
> -  v |= (unsigned long) addr[3] << 24;
> -  return (bfd_vma) v;
> -}
> -
> -bfd_vma bfd_getb32 (const bfd_byte *addr)
> -{
> -  unsigned long v;
> -
> -  v = (unsigned long) addr[0] << 24;
> -  v |= (unsigned long) addr[1] << 16;
> -  v |= (unsigned long) addr[2] << 8;
> -  v |= (unsigned long) addr[3];
> -  return (bfd_vma) v;
> -}
> -
> -bfd_vma bfd_getl16 (const bfd_byte *addr)
> -{
> -  unsigned long v;
> -
> -  v = (unsigned long) addr[0];
> -  v |= (unsigned long) addr[1] << 8;
> -  return (bfd_vma) v;
> -}
> -
> -bfd_vma bfd_getb16 (const bfd_byte *addr)
> -{
> -  unsigned long v;
> -
> -  v = (unsigned long) addr[0] << 24;
> -  v |= (unsigned long) addr[1] << 16;
> -  return (bfd_vma) v;
> -}
> -
>  static int print_insn_objdump(bfd_vma pc, disassemble_info *info,
>                                const char *prefix)
>  {
> 


