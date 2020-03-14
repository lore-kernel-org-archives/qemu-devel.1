Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB74C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6022074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzymaQ5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6022074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2Xw-0003NU-L4
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2XH-0002rx-Uo
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2XH-0003BZ-00
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:52:47 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54293)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2XG-000399-QF
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:52:46 -0400
Received: by mail-pj1-x1044.google.com with SMTP id np16so5374646pjb.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1RrH7SDMq9KXt1P4EbvBElN6M4GMgD5LFTmQs1S8rGo=;
 b=mzymaQ5WbZAtr+pHWIzQz9BiRtC9quTdow97fRSebMBbtixkYRq8wpY5IzHJH6Ei2F
 DByxDfUjpCAg51IxkPoZq0VT8u9SQ+Hg+a16ZXUmIUJDu63XVsfK4c+7IAsw1MSvadyK
 awJma5yudAT/PHNJUnrmphbKEXK1gBUWUpOt4ZFvtJUqDEgi11FF3gcKGeQn/Z+buCmY
 YMl4HwLXW6PeR4qf5FWVRerj2IUIP0hWmm2MyWx9far/0hcW5xmBT09klPsohNwNLEb/
 n3yQFSB7PRnhAaC+TdE4E76IX9bV8Xbyn8v4gCR5f1dC8Eb1M/5vWJ282dpobSXthE3d
 G1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1RrH7SDMq9KXt1P4EbvBElN6M4GMgD5LFTmQs1S8rGo=;
 b=Pi9R6npxOactSyx1f6UvxKcPV9X3OBj/27FzAwc6fLvebDzeIJndf4ntj49whOt2RR
 slhPkxlc6zyoRqr2MHy+RQHSm11uosjY/dyFDTpE/t9IU9p8mCEvS/LLN93h+vVFkqlS
 POP+FD6WPpuGLBIO0WYfMt4+j1d8R/M3OUGTr4WnLDY6Eq7zDWiEjnB5hoDDX2x4oTPV
 nivuFH8Pl8Wtqw3+rlcRCH+k/RBToo9T2PWcvhiPqvCjaorw6GfB/IwT6qm3ZTWwsOgB
 x8DnLubiWWBoPxxvLvkmZwoF5+3M/K4jutNsAfMG930DuiNpNqv1L5hN7wZzG6SAUpEm
 +pHQ==
X-Gm-Message-State: ANhLgQ1ogxVRWnbO3ND9uJmY4HLdQwaV0E+3efvwdbSxLJ/38nSnFMx5
 CWpBJtBMuQXSGAlL7Q89TYJQwA==
X-Google-Smtp-Source: ADFU+vuFZc0nCzUxRz0qPxEds3oPgBtAgLUp1kmRqldYih5cyASia8mklBHVqAg/RDFfiMDibqMLww==
X-Received: by 2002:a17:90b:3793:: with SMTP id
 mz19mr14569777pjb.194.1584175965642; 
 Sat, 14 Mar 2020 01:52:45 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e3sm27632352pgm.15.2020.03.14.01.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 01:52:44 -0700 (PDT)
Subject: Re: [PATCH v5 36/60] target/riscv: vector floating-point min/max
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-37-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03092865-9bbb-a7d6-31dc-b9df24f4688c@linaro.org>
Date: Sat, 14 Mar 2020 01:52:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-37-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
> +RVVCALL(OPFVV2, vfmax_vv_h, OP_UUU_H, H2, H2, H2, float16_max)
> +RVVCALL(OPFVV2, vfmax_vv_w, OP_UUU_W, H4, H4, H4, float32_max)
> +RVVCALL(OPFVV2, vfmax_vv_d, OP_UUU_D, H8, H8, H8, float64_max)
> +GEN_VEXT_VV_ENV(vfmax_vv_h, 2, 2, clearh)
> +GEN_VEXT_VV_ENV(vfmax_vv_w, 4, 4, clearl)
> +GEN_VEXT_VV_ENV(vfmax_vv_d, 8, 8, clearq)
> +RVVCALL(OPFVF2, vfmax_vf_h, OP_UUU_H, H2, H2, float16_max)
> +RVVCALL(OPFVF2, vfmax_vf_w, OP_UUU_W, H4, H4, float32_max)
> +RVVCALL(OPFVF2, vfmax_vf_d, OP_UUU_D, H8, H8, float64_max)

maxnum.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

