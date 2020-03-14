Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554CFC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22EE62074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 07:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBeDYo0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EE62074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD1Ls-0007me-CS
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 03:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1KE-0005Tn-RG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD1KD-00036F-8q
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:14 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35018)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD1KD-000341-1v
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 03:35:13 -0400
Received: by mail-pj1-x1044.google.com with SMTP id mq3so5566830pjb.0
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5d8VkS4eh1KZi+aDGZL6CCq5Tshn3BSLrfHk0kCZtGM=;
 b=VBeDYo0cjG4WvDYhzrLiR4QPHAkS/R2UavCde72N9+nVs9VrSbtyxMlxD2s7VE7vAm
 iYxMLSGrz2VYqqV98RBGc90LarFk4VjgeYlQL876DploH1ux1CP1Sb0VkDKgwFzt4XMZ
 H0CmJVSlBQIsEAotPBvWwvgI2xW9SJw0js1Iav7cnj8WmCx/5RE7DGlsHM6COGXyN0LV
 Pebevavae2nDoWi7eLKw0CmKFTSdsU6cTBYJdOvoJ3pe+ygyA/Mc5/hyWMMA8DtVGcaV
 S5n3mxLti1AwLoLn3tPpdztDBLzU+qm7SUV6SHMyeuKp8QydRoHDiIhB+6XpaHfdrgpN
 2VfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5d8VkS4eh1KZi+aDGZL6CCq5Tshn3BSLrfHk0kCZtGM=;
 b=QFL+SBJFrUZ87rOjAsxl53eMwF706xJyroVXodzGJaYmtt51aTeRibEN4FWvLp7oDa
 GFORAsv6Jsc/6nkJZqABn0TxzL2uB6/fAnAW0XeYp3zebGQ7ztDcbBi+v5Q/PjFdvIqI
 +LiE7Sgou90tk9hf84CYK7Qh0nkh7A+ad6QaP4brrn0hVqz5M+LumLUjZhCo9S0dZdsC
 UyVWpgIkjJGJ5IrDg0R9+o8bsQ+Kt+R0ZQrducKMOxkbX5iMfNVSAHnW++H4u49ghGuI
 kE1O4CNc5B3piy7db+S4abukIVicOrrqK2kKkH9Z8EFU+5KoFaEiYfb0a/5Uzsfza5wK
 OmRg==
X-Gm-Message-State: ANhLgQ2SbGSy7w145OInM0yDqyAsFDAxhMGVx16D6Haj6cn7uABN8x5r
 aJH+sPTvE4ak5RIzRaAAGr79+w==
X-Google-Smtp-Source: ADFU+vuuvC69TfCVCDJxRTiitMET2Oq5ZPonL3OeZO+Salub/yc9e9LJabu2YtzbFoWLB148zmbJ3Q==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
 ay10mr17215854plb.288.1584171312172; 
 Sat, 14 Mar 2020 00:35:12 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 ck11sm596568pjb.32.2020.03.14.00.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 00:35:11 -0700 (PDT)
Subject: Re: [PATCH v5 21/60] target/riscv: vector widening integer
 multiply-add instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-22-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a150d6f5-32c8-45f8-c4d8-38f9ca5ccc7b@linaro.org>
Date: Sat, 14 Mar 2020 00:13:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-22-zhiwei_liu@c-sky.com>
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
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   | 22 ++++++++++++
>  target/riscv/insn32.decode              |  7 ++++
>  target/riscv/insn_trans/trans_rvv.inc.c |  9 +++++
>  target/riscv/vector_helper.c            | 45 +++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

