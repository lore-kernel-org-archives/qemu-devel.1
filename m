Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B91C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554E62074D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 06:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ye7Xs+yT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554E62074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0NM-000478-Hy
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 02:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0MP-00034f-R4
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0MO-0004wk-ME
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:33:25 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD0MO-0004st-Dz
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 02:33:24 -0400
Received: by mail-pj1-x1044.google.com with SMTP id f15so5262344pjq.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 23:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ds2kqrrs33istRt1suE15np/U24q3ZUB/Pre1HY/bNA=;
 b=ye7Xs+yT96GXaA53U+0gOnWLJW3xyJDAXv/+Xjq4qSdoAGD5z3uiHCX/cf8wfIJDtf
 JiVOx5qdgwAZS1XXOCuBI1YyPfeuPPeF/TcOgB/By7T0B3fWYtf5Z9H4/q+KNPFuVWRC
 2/OntIpxXmVhiWQ0oBlEi7Xwc0uqz6weKqcAGiK0SWIEwcNjcqG994l0O3Y1HtnYt3mB
 vVy9knsktdbqAggM6UsQhK49Y0yEahr2Yf/Y7iIdDXeBJxwnNAs921eYfx2JzDR4bsVM
 oSC4/lK4pPvGCdqUDamk7ZryXp+J9uundWFbpV+zM8+3hdDHH87zlsngqPlDFs/9qxcC
 rR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ds2kqrrs33istRt1suE15np/U24q3ZUB/Pre1HY/bNA=;
 b=sL8jHc97tODGk0h3pIJ5+Jix+BtErQbaHuV2SP5MUH6CKgrxb04o4LNn4C+Bo25z8y
 oCBtPSjLdTdEiDczsuZZMkZLo02WqbZddG3pSCkbFftLDvx4XA6vJo2Yv1jEmR9MYdOi
 b/qlz8dsAvVlNhuBOdbAmGvNU6p/R5W+NZeZiK+X2WBf+y06FloWQRjOwhEg+Ymr3jQ6
 GU/oZhwgHFoV4h2LXSkLRRNoCOZ+z7AmFZlwvhkWIEzUenw2dFvuBy2wx1sNGXQpd9TP
 kpwQ2wHzKiyzsZL6OLEQgM5rN0AT6wwNpBYiidwKyIEGk1dhz1y1Wk1991OItKIAxSQn
 xsGw==
X-Gm-Message-State: ANhLgQ3Pygt2X1EKFthGNvSJ0HonsCIxGTQ+8mFyZ2h5wowJyIN01x+p
 zYS1zvijhpmETAoWJMYiR8xxhA==
X-Google-Smtp-Source: ADFU+vuoAVBfJIMVFkicPcuUQB7K/1wuT+s0zRTfAvPYrgGea5l20Vuoz2CeDevuHit3glNpNSc7EQ==
X-Received: by 2002:a17:90a:5d0a:: with SMTP id
 s10mr13660398pji.166.1584167603165; 
 Fri, 13 Mar 2020 23:33:23 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 129sm35422072pfw.84.2020.03.13.23.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 23:33:22 -0700 (PDT)
Subject: Re: [PATCH v5 15/60] target/riscv: vector integer comparison
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-16-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6a3f967-559b-41cf-5bda-f206c89fe837@linaro.org>
Date: Fri, 13 Mar 2020 23:33:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-16-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +/* Vector Integer Comparison Instructions */
> +#define DO_MSEQ(N, M) ((N == M) ? 1 : 0)
> +#define DO_MSNE(N, M) ((N != M) ? 1 : 0)
> +#define DO_MSLTU(N, M) ((N < M) ? 1 : 0)
> +#define DO_MSLT(N, M) ((N < M) ? 1 : 0)
> +#define DO_MSLEU(N, M) ((N <= M) ? 1 : 0)
> +#define DO_MSLE(N, M) ((N <= M) ? 1 : 0)
> +#define DO_MSGTU(N, M) ((N > M) ? 1 : 0)
> +#define DO_MSGT(N, M) ((N > M) ? 1 : 0)

You can drop the ? 1 : 0.  You can drop the LT/LTU (etc) distinction, since
that comes from the type.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

