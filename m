Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881A0C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30CC22574
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTXiINt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30CC22574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKd9N-0005Oq-JN
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKd8m-0004uT-2I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:55:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKd8k-0002Yt-8E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:55:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so15934650wrx.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LT2VWf4vo0h6YwWK778s41VyBezJI0XJHQ3hIkduw7Q=;
 b=JTXiINt9A12QF2KorSzAWXIwUG0ezddavLWqk3frmlt1mop0LeaRHbB7eOFSTBdFnU
 fmOpJ6GFPyn7NG6abqurzNyZsY9lpLLZlrwAmkIqeThBN0sfnMwyMAp44yDQbKXZZggy
 sh37ys6+wN1xrXKKECTQ6ICP68y6aSP2bcnpba1IPT0aoB7K5QBtr5fLHLYYM2oRMDVz
 iO2gyFrjzcGD02wo4n0um0HJSiXNoFlLYM4dmOzaI7RDq/ZJFXNC/gYuqeICYYJNS53R
 1SVu4PI7ff5RqIvsoMKgPq7+8t84wp7LlVU8Q5L3HCgVIEeVEaDbMmyvgZWy4A42b/GM
 DFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LT2VWf4vo0h6YwWK778s41VyBezJI0XJHQ3hIkduw7Q=;
 b=HjnabISg3pqR5yddmU6bsy8u7XnS67MicSPsP2uw6TuLZgdc9tOKMhsO0QeuuHfeQt
 30rI+akVm5SxriXYSHxGqXDJBEVAshFAIHgcIrvgdTYh/AQYssA6jZFKg4vyY8AtKpj1
 AfbNY4t6Wo9rl3gXzogFT940KajaZFIbUZ2nqEpAMMt5fo3ovmVZwvhlWgWJoiwkpzxQ
 DUzGepXCjkdTdXEBl3ly6W5cVAo33qDKtZyZ0KOKznwgMtZ3MmuebGflotS5tvhaCxQK
 zk2Hk4xrIhYeP3QaOwdoNo6Wu3AW9mm93A0aHs65X7BopmCFtGCtZMJm78qG/jt6GqbZ
 Xxgg==
X-Gm-Message-State: AOAM53176HAjYQa9hxGYvqXt3MzjGSHPHRYQPNYe/vFRYI5IfeHkRihd
 46w/IWYsrRcQ9GT8Zl8BjW0=
X-Google-Smtp-Source: ABdhPJzejLRUUTZSY8oTeD2azXYfezM4lx7yynrGZl0oRCoAHszs0SwB8RbMeSE0Xxlald/hvLZT+w==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr2897778wrj.155.1600761304805; 
 Tue, 22 Sep 2020 00:55:04 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 92sm26078665wra.19.2020.09.22.00.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 00:55:04 -0700 (PDT)
Subject: Re: [PATCH V10 6/8] hw/mips: Implement fw_cfg_arch_key_name()
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
 <1600742967-12933-7-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc293f25-85a6-8cb6-dd62-4c1831da62d8@amsat.org>
Date: Tue, 22 Sep 2020 09:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600742967-12933-7-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 4:49 AM, Huacai Chen wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> mips-specific key.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/mips/fw_cfg.c    | 35 +++++++++++++++++++++++++++++++++++
>  hw/mips/fw_cfg.h    | 19 +++++++++++++++++++
>  hw/mips/meson.build |  2 +-
>  3 files changed, 55 insertions(+), 1 deletion(-)
>  create mode 100644 hw/mips/fw_cfg.c
>  create mode 100644 hw/mips/fw_cfg.h
> 
> diff --git a/hw/mips/fw_cfg.c b/hw/mips/fw_cfg.c
> new file mode 100644
> index 0000000000..67c4a74f4b
> --- /dev/null
> +++ b/hw/mips/fw_cfg.c
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU fw_cfg helpers (MIPS specific)
> + *
> + * Copyright (c) 2020 Lemote, Inc.
> + *
> + * Author:
> + *   Huacai Chen (chenhc@lemote.com)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/mips/fw_cfg.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] = {
> +        {FW_CFG_MACHINE_VERSION, "machine_version"},
> +        {FW_CFG_CPU_FREQ, "cpu_frequency"},
> +    };
> +
> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}
> diff --git a/hw/mips/fw_cfg.h b/hw/mips/fw_cfg.h
> new file mode 100644
> index 0000000000..e317d5b9a3
> --- /dev/null
> +++ b/hw/mips/fw_cfg.h
> @@ -0,0 +1,19 @@
> +/*
> + * QEMU fw_cfg helpers (MIPS specific)
> + *
> + * Copyright (c) 2020 Huacai Chen
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_MIPS_FW_CFG_H
> +#define HW_MIPS_FW_CFG_H
> +
> +#include "hw/boards.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +/* Data for BIOS to identify machine */
> +#define FW_CFG_MACHINE_VERSION  (FW_CFG_ARCH_LOCAL + 0)
> +#define FW_CFG_CPU_FREQ         (FW_CFG_ARCH_LOCAL + 1)
> +
> +#endif
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index 46294b7382..c98391ce99 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -1,5 +1,5 @@
>  mips_ss = ss.source_set()
> -mips_ss.add(files('addr.c', 'mips_int.c'))
> +mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
>  mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
>  mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
>  mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
> 

