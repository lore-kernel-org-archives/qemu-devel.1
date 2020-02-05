Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B617BC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D82051A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woJNf4U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D82051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHVL-0002QP-SX
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izHUi-00021B-5y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izHUh-0002Nf-2i
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:01:15 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izHUg-0002Ll-RM
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:01:15 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so1850944wrx.11
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IjMIzUVnYgM87Br3J8hhudgLwXTwaEWyJqC5g8IEN+I=;
 b=woJNf4U9oX8m0i1vDjggWv7wYhZBMt1aMsMJQtxYaZpCU2e5+4AIqlKohCyjkCECWr
 6tChD9uNdSmvP9QLEJpIRyN8nP29HjGnYp3mLVNbk9v+hTcrE1CQX/gbPC4RzlmkC+I6
 0Wd5ZcOG1yOWMe0RJm043ELFw3z5kr7Ejj7lshUOezQYHJVjU5ew1aPGeeYsKGzKBnoJ
 eRXn2mKO+qDcWVTYLLRGWkbtiMMQbuyhcp+LSNNnyuX1PXzrByyE3980G4RIyxRMTSJq
 UWCr4PRfL+emKaZoBTEgiFQ7lmoNIV2b3v2MlnSgrfkS1vG4AXgto8mqd8sGhr1EC8jx
 ooww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IjMIzUVnYgM87Br3J8hhudgLwXTwaEWyJqC5g8IEN+I=;
 b=kvx7IhLJYxFZQMohUEfcVsVOVlT9+6xIDAaowP1/7TgfIkyCpbOFvilIy26bL3hhfL
 0fveQnXwXYXKoRox+FJRmhXz71oBmKiK8S/8WOPhzf3OeyLch70oaHpfKAos88XPQ2hP
 iy+VW+sQpLvptp/6qSoSbm2CfuHe/X5wEV6VnECbZuvNJsx8fa3gjyUBUGByqjYBfcuC
 KiDH8fwZLd3FBAh5loOchj551eDbIuR3iPnQfOC/XmLKCQu5p+F1MuyZVxu0cLLjyLIr
 2viiWgv3GBWqNn+RGcNpHDo6snsg4OVsnMjogZvfD8oCHWwsbW92vNR0/1vbUxrr3ZOP
 rVFA==
X-Gm-Message-State: APjAAAWuIB64sbAFCPbfcSIqpczdVGUoGeuVh0tjNA9ehP8jOwuZNNlC
 uN5q5nt2X6AkxmY4dOvF8S2jrg==
X-Google-Smtp-Source: APXvYqyPZgWGuVevLy1rDywEG2P5h40LE5580wG+kM8uHkzWCZxBXKM3jb1oVdn98nXnmSq7n4xN/A==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr26543823wrq.176.1580896873613; 
 Wed, 05 Feb 2020 02:01:13 -0800 (PST)
Received: from [172.27.246.193] ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id a26sm8016976wmm.18.2020.02.05.02.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 02:01:13 -0800 (PST)
Subject: Re: [PATCH] memory: Use QEMU_ALWAYS_INLINE to silence compile-time
 warning
To: Zenghui Yu <yuzenghui@huawei.com>, pbonzini@redhat.com, tony.nguyen@bt.com
References: <20200205081703.631-1-yuzenghui@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fe8ac60-52ec-6828-5ee3-5cd1141a8376@linaro.org>
Date: Wed, 5 Feb 2020 10:01:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205081703.631-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: wanghaibin.wang@huawei.com, qemu-devel@nongnu.org,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 8:17 AM, Zenghui Yu wrote:
> Our robot reported the following compile-time warning while compiling
> Qemu with -fno-inline cflags:

Why are you doing this?

> 
> In function 'load_memop',
>     inlined from 'load_helper' at /qemu/accel/tcg/cputlb.c:1578:20,
>     inlined from 'full_ldub_mmu' at /qemu/accel/tcg/cputlb.c:1624:12:
> /qemu/accel/tcg/cputlb.c:1502:9: error: call to 'qemu_build_not_reached' declared with attribute error: code path is reachable
>          qemu_build_not_reached();
>          ^~~~~~~~~~~~~~~~~~~~~~~~
>     [...]

Of course, the assert is compiled out when optimization is off, which is the
only time we expect inlining to be off.

The patch isn't wrong, exactly, but I question whether we want to support
completely arbitrary combinations of compile flags.


r~

