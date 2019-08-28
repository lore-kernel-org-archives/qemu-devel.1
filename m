Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5509C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A632189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgqV6dXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A632189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2zKv-0005wB-4w
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2zJn-0005On-NQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2zJm-0006ye-KS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:53:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:38738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2zJm-0006xq-Ax
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:53:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id w11so99836plp.5
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UMFXxTEkfic9GBhUBgGUTW+seag+jbKLbTxVok8QmXw=;
 b=lgqV6dXE13AZd6xQNVdyVG4/6f9LtLhsl/BgfP4sAmWHzV6z0uaI9TrUIQHc+nN8c9
 oAS/n4PLiTvpOvXku0waOItucNR6vybpSNGf2vp1eL2/O1BbbRhuUU0wYKP8uBNznx8S
 YR2Q50jhJNbcQcRR2rgtufusflK4m5CuhCM3GJkgDmcpXmIPXRYQXCfrqo3SmG0oSFK/
 o7uze3kjovyhaTCtt883+sELv5jKTEGeThXcK+EMCrkUO4lNwvIk+mQlcboSo8ZMpoAq
 Mx2K8WQxn1vHJShT0YcSu311iSakMQ7WIxo9x1gSZ4pdeufXaRRlkdOhq5g16m2lK9Iw
 DY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UMFXxTEkfic9GBhUBgGUTW+seag+jbKLbTxVok8QmXw=;
 b=ETUgyONNLoLqQrATMUJK+DerAXxUf75KTJkxhfNvZJuaEtt+vP/n/4uuRW6RtEsg0Z
 0muWqgRuU4zXaXy9KIGtLLUeKOklRYuc9j3eJIgVa5+q2EjihxaQgIFFP03n1UzbZRmc
 1Tbsad0bXyQz9F4DdE55qTRG+d39oBudp9L7Wfl8YRxXfLVnHHjYqHBM91oWMx/yTp91
 mFupxA3qlR5aWhHfj7ywuMOezdFKefhM8O0/gwFouDaltABwwRPfMg8D0ugsPCapy/eY
 RE9962pfgwRfqJlBgTCuWSlpXp7adWJo2Xg1oTbZI1dg/FY76UWgaipV2zBrzCim6CY+
 X0Ww==
X-Gm-Message-State: APjAAAW2xpi/C15iCZyqtfiRjkWpX4SIHdg7FOwjNDQ64GL/WaVnTXps
 GekN2mSmj/8+I5W6IR46W5LcIg==
X-Google-Smtp-Source: APXvYqxzDeHz1BgKrdFJrPD68D3jhLKmz83GxGmOjF3o9iaaCJ2Q8CsZpyz5GofCapV6hM1O48ZKcw==
X-Received: by 2002:a17:902:9041:: with SMTP id
 w1mr4827592plz.83.1567003980864; 
 Wed, 28 Aug 2019 07:53:00 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m9sm8188174pgr.24.2019.08.28.07.52.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 07:53:00 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190828111004.28013-1-david@redhat.com>
 <20190828111004.28013-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b9eb6e23-bcde-e987-048a-e174070d975c@linaro.org>
Date: Wed, 28 Aug 2019 07:52:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828111004.28013-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] [PATCH v1 2/2] tcg: Factor out probe_write() logic
 into probe_access()
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/19 4:10 AM, David Hildenbrand wrote:
> +void *probe_access(CPUArchState *env, target_ulong addr, int size,
> +                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
>  {
>      CPUState *cpu = env_cpu(env);
>      CPUClass *cc;
> +    int flags;
>  
>      g_assert(-(addr | TARGET_PAGE_MASK) >= size);
> +    g_assert(mmu_idx == MMU_USER_IDX);

We ignore mmu_idx pretty much everywhere else.
Why bother now?


r~

