Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EA8C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719D420578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUth1/9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDYcD-0006ZH-Gc
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 15:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYRe-0002ce-Rj
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDYRd-0000UX-Sq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:57:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDYRd-0000Qm-M4
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 14:57:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id b22so2337670pgb.6
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PDtmTCwcPEgm4OuieYeOqkSBuA6jPU6r2b5Kj3wu1oM=;
 b=pUth1/9ncBfCYN6YqlK+vmtXviBb6Ab5lbPEN4ngphVZyRlUZZcPSf4IG33YFUV95O
 0Zn+nMcNcwIW7R5qlREXKG6biuBjhrdQa2CVdfj6sbcbAmradtXSLj0tz7c3XscM/vMP
 wsfgMJ+zHeeuEYkTzLVU1fpFCvBGEURJ6RJ6DiU5zW9iQR4rAHgd1tmxCz5mNUaruyNt
 gaEhXafLE53+gGWR0l4xxK8n6dqMAuBcZCTlW19I+gJBP5my039QrNbgAk8+RdshCXVJ
 o/HLtFUPGVM74xjlxBCDMU37+XzruIZspKxkcUKFxk0346bfi4eZhhwuFBDaRgeeDD+d
 Y+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PDtmTCwcPEgm4OuieYeOqkSBuA6jPU6r2b5Kj3wu1oM=;
 b=MMAPTzzGUlJ8erMuPh/OmR+MromNXd8rGDpoOQQHRrA4we7bQGlva+8qPOeZFZm9bR
 cfzqLqIdl/E375s+iv5n/Sg6LxX5Zx2LByNr/lc1LzS4EXSp0UCYANZ+lcFIFGmiDr/n
 rx4OW7PxofB/XcI1rOTo2X8AbEy7/Fcv+btxValA3QfkQnb5J3uv54P4UPhuQq75xTfn
 IHi+K1vEsJz/XLoe1xIft8avIZXsJ6RqjAZeivCHjSJkgGvZdB/zuIMzasYcGmtzRVur
 hHr00vlU25+Xbfwq8T2FRNsGyMKW9reCOziDdVVKfPchGYTy84bKwZmqJwhgo0k27BVu
 gCPQ==
X-Gm-Message-State: ANhLgQ34o5k/ddZfwTtMeAMxOl0V/RjXhv1gOTiRBz9GyMFuL7GNpSMm
 aeRaFUhQmrJSbawY4RyG4mN+Pw==
X-Google-Smtp-Source: ADFU+vsTr5M+ef7X/zSRhKhoSQ/0bU2ZQ8EIWwuFuxsb7Qgf6/xLgdzo/Fxd5aM033NPbk69mtkWXw==
X-Received: by 2002:a63:161e:: with SMTP id w30mr23216111pgl.110.1584298624662; 
 Sun, 15 Mar 2020 11:57:04 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x11sm63955419pfn.53.2020.03.15.11.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 11:57:04 -0700 (PDT)
Subject: Re: [PATCH 03/14] tests/Makefile: Only display TCG-related tests when
 TCG is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3eb94cb-7cf4-2cfb-8eb5-ca1204c2be61@linaro.org>
Date: Sun, 15 Mar 2020 11:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313183652.10258-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:36 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


