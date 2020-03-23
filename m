Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED6C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808D32051A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0V7XOJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808D32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGRei-0004tN-Nn
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 14:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRdS-0004CH-2Z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGRdN-0007bE-KA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:17:13 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGRdN-0007aT-C8
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 14:17:09 -0400
Received: by mail-pl1-x642.google.com with SMTP id g18so6270159plq.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pDRzzm+NNbbFZdBTK50PUR2qXqEfwdFwccop38BdPZ4=;
 b=V0V7XOJ68XPIx37yTTot4S+uiPtl076P2JVWSUbjHS4awSXO6hKcgvLXsQ6Y8n2TXo
 SM/wKFhlbBZdmKiQ3KSZbll/fFvqd66a6Rxj5e23GfTAoam//eUWzafXLhhtgkKNqXMZ
 B3uksfq2juCT1TtXLMIjRN0BPq7OW4qYwWv6Z5qD4LhhIx1/OwzRMph0A2YeJTy6KyLv
 B1LINrCC12FaVAu7mEiHHme/zHAWoIoEm2KAyn2r/l48xZPYbVpk2gok2UsrMfH7ziNi
 ynfakRcNo563PF1aLLnVejByF3nmEHyPytKlSaq7xRvQiVlIwHcgw7D28VMpRxUurVu/
 8RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pDRzzm+NNbbFZdBTK50PUR2qXqEfwdFwccop38BdPZ4=;
 b=cPYQaPvvYoRU0SEcLCdSKnN7eqN4cAsSHOeeHkhZUkjkRE7iP60RLd1nWbIOhtfcu6
 ruX9faiasUHyYLItqlRGrshfgn5Xw4jpT2UH5UwJbukxJuNIcPxF9qhQvaCv54taU86p
 jw/Sd7tShYiaKRpN4EwgNi/LMC74SYfZ2V6F16/Eqk5bgaPFgtnP56aOqD5TXIeiee6l
 SSElFjF+6Hfkc8updglZzA+Wa2Dn0zRWe7dhgaAmk+P2uWG2EWQ4ZLxvhawArA9ceKF1
 V6nI3AUNNrq1dwEVx1jJ+9+Dg/1qL3dxw0NN9glKjFQgeqyK2CEvBjaE2YLu3O37Sq/5
 dNKg==
X-Gm-Message-State: ANhLgQ3C4r8/mE/ueQQDl6Gt2vVxftoIv3R177OhP9Z/bRV2Q7Ekl+iy
 1tS59lJyaJqX81C2BtObA5jjXQ==
X-Google-Smtp-Source: ADFU+vuQn+euX4BsLqj5gvZerqzWKL3W2+H+CN1S2msWcWrrllMnA6M2lkXALRczjPB3LxJtPkWZTA==
X-Received: by 2002:a17:902:8308:: with SMTP id
 bd8mr23169739plb.210.1584987427750; 
 Mon, 23 Mar 2020 11:17:07 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h15sm13889112pfq.10.2020.03.23.11.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 11:17:06 -0700 (PDT)
Subject: Re: [PATCH v1 06/11] configure: disable MTTCG for MIPS guests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20e5e10b-a2ac-06ed-edb4-5d4250c1775a@linaro.org>
Date: Mon, 23 Mar 2020 11:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 9:15 AM, Alex Bennée wrote:
> While debugging check-acceptance failures I found an instability in
> the mips64el test case. Briefly the test case:
> 
>   retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
>     -display none -vga none -serial mon:stdio \
>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>     -cpu I6400 -smp 8 -vga std \
>     -append "printk.time=0 clocksource=GIC console=tty0 console=ttyS0 panic=-1" \
>     --no-reboot
> 
> Reports about a 9% failure rate:
> 
>   Results summary:
>   0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
>   -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
>   Ran command 100 times, 91 passes
> 
> When re-run with "--accel tcg,thread=single" the instability goes
> away.
> 
>   Results summary:
>   0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviation)
>   Ran command 100 times, 100 passes
> 
> Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> that has been missed. Ideally we would fix that but I'm afraid I don't
> have time to investigate and am not super familiar with the
> architecture anyway. In lieu of someone tracking down the failure lets
> disable it for now.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

