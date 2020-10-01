Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDDC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE2320759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mv9FwbS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE2320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1U7-0001sR-3m
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1JP-0004zr-DU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:20:07 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO1JL-0001us-Nr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:20:07 -0400
Received: by mail-oi1-x243.google.com with SMTP id n2so6195342oij.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1/volPIcH8bJ9anN+IGeMOo36vJQajijwG205YarbGM=;
 b=mv9FwbS1zq2E/nKDk0lsd5zZAB5guJuD6chOWSqjI/9NAV1peVeE9CVHfeNUUzskuI
 hY5Fhbu8FSExHgnF1zHK2lmg3S5m/lCoG2DShFrX/l5fJkBtfIjKHg4iQ50nHoPHx4B+
 FTC1SbrRjmDL/VKLFZLZISvdHnSksAHN/TrgA+y2EUxuQnIOTv7BzFocROZwsLhRBb3A
 NBu87yKy3Ub3Su24cZSHvXxwjEPbtrWr/GV15Ag5slUNfxkEh1oZTo97sx1DEel7CPbR
 v5hDdQdYthXjtEF7wTbegjnNrBc+OYhkRBJMYfb3iby1bccDgXj5gyOLO77HVnM/aEIJ
 Zt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1/volPIcH8bJ9anN+IGeMOo36vJQajijwG205YarbGM=;
 b=MuJm/ZQ50GUXlluIYNl3gvX6CdAb8fDUDn/YN8OJuis6Ob5ns6fgAXp98tkR+i5HZQ
 utMDzpj9zYgd4aCJS7fv4EPxjkhPa6n33nkn0NDkbYGzj194Uh7tatZAVinBwcAlEwY8
 zx1Z+8DHR659htX5zSjnzjL98JJn1uPyBtEwgx6UheLJ9yCm05MNCe0SGSZl9Y+RHzdv
 yS0Pam0Gl4OCSfgk6GIpSiRLeKQaiENAPJ2ns/vCvhhvDYCGQsXOkexs3Rv50UozkUX7
 /LTdGBcoM6ye+PVWBilmow9LRWH2nGnWY1JAydqmOguO44t0Q2wKGpSY3hoh+kI5b8EY
 5Y+g==
X-Gm-Message-State: AOAM5308IwpaukUUW7tVpOSuzyPG8t6M30XgqFVHv6cxFu7x1H+0cZap
 Nw6e+25zKXSn7pte7RQ/ZR2Cyg==
X-Google-Smtp-Source: ABdhPJxittuR0j6gWkGkLJ4pmZEIaqxfNpO5IZU4KjZshquExmUY1aTBc/20MlRLYI9V2UWjmXQVkg==
X-Received: by 2002:aca:db07:: with SMTP id s7mr472691oig.67.1601569200241;
 Thu, 01 Oct 2020 09:20:00 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id w7sm1430698oon.2.2020.10.01.09.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 09:19:59 -0700 (PDT)
Subject: Re: [PATCH v1 11/20] s390x/tcg: Implement 64 bit for VECTOR FP LOAD
 LENGTHENED
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200930145523.71087-1-david@redhat.com>
 <20200930145523.71087-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd673c92-21c2-44b8-79f2-23457265f659@linaro.org>
Date: Thu, 1 Oct 2020 11:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930145523.71087-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 9:55 AM, David Hildenbrand wrote:
> 64 bit -> 128 bit, there is only a single final element.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/translate_vx.c.inc | 21 ++++++++++++++++-----
>  target/s390x/vec_fpu_helper.c   | 13 +++++++++++++
>  3 files changed, 30 insertions(+), 5 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


