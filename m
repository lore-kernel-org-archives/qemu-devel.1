Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E534C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AB12070A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhBwl2Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aOS-0006BN-Gw
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aMN-00047B-GT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1aMM-00072u-GC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:11 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1aMM-00070K-7w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:34:10 -0500
Received: by mail-pf1-x444.google.com with SMTP id q8so5905629pfh.7
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dD9Gwl0YviawrYH50yAj2nFcWE0R1gSfyvKEaJotWtg=;
 b=vhBwl2NmTXULuDQPL8cDwcK4DWd+mTOC8TJKpwBLb/hzFaSHrnYEzEEISmMxeA5vEN
 BleCTcc1y7SQMHAjSw3XhAl7kgdKha7vEl0RlQaNKgOvFO79D5W8uCNfxIds0KAN80W0
 UCS5PKyjmlG3XPLSu5wilDDsLDh1xw/iuQWF3FOxhBzCHpKrYRMUSDoy+WKItjAJyILt
 soFT3qZFDl6RoS5g8o3dqog/zHfZifFzllbU9R7JZXq/+ZnCfZ5wHDmFXoQb9FOs/z9N
 slBviXW3t9O4A7LVQ1ZVFTzgQ8Zk9kY2IqsZZCSFm3p3qJ65YJ0e1gCxDJ2id3fNz6XA
 +HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dD9Gwl0YviawrYH50yAj2nFcWE0R1gSfyvKEaJotWtg=;
 b=Sif7hu+3XEXUQiu7+fKsvJfS/xh7kyoGPD785z+MXwflgHdAyyNR1FqacVg+LXZvcB
 L7SCEHZtMW7PITaeQEcmVDYgfynvYMP95XJpQnNg0LIW6wx1+qPvPo5NRzm9Ewde031W
 w8IgeuAagZFBPtzLMJ5UX4vFFsloxVzwGNG/hJzl2IT0aX29LQgdIQGFjt2SzmQSVbvx
 tUhglU5gNoTLS1ifSeS4pAqF6YPr+Pd/gO2ZgQ1HevpGNpiB7VG0TwViY8KEOXoZK3fL
 u5SplVntF5FaRmKvG3ffO3PwLpmfFfPurypUfHHguVfkuIKnvAx28M/V0ng0R5W6TwCN
 FNXw==
X-Gm-Message-State: APjAAAVsfa21up/BsU/NBmi9Luk7reNC5SKz5D+4UyASEo1gHGvBovrR
 0rI9NWBH2Rp4caCSHGECRFtPNQ==
X-Google-Smtp-Source: APXvYqw7F5n57V9rMdbCcYaYOkYGd4U7T9oaQJ88BN9LSSoGlxHrSh9EiGEddPngb65uKsw94OPeNQ==
X-Received: by 2002:a63:e04a:: with SMTP id n10mr4336216pgj.341.1581446049050; 
 Tue, 11 Feb 2020 10:34:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 l8sm3998719pjy.24.2020.02.11.10.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 10:34:08 -0800 (PST)
Subject: Re: [PATCH 05/13] target/arm: Add and use FIELD definitions for
 ID_AA64DFR0_EL1
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200211173726.22541-1-peter.maydell@linaro.org>
 <20200211173726.22541-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a75d967-513d-93ef-b983-b8a35f78c2bf@linaro.org>
Date: Tue, 11 Feb 2020 10:34:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211173726.22541-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
 Aaron Lindsay <aaron@os.amperecomputing.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 9:37 AM, Peter Maydell wrote:
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> -        assert(extract32(cpu->id_aa64dfr0, 12, 4) == brps);
> -        assert(extract32(cpu->id_aa64dfr0, 20, 4) == wrps);
> -        assert(extract32(cpu->id_aa64dfr0, 28, 4) == ctx_cmps);
> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, BRPS) == brps);
> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, WRPS) == wrps);
> +        assert(FIELD_EX32(cpu->id_aa64dfr0, ID_AA64DFR0, CTX_CMPS) == ctx_cmps);

Should really be FIELD_EX64.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



