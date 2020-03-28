Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D0C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E706206F2
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 00:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMSFGcTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E706206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHzEE-0006K0-Ho
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 20:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzDW-0005Uq-LN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHzDV-0003Co-B5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:20:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHzDU-00031k-R6
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 20:20:49 -0400
Received: by mail-pg1-x541.google.com with SMTP id t24so5401607pgj.7
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 17:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kMnXvxoIDB6jHvcS3CzFeAgUuNu+ToAuP9j4ypZV71c=;
 b=NMSFGcTmDLLi9AqiTuYH3K1iF2JbDzQxCA2M1HET0Z9KEwPdVCHkjfwk84KZBbGoXz
 s9cdJxujHJbNtnrgpVzOj8FE+HO/JKtriQTUNoUAN+qLFdhyxtpgXIpUqEYLB1j/Tomr
 ECfKI7hawvPmbhoTRP8ggNonroO3ynhUT4pToIKtoW51+hicP2onMG5M0QgP1pnWPhGD
 NXR1de3/lLDMrZvmhYQwWa+hq45tYPdAQ5B6qk86MfQg/bRzMKgjGzvhCMa17EnBnxUr
 Ncc6z5Et7WoLQfVrjJ2uHKTuWkPk2NEOCmYqO7cS+3+UVGk2c4yXCSpc1XXRU7hn3gaa
 rHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kMnXvxoIDB6jHvcS3CzFeAgUuNu+ToAuP9j4ypZV71c=;
 b=jF0dSDlqUFSTAGf+8Zcb9jQ1f7lTNnOS0yM+pGICou5Y3lmMHTgDVKBfmYWsOshHX2
 QDrgWrDembE2s508G1uqw/IZS63/RUl8G5Hqe9Tfm90JwZFDmU0yTUj6CTVQ1nYfbfMh
 O5npDl2L/n1shzdV33GYBiJWVOWNVJ1GekAZ/9Bkna1sTe5GzrsxqRStSXzgR6rA617F
 LdIqGmEHG+VuWe9SbgpBBI//mnzhHf1CWDQ4HDgLczsJQk2q8xWFXvV1L243NqgIjG5G
 EnfUFComuYCS0CS81pkZSKYaBiorpjpd46cN0ssIbchiZsf9hlapSREI7tMoL/+3HcDX
 KarQ==
X-Gm-Message-State: ANhLgQ0aplp+d+87VV2R600Z1YkB21Jo2ahJo5c1hVjU3WqwECnDLQmr
 kF+Rc2werHGQ8uSgt4Xr04Cj+Q==
X-Google-Smtp-Source: ADFU+vuRKN2A4Uv2+NkyoiojZEa7JKcAEufvZI7L1zwrmw9iAPrIui5evCwCldYuikIs+8JQy0xklQ==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr1835473pgd.357.1585354847206; 
 Fri, 27 Mar 2020 17:20:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id x70sm4611391pgd.37.2020.03.27.17.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 17:20:46 -0700 (PDT)
Subject: Re: [PATCH v6 24/61] target/riscv: vector single-width saturating add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-25-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3460b0f5-ab47-238e-181d-a74f3d135005@linaro.org>
Date: Fri, 27 Mar 2020 17:20:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317150653.9008-25-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 8:06 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  33 ++
>  target/riscv/insn32.decode              |  10 +
>  target/riscv/insn_trans/trans_rvv.inc.c |  16 +
>  target/riscv/vector_helper.c            | 389 ++++++++++++++++++++++++
>  4 files changed, 448 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


