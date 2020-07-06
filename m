Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDDCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6710520674
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 18:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyTcSF3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6710520674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsVUc-0007ih-Lt
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 14:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVTl-0006kj-5z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:04:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34653)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsVTj-0001Uf-76
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 14:04:32 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so39135993wrw.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a+Bxjnj18EAM+5mrndyjyyBCU5aYWo0ZPyaHaXbXANs=;
 b=EyTcSF3xv+70BR6mADrnRmsU3E72dWlgsdPrDVOmxcyL25sRtqZ01TKIrZC9MvKXbg
 xeZuOTPCwZoDjyS8Qmi1tzoAlJQgCFTUFudwWClmpp8Al9LwW1alpUv2AUB4VnWYxjg5
 eCEepqfCRCCned3IFU8eAmHJcoOZQvBF397HNEVUJRNTSp5MzDnMarEFotjjSOH3WHV8
 FZ5fXECs+UdsHrrEoiEPr3YZ6YhPiC2tAYFAoBwHBosd66NSJntrAcmnOb3RqQkd3a4c
 D5hHdwlPyYYytf0R2eK64HQXQIO0WbHY/w9wOeXMInC6NNQycNpnlE6548quuQiUf0yF
 WwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a+Bxjnj18EAM+5mrndyjyyBCU5aYWo0ZPyaHaXbXANs=;
 b=tr2c31L8x3YKGELDcwM6Ryx9F1LFg/Zxr5SjN20EbpbPO0j0BNg4JocNwlm/TPrsq/
 WOHBEuCR4uQUmq6vq4UAUivUWFKvPNysBwIbqrGKl+SJnJ79E7vzsfxEG9tpnzoRqsFd
 uHftxmUGBH50ENH4gtpiDQYkhvEJ5RmaURgEwrMWq+qtavBgewVmbObT05szTxS8a/Jj
 JiMvT1iEUk1ujgF1o6fRxjPBs+g5FxdGiURSadQwQSO8V/rOZ9PdeGtmWsS4MVr6Aehl
 G3YQB2AcGKBtQhuIQGGKpSNAIDgBFdOvwS/VGHW+gSVGvYiaaGQVVPRSFRV7f6/3t/77
 qpUg==
X-Gm-Message-State: AOAM530FpSyTxV5NzgsL+n9DB3oxUD176Rx1VfwBuHNNWUPXkENIV/yu
 ZXvVNCTp89DysJ8LEcNJDJrkC1is
X-Google-Smtp-Source: ABdhPJzHOyoafqfwZFMGoQm4aIjxyp0FdhkEFOkl6WAjlMXK7SZxIUxpKkvjBD+T2zoQmZ4Z5P4Vxg==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr51195561wrp.96.1594058669064; 
 Mon, 06 Jul 2020 11:04:29 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v9sm17155545wri.3.2020.07.06.11.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 11:04:28 -0700 (PDT)
Subject: Re: [PATCH 2/4] hw/lm32/milkymist: Comment to remember some IRQs
 lines are left unwired
To: Alistair Francis <alistair23@gmail.com>
References: <20200705211016.15241-1-f4bug@amsat.org>
 <20200705211016.15241-3-f4bug@amsat.org>
 <CAKmqyKOcc=recN5dpsMUZRq9FkU2Kj0-AbmxGTOSpY=yxOEF-Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <68b27cb4-145b-47ed-bbed-428c7591f8c7@amsat.org>
Date: Mon, 6 Jul 2020 20:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOcc=recN5dpsMUZRq9FkU2Kj0-AbmxGTOSpY=yxOEF-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 6:19 PM, Alistair Francis wrote:
> On Sun, Jul 5, 2020 at 2:10 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> The 'card is readonly' and 'card inserted' IRQs are not wired.
>> Add a comment in case someone know where to wire them.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I'm not convinced adding fixmes or todos in the code is the right
> direction. It would be better to file bugs or use some other more
> official tracking mechanism.

This code is orphan :S

I'll fill a launchpad bug ticket.

OTOH we could also log UNIMP for lost IRQs (triggered but
no handler registered).

> 
> Alistair
> 
>> ---
>>  hw/lm32/milkymist.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
>> index 469e3c4322..117973c967 100644
>> --- a/hw/lm32/milkymist.c
>> +++ b/hw/lm32/milkymist.c
>> @@ -87,6 +87,7 @@ static DeviceState *milkymist_memcard_create(hwaddr base)
>>      dev = qdev_new("milkymist-memcard");
>>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
>> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
>>
>>      return dev;
>>  }
>> --
>> 2.21.3
>>
>>
> 

