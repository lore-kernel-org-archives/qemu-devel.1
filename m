Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62173C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9E82171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ow9w8Mds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9E82171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvmfU-00089G-Ko
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 13:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmey-0007dL-Lf
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvmex-0006pY-Q6
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:57:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvmex-0006oo-Jr
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 13:57:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id y15so44536185pfn.5
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jvCeSkCzmSCCppv30RCxwrup3ZK4y8htfnGE/hCcbH0=;
 b=ow9w8MdsTGwlly57Y4YzVI0gTejLDQuBUSX4EA1Vg0EWDcUlkskXZsYtAAWYDGQJAo
 dEGGs8+2jMwjvsfOVVKnZPaRBsKHG5RLSX5UuW7HW0195ui5AiTqdhwfxB8Es+GUHzDb
 EClC7HHo9ZW4pb3Uo22nIMD86I4WbPubfQcPr1ym0pOnJZr9mM39rAr56m6/m/9l+HV+
 os3VaiXLv+18zXSDweDv4x0dIr7I6Q3t5lOQJALh2CVQ48xFQa3GAEoBk6y0wvmILypu
 m4TmeHR0Rp84qSC7JDs72qf/DakqZj/VbU2cfb3iWq2Ms2toII+F/C4fQGykZ/0QGNOQ
 HL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jvCeSkCzmSCCppv30RCxwrup3ZK4y8htfnGE/hCcbH0=;
 b=UoqJqJT68Fh9JskNH9D6EV+n7/gG5XiDJM5yeWvGg27+o5pNvnQZajLVqDqQrYsIMd
 x8ESBRc3cFwM42gELTIEng+yQ4J67lnL5WEntj7AbA/e2xXYpwswtqGVgnlBqnkoaCSE
 c6+C5OBYCyXQCWD6a/5meZPL+TTAF+Pp4Qg5NkeYebsvT3BS9M/AA2hJbL4mTgsWQH7m
 dCQAH4qMbaAcx0Ol50hHe8qn3GpkttuO1OglGG2O2S2DfqG0Dotvw/e08n++VorrQI58
 vl7cjwXCGdMh6mBfxiGg5zn/yYCG6WyVkTU6ONzONAtrDl1HSIkVOtlrTWDAsY/bwdph
 Jwmg==
X-Gm-Message-State: APjAAAW6Bd9VHm8qDBiyhy0KSOaaACrIdxLbVXpp314tSeg473qKLWMc
 VETrLnHM/eBFEoVBR/MrIrdI6w==
X-Google-Smtp-Source: APXvYqxDm/t4xx9DyCTDlW5PdjtW+l2iGs9329brp+KXKQlybeRWdVcDkpn6nvIN6J0TjwOrG59OBA==
X-Received: by 2002:a62:2582:: with SMTP id l124mr16691352pfl.43.1565287026577; 
 Thu, 08 Aug 2019 10:57:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a3sm97157021pfc.70.2019.08.08.10.57.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 10:57:05 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190808164117.23348-1-alex.bennee@linaro.org>
 <20190808164117.23348-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <84c3374c-a309-6998-c61a-7c65b7c09d20@linaro.org>
Date: Thu, 8 Aug 2019 10:57:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808164117.23348-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 6/7] target/riscv: rationalise softfloat
 includes
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, armbru@redhat.com,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 9:41 AM, Alex Bennée wrote:
> We should avoid including the whole of softfloat headers in cpu.h and
> explicitly include it only where we will be calling softfloat
> functions. We can use the -types.h and -helpers.h in cpu.h for the few
> bits that are global.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/riscv/cpu.c        | 1 +
>  target/riscv/cpu.h        | 2 +-
>  target/riscv/fpu_helper.c | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


