Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F147DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B715722B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LulsBrzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B715722B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39cl-0004DX-0S
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39c7-0003ea-7Z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:57:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39c5-0002Km-LF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:57:10 -0400
Received: by mail-pj1-x1044.google.com with SMTP id d4so3498481pjx.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 19:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=UqDtWc2Pu2KpzdLmwzBc+Akg/AMn557XKQdX16SGZq0=;
 b=LulsBrzhka3kHQQ12+z1mTJB2OQQnVrRtaTpCMjfZBS6Wxv0KEt/oDorc6tNL8hI/E
 lFpp7FXCtwJ6SWueQ+H+arVbyQ8F+Xr3s2XtKcGcy1KcA+YW/xC2n3GLdDzTjspaNSNE
 xbT0qqQE1CMIhETMTex+Y8Pps3vUyO13xRX2ezqO+z8PuD7pAhdgJ91y9qa+vJZ5G7HO
 Aw3n41tqF4VJ5g3W2z2U7TAyyFZ9cKJftRsMHSDg2Vy1XCuCs6bRL2pVo8C6q5NDt3Kg
 r9lnt3MQNHDaxgf8uwUUUve5/7Tv/ae5F81N3S+5KshvNwg4dRY8yx2Z/s/DUkbAKyEC
 VV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UqDtWc2Pu2KpzdLmwzBc+Akg/AMn557XKQdX16SGZq0=;
 b=aMvhNCLzF/sZnUrdJ2V/s48CUZY7Egw3ezmvDm1jZ13yKiJ246RDe2Sg1uvMXXNa2m
 5H8hsaKBe2N51z1s8/TPGn62CXcLKlA/56kNDVHKKsaB5tKfWZdIs+TXsMdUyNfhYEFh
 ycfKpFKXLUw9a/e4Xzush5jxLGC9CcmeAXusSszfM8D9Su4CrKd4dZUBD29Fm6fB/IZt
 mZ56VC6OLwmlRle1/2bamQCzOeFI6k/H71xs/ukDqZyM8bkcWkVigZzn7uxyYYzuLI4G
 ZcF/V3UfdMCXtGUxZUK0Pggtzu1nAKbc4mG13dcGlY4LbhRQwtPJd3wbS8OrvOi1VhEB
 dGzA==
X-Gm-Message-State: AOAM532mU7x1PtCulvV0aMYiGDsZ/KZBP8y5CGAZReHlwJRXb4b0P6LY
 9rXoWPrANAbtaqoL+62JPrU3jnArDok=
X-Google-Smtp-Source: ABdhPJyFVJQbcczHFh/Q2jyLaTwBErkUnPiFP6wYVvbvno/wAuL9NXVIY/4dNuMZuwEjgNZeMvHUfw==
X-Received: by 2002:a17:90b:378d:: with SMTP id
 mz13mr1129769pjb.98.1596596227845; 
 Tue, 04 Aug 2020 19:57:07 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j130sm753977pgc.76.2020.08.04.19.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 19:57:07 -0700 (PDT)
Subject: Re: [PATCH 4/7] target/arm: Tidy up disas_arm_insn()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <595b55e4-23c4-d546-3423-b3213ad2ff8a@linaro.org>
Date: Tue, 4 Aug 2020 19:57:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 8/3/20 4:18 AM, Peter Maydell wrote:
> The only thing left in the "legacy decoder" is the handling
> of disas_xscale_insn(), and we can simplify the code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

