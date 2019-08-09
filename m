Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D1BC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1E72171F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxMyPPaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1E72171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvxMU-0006Xw-6g
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 01:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvxLt-0005zV-Hq
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvxLs-0000Lk-LF
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:22:09 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvxLs-0000Ky-BH
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:22:08 -0400
Received: by mail-pg1-x542.google.com with SMTP id n4so3530504pgv.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GFQf6fdXY7+fyX4kjByQA9BGer8bsmegQl2PDNmFEa8=;
 b=lxMyPPaNvSlC517wHZLEpXfkYJI3oYZE3vOUN726nsCOcScQrjRm16lXlm8lZvKg6A
 Jebz1pID2sLsnqDQKsUH0Zb5lTihPNZUZTqdAp2X4bTiiHQ2ogMDYAJmjr+EbZzQMvlq
 /vDPSQF03RTFxAVhJBRlAuXMRIkHgTjJv/vhvCZzUq4A3Zm9o1fa5aiHWoBHe//iV5FG
 +H3rccc8gYc2yl0lMnPuyjS5wU9+WxgqD6L6njoKt6gSUnTyDpk4nMHh7VDniKinAyGp
 GGo05TCy6SxDDL+bVQOtNNJ2qm3SpI5Rc/Khnm84Fxc33dQj/URdq46j9Eg43Sj7KT5P
 vdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GFQf6fdXY7+fyX4kjByQA9BGer8bsmegQl2PDNmFEa8=;
 b=YcodNtU/+amPeo0uoPeN23woMRLLzBW1K5kTY1lnqM+M7irKukSNiUynPJScWPLYoz
 yXNDpXbkhH2gUjHhWlMC+EV1vsy7MR4DSNhUrifRcHfALujJ8e0nPdPPUQWx3YR8HL4U
 ya+xzRRcoHpVyqOdHunyrjzUqt6P/mm9apeePb6fGE8Srtwey7tL1kV6EuXsq9Is/+Wa
 VMWzySeLcXMV2P1AM4msc3d6Ew5qyRlEqk3YByVBALeFcSUWbLYJDS6xrAdWURn4G6+T
 O4vCDIzThQdsw8jDf7QXQkfyoHflM4x4OOBwufPRRV4jUYPIp7hcAYGtp4bKp3nKJ7g6
 fJxQ==
X-Gm-Message-State: APjAAAUloTFS1UG2GOSRNJKMz42Z2OVeWPpxJGrGXLyikTuOBcPzTAu3
 E98/oz5LTk4m+4R6o1Z2IWIrwA==
X-Google-Smtp-Source: APXvYqx7B1/MLRUjD3/SpODUmBII9i2WrCON3ThKkuoOTgbPGI7oW5VDSLBIdf3lQVxjD9B/+M7+vQ==
X-Received: by 2002:a65:690e:: with SMTP id s14mr16216648pgq.47.1565328126625; 
 Thu, 08 Aug 2019 22:22:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a16sm105168363pfd.68.2019.08.08.22.22.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 22:22:05 -0700 (PDT)
To: Rebecca Cran <rebecca@bsdio.com>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
References: <20190809041952.57302-1-rebecca@bsdio.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <57083e0b-2853-7f5b-16ec-83bc22f237fa@linaro.org>
Date: Thu, 8 Aug 2019 22:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809041952.57302-1-rebecca@bsdio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] Update the avx2 configure test to be
 compatible with clang
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:19 PM, Rebecca Cran wrote:
> clang doesn't support the GCC pragma to enable AVX2, but instead
> requires the command line option -mavx2. Since GCC also supports that,
> remove the pragma lines and add the -mavx2 option when building the
> test.

No, this means we're not testing what we need:

We need to compile exactly one function using avx2.

The other functions should be compiled with sse4 and sse2, respectively, and we
choose between them by testing cpuid bits at startup.  If you supply -mavx2 to
the entire compilation, then the routine that is supposed to use only sse2 will
in fact use avx2, and then the runtime selection is moot.


r~

