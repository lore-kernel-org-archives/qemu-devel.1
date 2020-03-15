Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB7C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 03:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEC020716
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 03:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXSJSm9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEC020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDKN8-0000Ku-K1
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 23:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDKLz-00088J-Uu
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 23:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDKLy-0000jp-Hz
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 23:54:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDKLy-0000dr-AT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 23:54:18 -0400
Received: by mail-pl1-x643.google.com with SMTP id a23so6245266plm.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 20:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ui3Lo/LuSx3DTr/rn3Sq3dRraUq/YXECRClwT6l0PdI=;
 b=xXSJSm9LApPhdUHbGxVMf8oZjQpcRWAavkuvL5RkO+IFDuChLrM/HPb37qOZjTDTcH
 gpKJ62LCJL2EIZa8Pb7jJS9ePExyRKQzxe1vqX1tU6+GgbJ8RA2UFVSVT9PZ0JbbWcXx
 JWbmxH18/615bhRX2c6AHegXLfVdv+OBJeGjykF35z06nOi5RrGsba/t3+o3JqpphIDp
 TkTjwPurC3CxassSLur0xgfnHojHEk0YjVJbhvwwKDqbrG0tArandnbG7j1vfAfLBGYq
 +rnew+sClyWV5iwbfNCOicfzkEstLczHo5IW8Jd/nPy4nwNa/JJ6gUkPX6IzHt9xMpeu
 2Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ui3Lo/LuSx3DTr/rn3Sq3dRraUq/YXECRClwT6l0PdI=;
 b=Nk+9mCGp/J6qtxj+/NDWix9vSuWl6Rh3lCGrOPePGQMKAy4oqFl5ciymKhH8LxMmjo
 luKFBxMZ04wqQqgsexaJCeDFy4nUhLoAe21qeJfBIrEWmRW448DoTcKFMCORWNuaoafO
 YD4hxMejqfuyhYjA91XXeYl1+g0hFYQIB6vz6+Mdvcre4OMwDIwyYBiaU5gXDRgMMIBd
 CVwuPa8HswXF8xppmyhD3FKtkWYQCQTIpGY/wDY23fUYSgOXai0YWLjQvWEFcbI83Kth
 jz+pDk+KX0K4YyDuBonU/VHCcLw3n2osJSHAzD42GYI490G12UlRnILkEIp1T+325oYF
 7zQw==
X-Gm-Message-State: ANhLgQ1eXI/uWYyPh0cy/m6YNvebn1Fw/V8kVpwm/BjnwtH/zhq+avME
 jzQBc4qfBAuMFvQQSTOCpuZ1EQ==
X-Google-Smtp-Source: ADFU+vtbIiuaKzZxFaQJwla5r2hPdYkptI3xA3ztRX6g3/g4/1IumZIby1S51bhEp9GnlhJ2BcP4bg==
X-Received: by 2002:a17:90b:1889:: with SMTP id
 mn9mr17514795pjb.85.1584244455641; 
 Sat, 14 Mar 2020 20:54:15 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r10sm56769986pgv.25.2020.03.14.20.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 20:54:15 -0700 (PDT)
Subject: Re: [PATCH v5 55/60] target/riscv: integer scalar move instruction
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-56-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <183a0b1a-8889-988c-6f75-db23acdd4123@linaro.org>
Date: Sat, 14 Mar 2020 20:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-56-zhiwei_liu@c-sky.com>
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
>  target/riscv/helper.h                   |  5 +++++
>  target/riscv/insn32.decode              |  1 +
>  target/riscv/insn_trans/trans_rvv.inc.c | 26 +++++++++++++++++++++++++
>  target/riscv/vector_helper.c            | 15 ++++++++++++++
>  4 files changed, 47 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

What an annoying difference here between 0.7.1 and 0.8.
With 0.8, we can inline this operation as for vmv.x.s.


r~


