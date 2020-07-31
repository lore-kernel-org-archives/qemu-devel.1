Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA038C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C60022B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KpMNnTIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C60022B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Yh2-0005Pj-LN
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YgF-0004vm-CE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:18:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:46612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YgD-0006XR-KX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:18:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id k13so9935741plk.13
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BgSLifIsjwZZcBuz8dVhcHgyO9B5S7lmDSsidn38h6Y=;
 b=KpMNnTIRFC4VQ2jgDOJFa1CyIRKpm9+gPvfFlNy8hyNb7XIovyDF1ji7gl2z4hyhWb
 lXH1dysmAFK35JLe17cHnimsH9+xuFR+oa3X2ACPMqXqRsZeIovMHICUAR6tzKKZzv8I
 3dEU7zYVTLN9OhnI7rW7RZxJu5e+f9lcdVMEP2YkVKLZqeDbKqki0oM1hrZ7korE73U4
 mQF2INr2sb2aKNjtceQ91UYO7geJQwWgG24BnrHKWfWot0i0sszZIkUqc64QZi/ZXaqd
 9V+AwR6tHKdupsZ2hbBRPydJ9Lz6e0W9wy2M3ZytU/DVJBZno2P9jJ20ArEsDpOmE474
 WLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BgSLifIsjwZZcBuz8dVhcHgyO9B5S7lmDSsidn38h6Y=;
 b=RqZosMLIewvbVa/5n/xzuubMLwmdlSuHHp+yMvjjFDPxzSjC8DonAX1O/CgwEKkzie
 I/cu8icu16TPtnNc6d1dAv9crUFytnstAuDl9kwlN1uBgYT+kXEPQjhHCGBSjNsi6DoY
 IXDYYpY6eHmPcv+XHJDkZp9WqaWk/kcZ6MqeALo/S997JTm0AYSpnR80m1Tp8w47LiW2
 cKj8xMWXqm/E41ZFQ9iZJkJkewVdMtCRzqAcyOqHEVpwv3FaREGkjRIGjT56s71J1Yuy
 qu5ScPOikEPyFWjwQdZ8ky7ctgaU3qzhI0+3ur5N9x8YTql5D44tEsnvc8XiTjHDtfH7
 XfIw==
X-Gm-Message-State: AOAM530+lVD6K+qQBAkAVQgkUny6A4Afd5YVN9ZbvTMHuqz5JVs4+wa5
 gFtZixVs+1kVFRPXd3d+XrauLg==
X-Google-Smtp-Source: ABdhPJwuIsKPhtUV0SIwRy9VJcxrg7vrwbPYr85Go0EQT2KeWOu3GhXKx3LreRTrjDPbARkfsVmXOA==
X-Received: by 2002:a17:90a:8a90:: with SMTP id
 x16mr4977780pjn.89.1596215928071; 
 Fri, 31 Jul 2020 10:18:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i68sm10140796pgd.32.2020.07.31.10.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:18:47 -0700 (PDT)
Subject: Re: [RFC v2 72/76] target/riscv: rvv-0.9: narrowing
 floating-point/integer type-convert
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-73-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <adbe61bf-45b4-825b-5b27-b9a834493cd1@linaro.org>
Date: Fri, 31 Jul 2020 10:18:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-73-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> +DEF_HELPER_5(vfncvt_rod_f_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rod_f_f_w_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_b, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_xu_f_w_w, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_b, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_h, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_5(vfncvt_rtz_x_f_w_w, void, ptr, ptr, ptr, env, i32)

Again, no rtz helpers.

As for rod... I think you'll want a new helper akin to
helper_set_rounding_mode() that sets float_round_to_odd.  We don't want to
change helper_set_rounding_mode because that's responsible for SIGILL, and this
should be an interface private to translation.

You'd probably want to add a private value for to be used only within
translate.c and insn_trans/*, so that gen_set_rm() can remember the odd setting
as with all of the others.  E.g.

#define QEMU_FRM_ODD 8


r~

