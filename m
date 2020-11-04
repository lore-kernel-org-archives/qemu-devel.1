Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4B0C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E324E206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXIIzWpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E324E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLcZ-0004kI-Uc
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaLaJ-0001yA-T2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:24:33 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kaLaH-0008AA-8D
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:24:31 -0500
Received: by mail-pf1-x442.google.com with SMTP id c20so17683299pfr.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KkJj6LguC9285CDVew+iUQvZXtQK4Pc+c3R9AHxfrmM=;
 b=eXIIzWplnAYInHAZCdOfjmx4R6xCNB6lDpy8BnFa6iL1cofvKed0OqbL5WrdOB+4FL
 4ojKNo86ma8ETCALJ8YGz5VV0Xm5EP8b2WOjspxGNVPI1yizw2M8vgXuhJHzYQJU0XNL
 W8of7Qhh7+GRGGzbdCPRokw32rj2zHyFm3o75vF3HJO4y0K1vNQl6K+rFzvxTvt+t2Rl
 pdust4I7DZItqbfIYjKkMLC//y3I9r4HKRlHhHcvTS/OIAtgZ60rDrgjd9Xcgv1Zc5Eh
 fqBoSfTRIFoP951G5y6IfmALBX9sfU7i4ctCyui7GhnWze+eSl5rQYKI6z9vWNzfYNpY
 Qg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KkJj6LguC9285CDVew+iUQvZXtQK4Pc+c3R9AHxfrmM=;
 b=JLFEuZU6MpvtnXFG7mt94KOLz3JIDpGqJuVRDeBmicg8Z0ouYhpMVOKMJ8gNFRcNzy
 sNMYAA7VfnJxGSVmenewrnuHGcuuOpavWUaeiQX+OoUHS/V+tpDR6EPJRuKUjO6XPgfo
 YIpDH4/bTYp9KGq+MkDfE+KkYVkvqdx5Waa6vjCa8a3Gn9v9iHHJZ0qt5oyEfAFbAD5I
 LA7vuSwCTbh9YLBx4OZUZtZrt1iYtpcHLvK5gG2Z4Nb48AUZ3Uh/FBI1epr7HpQolUkM
 wbbCurR+vObPZdLm7uCoQv4ELUtkpQpQiMXq0oX4VM0oExbyxwQ7c7IfrMs/jCGM8JTQ
 rpJg==
X-Gm-Message-State: AOAM532Ufy1hy9rWyeElCzGJ5hL6wLrjYlA+aEn0aICw2Xye/72qO8F9
 BNTpLfMJYBSTlI1PuNfc0oeB+A==
X-Google-Smtp-Source: ABdhPJyjLDRQexVHlYUH22VztEEnwN32e8UsMDMtZngb5wUZq+RcRilMEgxDoAqYRZEFYsAA85F+JA==
X-Received: by 2002:a62:53c5:0:b029:156:223c:e88b with SMTP id
 h188-20020a6253c50000b0290156223ce88bmr30438840pfb.38.1604507066888; 
 Wed, 04 Nov 2020 08:24:26 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id k26sm2977316pfg.8.2020.11.04.08.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 08:24:26 -0800 (PST)
Subject: Re: [PATCH v4 1/5] target/riscv: Add a virtualised MMU Mode
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1604464950.git.alistair.francis@wdc.com>
 <4b301bc0ea36da962fc1605371b65019ac3073df.1604464950.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <021fc366-fcdb-3646-5fc4-0ff5790e6b34@linaro.org>
Date: Wed, 4 Nov 2020 08:24:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4b301bc0ea36da962fc1605371b65019ac3073df.1604464950.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:43 PM, Alistair Francis wrote:
> -#define NB_MMU_MODES 4
> +/*
> + * The current MMU Modes are:
> + *  - U mode 0b000
> + *  - S mode 0b001
> + *  - M mode 0b011
> + *  - U mode HLV/HLVX/HSV 0b100
> + *  - S mode HLV/HLVX/HSV 0b101
> + *  - M mode HLV/HLVX/HSV 0b111
> + */
> +#define NB_MMU_MODES 6

6 modes, but you're leaving two holes, so you need 8 here.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

