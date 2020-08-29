Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C3C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D2420774
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcRIO1/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D2420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7DL-0002Yg-P3
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7Cn-00025n-Aa
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:12:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:33618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7Ci-0006q2-6k
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:12:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id u20so2434070pfn.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aMR9+Ug4MmUYHlwmy8IgjDYQBVduO+UIUYA30MHKoqQ=;
 b=HcRIO1/Nk5Dag6u82Fb4ZMbk2qjPSV0L6OHx39bwYPJjycOcMUcG8mIyPITSxp9VrG
 mKRoBtbQDIS7iNB6fyZvXucoLIJ4n+ctYPYlumLqOIKKVRd5/njfWOswebQJ+Ypi7DQc
 vqM759UBgv3Yps8/npfBgqXLrGxdbXkGi806KC1/Kkejdzmb+WLxcENXwn+gYhoGszsc
 e8va/VYglgVpd/4468fUVhoFNXJSzJS3nFLIMFf66mue1YAhgWkrVGHs2zsLXLOOlLm1
 FnBGL5NWx/mTvNbrjmyAmHeUdkqD+Mu9wTuk+Gljq5mEPgldyR5SXmuNIwQRPN19vY9z
 RtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aMR9+Ug4MmUYHlwmy8IgjDYQBVduO+UIUYA30MHKoqQ=;
 b=f2JuFRNqGvEairGXYVVS4R/I9ZY+4EC3JZXKHuxodiW83jT9/JLpE6OQaheebbF8tF
 2mDPeJEyrh7ZofMuuWCTPEJ+rZjJjgDtDrvlomjJi6ISUPDx6+0VzkSHwnLZkFtdO+n6
 0edNJhtXy16XDd/mWo+A2/s3UlAbUPcQvy8Ce/tdDAI5xlxtEHxYL8lSWAAAPLeUQYGl
 KsHknYd8rAHAsHl01BRzzxj8QSE/z5w0WDk3LRhqsdsm6qfAMU/EYz59w52/tBIQSRbl
 bMlNXlz7LFn0bWHu2IGZ9wgAj4PxAPXZCP/CKfpMEwg2wM40CSXfCv64OuMkHQKT3r9S
 B5sQ==
X-Gm-Message-State: AOAM530RPsBaObvh5/Ux1CDtzrWtTrJa21EPq4HL1y4w8IwqqGtD8gmG
 WZUt5H85p5eZrpaQf5YCjXpjhw==
X-Google-Smtp-Source: ABdhPJzV33SGAvd0Jb1oev8+ZxlkJOLEVgfLdNMNX4dst6BxAFB9xJdw5HB7bqXks4TpV4XIZ7HWbg==
X-Received: by 2002:aa7:8ec4:: with SMTP id b4mr4014973pfr.227.1598731918848; 
 Sat, 29 Aug 2020 13:11:58 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o66sm3242040pgo.25.2020.08.29.13.11.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:11:58 -0700 (PDT)
Subject: Re: [RFC v4 40/70] target/riscv: rvv-1.0: single-width averaging add
 and subtract instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-41-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46a22b9d-b27e-f1c3-1d33-89b0d6024e5f@linaro.org>
Date: Sat, 29 Aug 2020 13:11:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-41-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add the following instructions:
> 
> * vaaddu.vv
> * vaaddu.vx
> * vasubu.vv
> * vasubu.vx
> 
> Remove the following instructions:
> 
> * vadd.vi
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   | 16 ++++++
>  target/riscv/insn32.decode              | 13 +++--
>  target/riscv/insn_trans/trans_rvv.inc.c |  5 +-
>  target/riscv/vector_helper.c            | 74 +++++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


