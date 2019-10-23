Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E3CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9E32086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa4l/GR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9E32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNI1z-0001tq-Og
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNHyV-00008J-IN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNHyU-00038q-1a
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:50:59 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNHyT-00038E-S0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:50:57 -0400
Received: by mail-qk1-x742.google.com with SMTP id q70so12448133qke.12
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fsylgJZZBzGS4aiTd01aXlUxbxS+jYEqQUci7i0CaF8=;
 b=qa4l/GR+Xu38gen8k5lnLnIinYCcffukSgbEhLvYP0TnV7UkAGTNm254dDQk7mi9e9
 zi1Bu83mWdUMMS3Gkz2xARw0QgIcfCnsZvM82Oh1Xl1++k4po9/GEa3Z246vJ0EMTpE4
 Poz7EStCeWVD/t5jrYB6wcML5wis69dUKhO6GHsVUCWpmbkmD+G9BDu+r+l0l6J3BNk7
 UnICh3KRwv7bnxHRBrYErCfmTBZ0/HOJJtsv5fF5qJb85KBzDfhdiP2ygLigFpS6XZKe
 9QIdFai3IECaSKREeQDjrePJLBKgZsaAa+YhjJWSswT48/khLFjkdwggtzxlIP0b6x90
 oghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fsylgJZZBzGS4aiTd01aXlUxbxS+jYEqQUci7i0CaF8=;
 b=WWCoHb10kDsMJQblY400J2u0aaErw5GqGWvvYnidHzptsZqfVnre6sbv1l/eul/18C
 suOGDCuAavzC1F10iSZGJEstb+BeAx71hwZyzrmnRmyAhyEx3bxHBkLZ3JharhB9mw9b
 tAMZJcvHee5F1Hew+YvgDcp2yterCR6wNHNY7iVDQ6N+Fxzzzjc8nkXfHcn8vdbbrv6G
 BorL6mg8YCUAGBdeQusxMSvRgZ2j3wdj4sURvttwsrLEVFwm2cQbCxhHARlfwYod0Cbp
 enq+KYKZE2nmgYUqSs+UOhixU1+Avspz3LYaO34fiyBiE0XvB123mW65hBBRFCbQjpM6
 Z22g==
X-Gm-Message-State: APjAAAX4TltjEzAFKItZNQaV/24JrTLtV9gCXGYHa2tIr+IjpJ98FOjJ
 vH3qbAbOXQruHk4e+bvzT4FVLA==
X-Google-Smtp-Source: APXvYqxS3cRxr36Rx/Y8uNphbaLmD0i5ZQMgY/fxTiVl2jNlhft3odZ+pbzzSzvkSRpy9VQ6H7a/DQ==
X-Received: by 2002:a05:620a:a8d:: with SMTP id
 v13mr8763159qkg.113.1571842256767; 
 Wed, 23 Oct 2019 07:50:56 -0700 (PDT)
Received: from [172.20.87.163] (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id c18sm10472909qkk.17.2019.10.23.07.50.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Oct 2019 07:50:56 -0700 (PDT)
Subject: Re: [PATCH] translate-all: fix uninitialized tb->orig_tb
To: Clement Deschamps <clement.deschamps@greensocs.com>, qemu-devel@nongnu.org
References: <20191022140016.918371-1-clement.deschamps@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f4619b84-cff2-366a-8c84-2e0bf226a70f@linaro.org>
Date: Wed, 23 Oct 2019 10:50:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022140016.918371-1-clement.deschamps@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 10:00 AM, Clement Deschamps wrote:
> This fixes a segmentation fault in icount mode when executing from an IO region.
> 
> TB is marked as CF_NOCACHE but tb->orig_tb is not initialized (equals
> previous value in code_gen_buffer).
> 
> The issue happens in cpu_io_recompile() when it tries to invalidate orig_tb.
> 
> Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
> ---
>  accel/tcg/translate-all.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 66d4bc4341..f9b7ba159d 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1722,6 +1722,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>      tb->cs_base = cs_base;
>      tb->flags = flags;
>      tb->cflags = cflags;
> +    tb->orig_tb = NULL;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Yep, the key is the the I/O region, when phys_pc == -1; previously the only
place that set CF_NOCACHE was cpu_exec_nocache, which is where orig_tb is
normally set.

Queued.


r~

