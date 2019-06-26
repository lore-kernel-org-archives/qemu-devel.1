Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A808C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8CC20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUlQR/yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8CC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg4t9-0001U4-MF
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44941)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg4q4-0006RH-U2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg4q3-0003ga-QZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg4q3-0003fX-Hn
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:07:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so1458780wme.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d13CFAs8heXrNe1lEMEAnywPJmbZC2RHpfH/z4Bp+Cg=;
 b=fUlQR/yCzjv9zpDX99mCZl0qkKJ14ozQMrthed/R+cIHiRmZgf6U+5u15BjHwxsd27
 HeqiYLRSPWxK/modB1CoGSfmJoKwsTpc0hJJlBMkvmuqM0wv7J7XTe1W9PaS62odX1Su
 dKkipVqymtpCNHr1Yl5pZFX2lx4V1J6RfAKY4BNJt9hrltOlVPcC4UMw4QoKtwim/UqV
 sU/sNRIWWfVJe2dP76COWlmq/BbSLRI9wRVWJCZEi3qhHnpalfWa6XdsxlR868YUibzU
 n2G8Hee2VG7sbYI3dss7f/XJo7JrCO9EUh/hNV+r1dU5HjhfRzLoZWeU2PsqVd2+qplF
 oqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d13CFAs8heXrNe1lEMEAnywPJmbZC2RHpfH/z4Bp+Cg=;
 b=uJf3CcnwD9vdy8UaNDA7wJlTQ0xlp+18ZRRZ/8CQRWjWhq/VHCeHQLpRtUu4z6uPrN
 1xmRTwjpHVRVP/QHiVda6Kw72ytPlESW8BlQ6vzqp17PLKN6+PeHawjw8sGKLMhEFxsN
 kotQUF1KYq9LT0Kro1Fo0D79Wb/nGTf7XI3RrbErYsshbZQOvLxi/n03i2wG4VW3udyn
 38x0O5bmoB+6PLYQOY1eMLPlLvPhALYczg39Sh+NL8EmDWSu2Y2It5ibHYlAJBn6uev7
 KcSYglF35yY+m3M6sV2inHDcKpH4MfhGghtI0lZQWt2zFYnYp4vgXB8m5rYyJ7QQ2PK0
 MPNw==
X-Gm-Message-State: APjAAAUFAeFcc1CufKJ+NW+f7lro8xqgK8pT1zawixzzYql+e5eB6sAu
 sYPRkXApD0coJ1CuqZN6gMsYNA==
X-Google-Smtp-Source: APXvYqyLaAs5XqQSGQhJNLMdFFpYV107oBZt5JWJ52BPC+hkq8GO8dOFUmtP8BSoIyjhGTh+jx8DQw==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr2239722wmk.40.1561543658321;
 Wed, 26 Jun 2019 03:07:38 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id 32sm32360886wra.35.2019.06.26.03.07.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:07:37 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-6-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <07f6fb25-daf2-4429-49c8-7aefb2cde7ae@linaro.org>
Date: Wed, 26 Jun 2019 12:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-6-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 05/14] target/arm/helper: zcr: Add build
 bug next to value range assumption
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index df4276f5f6ca..edba94004e0b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5319,6 +5319,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>      int new_len;
>  
>      /* Bits other than [3:0] are RAZ/WI.  */
> +    QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
>      raw_write(env, ri, value & 0xf);
>  

Re down-thread conversation, I think this is the nice easy way to make sure
that the 0xf is modified if we ever decide to support larger vectors.

I *think* that we could write ARM_MAX_VQ - 1 here, but I'm pretty sure there
are a few other places where we assume that we only need 4 bits to store this
value.  Anyway, we'd definitely need to audit the code to allow ARM_MAX_VQ to
change.


r~

