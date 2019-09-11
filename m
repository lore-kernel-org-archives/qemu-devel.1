Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B28C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DF4A206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdeGcMcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF4A206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8A3X-0005AD-HU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8A2q-0004aU-FC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8A2p-0005Go-EI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:20:56 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8A2p-0005Gd-8D
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:20:55 -0400
Received: by mail-qk1-x744.google.com with SMTP id y144so14289675qkb.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EvwHDP4nn8c4vPMn5Gt/yrJ+XmtQCXGLwaJE/UFRqHY=;
 b=sdeGcMcjcEz/CVmAZLiyLATgVOABPi2UFPiVGNqPcETL6GKOQagjLdw+8htqbaPAhQ
 30u19zO9A1VbVh/xvaF8RQptTowX1tmCn3gS1Uc0OTVhMvOGSu96qlGgpqVpfakR+BIc
 xu6+Hi90mNpYZUp/iQwk7d89KNRNmp/cETp+wY2I/MumzBB08wabk46yO98T6fxtdy9b
 cTe4fJz+ji5JvsjRjbWcbI9xF4ZbpAHIrbrctq12bcn8i9p54a0jRmYQGh1bOZmjuwjV
 FEXU/s7f56QootGCrtc2ITD5aASbh2T5BaTFfwg6t2uObw2BqxcjRZFNgwkGaOJ/eUfI
 +FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EvwHDP4nn8c4vPMn5Gt/yrJ+XmtQCXGLwaJE/UFRqHY=;
 b=a7QnGSgQw8WNaIxTFyNIEowsWMVzMlmH0cHeclj6ImcxTNjkUH1DqCDUzBLHRcrt4n
 1WYLwn9rCBFud1WJkjNPF7XlKRAfQJ7+sfZSLV/cKhHe8O5Sko3oCiXh0I6SObsy5saU
 Xq6TyGShrylsf5XkxUQ8nQMEqB7YmddYS4Zi3fmtBLydmYeupjjSlpaXFKLs1plZoHjs
 Q++rOj0f/GdIRC0bOcC0BaYfCZUDD1GYG+wpdKNj8c9SZADPgKLip1MgsFA6ld2tU2FA
 +o7tP7ST1SQXxZzARGQLHivIno5eCczDP5N/ylP79rQyubxVy92fn1M7o1lir29nbLZ3
 f9kA==
X-Gm-Message-State: APjAAAXq/iQ3GeyP3ju3/qTTfhMaq6JFqc1RCpzIh8ghir8sv/TUEHUl
 wzMwB+mT7NHppO4sF1+Mflzv3A==
X-Google-Smtp-Source: APXvYqzRUs9Vn27VvU3Rzrd860nLxS4Lgn/71AFraV08RazUHwAZNQ9QNwj6hzUUt/FQA62IncfyUA==
X-Received: by 2002:a37:49cc:: with SMTP id w195mr9170153qka.77.1568236854447; 
 Wed, 11 Sep 2019 14:20:54 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id j137sm10020230qke.64.2019.09.11.14.20.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:20:53 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <829ce31b-26bb-d0e3-eee4-83e91700f38b@linaro.org>
Date: Wed, 11 Sep 2019 17:20:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 18/28] s390x/tcg: MVC: Fault-safe
 handling on destructive overlaps
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> +static S390Access access_prepare(CPUS390XState *env, vaddr vaddr, int size,
> +                                 MMUAccessType access_type, uintptr_t ra)
> +{
> +    int mmu_idx = cpu_mmu_index(env, false);
> +
> +    return access_prepare_idx(env, vaddr, size, access_type, mmu_idx, ra);
> +}
> +
>  static void access_memset_idx(CPUS390XState *env, vaddr vaddr, uint8_t byte,
>                                int size, int mmu_idx, uintptr_t ra)
>  {
> @@ -420,9 +428,13 @@ static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
>      } else if (!is_destructive_overlap(env, dest, src, l)) {
>          access_memmove(env, dest, src, l, ra);
>      } else {
> +        S390Access srca = access_prepare(env, src, l, MMU_DATA_LOAD, ra);
> +        S390Access desta = access_prepare(env, dest, l, MMU_DATA_STORE, ra);

I was just thinking it might be better to drop the non-idx functions:
access_prepare, access_memset, access_memmove.  What this is leading to is
computation of cpu_mmu_index multiple times, as here.

It could just as easily be hoisted to the top of do_helper_mvc and used in all
of the sub-cases.

That said, the code here is correct so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

