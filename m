Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92A9C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78ACC206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufU+PPzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ACC206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDIR5-0004e8-LD
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 21:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDIQJ-00043A-6k
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDIQH-0000Rg-2c
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:50:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDIQF-0000HN-6q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:50:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id 7so7424622pgr.2
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=c7TqzKtCtZu32NnPv0ecI5mzrIGdYrPWqoYnmLj16MM=;
 b=ufU+PPzNSXRK+HbcJgUUVbzpqAAVhVog4DkZukMoydsInSyYWYmSC7O441KG/3E9w9
 POPHyC5wOHO9F7BuCAhxOGcEchGcIV8jZt3Psdx4wQ+ECvuW8NswEUtzGrb7v5aRSfNi
 B3zbY5yixHiryWpqJid90KWTbfTNriw3fyYOyegZsANzw5gAnBPCw1l3Em9/MmJU2X+Z
 v2CKQI7waM7jITRaN25BlqyD2+GlQUIwr/zid3H6mdgB7n3mr0AmaYEnKllPwNwbe7n2
 OB0Fi7df6Af7RPEVStJJ0gSozuHn6P5L96LJwNg8JUD5xVfnLERRKYIppwGdBvZSnPZN
 CqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c7TqzKtCtZu32NnPv0ecI5mzrIGdYrPWqoYnmLj16MM=;
 b=nzWPlhIl5dzMrhMF2MYJy0+lvil0+lecxkmtkxvRXBGnF7bAEoyuEqX6ld+5QPdeUT
 dpyrsVDWu1bFtvRWCwSiusoHGFQ6C7eX/2Rff8Y2oFIOjqVJ8ijIIto8m+nPhfprJmRY
 tfAfGa72HiImycT0/L2B+sU0ed9mZeKRzZD1OnSO4gzZoBG6qnoqSgQSzuPDHUoX3tyN
 XYsNKYfrq+ineEYk2qpYicWc7O/defN4qVMXnsCjA9QTyvMFc8d7METN7Rrup7r7RKkT
 sfB+qJmcxP9ByG5KU/HGd3ODkNZm1imbPG/5Nvd7gQdMOLlWh/cP2epeQp2WWhaH6EjA
 iAZA==
X-Gm-Message-State: ANhLgQ3y1CYdD9KzrSkLOW6wnMj6vD4JAum49Jatuw2jdkduyvq5p416
 JykaPl8+P//mTI+NOdGJx3V9cA==
X-Google-Smtp-Source: ADFU+vu/vN/Iex0W1R8bQrXZ4+B4oqh1SAcGcHZcQE8kEeOwsr4SyHU5F6+/pXyuN5XLU3ab8Umi6w==
X-Received: by 2002:a63:348b:: with SMTP id
 b133mr20786909pga.372.1584237032410; 
 Sat, 14 Mar 2020 18:50:32 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 79sm6360914pfz.23.2020.03.14.18.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 18:50:31 -0700 (PDT)
Subject: Re: [PATCH v5 52/60] target/riscv: vector iota instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-53-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2ef3062-2800-133c-fa71-7523101beaae@linaro.org>
Date: Sat, 14 Mar 2020 18:50:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-53-zhiwei_liu@c-sky.com>
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

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  5 ++++
>  target/riscv/insn32.decode              |  1 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 22 ++++++++++++++++++
>  target/riscv/vector_helper.c            | 31 +++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


