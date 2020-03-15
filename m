Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B50C10F29
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87187205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 23:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxNeug0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87187205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDcnn-0006p6-9b
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 19:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcfS-0005ZW-6x
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDcfR-0002EN-37
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:27:38 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDcfQ-0002Ar-RG
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:27:37 -0400
Received: by mail-pg1-x541.google.com with SMTP id 37so8614358pgm.11
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7kzRqUlLpkGjDOydIsoDKwsazMahQVbzT0T2HoBLlxQ=;
 b=IxNeug0L1ffIqU2BO8WEllFNhMJbqy54y+4HisD1mrqZu7ZvnG7H97sfceyU1W2F5U
 UsNSfc2aUJYuXLel+Ph8PjasFV8F1y1HrwepQKGK2wIhaAgiLJ10r4QdxNNpllFnq5d6
 I/u+YGy+XhD0Ukr39LYwhuWFez8OnKvrosW8kkZ8iXHwXch5XDMVbBjZ88opAZhJoOpN
 Rl/W9f/u9/k0A3Q6JHgmNe+0S5wSRLKF3SdW9pi4FaUZhrHYogAQPIqO/NFxj1EClQ26
 0Z7X5siiM+CZdcODlC+NDOYc23Aqz8rkHD0PM43QzYkscRCVg2zi+ykQlvFOg+ArPN/y
 rnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7kzRqUlLpkGjDOydIsoDKwsazMahQVbzT0T2HoBLlxQ=;
 b=TrLTMOXn0InpsU0Rt7IeRRd3GLMPAt1Q0tZyZ5Quf1FDOESAVTg0Jb2gRAGOk78Ydh
 +r8p+0XbAss+g7qDIJErwmtZJJVwRz6GTHTGwSuXObfnMc4lVjGlLhoCfWvo+WgkoQbR
 0WQCm88GC5bHkRMknDRNwKryvpI4R9urs07JmjwGVu9VUpfm+argbSGL2pjvWojEEcJA
 +ThHbOope9qoZ3ZSARHR1POIYKEcQ1mQGLkLQVDocCRJV4NzHsdNsLn6U1M3HL7cOGAj
 tqfTzNnnQKrz0uGmJFR3XlHLPlj3dPQjIjaBkPe7PSz1SznWSRkybq80SzF1KZM7NOhS
 j4DQ==
X-Gm-Message-State: ANhLgQ2zCedCA6RkPem73s0aVsvHCob1KElpoXwaPlTN/F2Z7OZ0Gt0y
 tHKBX+7FduSNtc/QBgvaMIGBKg==
X-Google-Smtp-Source: ADFU+vuExsYpZ3cHVZw6YERRgXKeYQAvx9SsZxCJrBulDM9ZhXR+zJhpimV6dFUbkprPjUGzfsDsIg==
X-Received: by 2002:aa7:9790:: with SMTP id o16mr23754567pfp.322.1584314855272; 
 Sun, 15 Mar 2020 16:27:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c11sm14574147pfc.216.2020.03.15.16.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 16:27:34 -0700 (PDT)
Subject: Re: [PATCH v5 24/60] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-25-zhiwei_liu@c-sky.com>
 <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
 <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
 <d48f77ee-ad99-26fa-a597-6cdcd2d55508@c-sky.com>
 <426e31f8-1b54-7b5a-b2a9-a2742f9c74af@linaro.org>
 <e40db19f-0bf6-9ccd-3f41-855f67cf88f2@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af9227f2-eba9-eb27-d409-c95556b046e7@linaro.org>
Date: Sun, 15 Mar 2020 16:27:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e40db19f-0bf6-9ccd-3f41-855f67cf88f2@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 3/15/20 4:23 PM, LIU Zhiwei wrote:
> Many other fixed point instructions also need vxsat besides vxsrm.

Ah yes.

> In that cases, can I just define OPIVV2_RM like this:
> 
> #define OPIVV2_RM(NAME, TD, T1, T2, TX1, TX2, HD, HS1, HS2, OP)     \
> static inline void                                                  \
> do_##NAME(void *vd, void *vs1, void *vs2, int i,                    \
>           CPURISCVState *env, int vxrm)                             \
> {                                                                   \
>     TX1 s1 = *((T1 *)vs1 + HS1(i));                                 \
>     TX2 s2 = *((T2 *)vs2 + HS2(i));                                 \
>     *((TD *)vd + HD(i)) = OP(env, vxrm, s2, s1);                    \
> }
> 
> static inline int32_t aadd32(|__attribute__((unused)) |CPURISCVState *env, 
> 			     int vxrm, int32_t a, int32_t b)

You can drop the unused.  We don't turn on warnings for unused arguments, as we
have a *lot* of them for exactly this reason -- keeping a common functional
interface.


> {
>     int64_t res = (int64_t)a + b;
>     uint8_t round = get_round(vxrm, res, 1);
> 
>     return (res >> 1) + round;
> }
> 
> 
> In this way， I can write just one OPIVV2_RM instead of (OPIVV2_RM,
> OPIVV2_RM_ENV, OPIVV2_ENV).

Yes, that's fine.


r~

