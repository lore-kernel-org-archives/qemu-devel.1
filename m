Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA3C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 17:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B89D3207EA
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="nlktJ/Oh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89D3207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxD4r-0008RC-TZ
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 13:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>)
 id 1jxD20-0007ds-IM; Sun, 19 Jul 2020 13:23:20 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@walle.cc>)
 id 1jxD1v-0001CP-6i; Sun, 19 Jul 2020 13:23:20 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 1ECCF22FEC;
 Sun, 19 Jul 2020 19:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1595179387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCGpOGQSsqWIS5LRWHyZRDrmJoK+XBUPU2nHA4wyJlg=;
 b=nlktJ/OhlXZvlSq4rWtbDH4O9e6pENfLbkSm9DXdc+cstb/wu4ABRo7PyP4x1G9OcHGrat
 NStap5oK6dlmlSiH7F+Nw4qVJITStegFF/0O6NPd5iVMc2RCi25/hEuhTAusQPGXlrIYXH
 RYB9tUY/dFhSegEhTmotnqFhCRtEJhc=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Sun, 19 Jul 2020 19:23:06 +0200
From: Michael Walle <michael@walle.cc>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1] hw/misc/milkymist-pfpu: Fix pFPU region size
In-Reply-To: <20200718093705.7271-1-f4bug@amsat.org>
References: <20200718093705.7271-1-f4bug@amsat.org>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b0eb3028f61e6eaaf9c1f4aedefeaa20@walle.cc>
X-Sender: michael@walle.cc
Received-SPF: pass client-ip=176.9.125.105; envelope-from=michael@walle.cc;
 helo=ssl.serverraum.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 13:23:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Am 2020-07-18 11:37, schrieb Philippe Mathieu-Daudé:
> The last microcode word (address 0x6000.6ffc) is not reachable.
> Correct the programmable FPU I/O size (which is 4 KiB) to be
> able to use all the microcode area.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/misc/milkymist-pfpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
> index 516825e83d..4fbe3e8971 100644
> --- a/hw/misc/milkymist-pfpu.c
> +++ b/hw/misc/milkymist-pfpu.c
> @@ -507,7 +507,7 @@ static void milkymist_pfpu_realize(DeviceState
> *dev, Error **errp)
>      sysbus_init_irq(sbd, &s->irq);
> 
>      memory_region_init_io(&s->regs_region, OBJECT(dev), 
> &pfpu_mmio_ops, s,
> -            "milkymist-pfpu", MICROCODE_END * 4);
> +                          "milkymist-pfpu", 0x1000);

Could you use one of the MICROCODE_ macros instead? maybe 
(MICROCODE_WORDS * 2)?

With that fixed:
Reviewed-by: Michael Walle <michael@walle.cc>

-michael

>      sysbus_init_mmio(sbd, &s->regs_region);
>  }

