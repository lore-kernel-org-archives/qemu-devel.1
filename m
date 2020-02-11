Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114CC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C2C20870
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKo51DIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C2C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XOE-00055H-6J
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1XNd-0004eF-Kp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1XNb-00047a-4g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:23:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25002
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1XNa-000477-PE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581434593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWsmfwx9LCnYDQCuky5v6KzLfLZJmZJ3cu2SywkhrlA=;
 b=UKo51DIHU37i3sfkOkPJG9y60PkgNcjD+2LR1JYixUuHVPc9vo0xSo9n5+sChmLS9OJ2rU
 8s5E5QDCFBhvJfQcXfqP9gwP8wLYU49+2BIb9hpgnY9wTWSYdj9t/L4lld2Qnf3+dTtb9h
 oRrwrqeHH2CU1n+sr3+Js1kdVPug7i0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-PFvkudljP6isr34ydHiZhg-1; Tue, 11 Feb 2020 10:22:54 -0500
Received: by mail-wr1-f72.google.com with SMTP id 90so7050736wrq.6
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sWsmfwx9LCnYDQCuky5v6KzLfLZJmZJ3cu2SywkhrlA=;
 b=LwnQZnZ9qYreHnqBkgowP6bXv5exrLQphaiGZWOWwEy8enMaX9SsZQWoDSBFbaLGZm
 OnieFwquEpPTBrPT3F3jOLPeUI4Om4t7c0HOpwPV7gSChddT9mBprVRPd1osErbVVYJx
 D790LJU5xl0bVBC8IUaWhkolzww4DSAh0eACPgZm9Pt4a4NxDR8R0T29lUJgI53MaUYR
 3YZ4unlNwW3A/hTe/AUH12+4K6+/vOVO8m8sAvGiZ8tcswXbjKf8Lg8g2ttLhywHYpcn
 N2yqyHkziEp6JmiCMhTBMF0/3SgwywDdMhNkfnMbKoC5goaS6St3dh3to+OH2y6ylwNs
 YnZQ==
X-Gm-Message-State: APjAAAVHlmAmpaAncwe9K1TqWUtS4dlULBCa2rWyzELktI/aaP+M+WJe
 IfJynyKBekWmE4tniiF/xnGPXZf8Vy5bmQK4t9lps1u6PL/WnUF2jizv4fY7UVVTQFYMWNFTTUu
 HJJLwp0FsapSueXs=
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr8936445wrt.253.1581434573695; 
 Tue, 11 Feb 2020 07:22:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqekNz4WyapIIhxb9Xx/7p1XCwPU+60aqNrKkP+JApJ5isieHJVutXBhk3NhCgHLBbkrHsOA==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr8936420wrt.253.1581434573400; 
 Tue, 11 Feb 2020 07:22:53 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g2sm5538439wrw.76.2020.02.11.07.22.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:22:52 -0800 (PST)
Subject: Re: [RFC PATCH 33/66] Hexagon TCG generation helpers - step 1
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-34-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4f62d1a8-4da1-4ec0-4536-d8e15462b187@redhat.com>
Date: Tue, 11 Feb 2020 16:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-34-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: PFvkudljP6isr34ydHiZhg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Helpers for reading and writing registers
> Helpers for getting and setting parts of values (e.g., set bit)
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/genptr_helpers.h | 323 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 323 insertions(+)
>   create mode 100644 target/hexagon/genptr_helpers.h
> 
> diff --git a/target/hexagon/genptr_helpers.h b/target/hexagon/genptr_helpers.h
> new file mode 100644
> index 0000000..2b91fdb
> --- /dev/null
> +++ b/target/hexagon/genptr_helpers.h
> @@ -0,0 +1,323 @@
> +/*
> + *  Copyright (c) 2019 Qualcomm Innovation Center, Inc. All Rights Reserved.
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
> +#ifndef GENPTR_HELPERS_H
> +#define GENPTR_HELPERS_H
> +

#include "tcg/tcg.h"?

> +static inline TCGv gen_read_reg(TCGv result, int num)
> +{
> +    tcg_gen_mov_tl(result, hex_gpr[num]);
> +    return result;
> +}
> +
> +static inline TCGv gen_read_preg(TCGv pred, uint8_t num)
> +{
> +    tcg_gen_mov_tl(pred, hex_pred[num]);
> +    return pred;
> +}
> +
> +static inline TCGv gen_newreg_st(TCGv result, TCGv_env cpu_env, TCGv rnum)
> +{
> +    gen_helper_new_value(result, cpu_env, rnum);
> +    return result;
> +}
> +
> +static inline bool is_preloaded(DisasContext *ctx, int num)
> +{
> +    int i;
> +    for (i = 0; i < ctx->ctx_reg_log_idx; i++) {
> +        if (ctx->ctx_reg_log[i] == num) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +static inline void gen_log_reg_write(int rnum, TCGv val, int slot,
> +                                     int is_predicated)
> +{
> +    if (is_predicated) {
> +        TCGv one = tcg_const_tl(1);
> +        TCGv zero = tcg_const_tl(0);
> +        TCGv slot_mask = tcg_temp_new();
> +
> +        tcg_gen_andi_tl(slot_mask, hex_slot_cancelled, 1 << slot);
> +        tcg_gen_movcond_tl(TCG_COND_EQ, hex_new_value[rnum], slot_mask, zero,
> +                           val, hex_new_value[rnum]);
> +
> +        tcg_temp_free(one);
> +        tcg_temp_free(zero);
> +        tcg_temp_free(slot_mask);
> +    } else {
> +        tcg_gen_mov_tl(hex_new_value[rnum], val);
> +    }
> +}
[...]


