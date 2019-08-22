Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A2C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5AF20870
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 17:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFyvlE1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5AF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0qVs-0000fy-Hu
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 13:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0qUI-0007qL-VI
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0qUH-0000Dx-Ey
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:02 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46506)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0qUH-0000Cp-6A
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 13:03:01 -0400
Received: by mail-pf1-x441.google.com with SMTP id q139so4336252pfc.13
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eZq2vsqsa0wP6reNOee0MyZDgeFMn6SHLG16kdwn5WQ=;
 b=RFyvlE1+BKAp+GEuC48SUH1Qdc8zfIFhXlU7wJAvEClyIHmcSqJ8bus/DOExnD9XKV
 iY0dafEAx1M2M7SmcL5MuefUFVJltElBcd6c73/WIfUGX2Nt51CzsfyXvFp1CY9Q0Znx
 5JTLUQ9xiL10PwfSyetdoL0XHzWRbFkEM4HGOzBbno95tjKjNunUvrdYrMyOKPuobETd
 6I3hpehOjjdGX+ImT3zOxSphvaoEOp6mUzmtusFrqRsQXubayZtUjsk816WuXN1Wij3Q
 IUUO4gUfDWQBWjBM1LOpaPWmncgbVIspFd74wY1ID6G45Xcbp61qQaRP08t68vzP88Kg
 eUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eZq2vsqsa0wP6reNOee0MyZDgeFMn6SHLG16kdwn5WQ=;
 b=qiSOoEVADIL353k0tTV+e0C1RyohJIghI8zmQjCMzkCiL1NN8UWlTwpWLUAnqrwwgq
 km2jz6swC0BUKMPZMBgfWRnrvc742K0YfyoMRwFbOVFtKqy+goJ6AKe6/ZLS1G1oH/yt
 9YOyQvcQBLfgYGB+vI6uCXR0Y++Fkj4aQqFun9jIoWU/FtOgbE0FjnKfqHB0NEcBdJWR
 iZXmWZo6bodnZxquMYXjog0axHaI7EAEPN3/ZRAJBIipif21BHxQAhxqn4HHFYcR418P
 W8dNJd9uQD2ZBePcwupE3D0jUhHnM8vhVQsNn+pt5QxqTJMSzGtGf6vMvD0uhlTgEZgP
 peOQ==
X-Gm-Message-State: APjAAAXP4cgN0j1ErKjgXWYa0d8Jaw7h+u/XPpeAkicJYNR4j7mUt9/Y
 iQ87Dj4JbtvS6+cprvGH60MZVw==
X-Google-Smtp-Source: APXvYqyXZ67W+Pam6BD416XVQsVd3Xavq3NKFg+4etmL5wtcTdiA4n2tRxB2fnENW3ZD7SO+fJUbmQ==
X-Received: by 2002:a17:90a:dac3:: with SMTP id g3mr684465pjx.45.1566493379131; 
 Thu, 22 Aug 2019 10:02:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c5sm29425654pfo.175.2019.08.22.10.02.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Aug 2019 10:02:58 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190822131534.16602-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c944bd01-14e0-b9f0-28a8-2dee677ed6c4@linaro.org>
Date: Thu, 22 Aug 2019 10:02:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822131534.16602-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] target/arm: Don't abort on M-profile
 exception return in linux-user mode
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
Cc: Christophe Lyon <christophe.lyon@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 6:15 AM, Peter Maydell wrote:
> The upshot of all this is that for linux-user mode we should never
> do any of the bx_excret magic, so the code change is simple.
> 
> This ought to be a weird corner case that only affects broken guest
> code (because Linux user processes should never be attempting to do
> exception returns or NS function returns), except that the code that
> assigns addresses in RAM for the process and stack in our linux-user
> code does not attempt to avoid this magic address range, so
> legitimate code attempting to return to a trampoline routine on the
> stack can fall into this case. This change fixes those programs,
> but we should also look at restricting the range of memory we
> use for M-profile linux-user guests to the area that would be
> real RAM in hardware.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1840922
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> I have no idea how we could achieve the "restrict addresses
> shown to guest for linux-user" mentioned in the last para:
> any suggestions?

I guess we'd want a new cpu hook, and change MAX_RESERVED_VA
from a macro into a function call.

Move the cpu_create() in linux-user/main.c up a few lines
before we default reserved_va for 64-bit hosts.

Move the check of the command-line setting of reserved_va
vs MAX_RESERVED_VA out from handle_arg_reserved_va to just
after the aforementioned default.

Seems plausible, anyway.


r~

