Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBECC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB20120708
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnlkCLKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvka-0003P4-S0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvYN-0006Sc-DR; Thu, 17 Sep 2020 11:10:31 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kIvYK-0002Ud-PB; Thu, 17 Sep 2020 11:10:31 -0400
Received: by mail-lj1-x242.google.com with SMTP id u21so2345710ljl.6;
 Thu, 17 Sep 2020 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=t93QmXvWf49oJ6tHh5ukHLlQ/jL/PlDziVbWsUzfxF0=;
 b=RnlkCLKvtnpPscBbHjg9Td1Sh3EXBregPZZtqPvfyuswaehWutH6DEUrO+8CkL290G
 WZrhdK33LXAuhyYehGrNXwyQPvCjj3rW184P+SEugJSEGotXRApPE3B4sqbtYGy1OO6N
 4FWGYNiOS1xOmIJkhawM3FFzzskd3uJQZqMJrsuc/CzS1UU+O2nlRhSOGNA+PYtgFK+Z
 VrgS3krcO3DWQahKZCim8/QIokhYjM4Sv2ieiOjCBUVaBsSp1pMkoqm+W17p4Kt0b+k5
 g6I+TDe+qyUxgjvKEazlf66EuHXQFyIoxOgwvBYBM8apfYvTgCYeH74s2RLNjNtIQJAt
 cnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=t93QmXvWf49oJ6tHh5ukHLlQ/jL/PlDziVbWsUzfxF0=;
 b=V5ZhDYqGa7uY3Yy1UdjB1JUrkydwmdsNEEem7+TsRPSKMPYQIvX3zArZ2jmG1WFU7n
 JDYiQn6hobnHH/zXPwZbbkzd1vT2IGUx7PdURKkPq9y/XLAZd1z5WyBYQijoEeUJ0ywp
 XbNXwBMwwfZNo7nVjVQLIj2fR74Iv/5sqbc8/k2aMOzwh/78T4enoC/0orJN1WKt4qQO
 RHc1LQYsWmEMYuAvFXua0UYgmypv/n+8DQhSLvrCag+QMBDfVy1pHSgIFXs+5kLxQHjv
 dViJKsVPanq5TrB9Rsf5hrhFtF4Y5wdC/F01S+TY6y+WnthPoUJFFGn5WOahgv8nVkSH
 OCsg==
X-Gm-Message-State: AOAM533iQLBpjLmoz7RtCg4g8wo5wJh+SmzFMB9PIKC558fIE9zpVnmJ
 7iK9JL1q1n5u9FZDZi1cStY=
X-Google-Smtp-Source: ABdhPJw8ZFgDz0jPnFCTa6k7FECtkyXOf/5XXjr9iOygWZ9fUbXZ34A6KPIvMEsGeFecJV1k4f3+Tg==
X-Received: by 2002:a2e:6f1c:: with SMTP id k28mr9517475ljc.297.1600355425763; 
 Thu, 17 Sep 2020 08:10:25 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 o8sm5234603lfn.179.2020.09.17.08.10.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Sep 2020 08:10:25 -0700 (PDT)
Date: Thu, 17 Sep 2020 17:10:23 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 2/9] m25p80: Add the n25q256a SFDP table
Message-ID: <20200917151022.vy5u6x5an23cnzhn@fralle-msi>
References: <20200902093107.608000-1-clg@kaod.org>
 <20200902093107.608000-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902093107.608000-3-clg@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cedric,

On [2020 Sep 02] Wed 11:31:00, Cédric Le Goater wrote:
> The same values were collected on 4 differents OpenPower systems,
> palmettos, romulus and tacoma.
> 
> The SFDP table size is defined as being 0x100 bytes but it could be
> bigger. Only the mandatory table for basic features is available at
> byte 0x30.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80_sfdp.h |  2 ++
>  hw/block/m25p80.c      |  6 +++--
>  hw/block/m25p80_sfdp.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>  hw/block/meson.build   |  1 +
>  4 files changed, 65 insertions(+), 2 deletions(-)
>  create mode 100644 hw/block/m25p80_sfdp.c
> 
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index 230b07ef3308..d3a0a778ae84 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -15,4 +15,6 @@
>   */
>  #define M25P80_SFDP_MAX_SIZE  (1 << 24)
>  
> +extern uint8_t m25p80_sfdp_n25q256a(uint32_t addr);

s/extern//

> +
>  #endif
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 4d6133b3594e..dbfd88b41a12 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -234,11 +234,13 @@ static const FlashPartInfo known_devices[] = {
>      { INFO("n25q128a11",  0x20bb18,      0,  64 << 10, 256, ER_4K) },
>      { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
>      { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
> -    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K),
> +      .sfdp_read = m25p80_sfdp_n25q256a },
>      { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
> -    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K),
> +      .sfdp_read = m25p80_sfdp_n25q256a },
>      { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>      { INFO("n25q512ax3",  0x20ba20,  0x1000,  64 << 10, 1024, ER_4K) },
>      { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> new file mode 100644
> index 000000000000..24ec05de79a1
> --- /dev/null
> +++ b/hw/block/m25p80_sfdp.c
> @@ -0,0 +1,58 @@
> +/*
> + * M25P80 Serial Flash Discoverable Parameter (SFDP)
> + *
> + * Copyright (c) 2020, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "m25p80_sfdp.h"
> +
> +#define define_sfdp_read(model)                                       \
> +    uint8_t m25p80_sfdp_##model(uint32_t addr)                        \
> +    {                                                                 \
> +        assert(is_power_of_2(sizeof(sfdp_##model)));                  \
> +        return sfdp_##model[addr & (sizeof(sfdp_##model) - 1)];       \
> +    }
> +
> +/*
> + * Micron
> + */
> +static const uint8_t sfdp_n25q256a[] = {
> +    0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
> +    0x00, 0x00, 0x01, 0x09, 0x30, 0x00, 0x00, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x0f,
> +    0x29, 0xeb, 0x27, 0x6b, 0x08, 0x3b, 0x27, 0xbb,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x27, 0xbb,
> +    0xff, 0xff, 0x29, 0xeb, 0x0c, 0x20, 0x10, 0xd8,
> +    0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,

Looking at the SFDP spec I have it says that reserved locations (unused or not
yet defined memory in the address space) are recommended to return 0xFF. Do you
think we could use that and somehow and return 0xFF by default above instead of
having them in the array? (The file will not grow as fast then)

Best regards,
Francisco Iglesias

> +};
> +define_sfdp_read(n25q256a);
> diff --git a/hw/block/meson.build b/hw/block/meson.build
> index 78cad8f7cba1..6f0380a12081 100644
> --- a/hw/block/meson.build
> +++ b/hw/block/meson.build
> @@ -10,6 +10,7 @@ softmmu_ss.add(when: 'CONFIG_ONENAND', if_true: files('onenand.c'))
>  softmmu_ss.add(when: 'CONFIG_PFLASH_CFI01', if_true: files('pflash_cfi01.c'))
>  softmmu_ss.add(when: 'CONFIG_PFLASH_CFI02', if_true: files('pflash_cfi02.c'))
>  softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80.c'))
> +softmmu_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
>  softmmu_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
>  softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen-block.c'))
>  softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('tc58128.c'))
> -- 
> 2.25.4
> 

