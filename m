Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9585C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D214207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UaTnlaOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D214207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lVS-0001k8-QH
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lUb-0000lF-C9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lUa-0004fx-GF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:51:41 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lUa-0004fL-9o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:51:40 -0500
Received: by mail-pf1-x441.google.com with SMTP id s1so9356437pfh.10
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RlzleNaBywoJI/VD6xKtkCpg7vqDXQTGrsG2SIB5yKg=;
 b=UaTnlaOtACSvtnoHvSsfvi0Gp3ceJcpVR3phesqPbulnBLlD6WKHsNtU/p+rfWZZ6y
 mkV2VFhk2fP9iaQP6yoYjEIRE9xkpHdNYcD0pZ/j5o+D9zQZ4xHcNTUdrzYWtnCJLZcW
 vLij2X+JwyBVwgre1KZM5NrYZiHJfZZG4RX8MIDanIEq5sjxt3ocvQ3P8WNJjQR88lrY
 rJZMcxjwemEz8m3UrIMic+4A+21AQRci4Ri4Cnp1ImxMTo3uspCEG3ltYPxVXAEhf+v4
 eS6YdBVeeyni9qoIJJz8X+NX9Y75Woh8e9gG5GOh1ECAGwOXiod0GhoKl7RKAnVaFqNl
 ImBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RlzleNaBywoJI/VD6xKtkCpg7vqDXQTGrsG2SIB5yKg=;
 b=WRtyLBzJnpxu3Ljl3fYumGZuRLB+GQvg/kvsndvZJRQ4nqPrIfdybsyuksDWgqQT5+
 6KcAcXmLwjcZqlIfpS8hKFoYKLSOIoctmuxIp9X5jlZIWcXH7DDfHswWLnQ+9OLgtQQi
 9u4vxwLrtuz4DvrRohN8+b1qivG95RvgHfhqPMhP5tRyH5Hhx3MmT7k0o9EFkSi5z9wo
 wUGL7MxrvHzKllX+NNBsD0mi84YxYHBax2ytXD94zBmdSOAXZ9pf4+E2/4LiCbLoh9+V
 ZaLV/MQd3A8UJemgJVE6kil9TD31vEEV2Snaw9vjAehfKXwFCVvQDAI5PsE68HuCa9js
 HexQ==
X-Gm-Message-State: APjAAAVnzT3yevuf8srcgdqcz3bGmeh2aoL2/nWCw9XCYnDDnXS5x4qN
 aoLHOT0uWTEOAubC2JVkfBNeWQ==
X-Google-Smtp-Source: APXvYqwHnIvB6A6VBZRml2JCVCsgEjDMiSgPtCA6+0I1vv3sjwNXgO/gumJINtQbT+jyojyendUkxA==
X-Received: by 2002:a63:60a:: with SMTP id 10mr16799278pgg.302.1581965499234; 
 Mon, 17 Feb 2020 10:51:39 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e18sm1179608pfm.24.2020.02.17.10.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:51:38 -0800 (PST)
Subject: Re: [PATCH v5 13/79] arm/digic_boards: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-14-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eca7b7ed-d7a9-8997-1768-d085c27f87d6@linaro.org>
Date: Mon, 17 Feb 2020 10:51:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-14-imammedo@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, antonynpavlov@gmail.com
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
>  remove no longer needed DigicBoardState
> 
> PS2:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v3:
>   * move 'DigicState *s' declaration to the top of digic4_board_init()
> v2:
>   * fix format string causing build failure on 32-bit host
>     (Philippe Mathieu-Daudé <philmd@redhat.com>)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

