Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9860E2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEDzPWEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9860E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwtx-0005X1-RM
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwtO-00052v-Ia
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:32:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:50451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwtM-0007TS-CY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:32:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id k71so2911202pje.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dpERKSrC5Ld7XZhm4Ee4haRxev/yowN/xBhmr4Zedbw=;
 b=CEDzPWEqlTihIuLGj+mtikQDygj6cygYUqqfor8lnA86/3O8aWGJKq7S+/cMUH6yrt
 dsa+k0R6GYtfPTDCWBLq/KUwMZ7Qgp0f82Qa/bViYRvhGqpoKnypnLD2DhXzvgCrf9L5
 l72nN+14uZK+KrNDcCg2GsAwV+K/1ePnO14L3hZcdqlFK8gS5/I8uae+6EWfjsGbX3jb
 t4rBfik0GD/TuqOCeH1P5Mxp17ClY1Ckqp5ZS2PmohJRuaU/2l7PqTrW90moMls9j7tW
 mG3GNQQ5bwTtEcPeC96M2KCgNWBOVj2HogfNas+Ati53mTCMUgO7UYEL0Do1E/TPEJ+v
 J7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dpERKSrC5Ld7XZhm4Ee4haRxev/yowN/xBhmr4Zedbw=;
 b=X8chgpepSYeuGqcczIzqMcnP3Io/qUtuAJ7vmMEVIBVbZUMESXLbEPd6ECtibuZGLb
 yff+xbbUE00Vd5ZasG53RVATiUOq4mGZZgAQ98blhgdII6gdozl6swi1ND6lCgbc0GlS
 tEC3MIl6E5LJx/Ua1b+RwfX0D/5XsMyzk9JxhllrD3Gerow5lYqjqUrlqpmSHp4Ll+oz
 GjlOJPWG1FoEvOHQN9MUGszXKhkWMj/fdtsA/hljpeouiTklTA+jYuuh5wlzrOAzE57u
 EKpxx2UjRiL+WGwAv/Z0WP5WnMxY3ND8m+H0tNdsK3RITbAv7FkVB306inFKZVdF1rF6
 JuKg==
X-Gm-Message-State: AOAM532diuWCZbE2Eu+bKg4yS2FTf0zftkJqubLj8iyL1IJiAzvrTMNz
 qB1DjuMmhkoW4xsUQ3rpG39Q6g==
X-Google-Smtp-Source: ABdhPJyjCaQ613F2vRafFSFDb27kfTi5y4JYMtVDvbz2R2irYGhkBMneRXklfx/ZSWkxg9z7bKKNKw==
X-Received: by 2002:a17:90a:de94:: with SMTP id
 n20mr6974563pjv.125.1594402374907; 
 Fri, 10 Jul 2020 10:32:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 144sm6687449pfb.31.2020.07.10.10.32.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:32:54 -0700 (PDT)
Subject: Re: [RFC 10/65] target/riscv: rvv-0.9: remove MLEN calculations
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-11-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78689d02-8def-262b-5e62-316faf8dad1b@linaro.org>
Date: Fri, 10 Jul 2020 10:32:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-11-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> As in RVV 0.9 design, MLEN is hardcoded with value 1 (Section 4.5).
> Thus, remove all MLEN related calculations.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c |  44 +----
>  target/riscv/internals.h                |   9 +-
>  target/riscv/translate.c                |   2 -
>  target/riscv/vector_helper.c            | 252 ++++++++++--------------
>  4 files changed, 116 insertions(+), 191 deletions(-)

You can't do this until you remove 0.7.1 support.


r~

