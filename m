Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFFC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2362086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8e5AkJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2362086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aUo-0003kd-O8
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aT2-0002Jt-8c
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aT1-0002NY-An
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:04 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aT1-0002LR-4f
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:41:03 -0500
Received: by mail-pj1-x1042.google.com with SMTP id q39so1621201pjc.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CsEraNL+eCiliAYsnik2Wjy5DfmaIOa1lMicG/YV6+8=;
 b=r8e5AkJWTHWNzM5tg2EVsBP38ngyLPTOCHCIsAXf531bVkYUIhaUmEfhTkzxQcX6Rn
 JM9qbEeZiHFgHOn59LqpvLgeQmBdeRu3H/ILCaU+7jL+5iIJu+9ntKxnj1qchm7pJvW4
 YpO4JY55m7D3h8GbIaWGiKQ42bldNr6yUpOwWWgK2cdT4gqbSIUV2gjtAaMNTGULqwNI
 sGkTsNpjnRSiWQKvmpoxj3pX4RZMAWB/k9IALYKLLLn46qpxQ0VcJEfAE/Q9sq+w/vIH
 NraH0em32ylJAIN0mX8XlbeQdeRu/DdIrEIYnlJQEU+pcu4CepyJehaPREQiWBcrJK0t
 d/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CsEraNL+eCiliAYsnik2Wjy5DfmaIOa1lMicG/YV6+8=;
 b=Viiss0TSImoOK3C8c6ZhxKO1+39H+NaGarMhdjpUGKSfMFAj1VN8xOfAFq76FTIAwy
 1Zo5a57xemNsCFRGJ2Ou16JBZmGqNNtyKDQs0lA7uW5ilNDYeyX0ZQP3jshYroM6rSmK
 LUvo6CEVLUvfq1xLcYvgUa9kV8yLscp4QNRRPEklqZ9N0Lz6OUyauf2ZX0j5/k1o3zd8
 boQCP96x725ZGw2SxyaYPgnE5IEL67OAG/ba8Yk8K2LhBY9GIzkKPPPpvrr8uiRJU6PD
 00Y8MgJBKSGFhS3atDYNOMU4MD8O3BQqv7i5AkBn43qCqoZ+CYGAQLT+G1KFgWqPckzT
 2arw==
X-Gm-Message-State: APjAAAXkDbayQ6nVc6jxrVj1CS1zavtKgxPpqEQC94bsab/sZZDIohiL
 yWhbPGWuTetETmeWs20dqL7Crw==
X-Google-Smtp-Source: APXvYqzqZhTSIA/GgQPIUrg9JtTvZjvPEIfZcbufluKOdkxVuP0Hc2zJMGYJE0XDjEh2HywV9JTUbA==
X-Received: by 2002:a17:90a:26e1:: with SMTP id
 m88mr5168859pje.101.1581446461925; 
 Tue, 11 Feb 2020 10:41:01 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s130sm5628290pfc.62.2020.02.11.10.41.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:41:01 -0800 (PST)
Subject: Re: [PATCH 08/13] target/arm: Add _aa64_ and _any_ versions of
 pmu_8_1 isar checks
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7f2e055-d61b-d19e-598f-8d94fca6c1dd@linaro.org>
Date: Tue, 11 Feb 2020 10:40:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
> Add the 64-bit version of the "is this a v8.1 PMUv3?"
> ID register check function, and the _any_ version that
> checks for either AArch32 or AArch64 support. We'll use
> this in a later commit.
> 
> We don't (yet) do any isar_feature checks on ID_AA64DFR1_EL1,
> but we move id_aa64dfr1 into the ARMISARegisters struct with
> id_aa64dfr0, for consistency.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 15 +++++++++++++--
>  target/arm/cpu.c    |  3 ++-
>  target/arm/cpu64.c  |  6 +++---
>  target/arm/helper.c | 12 +++++++-----
>  4 files changed, 25 insertions(+), 11 deletions(-)

Normally we also read the value of the ISAR registers for KVM.  I know these
tests don't apply along these paths, but for consistency...

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


