Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB118C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7830B21739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnfoDiMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7830B21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOkZ-0000Ce-ME
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwOju-0007tx-Fm
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:09:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwOjt-0007Lw-9l
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:09:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21527
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwOjt-0007LT-5A
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:09:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580209740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cZqk+6kPtdczzGJ/Wfl4TJaPg/W0JrGzpMSVuttE94=;
 b=KnfoDiMIeFd0n+dVXUZT0OkGbaryDkL+H8BoWwODGeZ/t9oNQOSkLiZEHOTfO9lLvO8UYz
 toFl7qbkxDXqHRrSGa1fsN+KS3AKmCRKrxEtuZJpzmaUqRIuZM8/WJb1lTgtIPUMQlCYLE
 cVefdZOVx74jRiF1G6m3uy9y6GIwz/c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-gcIaDj7mNPO--d1JJWDuiQ-1; Tue, 28 Jan 2020 06:08:58 -0500
Received: by mail-wm1-f71.google.com with SMTP id a10so534200wme.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 03:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1cZqk+6kPtdczzGJ/Wfl4TJaPg/W0JrGzpMSVuttE94=;
 b=U24sBlH7nK8TGZ5TihHmwPesvmSr1JtAjcQncPmEGzOUVkZCMflneaDRT2QLbceKIj
 aILLjHUnvYd8Di/KY+k3mC2WqtF2pwBiPwPDrSCFlOcunqWAu/FePP+K5ZtieZUJVwkl
 gLSimNCo7oeeMqqTxrBXGOZdNCnWQPcwJCaMPqEgQdnuSvT4c2WzNEiHiStStpie38WZ
 qu0JJ19UUDE2Nq9Hr5USdWHfeUYD2l6kqsIKa0fmmFunpwUywLsP4y5TU2MSBoCxc+Ur
 +CKKBeKBK16LM6/20sgXWJWWra2qeK8wSWeSLGaFputfzVKHCP7+1rkt1tCSbLKPJ3X1
 iYDg==
X-Gm-Message-State: APjAAAWWYpby1MUUBmMnBO2x7h1CQ4VG7yTojBSG5h7m8nk7mW/TLtn3
 riAzSW9ViJYsAKawqgkCLmUx6tOCVAOVa2E6khcfG8z4QRZxrBs7wmcLP18OY+8cHjw/7jgJGWF
 j/daHlR4pXKg3g1s=
X-Received: by 2002:adf:d850:: with SMTP id k16mr28380129wrl.96.1580209736966; 
 Tue, 28 Jan 2020 03:08:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8Pd3bRdkGev6FxXbfQkfn+S8FO7+CpIgit74xGC3DCVy3OzX/lc0//OynjBXUKuUabrt6yw==
X-Received: by 2002:adf:d850:: with SMTP id k16mr28380098wrl.96.1580209736708; 
 Tue, 28 Jan 2020 03:08:56 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p7sm2513090wmp.31.2020.01.28.03.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 03:08:56 -0800 (PST)
Subject: Re: [PATCH v3 13/14] dp8393x: Don't reset Silicon Revision register
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang
 <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <cover.1579474761.git.fthain@telegraphics.com.au>
 <34caf9dea82cd30dc51b4f8768adb7a90b236bf2.1579474761.git.fthain@telegraphics.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcd1dcd2-719c-1db0-e9ce-25d26ed1f6d4@redhat.com>
Date: Tue, 28 Jan 2020 12:08:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <34caf9dea82cd30dc51b4f8768adb7a90b236bf2.1579474761.git.fthain@telegraphics.com.au>
Content-Language: en-US
X-MC-Unique: gcIaDj7mNPO--d1JJWDuiQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 11:59 PM, Finn Thain wrote:
> The jazzsonic driver in Linux uses the Silicon Revision register value
> to probe the chip. The driver fails unless the SR register contains 4.
> Unfortunately, reading this register in QEMU usually returns 0 because
> the s->regs[] array gets wiped after a software reset.
> 
> Fixes: bd8f1ebce4 ("net/dp8393x: fix hardware reset")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   hw/net/dp8393x.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 1b73a8703b..71af0fad51 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -591,6 +591,10 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr, unsigned int size)
>                   val |= s->cam[s->regs[SONIC_CEP] & 0xf][2* (SONIC_CAP0 - reg)];
>               }
>               break;
> +        /* Read-only */
> +        case SONIC_SR:
> +            val = 4; /* only revision recognized by Linux/mips */
> +            break;
>           /* All other registers have no special contrainst */
>           default:
>               val = s->regs[reg];
> @@ -971,7 +975,6 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
>       qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
>   
>       s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
> -    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
>   
>       memory_region_init_ram(&s->prom, OBJECT(dev),
>                              "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
> 

Please fix in dp8393x_reset() instead:

-- >8 --
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index cdc2631c0c..65eb9c23a7 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -862,6 +862,7 @@ static void dp8393x_reset(DeviceState *dev)
      timer_del(s->watchdog);

      memset(s->regs, 0, sizeof(s->regs));
+    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
      s->regs[SONIC_CR] = SONIC_CR_RST | SONIC_CR_STP | SONIC_CR_RXDIS;
      s->regs[SONIC_DCR] &= ~(SONIC_DCR_EXBUS | SONIC_DCR_LBR);
      s->regs[SONIC_RCR] &= ~(SONIC_RCR_LB0 | SONIC_RCR_LB1 | 
SONIC_RCR_BRD | SONIC_RCR_RNT);
@@ -914,7 +915,6 @@ static void dp8393x_realize(DeviceState *dev, Error 
**errp)
      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);

      s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
-    s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */

      memory_region_init_ram(&s->prom, OBJECT(dev),
                             "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
---


