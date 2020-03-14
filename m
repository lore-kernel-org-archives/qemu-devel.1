Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F1C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B529F2074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmBx5DIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B529F2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2Wn-00028s-Vd
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2UF-0008F4-8V
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2UD-0002Es-C7
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:39 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2UB-00024F-OA
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:36 -0400
Received: by mail-pj1-x1042.google.com with SMTP id l36so5375901pjb.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8zXx/792WLgRyPMk6TwxKI9vhi/pcFEZ88ADo3fFGso=;
 b=cmBx5DIFYSKzW4t3ERiX5I8wvLucLuiIYKBl5rKMMO4pHxblDnwrM0JC5FZXeC71YZ
 4uPvbAWLsbTsIDxlHeye/mVHn9pp3FhG3ZsM/drj0QUKRTU148DxMONDqeAE0QiHVJT4
 /XLMSUAArDde2KqHewbD0fRvMjjCvtWktKG39aC1B9p1uJDmhruL5Ls73a1dQKs2R65W
 vaFT6yNGqcjwvtUepEeNas//W+f2NODlS7ExIc0Z6+HFubqcgpZpoyBnLjR7hx1ay3VH
 VCNS78mK/i1XQ7f1x0ghhxTVEfRr50BRRmWWM3a3Z+kH68HZ/eEcasPZ16A0XNOjGB+y
 aI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8zXx/792WLgRyPMk6TwxKI9vhi/pcFEZ88ADo3fFGso=;
 b=LAkyQDZAqZJ1o2WkkX2BQbd+8wc2yCq/IZp/vnyruz4ciaC5/l5DU9yRv8IAU+ccuN
 WcZRN5ZELsJmEbbmcWG/6CNu0EjYJuuUXkhVO7e70SMFFtGPbe6C08mTdww89YVRAkTu
 93+Xl9jO82p6GV/tT59vih6AWsK1Y8Tl0jqcdsMTdd+wNd1c0ne5VUvUosDU/VyypTI5
 HqC1q/tsVYjjuV5yYIgrfBLJBta2kbcKwD2KU4AOTTW5aX1AbtvhyE9B2q3WmsvOCWIS
 gdEZ+vtavUi9hS+S1ECnZwSjfcW2a5N3m85YUCnNJbUgSCPxo+sDttUENzns/OVHsKH6
 cl0g==
X-Gm-Message-State: ANhLgQ26DTeVPrrI93MTFPVMSoaOLtpCdo01pIKnMjLtoRTRmJXWhlLK
 aFPEgQyyauJqc+vI0/agiQJmTA==
X-Google-Smtp-Source: ADFU+vuSN8+6qdyW+iMDPd1jLr//i7dBtAR9mYURRIrHKWMhvTWIZOZyfLGlkMjfG3sSuudTMK9/KA==
X-Received: by 2002:a17:90a:350d:: with SMTP id
 q13mr13581865pjb.171.1584175773335; 
 Sat, 14 Mar 2020 01:49:33 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i2sm13632837pjs.21.2020.03.14.01.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:49:32 -0700 (PDT)
Subject: Re: [PATCH v5 33/60] target/riscv: vector single-width floating-point
 fused multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-34-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fbaa033e-e1e6-e17c-8758-b7087834ed8b@linaro.org>
Date: Sat, 14 Mar 2020 01:49:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-34-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
>  target/riscv/helper.h                   |  49 +++++
>  target/riscv/insn32.decode              |  16 ++
>  target/riscv/insn_trans/trans_rvv.inc.c |  18 ++
>  target/riscv/vector_helper.c            | 228 ++++++++++++++++++++++++
>  4 files changed, 311 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

