Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325DAC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EC120578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1GX5cBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EC120578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mIJ-0003dQ-67
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mHl-0003Dh-5q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3mHk-0000ur-5x
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:42:29 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3mHj-0000tD-WB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:42:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id p14so9441546pfn.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=S1GX5cBn76zEaN3Dx/77CuHA2I2e5eNOJrMeujGp7PJ33uxpJS/oaw8CEccC2iXBYy
 Qbvw4xZx8Q+r/e9TqNYDRnrLouJZRpvT2QR62MuW6j3e9FaNTYvbf1WiZ9/FrNFAxt+f
 Hi/A9mEa4OXkrXvVbSbRwZ5KIOxHZ/DRsGu8qIepsmn2Y/6BnJ4G4UdlcezekVs/PLgY
 XWgg45ep+17HR2XOkA0RNaevKhV0g4twcblVzX9+fRdejjIm+WqLeg2YFkuFgYK9Q2Zo
 t9OGtUUhrSPSvGxj29empLGFg9e4QHudTsj2VmYtoJxRH04TY+GzqfWVggunPKIK6PRb
 /yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPGkuief6c1gMx0IQQHkieq2SiUsEqNdkxvRQsC4DHg=;
 b=qZ9zpgpZbK4YQyabW9pg06dYMAKyiJgdxWcRHmrdIq9LywzjQuXz7uxrFf/Ur3XPO6
 +IQOGWgtfpS6w901lxnGsfj4axsaiI3EXOKBbHssczD6CELikzwLuZ6kpgFtKBtKReMp
 eWLk9qleW1ouAvjeQBftDfb6gaHp8PAj+w7K0TRxW/R421x9KajAYmJpwHJTKY8AGjmt
 EWKT/X/nNXfruRZ0mXrbhQkVfkppYlZkx+Ob8imHP+y9F8sXtsp9pKmuRCTQxat66PcS
 fI33S/zth7l+YYIHW1q50G6N8uloywRz7u0wu5O/D/6i0yefhUQ02d6R8te4AzYGGaOB
 3XeA==
X-Gm-Message-State: APjAAAVWmFifWrheWXXYnFQPU5a0O6Gqo+X8Bvnk2AI7+NA9gn2fWuFU
 SXL0V5IQoB2YNakoZKrWWEkUmA==
X-Google-Smtp-Source: APXvYqwH7b1Pn/WdwP1qeenLoCe7SKFp2hlpSE5hjfFLZExHwnXS7lxBDrTOIGaEKm52iugv9QewJA==
X-Received: by 2002:a63:4763:: with SMTP id w35mr19632158pgk.113.1581968546878; 
 Mon, 17 Feb 2020 11:42:26 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x12sm1270207pfr.47.2020.02.17.11.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:42:26 -0800 (PST)
Subject: Re: [PATCH v5 71/79] sparc/niagara: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-72-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30a5c2f3-0197-52e4-c2d6-10a721dead9f@linaro.org>
Date: Mon, 17 Feb 2020 11:42:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-72-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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


