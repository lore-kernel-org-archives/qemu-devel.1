Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C064C4BA24
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AEA20656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQZsQ63l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AEA20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Vy-0000ev-HO
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j75Uz-0007jG-I8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j75Uy-0000n1-Lo
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:49:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43786)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j75Uy-0000ma-Fl
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:49:48 -0500
Received: by mail-pf1-x441.google.com with SMTP id s1so516041pfh.10
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VP3gll11f86CTRcwmjPBh1Eol8K/ihxbxiVaCfc3vK8=;
 b=KQZsQ63lscHJzGF1diWK/qnwSvzLUFCR//508ekf16J3aGwoKuMLt3hVQZQX03I2mq
 hKDsaVRd21k0NHG4w7W5hTG87ti3Crr2/9OxZ20dODznzzEwXeo1o2qve3SsXSQtB2cH
 AGDoeGQterz4PzEQ84iicEHhro0Xcbbgs1VRjzpcyPuavJlYxDTCU85+ObeMdx32gGbv
 YiM2tLsKleKte6nf/RGskfAR/khDwwSWwMRUyQrnaKedBtbZRC8wnhtCvdJxDhuycSaM
 VyxmZqdS6sAQC8AnvMIKURnV4nmjvWDnZ/B0OET7skojMLMo5pHVqwDMY3ukUnEBrttF
 MNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VP3gll11f86CTRcwmjPBh1Eol8K/ihxbxiVaCfc3vK8=;
 b=NNhLoSUL19K6Cis7r8Tufj+h019/A9PJQ4+2EmCGEy62g2VgxzHFoo+WGntssMsY5U
 2TvIkoqB0xDdx0aWRCg7XslbLfsvxpUE+3tA46samo0+WiGMpYjWYOp8fEJIBtMeCBE0
 WFrFrkoQkYew9whW3l2qzk0ncy9/khcBu2fJiuaXYmhZY8mS+t0gzqiLKqmhL95WDxty
 B9cKoUIgZhMjoackosTHfCL8TxWfZrfAQVK1ldnvDvuZRWaD8nQXuqpdQmdRi1ESJW2D
 W8CLJOEkE9B4m4lA8yulD0QTHXQstgVb0CqAXCqQUa2gq/r3staN8OGvh+5YWeKqtCbA
 oVlA==
X-Gm-Message-State: APjAAAVU+Ond6lgOCVjSjYSJ7DVZqV7s+dRW1boBReYJcBqrQuTYt7X6
 M/+2OVBPLCTyXTgA/t35IihGMA==
X-Google-Smtp-Source: APXvYqzUSvO424up8z1hcD6T1XhcCaUtqzLh5aIhCYn3tiWQQOuyquXKARHzSh7Wz4YYEbeQmfKUBg==
X-Received: by 2002:a63:8148:: with SMTP id t69mr1028220pgd.187.1582757387613; 
 Wed, 26 Feb 2020 14:49:47 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r62sm4248542pfc.89.2020.02.26.14.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 14:49:46 -0800 (PST)
Subject: Re: [PATCH v1 2/4] accel/tcg: remove link between guest ram and TCG
 cache size
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <86556987-dc1f-fa81-5f9f-fe4b438168c0@linaro.org>
Date: Wed, 26 Feb 2020 14:49:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226181020.19592-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 10:10 AM, Alex Bennée wrote:
> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
> 
> The current DEFAULT_CODE_GEN_BUFFER_SIZE may still be a little small
> but follow-up patches will address that.
> 
> Fixes: a1b18df9a4
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  accel/tcg/translate-all.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


