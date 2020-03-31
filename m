Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4D6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A477520786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+ZJdeNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A477520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJcW-0003Cy-Nt
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jJJbR-0001qK-03
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jJJbP-0008Dr-Ff
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:19:00 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jJJbP-0008DN-2G
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:18:59 -0400
Received: by mail-pj1-x1044.google.com with SMTP id m15so1278746pje.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pDknqcI8lOyo6IYJO5ra22D+hgIy2xxMdwJohaLDdKM=;
 b=S+ZJdeNHOAdwkX4kWzOjE6npcTiw8pPGG3oSaKnqIbIicSYjeOG4c4fJct8AH6eJtp
 Rv3kJIMajP2O9iUWSLg31Cnnmm/sLK7yxf1Ed6b15NoXMYFX8MPDlUYHiLJKh3CPxFGF
 BsrdbhSyHbNk2SJRSa1f6p1jatAP0tXLpY6haqX+5Ej9iOqkWVJU9keRMwFnBRNBPcIK
 wIj6BPbQWWvCCZsX5IqblcImsEq7AFopxdapfS57SzhLRru+kN8jMp8h+xk36j9H7DPy
 5DqlZU2xbB/j9HKJVo1AfnSmRWJoVCwMS25vLrVp/pcbppnK2I0KdC6bbJnUBxepIUWD
 rDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pDknqcI8lOyo6IYJO5ra22D+hgIy2xxMdwJohaLDdKM=;
 b=m1mwGQEn9801ap899cP6h7e1IUicFaraXYIQO62wSxUisFDrKYMu0328asMdLHRnZ6
 165+E/6OZU4WvyJWj5FYfFzkj5nQRL6ZW/l6sdxMhRc/GFGASvH66Ylg1j0ufFPFcFxj
 6llnISkddl637pTBe4K8PHrcXtML2tKUmN2lbbl2K0V+Ylb6kOAbBShG20rEp63Ztzh3
 /tHb1OqpHdOAs1Mw5UHGphTftzm0xvhisZZAPEazkvgIDt2u3A0eBOs41VZ6mlrQgkdt
 rMrIllO+DTB3n+uCgo52hof2/5r+Qz9JTGDfklngHZ7wlCW5NqDGwuHdvZUuFjntAyKJ
 zP/g==
X-Gm-Message-State: ANhLgQ0NUs9+/6oth6dGonlG6E8Us6L2CtkzZ2ej7s4Aka8heEMW75wQ
 2n5+JB5N6zek3lFtZQix/PTlOg==
X-Google-Smtp-Source: ADFU+vu3n6CZMF3yFKC+eXeQ3bcv/MKLSkWsnMKQv+h9/uTj53hGW3BKn1lk8fIpYTQUwmmxuX3xNg==
X-Received: by 2002:a17:902:a706:: with SMTP id
 w6mr18748177plq.79.1585671537536; 
 Tue, 31 Mar 2020 09:18:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id e204sm12792387pfh.199.2020.03.31.09.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:18:56 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
Date: Tue, 31 Mar 2020 09:18:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 3:50 AM, Philippe Mathieu-Daudé wrote:
> This test was written/tested around beginning of 2019, but was
> extracted from a bigger series and posted end of June 2019 [*].
> Unfortunately I did not notice commit 162abf1a8 was merged by
> then, which implements the AHB and APB plug and play devices.
> 
> HelenOS 0.6 is expecting the PnP registers to be not implemented
> by QEMU, then forces the discovered AMBA devices (see [2]).
> 
> Before 162abf1a8, the console was displaying:
> 
>   HelenOS bootloader, release 0.6.0 (Elastic Horse)
>   Built on 2014-12-21 20:17:42 for sparc32
>   Copyright (c) 2001-2014 HelenOS project
>    0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
>    0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
>    0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
>    0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
>    0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
>    0x4006d390|0x4006d390: rd image (152678/65889 bytes)
>    0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
>    0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
>    0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
>    0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
>   ABMA devices:
>   <1:00c> at 0x80000100 irq 3
>   <1:00d> at 0x80000200
>   <1:011> at 0x80000300 irq 8
>   Memory size: 64 MB
> 
> As of this commit, it is now confused:
> 
>   ABMA devices:
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   <1:3000> at 0x00000000 irq 0
>   ...
> 
> As this test is not working as expected, simply disable it (by
> skipping it) for now.
> 
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627094.html
> [2] https://github.com/HelenOS/helenos/blob/0.6.0/boot/arch/sparc32/src/ambapp.c#L75
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/acceptance/machine_sparc_leon3.py | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks!

Reviewed-by: Richard Henderson <richard.hendersion@linaro.org>
Tested-by: Richard Henderson <richard.hendersion@linaro.org>


r~

