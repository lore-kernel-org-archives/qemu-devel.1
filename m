Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C1C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274232072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fze6/rAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274232072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m3u-0005bv-CH
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m2g-0004BS-C4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m2d-0002L8-GY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:26:54 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m2d-0002Km-BT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:26:51 -0500
Received: by mail-pf1-x441.google.com with SMTP id x185so9410649pfc.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=fze6/rAssocoODf4bn7vLxw3/o8jU/NGPRt08m1HuNLPeT8YD7FZapyaDjwAah/VMm
 k0T/rEn0LntaoH97mSGqwxR1fMYP8JyOmGN20G65P5mHpQ5P7NI5xrL2IErGlX3SuOHk
 GHaXPOh+dSBWBFRb2eLClsoSNqQThLnwVfD8tMK0fcRdVmR3Woly1meFbZ5fgpcXlHwC
 QMaq3tI0OYiC/e1aGIW6v2kH/AGqeLUJFwUDAZdPoVjPe7wqvkfTmblWkL5/ppECBf2u
 RBUmrC0I4qxRFcgkIMwpHQXC2xoxLuzzBVFxljA/WQO41/h94Zm1kSkK3zOlG7nQNGUW
 WPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0JXBjTsj59hubbgQEw+E94ZUzjwM8GP16u5Yl6V3o6I=;
 b=Vv2GbSnFInGjyDzdRBvIJZjvAXb1DA31G//LcddO02NKU5OqairWt1/QjeEPmf7pXK
 QmImlSDMJv5ACcE2fCypZuA2GuU8IAyfweWaiAbV3uCcAywL5yAYSoBx4Wd1rKmmnGc0
 pelWQHVep/j1zvtGspj0mZRVXU/c7lJNpovOn6k7VXkuN71RWFCGXQXxl3qWdXWA+dm+
 yVFWlC/7+Ti5m0gL7ZnNjzBJY14YNcr2M4iJksNmGw285IaA++MzPzjrsjCu427xw7V6
 Jjj5bRUOJZTIoTLwBEbHPss1YIxF8rU8lfZiWVhN1eC9iqNqqTild/0UpwlQHluLIRTe
 ctUg==
X-Gm-Message-State: APjAAAUcb7/Icd7/gQCDPNoTZiGCx+U/0UpnYS8oXC4BeDXk/cGAo+7z
 8JwqPdkC5wdoBo69RX/MAI2F7VkkaLo=
X-Google-Smtp-Source: APXvYqxYyoC5rw0L96MNNuj1dR9xtnD49q7VDtQiNqCMynx1hcquR3HCPvLHVAP73l8Q9I/kcdi2Qw==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr18059476pfm.41.1581967610521; 
 Mon, 17 Feb 2020 11:26:50 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z64sm1282764pfz.23.2020.02.17.11.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:26:49 -0800 (PST)
Subject: Re: [PATCH v5 39/79] null-machine: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-40-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <347d70ca-f0da-929f-9ecc-1317f49b8a24@linaro.org>
Date: Mon, 17 Feb 2020 11:26:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-40-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


