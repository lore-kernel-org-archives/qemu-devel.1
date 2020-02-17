Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD96CC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7666E20637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrXkJKW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7666E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51919 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m7i-0003yN-M6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m57-0007tw-BF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m55-0003H2-1c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:24 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m53-0003FW-Kx
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:21 -0500
Received: by mail-pf1-x444.google.com with SMTP id k29so9400702pfp.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yXWmWbTow3nfGq25Kdd4WZBXZZdNP2bAetHH/H1lBQc=;
 b=mrXkJKW2wpNH4dlTL87xlErtR5rTog2PsCwsxLNA4OdB6+Uu8CCESIcv7YTtD/9L+u
 GK8mR2GweW0SUdPf6RlWXHErSsHgP1MSxa8TIXCttysLf2Lf/K2sFXzCo8PD3K0zGyCH
 8fiVFm+bsUmJ1SyP7JsU6a15ya3E+7m1LwtwMyrXLfbjI8YaE5WEzaEQtPN56Lx/5pBD
 913VJQEWb0/vLabiK85FQSZgV7H7IOH4kqDoC3cUS/doa1j4UDeglmnCUB0KCRuQ1w6s
 Z8IIvpg0snb7taAKgMSqWJId4C9W24EKKVG9E/WcFtyNkPOsJKmJr6RnuFyOJk0QdOxD
 r9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yXWmWbTow3nfGq25Kdd4WZBXZZdNP2bAetHH/H1lBQc=;
 b=ZHZIpCw/7CKv8WBOii66tS2ymaNlt4S8wm+jQ9vucE6C3kGoVxy7ubl3VDjfwTA1u/
 n19/WtkmsrQy7p8fSxNY5X51Tdw4dpRff2dN0pc1WUoNnpoiTo2esZyYHW17OusPXcup
 j6cPa2MCqAAK2UWeRdWngnQd6utSEogl1twnS0PCxkp6R67MKB5qQe8c/nzi2gLXJj+N
 H3XDOq1N3T7hWzu4iQRlwBiQqSJjo41ojQH6jpu4Hz3ZufGh6eQbpjhpURgpiDYJVewl
 Gf7hYDulUPdfNub8+1cejJy8eCEWwll7aVC5py5DlOMS4qr2S9O99W0UzxA/IC33o7/A
 JSHQ==
X-Gm-Message-State: APjAAAXfbiy+fNtJ0ZSkj0dDDrG7x26BTUTjwq0bxMDdZQv9ia4lTpOl
 d7KidVnqOafMOd/zVdCcWWPZ6w==
X-Google-Smtp-Source: APXvYqxU4B/VNbiXMgfyRH4fIRlv7NRqyQ6+CJ5KhBWVGwHlvBKzRO0vpOwG5J8/ru4Qdv42cmPGsg==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr622808pjo.69.1581967758719; 
 Mon, 17 Feb 2020 11:29:18 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w18sm1783070pge.4.2020.02.17.11.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:29:18 -0800 (PST)
Subject: Re: [PATCH v5 44/79] lm32/lm32_boards: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-45-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8716531b-3d18-5da1-6087-ec2f1a53d49a@linaro.org>
Date: Mon, 17 Feb 2020 11:29:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-45-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, michael@walle.cc, philmd@redhat.com
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
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


