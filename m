Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDEBC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A5B20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkING2rD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A5B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3leI-0002Iv-ND
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ld5-0001Kp-65
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ld4-0001Qu-7C
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:00:27 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3ld4-0001QW-0e
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:00:26 -0500
Received: by mail-pg1-x542.google.com with SMTP id g3so9553537pgs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uGYJgeR0f551254Hy8SWSLE/nuOgmy2/gVoy8rU3S0Y=;
 b=gkING2rD99ehha0ACq0aTZvYh6ntj7zZb8P3DKYbTMJ8RMsHYt2E/aJ8meB42Ywfs/
 9n2qDozBT0cwb28jDWt7J+dNbOJQB0ZpBUaK1f1WquXVMSZOBaqdX4m0G/buPqCXl+Cr
 mMkn7RIruaCxE3wKkZ+xIy16vl7VC3Q2yVXnXCNcd5/asacBYFlg9n8lUxnKDa7g3IED
 YOj99IuaIAjfKHDh+MC2FgDGHTEY0HmvD24UE0Lrwnt9r3ONpfMEReU2hK0Ed+5jFl/o
 ZQVstCfasKSB7IxMi0XHrdNFwWgbFhwZHaJQD3q2wvnxJv8hQGzMnGtXDj6rhr3AehSg
 qFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uGYJgeR0f551254Hy8SWSLE/nuOgmy2/gVoy8rU3S0Y=;
 b=NuSj/t68nXBJLJWIGya1V6g43UnMfu9fYo+XbClv3peCJO1yHt5JGrEvKve1aQXm9y
 Q0SRzspmsxPwM3n8h0XrLsDPQGcGllh5XhKvJ8WfKPp0AD0NX/p2YlR/HVFHkRsoRtNV
 2SUuoR0Pl7fhyhyQXCYI6jgr4KPBFXfzwV22mq/7pbuxkl93PoKOpKsGd8Hl+PXls0FF
 dl7Lk130mGbOovMG+p57+YNsaWmQTsBl6QXGm7jIY0IQZckfzuX5JOdk8ZDq0T/UUNqS
 6PD7YVOzVK21E4VdbYaq7VIk5VdGcBMfs7e4zKPdlslQRo+0R2OCQlhNDM9x05OqPYDJ
 BF+w==
X-Gm-Message-State: APjAAAVLQoJjYOmt9LKjkDXokq/duCSLYtBsW4aOeq0lRszpO+Lr3U4T
 S+M4ISsxE+lEuxassGswaZz0bw==
X-Google-Smtp-Source: APXvYqw8iU1ISjRv1/HM1M01xb5Os6J3uRsaYHiKwp8CYdHWDM/hu5uCtK3DH9vw3Pdm7v9KLf6dSA==
X-Received: by 2002:a62:4e05:: with SMTP id c5mr18049203pfb.258.1581966024953; 
 Mon, 17 Feb 2020 11:00:24 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 p24sm1197631pff.69.2020.02.17.11.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:00:24 -0800 (PST)
Subject: Re: [PATCH v5 20/79] arm/mcimx6ul-evk: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-21-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d166d65-7df4-46a3-10e8-6614dbc3f1d2@linaro.org>
Date: Mon, 17 Feb 2020 11:00:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-21-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> PS:
>   remove no longer needed MCIMX6ULEVK
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


