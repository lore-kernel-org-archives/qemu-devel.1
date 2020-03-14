Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C54C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D7A206BE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+ibzfaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D7A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD0tC-0002FD-1B
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 03:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0sY-0001oq-3R
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD0sT-00064d-16
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:06:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD0sS-00062l-RP
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:06:32 -0400
Received: by mail-pl1-x643.google.com with SMTP id t3so5368525plz.9
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 00:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BzuCF4Yxzja95U69C7q76xUL4I543r4Qz/8+UWv4WPI=;
 b=H+ibzfaQsvu7V+sFLOxaZ6ddSqh9HKtzyJXKDwXMfuMsNkyZKzIF9ew64f+aYOTCIP
 20AAuwCttIHySF7b6vFuOpMTOIkz8TcVgB9kMqjNloji2j43pBEsVNGdV+mYOQT4ZRNU
 lMqlRBGOEJzd4ZHLZGCSyHipfmEXTLpy3Qy2ygi3J0m3pUy6bzHD0YvLbBibfF9sdVqX
 aFXlqhs2RnObCoD+QvKyU9LW9WuznTFsue80re5E9xmVrEvUIjMjZop7bd+4yER7pSil
 Pjp0XrIonDaEwPlWmJErK5gdL2hytw3eaEzdaD5RKp4CIBcS5t+n/aTdKB17T+6BWe6J
 UU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BzuCF4Yxzja95U69C7q76xUL4I543r4Qz/8+UWv4WPI=;
 b=HdcUo9pYoZTWhgCADOBMxTBbtihIJw/iagDY98oEcsfG343CaAm17wLOhEz62/4J4L
 CGDRScG18mWlgwwEnUOWZgwxa9EzrD1os3iS77AgNWZ3sz4fMWaSGZDMTK2zdujv6Cpp
 VOv58TGXuL5lLwoD6ysHY7SEWLidpJaUZI/CUsMx4dEMiVEusc4GX01YEKipgqwp/FFY
 ciehYyy1q1RjcE3/5GZqq5GlnFnEqR8vJHCHKhv/DE4CL4Scb0Jr5nGTg1XnfRGfPrjy
 h6AD5MrJE2lX2fSNre/xSDeTAHY103oIGjt5MesZVqOnd0lc3k9F+llqxi8HCOfPEkQy
 M6oQ==
X-Gm-Message-State: ANhLgQ1i2fMnClzGoI9vK6rAM0gUjNQQSulAAb4ZGjzAemgqpzoIcFdU
 8wt2gRWeVW1Vnk+2mRtXspBqLg==
X-Google-Smtp-Source: ADFU+vvZ6+PITyG0rsXfSfDBgy/GIULg1TD5HxcfoX1NvzqL4WNUQSBziLBNbIr1wcTOB33kUo+Mqw==
X-Received: by 2002:a17:90a:3acc:: with SMTP id
 b70mr12833632pjc.179.1584169590126; 
 Sat, 14 Mar 2020 00:06:30 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i11sm9379502pfd.202.2020.03.14.00.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 00:06:29 -0700 (PDT)
Subject: Re: [PATCH v5 19/60] target/riscv: vector widening integer multiply
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-20-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93f59ade-8022-ebfd-cc0e-7540b97acae8@linaro.org>
Date: Sat, 14 Mar 2020 00:06:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-20-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
>  target/riscv/helper.h                   | 19 +++++++++
>  target/riscv/insn32.decode              |  6 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  8 ++++
>  target/riscv/vector_helper.c            | 51 +++++++++++++++++++++++++
>  4 files changed, 84 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

