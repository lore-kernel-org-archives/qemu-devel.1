Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DCC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6637E20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFPNS6sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6637E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mGm-0001uX-K8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mG1-0000z2-55
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mG0-0008TI-8L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:41 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3mG0-0008Sf-3i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:40:40 -0500
Received: by mail-pg1-x543.google.com with SMTP id g3so9617153pgs.11
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=sFPNS6sVfZdKlcMmHOLTBoHEhR67wKtosc+ilhU2s748qw2xlXKcTu/uj8M7M+pvCL
 d3qKm8yHQkCMLGCEUb6Kaum1dqeTcFJHX2hukKcLVG5HEBs8EZgyfK4Ii0oeKaga0HFJ
 Hhu3LGBDssELVf5pQlG7YBP3tNvEOicR+ioi3tOlRTT5rKD3aBw6qujrIQXSMzkHLb8u
 sjB+mtfIPDQ+SaKhyCJL+8J9meHGqZKbr353B8TvRR/IyrJMlrFZO8CNc0I/O83ywBH+
 XcU0KyWoK0qJliVf3XYw8MZdOLlgSD3RxBP/Or6kWGn5PZTK0+aKIBjo77cKOfvBN1N4
 JNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=etGczYHi1T4G0GeIFCOFtrpOmmztbYS+NkfbZgSlwCX+TeItugBh/U6nNMtLe/DkpU
 l7daYPOYxjj14Swedu2BmQfpdzsdD+y9Rp0SGb33/MjokAXKzMyAeDOQIl9x+NCM/c9r
 Sw5jpfIhC3hd+ze1QvuIlZzSdrPNsewQa9vpk7P0mrq4It2IwiWJvFaUpC+SpCAaXxp+
 01t18GMzyJkxxKUXyV5Ptn2MBKObAPeTdN5eIx+SUF0cV2x97wH93Y0Q09cvs/P8vTXX
 IidAx5MC+mQ/3Oc9DJBXAJOvjme/1/xfkR+cH1PlxSpXx54JET5A9bxf4zrq4sg9plkL
 3VoQ==
X-Gm-Message-State: APjAAAUgwNiagM/4aIMikKUYIIkI4maYuzrEiT6E0d8XYzgygCk4j/SZ
 vLF/rNJSEkEJvYc6A7zXSINfxHw4+hg=
X-Google-Smtp-Source: APXvYqxCwjkfhnO8Y65a23AaL88+cLR4oxtXrCwLndRqax64xCyiMM06EfduyHr7euWNUyuJJdFgAw==
X-Received: by 2002:a17:90a:bc41:: with SMTP id
 t1mr655069pjv.137.1581968439273; 
 Mon, 17 Feb 2020 11:40:39 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 o29sm1250576pfp.124.2020.02.17.11.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:40:38 -0800 (PST)
Subject: Re: [PATCH v5 69/79] sparc/leon3: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-70-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6645805f-47d7-08d3-1164-27613d54afc4@linaro.org>
Date: Mon, 17 Feb 2020 11:40:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-70-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


