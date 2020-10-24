Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E00CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28170208B6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONAU2TJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28170208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWRXJ-0007wM-3n
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRWR-0007Uw-VI
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:56:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWRWQ-0004zR-9F
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 17:56:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id 13so6698988wmf.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2020 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V/fWcXwpCIvNwURnDwOC9D6xGZaiAiSa6s45bsGQrWk=;
 b=ONAU2TJ5kir3O/SyvQHQ+/k0MjOnM0hOx/JSEs0RFPfakHRNKXaMn4HZc6KtlQc1sd
 1HLjYrp6B8KccReMPwRYeya92zzj5f37/c6jbpunejlg3mnfPg+946/lNewPfTeNsHOV
 bnngXy8fyWx8ODWAMXhul2vjOUxFLu9gu/zqXmYBkiQEpLroaxyrkAcsFhFFSAQSIIBp
 ykn4Z1tABYgsGdKVt9Njw4ibRiOq//4JRnHnjnuZ8RmM7Ihp7YaPjevysfQB5TlrHHD3
 4ZuQQK8+e+HEYpj+G8mK4QJAVRVYmC+y4b8fmJhKgWD0uVdLLw/i5X+QcxqkTw+cGNs+
 m5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V/fWcXwpCIvNwURnDwOC9D6xGZaiAiSa6s45bsGQrWk=;
 b=XHL8FIHKAK22IP3rRtOwsMqxk9JIH6cqW51wZLqnygvxlpOf6JCIK4rclRu1mFVItX
 XeBZ25m7xkk2T6Qb3k38x2TN4CTLMeqD0eZJwJsQv4Yu73NTbmAuaoVmliiSJSlMw3HY
 YBUufIdwG17GXQ08WtubDjgE8O2u5KU9lu8b6FSjCeeTxf3kRcI1ZvdTdiRyb6OVt28G
 dcqD7FCBKWI9Vntli1I5oFO8n7WbilcSoKKinoUL5Elrbcz1491tTUpVqrlNgeqZlqJz
 3vpEpzVRVxS0TuLS1nL3laqXAi221Lw9L9i8sUr/cF8zXAQH64viS1KqTuEJU8ybYS9W
 rZqg==
X-Gm-Message-State: AOAM5325USavdIsp7BBInv0joXiFskf29Pf1/LRwCr+JtnF+JIMB7u2a
 5bMeKh90xSOoE7IpZGk1UMy837scBtM=
X-Google-Smtp-Source: ABdhPJxZuYv00UwMY2xY9QlSOhSUR4hKWiX6uDggh0uCM0+lFoJu8qpFaMulLWMp85W7j0gvRWh0GQ==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr2387218wmj.78.1603576580397; 
 Sat, 24 Oct 2020 14:56:20 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h206sm13127303wmf.47.2020.10.24.14.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 14:56:19 -0700 (PDT)
Subject: Re: [PATCH 05/20] hw/rx: Add RX62N Clock generator
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-6-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aafa29bc-d3fb-7331-7a40-9c5f62b5bc31@amsat.org>
Date: Sat, 24 Oct 2020 23:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-6-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:38 PM, Yoshinori Sato wrote:
> This module generated core and peripheral clock.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   include/hw/rx/rx62n-cpg.h |  72 ++++++++
>   include/hw/rx/rx62n.h     |   5 +-
>   hw/rx/rx62n-cpg.c         | 344 ++++++++++++++++++++++++++++++++++++++
>   hw/rx/rx62n.c             |  52 +++---
>   hw/rx/meson.build         |   2 +-
>   5 files changed, 447 insertions(+), 28 deletions(-)
>   create mode 100644 include/hw/rx/rx62n-cpg.h
>   create mode 100644 hw/rx/rx62n-cpg.c
...

> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index 4b5c3c1079..ec63fa5db1 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -47,6 +47,7 @@
>   #define RX62N_TMR_BASE  0x00088200
>   #define RX62N_CMT_BASE  0x00088000
>   #define RX62N_SCI_BASE  0x00088240
> +#define RX62N_CPG_BASE  0x00080010
>   
>   /*
>    * RX62N Peripheral IRQ
> @@ -56,10 +57,6 @@
>   #define RX62N_CMT_IRQ   28
>   #define RX62N_SCI_IRQ   214
>   
> -#define RX62N_XTAL_MIN_HZ  (8 * 1000 * 1000)
> -#define RX62N_XTAL_MAX_HZ (14 * 1000 * 1000)
> -#define RX62N_PCLK_MAX_HZ (50 * 1000 * 1000)
> -
>   /*
>    * IRQ -> IPR mapping table
>    * 0x00 - 0x91: IPR no (IPR00 to IPR91)
> @@ -149,36 +146,45 @@ static void register_tmr(RX62NState *s, int unit)
>   {
>       SysBusDevice *tmr;
>       int i, irqbase;
> +    char ckname[16];
>   
>       object_initialize_child(OBJECT(s), "tmr[*]",
>                               &s->tmr[unit], TYPE_RENESAS_TMR);
>       tmr = SYS_BUS_DEVICE(&s->tmr[unit]);
> -    qdev_prop_set_uint64(DEVICE(tmr), "input-freq", s->pclk_freq_hz);
> -    sysbus_realize(tmr, &error_abort);
>   
>       irqbase = RX62N_TMR_IRQ + TMR_NR_IRQ * unit;
>       for (i = 0; i < TMR_NR_IRQ; i++) {
>           sysbus_connect_irq(tmr, i, s->irq[irqbase + i]);
>       }
>       sysbus_mmio_map(tmr, 0, RX62N_TMR_BASE + unit * 0x10);
> +
> +    qdev_prop_set_uint32(DEVICE(tmr), "unit", unit);

Runtime failure:

qemu-system-rx: Property 'renesas-tmr.unit' not found

> +    sysbus_realize(tmr, &error_abort);
> +    snprintf(ckname, sizeof(ckname), "pck_tmr8-%d", unit);
> +    qdev_connect_clock_in(DEVICE(tmr), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>   }
>   
>   static void register_cmt(RX62NState *s, int unit)
>   {
>       SysBusDevice *cmt;
>       int i, irqbase;
> +    char ckname[16];
>   
>       object_initialize_child(OBJECT(s), "cmt[*]",
>                               &s->cmt[unit], TYPE_RENESAS_CMT);
>       cmt = SYS_BUS_DEVICE(&s->cmt[unit]);
> -    qdev_prop_set_uint64(DEVICE(cmt), "input-freq", s->pclk_freq_hz);
> -    sysbus_realize(cmt, &error_abort);
> +    qdev_prop_set_uint32(DEVICE(cmt), "unit", unit);
>   
>       irqbase = RX62N_CMT_IRQ + CMT_NR_IRQ * unit;
>       for (i = 0; i < CMT_NR_IRQ; i++) {
>           sysbus_connect_irq(cmt, i, s->irq[irqbase + i]);
>       }
>       sysbus_mmio_map(cmt, 0, RX62N_CMT_BASE + unit * 0x10);
> +    sysbus_realize(cmt, &error_abort);
> +    snprintf(ckname, sizeof(ckname), "pck_cmt-%d", unit);
> +    qdev_connect_clock_in(DEVICE(cmt), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>   }

