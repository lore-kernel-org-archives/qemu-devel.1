Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4F2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DD421741
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c36NkZKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DD421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwRN-0008Pv-Hl
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwQm-0007y0-O1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:29:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwQk-0005Dx-RE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:29:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id g1so1101287pgm.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/8PBR3k/r2NCRoMrI78K9H5qgznee/2LFVwyC6xM0LA=;
 b=c36NkZKah1WWH1Dn9C9SGcjy+VdTyDsIndlWpSNmPoN14/berC4Um3z2IaUoEhzpuF
 WaoBz6TWuoxwjlsWoILwHKhNyu5Ic9dcN7V4z4mr99Cl4QI2oLelvBysaehBvI/caVJR
 yN4Sga1ziRx9duY5yjpY2Rgek+kNyk6r/hlS9T0H9+DnbW3x3eA3fwCwB0MZUFTP09Ld
 bc0+SHOoAeUTdCWIzhPcIwYjur25kzGuhHH1tl2mXA1G/T5RCNEgW4Xp2zYI7zXfwAiG
 8Dbqi9TFehFr8M56435AsUKxULE2AcwkT+HMayOGZerV1JG7djPfBWvEQTJrSAjoFpbI
 orAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/8PBR3k/r2NCRoMrI78K9H5qgznee/2LFVwyC6xM0LA=;
 b=IuQmNXhhDer7ehwc8SpEYStTjzxRx8yuoZEPLeSNosmtmrDT0xyOft4NdDza5SYSqM
 /b98tr/nKfHvbN5YuJu5prjA2ccna7clEqXuABm8By/7NtjYqowmKGPA286yv/NjgzKj
 y+FfQrylp7isWY7knFFPluxvpcb9/yd3fi+mHZhSSFpGiyFGcZSfxIA0En6bPXDDEf81
 OfiX58Jis1ZjhcPbt0Q/MxQ99aSOrPFKwhrwAL4bJNDdbKVneOqs1JxFZmLEFKKBStIX
 noSPtBGxIHlC6JBPOzQOTAVH7ZHX2BRpC5jHSSXpvl0nzWUL+AudERcCUcwCKRGdsMM2
 4tBQ==
X-Gm-Message-State: AOAM530+Bwv1dtBW1+ICs4AFyPmQm41O4Qf0j3K3hIT9uAKm9aJtQ9ja
 Abs4dzklefRgyKV8TKt8jlAa1A==
X-Google-Smtp-Source: ABdhPJzbt6NGCy1Edsnxv1fDzx9uYSuEtoPhy2pC5Skc1qSdMN1vBHz6aomq55hfyl6BSpeAa9oPUQ==
X-Received: by 2002:a63:5a41:: with SMTP id k1mr10437720pgm.346.1598452177531; 
 Wed, 26 Aug 2020 07:29:37 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id j2sm2298733pga.12.2020.08.26.07.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:29:36 -0700 (PDT)
Subject: Re: [RFC PATCH v3 11/34] Hexagon (target/hexagon) register fields
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-12-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9116d651-9b54-1507-9723-d3a365812dc4@linaro.org>
Date: Wed, 26 Aug 2020 07:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-12-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Declare bitfields within registers such as user status register (USR)
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/reg_fields.h     | 40 +++++++++++++++++++++
>  target/hexagon/reg_fields_def.h | 78 +++++++++++++++++++++++++++++++++++++++++
>  target/hexagon/reg_fields.c     | 28 +++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 target/hexagon/reg_fields.h
>  create mode 100644 target/hexagon/reg_fields_def.h
>  create mode 100644 target/hexagon/reg_fields.c
> 
> diff --git a/target/hexagon/reg_fields.h b/target/hexagon/reg_fields.h
> new file mode 100644
> index 0000000..cf168f0
> --- /dev/null
> +++ b/target/hexagon/reg_fields.h
> @@ -0,0 +1,40 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HEXAGON_REG_FIELDS_H
> +#define HEXAGON_REG_FIELDS_H
> +
> +#define NUM_GEN_REGS 32

What's this?  It doesn't appear to be field related.

> +extern reg_field_t reg_field_info[];

const.

> +enum reg_fields_enum {

Doesn't follow naming guidelines.  But you don't actually use the name at all,
so better to just drop the name entirely?

> +/* USR fields */
> +DEF_REG_FIELD(USR_OVF,
> +    "ovf", 0, 1,
> +    "Sticky Saturation Overflow - "
> +    "Set when saturation occurs while executing instruction that specifies "
> +    "optional saturation, remains set until explicitly cleared by a USR=Rs "
> +    "instruction.")

Is the description as a string really useful, or even used?
A comment would seem to do just as well, not consume space in the final binary,
and even then seems redundant with the actual architecture manual.


r~

