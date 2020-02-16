Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2992AC76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88D12073A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHCFG3rM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88D12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j39Ud-00085I-6T
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 21:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Td-0007Qh-EE
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j39Tb-0000Uu-Go
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:16:09 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j39Tb-0000Tl-0L
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:16:07 -0500
Received: by mail-pg1-x541.google.com with SMTP id b9so7039283pgk.12
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u3qGc4XRM+DXPV2VcXzsEwStXj2fsHDrXRR1bHt+R18=;
 b=LHCFG3rMIjBX9beMGfTJib8fv0xDLWCN3kbvB2X//9vigfVf3Thb7fyW9V5DsqYBQo
 AC7CmjvzUNabry4E2yfcINuBYJ5kg4shWp/CL0i24OLEGD1yiL8GcM/sDZFrfUELj3tQ
 dgWwgRc0GiK0jENMH7RIfp9PeDyPhqOSpIEtwZvnTtzsF/jWN8OambTTxNmN4NF1Va33
 vMHdnya1ylEzLQEyp0POGWxIFIAntYRKQ7+s6ixnYQ2PA7LOjK66xkcpSU4GFZptxykA
 M2TGc7PXc4nxezf2ZY5TcJm92D09j0atiD25k29v8zF6hm7JsE1X2ymcGTvKKusBVKkV
 dqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3qGc4XRM+DXPV2VcXzsEwStXj2fsHDrXRR1bHt+R18=;
 b=EvZI7z99jrv0HNImxvzYHFr+lEa0bj0dHpko5sVQpV/4p7vqEgSVneFcJeNsvyX+oZ
 dS26JbwRFlG94q07L1JNyEk8ErCJKhgKAFfSchYrI0nKeQ/4ffDmQFL8NBq8dN+sWjie
 izKWhGq8jXGxlMqf+JBgIQtOijhTbVgIGv43X5xQFm1Lgc20+lGBQZq7hHa/LMW+RJOR
 UtOthhyDzmSmjATTkBCE+Iy0JwjOcXTUoHvsDRQA+fguDvCG85DbceH3GjRvGUv4jxBa
 C0qGqvALE5zE+ZXYw9pvjzpOqhMamT/bYXjnc7qk4/7r2k26q9DvuTrQfm/dIoMvonqY
 YcJw==
X-Gm-Message-State: APjAAAVkIbAi9252xQcwhk0wcA+wlj8XXIoEU8H9pYb7vG4NxQ6+aWhS
 cgWg2pTqjNzRlM17hw49OoTSJw==
X-Google-Smtp-Source: APXvYqz6upRTjSxKQapixJxoNSk1wOSQDrr1Up+BHFgctGpdAcBVdDXh9ldumSS/P2zqQhik+rij/A==
X-Received: by 2002:a63:da0e:: with SMTP id c14mr10872558pgh.237.1581819365987; 
 Sat, 15 Feb 2020 18:16:05 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b98sm11910128pjc.16.2020.02.15.18.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 18:16:05 -0800 (PST)
Subject: Re: [PATCH 01/12] hw/arm/raspi: Remove
 ignore_memory_transaction_failures on the raspi2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215191543.3235-1-f4bug@amsat.org>
 <20200215191543.3235-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <405481cc-7fb5-8faa-7baf-1cac54c7c7ed@linaro.org>
Date: Sat, 15 Feb 2020 18:16:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215191543.3235-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 11:15 AM, Philippe Mathieu-Daudé wrote:
> Commit 1c3db49d39 added the raspi3, which uses the same peripherals
> than the raspi2 (but with different ARM cores). The raspi3 was
> introduced without the ignore_memory_transaction_failures flag.
> Almost 2 years later, the machine is usable running U-Boot and
> Linux.
> In commit 00cbd5bd74 we mapped a lot of unimplemented devices,
> commit d442d95f added thermal block and commit 0e5bbd7406 the
> system timer.
> As we are happy with the raspi3, let's remove this flag on the
> raspi2.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

