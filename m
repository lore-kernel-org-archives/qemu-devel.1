Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C6C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47188222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVwef2TD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47188222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2heH-0004SQ-Gz
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hdE-0003Cu-54
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2hdD-0006vo-6j
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:12 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:35776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2hdC-0006uf-VZ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:32:11 -0500
Received: by mail-pj1-x1041.google.com with SMTP id q39so4393075pjc.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9hG8SXXZJoqeLzXg5G3xeFaLJJkIakNB+GjZrK3aecU=;
 b=BVwef2TDnEXSg/XMvo4XEADNYW19ahzUur2+kTHx9Aoip/Utui1ejAgkxfl93dGf69
 4biJljocNZRH0LYQ8ZlKQ02oCFOexLri7F0RHXNY5G+oAKdcL/aUChUFx9NrLVwCE7As
 F+zMLa0XdSrOcC9sPOO0D6isqHii2VuN4HnQl1SINX5lR8NeHF2ylCYvPhRfoTirlHQc
 D7EBWEowgU4y+67zYMCYoNREma8oJ9btfF1OgE3Udu9sLnRGH42Mvp99i1RJbhZzoKMw
 GDWK4+gVdCziRBXlk1+h1z4/HWF7hsf4bzF/Vr3lKtcrBgWcfUHkgMD1Z3OQn6FcMj9s
 U4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9hG8SXXZJoqeLzXg5G3xeFaLJJkIakNB+GjZrK3aecU=;
 b=YptwnPwqWggBxolaVdhci7MZWIZrtyyO9/9A1zRLjJ/J71//NDo6+TYjq+P1GzAIZo
 PuRd6t6faQlE9nPIGanCzfdU4d6YWRD44SfvC1Cu2B5cY2ceTodkuga5E5HpQQKDfd6w
 M/54Fvh2K4LNvk8FmOU7oWVZndsJMG66owha71aO4k2rChN+er25sLOekqIUdV3y/Ohs
 KW9wS2d2quFdQcTP3ZtLoPRujtYPkTs/RUkL44PoBdJRkOVhrS33rUcex203gZE3Cr6C
 TTB+X3hbhzeVF3JwCi0WopYODz7muJS4PHIvQzFZBjZfRaZOWGdPsrNWKY4iO6cyFAM5
 vVDA==
X-Gm-Message-State: APjAAAWFcTp7uN5r+SX1e4rhbMfiUY+uNl11qP4G6kj5zed8HjWWRbHq
 4cbGYs1tF9U1aa0qkKCcEO/SJA==
X-Google-Smtp-Source: APXvYqz7C79r3VcLuu6JJVwtfdqNR62PCmi2MONMeO9cOUnTOZ2Sp6lzaJcY+YhDDc7ZIVGnAVcAAA==
X-Received: by 2002:a17:902:7790:: with SMTP id
 o16mr4877872pll.271.1581712329982; 
 Fri, 14 Feb 2020 12:32:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 q8sm8078939pfs.161.2020.02.14.12.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 12:32:09 -0800 (PST)
Subject: Re: [PATCH v2 19/21] target/arm: Use isar_feature function for
 testing AA32HPD feature
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200214175116.9164-1-peter.maydell@linaro.org>
 <20200214175116.9164-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15e44636-abdb-c339-1eb0-cc59343a9334@linaro.org>
Date: Fri, 14 Feb 2020 12:32:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214175116.9164-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 9:51 AM, Peter Maydell wrote:
> Now we have moved ID_MMFR4 into the ARMISARegisters struct, we
> can define and use an isar_feature for the presence of the
> ARMv8.2-AA32HPD feature, rather than open-coding the test.
> 
> While we're here, correct a comment typo which missed an 'A'
> from the feature name.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h    | 5 +++++
>  target/arm/helper.c | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

