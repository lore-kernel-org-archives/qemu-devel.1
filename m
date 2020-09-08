Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F2DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF9420659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 21:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBPC36Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF9420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkvW-0004wb-2F
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 17:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFkux-0004Ue-Lj
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:12:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFkuw-0004uU-05
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 17:12:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so343119wmj.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=evUG4LHbrIB4zAo6FHSAabQeoRkTtPalK8sKdy45q4k=;
 b=YBPC36MrKxcNIA4mghw5dB5iM8oX8VOuHTMnohCTf26tzRkd4LXrXOPiXdovNBbisB
 zWkTa/p/o/8oYmh2TVw3nYvbw8dgr4MeNeO40Bn59wZb0V3cRQRAZiwwfeOoVio1nKlS
 qfWr0Dk3RkeOq1IPacqjf3FLpYn3TRdgqb3Js2dGJJF5txcECFGUGKtwY8scQ1bPVZn3
 AcyqfFc/wufsMmH8vNaAg3IZsDkoWkVRlsx/iEBxNjYgyM9lKSFmWZpGpak+Gd+b67Q2
 u8RIjATLq54udXJRthwwRpf8NdayKulHz43Hz0wicPKRUxzd3rzn6mIBJk9LiYakPWs7
 hJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=evUG4LHbrIB4zAo6FHSAabQeoRkTtPalK8sKdy45q4k=;
 b=iqRwEbHJdPGNUoKmY2On2fOi6+W8OB1ffmP0APjPbSxjNbIs09+mZU2Mi5N7QqkKAd
 rw0BKS7DowC8D0+baYQg68KGPunwQyww2HEZYbVPLxCK9CdEKARxWGaqPXEZHRAnBUwX
 60rpK68d3eNbirRzudrqzT/xn1olLnLhuGUObU4UvE+RMPd5nZ6RQUuDM2oNLw+EPwuf
 PjTNtWfNb27UGJnzWwob8wDOL/4FksLAgm2N4jJwiRHw7addswRJX0kcfnVjX40FKQcA
 tgRygReGWsGOcSGYCqvf71sFnrDmbbPEuWGmaLJtKIe3rcKB3R3VByLuubDZ1Fg3Oago
 p9Ww==
X-Gm-Message-State: AOAM530bYLS618ILCXUCZUTLFjxr6utGVzNockbvcQq+YYzlNha/06L0
 pbBYpwSVsYaM6MFwcnA2ZjsYTP5/Q3c=
X-Google-Smtp-Source: ABdhPJy4X/erajcXAOAExPvY1sVKqr/eWvIqWgEVILXVj5XumC4mfihUwgvAuP+Ppi0QjSlS+ocw9g==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr297224wmc.161.1599599560035;
 Tue, 08 Sep 2020 14:12:40 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v2sm1001352wrm.16.2020.09.08.14.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 14:12:39 -0700 (PDT)
Subject: Re: [PATCH 14/20] hw/rx/rx62n: RX62N Add MTU module
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
 <20200827123859.81793-15-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <afcaf8d3-e28f-ae2e-2a7e-5de6c7b857bc@amsat.org>
