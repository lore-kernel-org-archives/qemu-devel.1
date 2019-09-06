Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1843BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D491020644
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKn/l5zP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D491020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6FBS-0008CZ-4N
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i6FAQ-0007ao-Pk
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i6FAP-0002t7-DP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:24:50 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:46401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i6FAP-0002rg-6d
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 10:24:49 -0400
Received: by mail-io1-xd42.google.com with SMTP id x4so13039489iog.13
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lMiKSI/KiLROMZfuon/38GGDt/xmvodhfW5MQY62FPg=;
 b=FKn/l5zPCBj+sVhLGMtqztILxVclX8WcdF4vme2+SKV93yJkbD5qhWMwX28GYR8jld
 3+PunhZdFOhHCP40mVxlcYKrQRQYyWzzHxBTGRnTNa7T8OA80+Wi6TZXh+9vynGODNoD
 FOR3TfZYqTzFwI/ULLZj/x2fwYIDtIz3R96eCTdLqu960OY5geI/pDS6LcK8iCqJft9y
 3Kg/HaBqndl4w4du9NA7Opgnckk/i6eBDm/UD0nsSvwxMtbPSeRzHU8eSbJ0PzqYlJun
 lbhZqnHmM/V6Qd1y+qm7IfBnKjym0SoHv6cu22ZjOIaKGPbA3liv/W/kHWzf6qoCsoOt
 wZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lMiKSI/KiLROMZfuon/38GGDt/xmvodhfW5MQY62FPg=;
 b=PAaETKL7ou91ewF5vB3iziMcAUvxNUK9FLwfP0oDYMu/fgYwuSjQ3hoHnpMXG7Evo1
 R891RSs8P2j7l6wMpUr0SmjERv4VxUkAO63kXmGf5Zn0whg0QfibIZ6BvhPc8rEJ1uSh
 Lrl/wlxQJrN7QFklL8SoAIy95uIewBG9va8iqnUXEvq1pa75OmpqNciLHjIRsZc4Ub+w
 Bxp6NdzYPIQWhRJkpUOtmJ3UUbK7Bn39iig1C2EDtGqzA/Z5H8GnjVLntejEgxMIuH/8
 baBdnuhGcu2oX/e5p8nfrOj1/kPpIvnlH/1CDceivFcnfS71scwRSXKxf6+vguhFCisM
 8fHA==
X-Gm-Message-State: APjAAAXyOc5zO/4CvZwFltsjOvZjeV55t80O5axYngyEN4fl4YlApfik
 reOJKOLLthuNWZ4ye7eEo3f0LFlpWjqlxw==
X-Google-Smtp-Source: APXvYqzkltsPHA/f1mwT+GjKCYyNcxxhpk9oyDlnj4q7Vgdgm9OKo3BajFQwEod83Qq5DUb2Ba39Kg==
X-Received: by 2002:a02:a806:: with SMTP id f6mr8515311jaj.135.1567779887695; 
 Fri, 06 Sep 2019 07:24:47 -0700 (PDT)
Received: from ?IPv6:2607:fea8:a260:81:78cf:74ad:c2b2:73ef?
 ([2607:fea8:a260:81:78cf:74ad:c2b2:73ef])
 by smtp.gmail.com with ESMTPSA id s201sm11183569ios.83.2019.09.06.07.24.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Sep 2019 07:24:46 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-3-richard.henderson@linaro.org>
 <875zm692za.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f8112d1c-49f4-9e90-bbc2-280d91e8d8fc@linaro.org>
Date: Thu, 5 Sep 2019 23:26:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875zm692za.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 02/17] target/arm: Split out
 rebuild_hflags_a64
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/5/19 11:28 AM, Alex Bennée wrote:
>> -
>> -        if (cpu_isar_feature(aa64_bti, cpu)) {
>> -            /* Note that SCTLR_EL[23].BT == SCTLR_BT1.  */
>> -            if (sctlr & (current_el == 0 ? SCTLR_BT0 : SCTLR_BT1)) {
>> -                flags = FIELD_DP32(flags, TBFLAG_A64, BT, 1);
>> -            }
>> +        flags = rebuild_hflags_a64(env, current_el, fp_el, mmu_idx);
>> +        if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>>              flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
> 
> It seems off to only hoist part of the BTI flag check into the helper,
> was it just missed or is there a reason? If so it could probably do with
> an additional comment.

The part of the bti stuff that is hoisted is solely based on system registers.
 The BTYPE field is in PSTATE and is a very different kind of animal -- in
particular, it is not set by MSR.

But also, comments in cpu.h say which fields are (not) cached in hflags, and
BTYPE is so documented.

Is your proposed comment really helpful here going forward, or do you just
think it's weird reviewing this patch, since not all BTI is treated the same
after the patch?


r~

