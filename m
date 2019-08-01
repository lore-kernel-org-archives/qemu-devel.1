Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC7FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184942080C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="seLIY6ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184942080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htH7E-0004q5-Bd
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48531)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htH6k-0004Pw-Cl
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htH6j-0002dT-6B
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:51:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htH6i-0002d7-VZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:51:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id c14so32581536plo.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AgxYzN8cD2aem5SHE7ZTXaSaVH8BLBP3IighCEwmxQI=;
 b=seLIY6okw+j7Fva6S8d0TXdoxmRefLJFiUSvJr2JHqlV6k6UFbkGzfqjnT3TMr1WxP
 iphac8Cjos1Un2D9xbeNvrD4pYBbEgfuSzv7cR3bW7R+Dv5cH/6K/YsnCjoGYtXHTtB5
 l3HsxliG7e8/PEO5DBjmqAJyBNsgqJqrkLWkAwDJfPiCMfEZL1VEjkvyT14kiNp/35DT
 jsS7w0V6KtIdm1HMqT8I6QMz57A6zMV7oVNIwX6CMRbgrOh369cDfSdSUKKxtfcqT12f
 AIKg5f6KODrwZELCiFZmX/VaYd52yyVgiW13AlskHJKJeOiTQp4mInzzkiCExHLDlzVJ
 YUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AgxYzN8cD2aem5SHE7ZTXaSaVH8BLBP3IighCEwmxQI=;
 b=Ctm6T7gWBj5U14JdaZeSBxm/d0Kridy6kzGFq0c4wFkMYzBMj0I9ldlXcEZmXxY2Ea
 iN2Kuo6E2rPOEIe5CZTVWMfAPu5kT/PbM1i/SQwsS63PFSY1OKfKykCHfLhXg0GzE752
 //XKoZhM9Om+ygYNocDr/OVaGsV5sGhxV7A4uTRj3lSfmzMw3UtyhtLK7Iy/DzMyfFem
 rHlYVU8fD4KoqQ2zbcAx77LXNz703KVlGkxtXmQdXldWqCtDRd0785/1ZV0Tcc5iQQdv
 MFdy/P+0A0/V4NZ5G4Vb+rw6VCpGUMcvgrnuAWkhFg8dW1iraPVHolg1gG9Kt3Jnd3ER
 hOnQ==
X-Gm-Message-State: APjAAAWwbPmNBkBCGOZfwYbJdtQWXPz2b/7NMlDAnfUQweesbvt81IRU
 ccNKPZx5M00k976+RijZL3qykw==
X-Google-Smtp-Source: APXvYqyjsmlxcp3jQq3kVvKCPNjuEUkjkEUPnGDkJ//+IVGkNCFr2nfIzLj96bATay8eEVxoH4IXyg==
X-Received: by 2002:a17:902:7686:: with SMTP id
 m6mr127620872pll.239.1564689083971; 
 Thu, 01 Aug 2019 12:51:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c70sm29902996pfb.36.2019.08.01.12.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 12:51:23 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-54-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dfeaea75-a3f5-d1c7-c677-815da8385f6f@linaro.org>
Date: Thu, 1 Aug 2019 12:51:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-54-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v4 53/54] include/exec: wrap cpu_ldst.h in
 CONFIG_TCG
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, aaron@os.amperecomputing.com,
 cota@braap.org, bobby.prani@gmail.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:07 AM, Alex Bennée wrote:
> This gets around a build problem with --disable-tcg.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/exec/exec-all.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


