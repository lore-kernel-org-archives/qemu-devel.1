Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F867C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB4C215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvFdxBL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB4C215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMGG-0002SH-U1
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMEt-0001Qc-SZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMEs-0008SL-Nk
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:47:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFMEs-0008RB-DH
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:47:06 -0400
Received: by mail-pf1-x442.google.com with SMTP id q21so8534738pfn.11
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dw5+Plo4HhNnd148/i5R7IfjhCcc++n0+iY55oE9COQ=;
 b=gvFdxBL44N1v/G2ecamkAds27Mc7ppkB794seBu2ovL3epAaClPHuTrehL6Q8IZMO1
 Vr57RjVEyrfONmiCZj2XETFwnX6Gblz1R73OT2rJH7bXHoLjr74r4uNOYtJcqUDrHUIk
 +RKdceg0slzV/KDsBRe0ewMbdEKUmjk84TRsQXJ31H88fSUrgRc7eRvK3jOTxxc8jzOu
 3IcuWVX8UxJqK03HtCc5gjrxLnvtyZNBINUlX78CjKYFlFEsoWG/ymQiEoEfaEw9IQow
 ptjw1Tmp3W7KjeI5oL3/7jHgToVlwtbGRAUaMu3Us6DPz8b9kCeHaIpatjLSlbZRHaQi
 U86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dw5+Plo4HhNnd148/i5R7IfjhCcc++n0+iY55oE9COQ=;
 b=bvh12otxcY2hTeiSLUhjGcAqdE9SZKfPGZWHuDjbU6BI1dHLjCBFi74mrrr2aOpGNL
 13l3fg1NFDjJ3RfJGdEQnbf5VFaW+cc005jWzKCP3woPEJE0Nv0bq6gqSovo24bQV6/U
 0yLlUyXbfcMiDRWMiQp25Hz/NDapdg7QON33JugI4cXqkH1XQuph0e+OBLdLMsMj+C8D
 wWA4BZdSGTcgn7xKfDSGVZWcL6NDg1QgYV+qujdMNIJxmrbPjzTFp0fUzdFixauSB9pu
 EaZZFIqDAI2s1Yvw+qIb7S8fNCSUnsGi4z/1Plna/keahQ2crERBFmwMagDJEYrV3688
 n5Hg==
X-Gm-Message-State: APjAAAUT3WEavv5ARHDWy/AoOc821p+bLDcwbVNRizOs245bXctXXRph
 eSp5o8moAoiNe0AOptpcYGO0Og==
X-Google-Smtp-Source: APXvYqwp3gU69k2umjl88FK9zrPIN/BiICOUzTOIzp4RAJpvowKdFirwcNFgwNCYAuczxiMUEYLZlg==
X-Received: by 2002:a62:1516:: with SMTP id 22mr28725141pfv.87.1569952024349; 
 Tue, 01 Oct 2019 10:47:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id m9sm9343571pjf.11.2019.10.01.10.47.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 10:47:03 -0700 (PDT)
Subject: Re: [PATCH v5 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-5-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <320e09a7-3025-6f8c-d37a-840094d7d8e3@linaro.org>
Date: Tue, 1 Oct 2019 10:47:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001125845.8793-5-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On 10/1/19 5:58 AM, Andrew Jones wrote:
> Introduce cpu properties to give fine control over SVE vector lengths.
> We introduce a property for each valid length up to the current
> maximum supported, which is 2048-bits. The properties are named, e.g.
> sve128, sve256, sve384, sve512, ..., where the number is the number of
> bits. See the updates to docs/arm-cpu-features.rst for a description
> of the semantics and for example uses.
> 
> Note, as sve-max-vq is still present and we'd like to be able to
> support qmp_query_cpu_model_expansion with guests launched with e.g.
> -cpu max,sve-max-vq=8 on their command lines, then we do allow
> sve-max-vq and sve<N> properties to be provided at the same time, but
> this is not recommended, and is why sve-max-vq is not mentioned in the
> document.  If sve-max-vq is provided then it enables all lengths smaller
> than and including the max and disables all lengths larger. It also has
> the side-effect that no larger lengths may be enabled and that the max
> itself cannot be disabled. Smaller non-power-of-two lengths may,
> however, be disabled, e.g. -cpu max,sve-max-vq=4,sve384=off provides a
> guest the vector lengths 128, 256, and 512 bits.
> 
> This patch has been co-authored with Richard Henderson, who reworked
> the target/arm/cpu64.c changes in order to push all the validation and
> auto-enabling/disabling steps into the finalizer, resulting in a nice
> LOC reduction.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

