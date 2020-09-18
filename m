Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90868C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1A2206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQiYswT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1A2206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIuS-0005HN-Tf
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJIj1-0000Sj-6P
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:55:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJIiv-0000J8-R6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:55:02 -0400
Received: by mail-pf1-x443.google.com with SMTP id w7so3715468pfi.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W0mG51GdAIy6lm3BFUcAHjyF62GYCpd37KY81IEPIro=;
 b=tQiYswT4oll1iOUREEuNoP4q8SDIAEwhDvT+gPCYzTO37SWsaQlUFhQxEvwZPK9wrU
 nJ6ZE2HR2fhRHwgr/Soy4c7jn2sO+h3CNEGMpaMY+xxp8MUY50fy3N6hGBNQM0dDDY5s
 mS88HJFjzlbZmw+fPBxGJX2ItxQjnBrcODa2NQyE3kC0XSiUqFWTZge2/mB4LFZgGjXU
 NT232S7xdNQjwPs7okDiJrT5VQzFyMCZZSGGwVicflCQQJb2C3xvw1bzFf1CqxVZqdHj
 v7XzL8IxVw02OXmI1sqQVnYSeyS6B98KdowzfstHgN6+oNiz9CWdbB3BKrNfLw+QdPIY
 eRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W0mG51GdAIy6lm3BFUcAHjyF62GYCpd37KY81IEPIro=;
 b=FpUnr5yXL9D/oeqQUVOUEkbm5gdx5yT2eD4bHgi4DIU6fe7ZmoVkJtUPSc8j01LIAh
 jIpBJIZeWUT9KAKeU5tTRrBusbYWc+BW6joupV8GrYBoVjtGLVeHesP2EQBYF8ablV1C
 jBR9ZzsgnzafHCwkkT693TvqU1rQzIOiTDdOQwEvsKp09nWrV26dirTgk5WmKpc2sbri
 cKbwi9/qXhPpFThQWVVHuvos8yS2Ic2OpsK7w9VLuBBCzuTXQHsoElASkBZ+hHN9m+Sl
 0ze/5LoHRaMxNA5U8H57gehjTdXX2EQA92vf7RXJK0+4jKkHbziQohu53gvkeGT3r9xS
 OSJw==
X-Gm-Message-State: AOAM531VW4Ci+Z1IFJHCnCuzAi1y+/tUqFz/cxAA8THUYiMuLBVPtkJJ
 OoL0Lya5cBTSHtQZ1dCNvRVCLg==
X-Google-Smtp-Source: ABdhPJxDEWVerXA4fJyZpRpRZV55eQN6I9gP4dfOUEbQkiKe+F3Ik1rVisszhKt0+PChBid0CuSqAw==
X-Received: by 2002:a63:4822:: with SMTP id v34mr26882212pga.342.1600444495676; 
 Fri, 18 Sep 2020 08:54:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o19sm3765895pfp.64.2020.09.18.08.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 08:54:55 -0700 (PDT)
Subject: Re: [PATCH v2] s390x/tcg: Implement MONITOR CALL
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200918085122.26132-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <58cff977-45a7-f475-8aef-f2e16542881e@linaro.org>
Date: Fri, 18 Sep 2020 08:54:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200918085122.26132-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.869,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 1:51 AM, David Hildenbrand wrote:
> Recent upstream Linux uses the MONITOR CALL instruction for things like
> BUG_ON() and WARN_ON(). We currently inject an operation exception when
> we hit a MONITOR CALL instruction - which is wrong, as the instruction
> is not glued to specific CPU features.
> 
> Doing a simple WARN_ON_ONCE() currently results in a panic:
>   [   18.162801] illegal operation: 0001 ilc:2 [#1] SMP
>   [   18.162889] Modules linked in:
>   [...]
>   [   18.165476] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> With a proper implementation, we now get:
>   [   18.242754] ------------[ cut here ]------------
>   [   18.242855] WARNING: CPU: 7 PID: 1 at init/main.c:1534 [...]
>   [   18.242919] Modules linked in:
>   [...]
>   [   18.246262] ---[ end trace a420477d71dc97b4 ]---
>   [   18.259014] Freeing unused kernel memory: 4220K
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

