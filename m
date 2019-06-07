Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00083C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7140208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvIRYXXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7140208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKQE-0004iN-3h
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZIPN-0000K7-99
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:12:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZIPL-00070v-5f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:12:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZIPK-0006tb-UZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:12:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id 203so1914686oid.13
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rmp/CIxrfYaQ3kAVAZxIGEbkm2dLESS36pKtPsSJcHM=;
 b=YvIRYXXI0yKEi91ekgNbKHxR3IE7Ep4qvlWeoE4FpY6x0V3rlmz4WdAEXqfOoBPrgR
 64wlc5+65kjA+5YuIuMczkAMsdQVyJiIkiX6WWNkSc1k76zhYEKqhogosGyJOL5mR4to
 gSXJPwRBvEzbfBo1aQmaaArGTBX114PFLAhywqAy//N3Fh3+rbeFfV8OvWNpr5V1K8Z1
 jY3gSaVccfpAa7pNhdCeRiNWQrAEX+d/KOaKMxulsKCMPILEf6Qm2ThMA1caCuhMdk9C
 X0UV0lAyDv0O/fdqVV8sjADP/+Fy8S3WdYse8/YoIUI1yKdcOt4Q+xGEWIhpDcyBjwAN
 BrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rmp/CIxrfYaQ3kAVAZxIGEbkm2dLESS36pKtPsSJcHM=;
 b=DVPKzDH6vnU0UWb6iXjRR7pyKtnQzl4PvC3h8ZZrb4m+bUu+49feDRGRgipeJGtmyS
 bJoL+ZlNxIdLl+R3HCD72TxDls9uqlOtydZM7T0veFyCXddfaf7gGGp294Pgr5OCzkjA
 d1ZOPcFamNDty5UpozjNwbr5Au4VoNX9Oun1HPi3FhPiqKcRXKMip6eKPvuU/OGOay7A
 LG3KbTYcb3XojIYrGty/h0Znf0uOVgvuMEvUGn2fEeKy24Qdo6IDBk4/l1qV3hbt1Ld/
 VNftD377JM7esqU/7misedIXpWnGJ4v+kxxIv0SulaxlewWcc9+y0s87i22kno/u1H+c
 UFow==
X-Gm-Message-State: APjAAAUekV6WyQyO6HbwXx2hwmFDN3YuBpq2MbOs7Vg7UqAhStygkdtH
 f8poYOh4X5FS51ybTKiSFh6RDRj00SCbwg==
X-Google-Smtp-Source: APXvYqzJ4lnZQyPlpI4ZY3ypq0vbpDCF1vf6mlCIjHZ+apPRZ9qpIND5nq82abXBLC5+7LkErVDyzw==
X-Received: by 2002:aca:fc81:: with SMTP id a123mr4502841oii.75.1559927519526; 
 Fri, 07 Jun 2019 10:11:59 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id k17sm925040otl.13.2019.06.07.10.11.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 10:11:58 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4ad24b88-7013-e925-16ac-398d5e5c4619@linaro.org>
Date: Fri, 7 Jun 2019 12:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 11/42] target/arm: Add helpers for VFP
 register loads and stores
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> The current VFP code has two different idioms for
> loading and storing from the VFP register file:
>  1 using the gen_mov_F0_vreg() and similar functions,
>    which load and store to a fixed set of TCG globals
>    cpu_F0s, CPU_F0d, etc
>  2 by direct calls to tcg_gen_ld_f64() and friends
> 
> We want to phase out idiom 1 (because the use of the
> fixed globals is a relic of a much older version of TCG),
> but idiom 2 is quite longwinded:
>  tcg_gen_ld_f64(tmp, cpu_env, vfp_reg_offset(true, reg))
> requires us to specify the 64-bitness twice, once in
> the function name and once by passing 'true' to
> vfp_reg_offset(). There's no guard against accidentally
> passing the wrong flag.
> 
> Instead, let's move to a convention of accessing 64-bit
> registers via the existing neon_load_reg64() and
> neon_store_reg64(), and provide new neon_load_reg32()
> and neon_store_reg32() for the 32-bit equivalents.
> 
> Implement the new functions and use them in the code in
> translate-vfp.inc.c. We will convert the rest of the VFP
> code as we do the decodetree conversion in subsequent
> commits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
>  target/arm/translate.c         | 10 +++++++++
>  2 files changed, 30 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



