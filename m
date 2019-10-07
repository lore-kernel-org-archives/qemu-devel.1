Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7279ECE58D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8598F21721
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrmPgEtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8598F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSxq-0005YR-Cy
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHSwP-0004eX-DR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHSwO-0000u5-AM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:20:45 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32]:40734)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHSwO-0000tv-5K
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:20:44 -0400
Received: by mail-yb1-xb32.google.com with SMTP id s7so1037875ybq.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C+ot8Nq2sHr3ETVQasICTFOGE5lJWr4A2nrqF3GXIow=;
 b=xrmPgEtPG/23g4fq/kw2XaRY2VxAS2HWM5BesdC2yVE6s0GEG90g4OGPbIAlBRFf6M
 p7QbrvpRtwhxJ5IFzh6ElgsUSjVbu8wtf74C5CR91QPYyoJrMNJAjK79b3wMuZg0sZqK
 D0zo3nklRnQKWY3HNxtGgSAU/w4fxe+kd42FjaxSCXf8+w3X2TC6Kiktc/BrdHpRn+S+
 fv8kZbef7zQtpqa+AY31X1tAOrTpxZccIC37pO8LGzagNKI1wu5qh5qK2R1a7HB8NMW4
 hiKbdKULsxhzh+dGmc/+vwPZ0T7gzJraYekO1Uc50bAR9g5y7DtDlaoRn2JauqrfN2DZ
 Zzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C+ot8Nq2sHr3ETVQasICTFOGE5lJWr4A2nrqF3GXIow=;
 b=O/vgGMFQUu9Q6YcQGFgPk2TdUReMLeABOP76r0xSzrOpWhLiPku6q9MyR916k4zxZD
 RMvfT8oKWP8iePADLvCvm25LBDQWMTRFlya0rwS9XOaiIlbSzbKAdMrihu4SaIr5Qy71
 8zqbk9wDU2YJgIVV15nX5HODi1Of0i4TVzvE+nvQqgejWOkgrNuKv+Uuqx/vm1j/w0wA
 NCl9FpTEHDCVqAHyZXNc1ayqSY00Ov6S08YpQ6FBDBpFSu/2q7X7jwpHiNvpA/tW+IVp
 J+XYxw0DtT0JQ8iJKbFyYUMmq/WHl6vaCltT7u/QEp9C8ee3nw+34aFBY0E8a+JMmt12
 +P8w==
X-Gm-Message-State: APjAAAWRmrXcnNPqowgMIWxuxK2H1SG29FfNabpBwwjq+VEt46g/Djcn
 Ubxvm5lZPpViGeNw3mo9XgiVrQ==
X-Google-Smtp-Source: APXvYqypxWmNaA8XwHunp1w//t6f6oSrFNPKl2RA+l0ARB4yRI3ow7GDRX03/C64lOTwI5h1fQVOGA==
X-Received: by 2002:a5b:44b:: with SMTP id s11mr10623527ybp.97.1570454443176; 
 Mon, 07 Oct 2019 06:20:43 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id y75sm3773300ywa.58.2019.10.07.06.20.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 06:20:42 -0700 (PDT)
Subject: Re: [RFC 2/4] ptimer: Rename ptimer_init() to ptimer_init_with_bh()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20191004114848.16831-1-peter.maydell@linaro.org>
 <20191004114848.16831-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8a973b8d-a53e-011f-6fab-8bb86159cec6@linaro.org>
Date: Mon, 7 Oct 2019 09:20:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004114848.16831-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b32
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 4:48 AM, Peter Maydell wrote:
> Currently the ptimer design uses a QEMU bottom-half as its
> mechanism for calling back into the device model using the
> ptimer when the timer has expired. Unfortunately this design
> is fatally flawed, because it means that there is a lag
> between the ptimer updating its own state and the device
> callback function updating device state, and guest accesses
> to device registers between the two can return inconsistent
> device state.
> 
> We want to replace the bottom-half design with one where
> the guest device's callback is called either immediately
> (when the ptimer triggers by timeout) or when the device
> model code closes a transaction-begin/end section (when the
> ptimer triggers because the device model changed the
> ptimer's count value or other state). As the first step,
> rename ptimer_init() to ptimer_init_with_bh(), to free up
> the ptimer_init() name for the new API. We can then convert
> all the ptimer users away from ptimer_init_with_bh() before
> removing it entirely.
> 
> (Commit created with
>  git grep -l ptimer_init | xargs sed -i -e 's/ptimer_init/ptimer_init_with_bh/'
> and three overlong lines folded by hand.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


