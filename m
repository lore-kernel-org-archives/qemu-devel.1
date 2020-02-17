Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E9C34024
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348F620725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YM9t0oZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348F620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lTw-0008SW-DA
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lRl-0006sz-Cj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lRk-0003Zi-Bm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:45 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lRk-0003ZV-6E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:48:44 -0500
Received: by mail-pf1-x443.google.com with SMTP id j9so9345648pfa.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=12wyfLftuE/TCUM2xhWQuRTtzhOaNz7Sa8u7ZLejXog=;
 b=YM9t0oZK/VIZO7pfWLGxmY3vvLeVEX3p6yaO5za5PVamOeLrrNVYJGk3+AHcTlxQJB
 X9h2EyI49hAZjhRMd5ksHZDKvPtJAOKN9EWO2EioubtZiqs+Vn1+Ckq1SjoV8ujlmHPn
 VUJoore2EQxd8Zftfr/yKT8g0lDBQ7W478epPURerSE++2UEvJlq2SLKI4RtQSfi4VaS
 ZotPfjoluz1JGk0+iQX442dJB6v6hJ6rbHaQXDAiHcZamL1ppC8ECeQyFmS6pGNNLW+5
 KVnhOOqKgLJwndvMurKn2OVCKdP+oAOj0tkPEIu24/oAxYUa/PMFdYqvpEe0dz9ZS0lA
 XOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=12wyfLftuE/TCUM2xhWQuRTtzhOaNz7Sa8u7ZLejXog=;
 b=LtA9cIilUEDyRPkCA1qlMqBafGc7wYYP3sls7udzMIEROghsy33CydooMhUPwoE/5s
 lrSJDibA0pETosGQUgLMFRwuYTSVoPhVKdY+pjIRQ2PWucZ9MTHXHUz4qkX3PzDuFirc
 zKpKfcgYxqESsZhNEoVXX7CQ1shCDeOmABMhWgeEHXsdOBeEvmTU7CqMF9w+cilSCEXR
 Ku5v4+dwCjDCjFrp1inzjk7qg/GmIimcJBzzClQrjpjhkg1cXlT3xDy27O+pa+0Ffhy5
 kqZuLsBfz4lvNsnD1E00qyzBEpuIpkIOYZy2p9nBIHy2mas7gKs/1ep6LrhLgiEZp6lK
 RO2w==
X-Gm-Message-State: APjAAAU3gXseKgIb5NDr7ee67S5YVR1mZ9FHKJFuIZy2OIEqlFmxjgfu
 h42TuOd0RkCWOtTuBhlvrdzgIQ==
X-Google-Smtp-Source: APXvYqyH/gT3JwPNLx3Ayy7QdN3aDhyUfrT16IXOs3BrIhmxNUYzJkYCjRfp2c6PBEsqoBr8oIQMAw==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr17862905pgn.387.1581965323167; 
 Mon, 17 Feb 2020 10:48:43 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z10sm1670572pgf.35.2020.02.17.10.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:48:42 -0800 (PST)
Subject: Re: [PATCH v5 10/79] arm/aspeed: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-11-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <efa67908-3fab-505e-3a2b-b683bbde957e@linaro.org>
Date: Mon, 17 Feb 2020 10:48:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-11-imammedo@redhat.com>
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

On 2/17/20 9:33 AM, Igor Mammedov wrote:
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
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Acked-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