Date: Tue, 8 Sep 2020 23:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827123859.81793-15-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/rx/rx62n.h |  3 +++
>  hw/rx/rx62n.c         | 28 ++++++++++++++++++++++++++++
>  hw/rx/Kconfig         |  1 +
>  3 files changed, 32 insertions(+)
> 
> diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
> index f463148799..170c8cb6fc 100644
> --- a/include/hw/rx/rx62n.h
> +++ b/include/hw/rx/rx62n.h
> @@ -28,6 +28,7 @@
>  #include "hw/intc/rx_icu.h"
>  #include "hw/timer/renesas_tmr8.h"
>  #include "hw/timer/renesas_timer.h"
> +#include "hw/timer/renesas_mtu.h"
>  #include "hw/char/renesas_sci.h"
>  #include "hw/rx/rx62n-cpg.h"
>  #include "qemu/units.h"
> @@ -45,6 +46,7 @@
>  #define RX62N_NR_TMR    2
>  #define RX62N_NR_CMT    2
>  #define RX62N_NR_SCI    6
> +#define RX62N_NR_MTU    2
>  
>  typedef struct RX62NClass {
>      /*< private >*/
> @@ -70,6 +72,7 @@ typedef struct RX62NState {
>      RXICUState icu;
>      RenesasTMR8State tmr[RX62N_NR_TMR];
>      RenesasCMTState cmt[RX62N_NR_CMT];
> +    RenesasMTU2State mtu[RX62N_NR_MTU];
>      RSCIAState sci[RX62N_NR_SCI];
>      RX62NCPGState cpg;
>  
> diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
> index f61383a4c2..344be846bc 100644
> --- a/hw/rx/rx62n.c
> +++ b/hw/rx/rx62n.c
> @@ -46,6 +46,7 @@
>  #define RX62N_ICU_BASE  0x00087000
>  #define RX62N_TMR_BASE  0x00088200
>  #define RX62N_CMT_BASE  0x00088000
> +#define RX62N_MTU_BASE  0x00088600
>  #define RX62N_SCI_BASE  0x00088240
>  #define RX62N_CPG_BASE  0x00080010
>  
> @@ -55,6 +56,7 @@
>   */
>  #define RX62N_TMR_IRQ   174
>  #define RX62N_CMT_IRQ   28
> +#define RX62N_MTU_IRQ   114
>  #define RX62N_SCI_IRQ   214
>  
>  /*
> @@ -187,6 +189,30 @@ static void register_cmt(RX62NState *s, int unit)
>                            qdev_get_clock_out(DEVICE(&s->cpg), ckname));
>  }
>  
> +static void register_mtu(RX62NState *s, int unit)
> +{
> +    SysBusDevice *mtu;
> +    int i, irqbase;
> +    char ckname[16];
> +
> +    object_initialize_child(OBJECT(s), "mtu[*]", &s->mtu[unit],
> +                            TYPE_RENESAS_MTU2);
> +    mtu = SYS_BUS_DEVICE(&s->mtu[unit]);
> +    qdev_prop_set_uint32(DEVICE(mtu), "unit", unit);
> +
> +    sysbus_mmio_map(mtu, 0, RX62N_MTU_BASE + 0x100 + unit * 0x400);
> +    sysbus_mmio_map(mtu, 1, RX62N_MTU_BASE + unit * 0x400);
> +    sysbus_mmio_map(mtu, 2, RX62N_MTU_BASE + 0x280 + unit * 0x400);
> +    irqbase = RX62N_MTU_IRQ + MTU_NR_IRQ * unit;
> +    for (i = 0; i < MTU_NR_IRQ; i++) {
> +        sysbus_connect_irq(mtu, i, s->irq[irqbase + i]);
> +    }
> +    sysbus_realize(mtu, &error_abort);
> +    snprintf(ckname, sizeof(ckname), "pck_mtu-%d", unit);
> +    qdev_connect_clock_in(DEVICE(mtu), "pck",
> +                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));

Moving sysbus_realize() after qdev_connect_clock_in():
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +}
> +
>  static void register_sci(RX62NState *s, int unit)
>  {
>      SysBusDevice *sci;
> @@ -248,6 +274,8 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
>      register_tmr(s, 1);
>      register_cmt(s, 0);
>      register_cmt(s, 1);
> +    register_mtu(s, 0);
> +    register_mtu(s, 1);
>      register_sci(s, 0);
>      sysbus_realize(SYS_BUS_DEVICE(&s->cpg), &error_abort);
>  }
> diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
> index d1812870ea..887a5782bb 100644
> --- a/hw/rx/Kconfig
> +++ b/hw/rx/Kconfig
> @@ -4,6 +4,7 @@ config RX62N_MCU
>      select RENESAS_TMR8
>      select RENESAS_TIMER
>      select RENESAS_SCI
> +    select RENESAS_MTU
>  
>  config RX_GDBSIM
>      bool
> 


