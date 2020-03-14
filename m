Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E27AC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF170221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgZ6GwCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF170221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDGWb-0002LA-54
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGVx-0001qn-4G
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDGVw-0004l3-3n
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:48:20 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDGVv-0004jc-TC
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:48:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id c19so7559893pfo.13
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 16:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0bhJ+T1R7B4Okb7PxIdIqUuwnWvw9/yCUolBWmPYlg0=;
 b=zgZ6GwCDfiBfgkS1qfkdsnOJqQdJd8wLzspaNbNpdHkrPPcvTUdVrUq6FGfd5ZQ5VE
 BZSSHRBQiLtDbNvSeeE72VEOs4yWo6owQSfvqDX+gMMcE84dSM4GB1OFzwT0ofACT4CI
 DSibdf9rpZe2Kb2iA//iMTx8NPJ5GKRGraDyrVQqoIWpq5Giw2Fj+dWx0IYRNfrBbU4y
 ScBwUobJRiaxyzIlIq1mUyASbjqSY9EnVQ6+96jhZhYz1Kh7v//zFsLoQ96EkvBY0wTd
 VJUKVQoRxZgEU292XMZU4PXuUUNU3d9zUkEZ2riNFeZfqGiOy1YyWDna2nKhyOfKtO6k
 PdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0bhJ+T1R7B4Okb7PxIdIqUuwnWvw9/yCUolBWmPYlg0=;
 b=mBQ6zv8X3CPNucRjsLtPn3WgX+NtlUDTq8nLG4STUkxGnOjut7A70mHqj7bqH+O9gB
 +gP5EvywNKl1ADqX4uyz0WFwR1XPikAz1WHqQ74mJSc4IzaSScIY6Bu7OJiaXybPQOdl
 fKthR42a2tm4s1r+t8yM5bOhBOAnlM0zr66Yuizet2e+fMGf8qX3l/ZmjsR1JDQZfpbG
 D7OC1aRWu/ShQxIJJlfc7Q/nYg13McuTUm2KIMm47/Lsln7Xd0gGUJPw65n5tS6Ywn6V
 YbmdSy+Mi5SoChU43Rref5JfirE9zkLQFaN+nfoge1t1baTPjAr3BmxT5f/sA8PiM84g
 9Qlw==
X-Gm-Message-State: ANhLgQ1DGpTc8eY9IqNf3IWiItGrBa7yn8aY5DbifRKFOkOM5AF0Fpho
 C9HZw/9muC8rvYN/yobNELnY5w==
X-Google-Smtp-Source: ADFU+vupd68odTcVE93f/5NzUyjLTRRKFFf9QNwY/tZDnemCmB0fB6cx7G/ENimJbfqAMquPLN9D/Q==
X-Received: by 2002:a62:3854:: with SMTP id f81mr21301548pfa.81.1584229698524; 
 Sat, 14 Mar 2020 16:48:18 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 19sm40712236pfn.30.2020.03.14.16.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 16:48:17 -0700 (PDT)
Subject: Re: [PATCH v5 46/60] target/riscv: vector single-width floating-point
 reduction instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-47-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4bb9d254-7b07-c195-761b-de9319165eb1@linaro.org>
Date: Sat, 14 Mar 2020 16:48:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-47-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
>  target/riscv/helper.h                   | 10 +++++++
>  target/riscv/insn32.decode              |  4 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  5 ++++
>  target/riscv/vector_helper.c            | 39 +++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


