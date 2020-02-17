Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C59EC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0659720637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaQOFAPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0659720637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51981 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m9C-0006Yn-DI
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6Y-0002Ad-D0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6X-0003xS-H0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m6X-0003x5-Ba
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id j4so9740053pgi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=YaQOFAPEHqSNbgbE+FrzkR0fEaVibFDirw0049/K6OaKjUEOPU13Tpbm8vDRMerDBc
 auF7Lsmjnqo2Cn2wkpKz1S9lS9vLJQikZSAGlbZ6zu+jcMdacVYRaSc+7SMW8VIC2juw
 4B4EO9RqobUwAZnsqOtaBwiWfsrH29UQAcThMLsRbL2aDr7AKLhzRb8orrBv0oARawWB
 ifAi2yiuoa2u5QwVOjP30l9kzv7wh5k+pugvjSWvjxeilWaE8sdMSh0XzfD4TuqQyVpD
 dfDQp7cIlA07+/AmjDAN8TEg4XFPsaiZAXGf74wORKrk4aH7V/IKKT13+RqUlVV9lsU8
 zWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=EB0UBkws0ffwad24v8J09nePB9HPaJF+uE2x8OJ+dSLsUUEYQo9kuicq7kyN0GdT+T
 K7aNY9blvAQP/Ja6YnSYqq1P4dddZIzH3FlerqxCXCOju7rd5E3Nj7Nm/JpSD97/GNZm
 M+uYAnigARa0NJOojW1+ji5Jq5boodTkXvESF1rTJ12Aupl/JwXY4Z65vSw37MYfOihg
 ivOfKmW6MnktNrDwEdJZrEiFpEin6IgIlkzt0whsBTkLBYt2+0uCVnLaTTpgsEcreuZs
 /Woo+zrDYL+DyfeLm6e5BgxqUjJUQpPU7MlSlbnh7L5p3WiTmQdYwauUKL5aD2pZHiR3
 pMUA==
X-Gm-Message-State: APjAAAXw1cCbVV0f1SZkG0O5UOK0Feg083gD2dALl+MpJDHPFNMZLTmA
 1LXuE7Jmakhglqe0enPUZUO+HQ==
X-Google-Smtp-Source: APXvYqzrgD80fqku9KHxmLz6cnen16ZnR/xqoRpWWnPWaZ/KMPxzG8U9/Yq+igBd6ZS2zFEb//ggHQ==
X-Received: by 2002:a63:60a:: with SMTP id 10mr16923883pgg.302.1581967852491; 
 Mon, 17 Feb 2020 11:30:52 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c1sm1218767pfa.51.2020.02.17.11.30.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:30:51 -0800 (PST)
Subject: Re: [PATCH v5 48/79] m68k/mcf5208: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-49-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07f5a7d6-2233-6152-97ac-3f8b17bdd76b@linaro.org>
Date: Mon, 17 Feb 2020 11:30:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-49-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


