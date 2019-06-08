Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F0FC28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 20:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A79208E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA/rJ2gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A79208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhYO-0001Ce-IN
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 16:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39116)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh44-0001Cw-Cl
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh41-00015t-T3
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh41-0000rA-Dx
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:31:41 -0400
Received: by mail-ot1-x344.google.com with SMTP id z23so4893962ote.13
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OmR05geqhI+CrTiQe1FRjXamoiDOgmToTEUoLNtYb+U=;
 b=MA/rJ2gl9EHfwsBa4iQetLIZ2zMp/qbcytrZR5kBCqhBB9qCm1kMhpOyYz94z49KWy
 IRtmXnZzm06NmQh/JDDlciz1246eJ0UdPb+jMwKDdC9z5dfK5ldetNZPTycotLfQPJkm
 FmKc/gyhQfDIMQCCZWbnXfGa5I9aS60mxPslvP9DfXo6U1QWS1m+nu8aE5LAhJ4FV/et
 RYccBC3B0hEoaYOW9p7ltwCCKvKGxKt1VxqfV0cgGi6sheCFAKlVqbyHTx/oS1OV4+Uf
 Xiac/fLp/cZX+MxF44n5XD1ivMShK4Fl8AG/nRQzfACtyJ//Wn+xCstATbuDWUDSByyG
 oNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OmR05geqhI+CrTiQe1FRjXamoiDOgmToTEUoLNtYb+U=;
 b=G5+e3KaWQZyR5xprK/RC4kmI0JiIaL2CbtcJoFfaGUf1urQPpuSc9gq9nbrekxol7n
 1dUod51C/y10vP6QSBK1gIUsHynSrV8qm5ZbA7LHeBvhvUu2Oa8mYfAeUTcW498zQdc0
 B0EkMiE8Rez4Ol3jtDcAlb6AYXtGEKN7T8Z0oarmvrZcPrt/6UNPO+k5u1Aq1RdPOaDl
 Lt5nwzA1dDSwrsJ48/u6GHz/HjCXWMC7fJD1YpQElt4NmCStrO4fiAcORz5u7gnV9GjA
 pVPH//IUeKUQvleziI46Vr3LiUtwSpr5gXmkTM5lGd8JLAtmJU76fhMiuW5mAfqPCUFH
 hOVA==
X-Gm-Message-State: APjAAAXycojKXWZWF1s3oyS5NNlwgyEl7vnvzNSAqCt3iQ6pNpQX8pHH
 bHsFYJ/cSxeOt4eScOZahlDapQnWkOEoGQ==
X-Google-Smtp-Source: APXvYqy8FofoJRwdFyaqkHZLMWcnacLgUeDE2ie6hUhtxMGsz48iXBFUR6DUKbLnlBKkZiulCpVzxA==
X-Received: by 2002:a9d:7d83:: with SMTP id j3mr24830060otn.191.1560022281963; 
 Sat, 08 Jun 2019 12:31:21 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id v20sm2023351otk.66.2019.06.08.12.31.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:31:21 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-43-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ea5749c1-e6c6-5c32-deaf-90e66ea5c2df@linaro.org>
Date: Sat, 8 Jun 2019 14:26:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-43-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 42/42] target/arm: Fix short-vector
 increment behaviour
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 12:46 PM, Peter Maydell wrote:
> For VFP short vectors, the VFP registers are divided into a
> series of banks: for single-precision these are s0-s7, s8-s15,
> s16-s23 and s24-s31; for double-precision they are d0-d3,
> d4-d7, ... d28-d31. Some banks are "scalar" meaning that
> use of a register within them triggers a pure-scalar or
> mixed vector-scalar operation rather than a full vector
> operation. The scalar banks are s0-s7, d0-d3 and d16-d19.
> When using a bank as part of a vector operation, we
> iterate through it, increasing the register number by
> the specified stride each time, and wrapping around to
> the beginning of the bank.
> 
> Unfortunately our calculation of the "increment" part of this
> was incorrect:
>  vd = ((vd + delta_d) & (bank_mask - 1)) | (vd & bank_mask)
> will only do the intended thing if bank_mask has exactly
> one set high bit. For instance for doubles (bank_mask = 0xc),
> if we start with vd = 6 and delta_d = 2 then vd is updated
> to 12 rather than the intended 4.
> 
> This only causes problems in the unlikely case that the
> starting register is not the first in its bank: if the
> register number doesn't have to wrap around then the
> expression happens to give the right answer.
> 
> Fix this bug by abstracting out the "check whether register
> is in a scalar bank" and "advance register within bank"
> operations to utility functions which use the right
> bit masking operations.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 100 ++++++++++++++++++++-------------
>  1 file changed, 60 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

