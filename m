Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59722074B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bg+iObOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59722074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YYk-0002oc-2E
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YY8-0002GP-HH
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:10:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:56248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YY6-0005g5-Vm
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:10:28 -0400
Received: by mail-pj1-x1036.google.com with SMTP id k1so7710321pjt.5
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BaLSTqvrAbbIVKZgB0PMhSdfcixJzZBLbsjsxOPCkKk=;
 b=Bg+iObOtu8KgvEzYel/2I9FBo5q2DM80PcQUKnMNMZgs22w3G0D7xeAXC8oDlxrsxv
 /ufTMpFKeBddjW+Gk7gOqzQcsU4wlrPzkU5hyaGy/D8DA/0Cn4XHo0ZzMEdmo3lMH9wd
 xFM+7o2YkN2QJ9oETYI1JShUyN+4XYI52zIiLOmBLI4KKFbb6orNdhtHLVyFw4q5oNjz
 wbS2KpXj3ghfamD8SE7XTpAlknIWIvJmOYMqtgsiYme8ZSNypnlZu99+PZpaa/SYu2Gz
 lFGPVB0rxCv9zRHxSEDDw8Tp8+B1HhxqBb2+LGHuTH2Aw3EUqN6SZNooTr23WY5NdqvT
 Q2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BaLSTqvrAbbIVKZgB0PMhSdfcixJzZBLbsjsxOPCkKk=;
 b=uUXvOze6tpg+7f+pbOh1p6xwgzwJA+WGCjc9ex5fjNGZvYpWTllyI3GL1Pnf7Dg28S
 xi0RP0e0YlnuHn0I7/vS6McF+32DrOcv2H55aI1zzQPJJ0+WBQrkm7Bxq6YRXxMHaL0c
 7v7RGfpd3pBBWx9DT5M+Mn4jxFhUPsZiUZ4fwCilRnIv5jnARk9DwxUGjASdnvINJ+Gc
 vcPPPx/rmwTAlrwUUAbyj028jmv8RjJh51dyazCSs4NoftIb+SdDHTEe5b9Cj9u0qf88
 qlHpUpzwHa04OwyB1nWnGWI5swd3FJZGJd9S2jxTwesbFdTSih+okEGJuoptbY1ItjYz
 eBBA==
X-Gm-Message-State: AOAM5326IXPLkre8c1PPf7rrMVAWO9y5IB0nezK61HLxyX6xeheGIXzz
 3QuGliEEIMJrr765SgLeefBMgA==
X-Google-Smtp-Source: ABdhPJyPc2PEDOeLTq5M5lA1z7BrBJ76EVxQ9HwonMiWz5UjLYYIXBLw2bHK0AsnGKjVhx5qgefCVg==
X-Received: by 2002:a17:90b:3d7:: with SMTP id
 go23mr4609448pjb.44.1596215425145; 
 Fri, 31 Jul 2020 10:10:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z77sm10865806pfc.199.2020.07.31.10.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:10:24 -0700 (PDT)
Subject: Re: [RFC v2 71/76] target/riscv: rvv-0.9: widening
 floating-point/integer type-convert
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-72-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4b58f990-5fd6-6528-6554-986c4f849463@linaro.org>
Date: Fri, 31 Jul 2020 10:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-72-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/helper.h                   |  6 ++++
>  target/riscv/insn32.decode              | 13 +++++---
>  target/riscv/insn_trans/trans_rvv.inc.c | 43 +++++++++++++++++++++++--
>  target/riscv/vector_helper.c            | 29 ++++++++++++++++-
>  4 files changed, 83 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index d74dbffc21..03330fa332 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -977,12 +977,18 @@ DEF_HELPER_5(vfwcvt_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_x_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_x_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_xu_v_b, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_xu_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_xu_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_f_x_v_b, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_x_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_x_v_w, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_h, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_5(vfwcvt_f_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_xu_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_xu_f_v_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_x_f_v_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfwcvt_rtz_x_f_v_w, void, ptr, ptr, ptr, env, i32)

As before, no rtz helpers.

The rest of it looks ok.


r~

