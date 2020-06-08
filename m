Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E706DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A88206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhESHOKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A88206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDA5-0004L5-Vk
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 04:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiD9C-0003hS-4X
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:28:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiD9B-0007TD-5q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:28:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so14432225wmh.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CLf37al5XAy6fx9my8sf9APrf4zVGhUtExZNmWSI9qM=;
 b=qhESHOKO2GhpY95gTcELK2Lg1jf6277xGiX2zgFSuCor0QUy2UgxLglHoKa13vL/6V
 bX3yT0a71PaR0TyZ34ABzuu7nngPlg27M0WGllCwEaU45IzsBXBly+sMv+AJTgNHthI5
 vtHNk+ORi0tMUPi2/gAwtE7SP02WaQGDEO0iYK0msX6MK9gcLPZQpC5Zqp+2eRkcjT5t
 XYkP4cXbkYEqZ+DJq5J85xeWRQiGaSRBpDxGy5rE7bdYxhuqAgHZd82VXbr4O1Uzy/tA
 HJN2TlMMyvSW89scNdZ3JM44Jemh+l+SdnLHBBVNyXJ0BgD06GxpEulLLYcs0PTpSwZQ
 R/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CLf37al5XAy6fx9my8sf9APrf4zVGhUtExZNmWSI9qM=;
 b=Z5816VUMz90v2AdEjnkZk7V6Cu9qNqrBqhLZCUYgQYBXcoiKzuRP4/uCNpwMD65KnZ
 4P7OmP+3aLxSNwVCJy9R28qWqTCuh66c41vE2OLnRZni+DdH7voVIxaaWR8p7SPzfaza
 v47Pg0eM4z3z5qXNfD0RcE0faamHT85tFDB4Hl/6PtE+hf/4uFa0G30z1wdwM+GlxNld
 PG59dRt9ARmzsCsMMLYJgyj4q7K7NeKwdQoHVgWHMQiPfLEarlVkkuuTBRywQ6ajQjka
 8kqcy0OC5wzuFXNf3enG4+E+GhNB9L2YUsxvj5pPdER/O3EBfli0bgqv39Y9g687jJ5e
 siGg==
X-Gm-Message-State: AOAM530U6kdvyoOGWPeK9YOizljl3DNX8HTSyDqOZpy6bxi15nP1eRbC
 +fzaY7NB2U0rqerTt7nIKTw=
X-Google-Smtp-Source: ABdhPJyar0BZAKUN2zxeiLk6TjM7heyRPeLaJMQRdvlp6DLQm1n9v8kM/VIC3ftcj8s36B/islWCLw==
X-Received: by 2002:a05:600c:24c:: with SMTP id
 12mr15880653wmj.28.1591604923456; 
 Mon, 08 Jun 2020 01:28:43 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id i10sm22163776wrw.51.2020.06.08.01.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 01:28:42 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Aurelien Jarno <aurelien@aurel32.net>
References: <20200601092057.10555-1-f4bug@amsat.org>
 <20200601214125.GA1924990@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c3f5d8f-fb63-035d-3c27-41e0d86ad895@amsat.org>
Date: Mon, 8 Jun 2020 10:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200601214125.GA1924990@aurel32.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aurelien,

On 6/1/20 11:41 PM, Aurelien Jarno wrote:
> On 2020-06-01 11:20, Philippe Mathieu-Daudé wrote:
>> I don't have much clue about the Renesas hardware, but at least
>> I know now the source files a little bit, so I volunteer to pick
>> up patches and send pull-requests for them during my scarce
>> hobbyist time, until someone else with more knowledge steps up
>> to do this job instead.
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  MAINTAINERS | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0944d9c731..cbba3ac757 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>  S: Odd Fixes
>>  F: target/sh4/
>> -F: hw/sh4/
>>  F: disas/sh4.c
>> -F: include/hw/sh4/
>>  
>>  SPARC TCG CPUs
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>>  F: pc-bios/u-boot-sam460ex-20100605.bin
>>  F: roms/u-boot-sam460ex
>>  
>> +Renesas Hardware
>> +----------------
>> +SH4 Hardware
>> +M: Aurelien Jarno <aurelien@aurel32.net>
>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> That's fine for me, and just to be clear I don't mind being demoted to a
> reviewer or even removed from there. I do not really have time to work
> on that.

I understand. Aleksandar implicitly NAcked my patch, as there is
another contributor who is a better candidate, Yoshinori Sato.
He recently posted Renesas series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708102.html

I'll simply send a patch to make this hardware orphan, and
Yoshinori can maintain it if he has the time and is willing to.

> 
>> +S: Odd Fixes
>> +F: hw/sh4/
>> +F: hw/char/sh_serial.c
>> +F: hw/intc/sh_intc.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/
>> +
>>  SH4 Machines
>>  ------------
>>  R2D
>> @@ -1246,6 +1256,7 @@ S: Maintained
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>>  F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh_intc.h
>>  
>>  Shix
>>  M: Magnus Damm <magnus.damm@gmail.com>
> 
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> 

