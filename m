Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B1C2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byDnkRiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B1C2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2WQ-0001Zj-Dt
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2VR-0000ZW-Nf
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2VQ-00080g-Mb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:50:53 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2VQ-0007z3-Fl
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:50:52 -0400
Received: by mail-pj1-x1041.google.com with SMTP id l36so5376907pjb.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/UWXHZi4DXFBfffCfyPVocmAFNI4snXYbPo4qlWnlaE=;
 b=byDnkRiEh1OEfbLEeEOTVYhXxZ9lchh/blL8OXYhlzcX6eODcFELVoRWMkK3eOfkAs
 g+nOzoCqmy5HsELBfBZFkqjYPpmiJan3GICL07c8eVwM2a9nrv1oqs/C8nxyOgwcSVCz
 7IVNPKn53D8hPDDhI6EBz7jGzy64WrU18CJAaldt2LtZ6f1/3n5OTr9bsjBdB3HGnkqV
 MUbv2HtgFNh/mH70mO720eaSw6wTAkZr3x9qfOFLaraIZKcTiYTzprSGtm1KN3I2h81M
 2TOCSxnaNltCxBUahys9E5MSDXzt6Nu7B23ezUamiwHCR1ffMDyDfVR0MwgYokSG/CDT
 XmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/UWXHZi4DXFBfffCfyPVocmAFNI4snXYbPo4qlWnlaE=;
 b=MUQJlcLfLNECJvFLZXqbe/OBPvjR98T20uAo5YB6cM7glcm0aHNO+F48GQmYqQBrFe
 /YGmb+k7DjtphYLssyhYlVkcjNDm5dBv9uMXSpb6e7xZ/b6Iz33EdB+3bW1hWjwxPRzo
 UOW5ARmWfK1x3fHwTNGe/fK/9Sk4e1lWBozHuac29rxj9t/6D1E7xr0LmXmNvGMSWBNx
 4ms27UeNCfIxoB+aaGmzSsUU657ejLoCda49PuXyajDTFtU8Y0nnpD1pID0tM2hBtRX2
 eoKg4cOHLElNzNx6yTKJcOWLqolaWxFBAIdWhH0A0gL30Vi7bLChjVywA6pRaIYdlrzE
 E+zQ==
X-Gm-Message-State: ANhLgQ1ddMCaoNFBQaHhChYozNvOhkxQmu2E24d+GWLwWtQou4myEDC7
 sKjyFCgIDH766Lgc2LNH4X85/K3OEFc=
X-Google-Smtp-Source: ADFU+vvXzdQK3jVEpzCnHOr6uqNGD7TzVl5uCPxpQ8gBeU/Lul7oxqZRSDrPqEv0LCYTwuxfUe7pNw==
X-Received: by 2002:a17:902:7586:: with SMTP id
 j6mr2635820pll.257.1584175851518; 
 Sat, 14 Mar 2020 01:50:51 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h24sm19381216pfn.49.2020.03.14.01.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:50:50 -0700 (PDT)
Subject: Re: [PATCH v5 34/60] target/riscv: vector widening floating-point
 fused multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-35-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a7ff25eb-b7ca-ce1a-5aad-1d2035f1fbb3@linaro.org>
Date: Sat, 14 Mar 2020 01:50:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-35-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   | 17 +++++
>  target/riscv/insn32.decode              |  8 +++
>  target/riscv/insn_trans/trans_rvv.inc.c | 10 +++
>  target/riscv/vector_helper.c            | 84 +++++++++++++++++++++++++
>  4 files changed, 119 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

