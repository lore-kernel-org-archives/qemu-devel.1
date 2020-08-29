Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4A6C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AD72076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 23:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHpTly3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AD72076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCAkz-0000LF-Ta
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 19:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAkM-0007tU-Mk
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:58:58 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:39403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCAkK-0004d6-Kb
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 19:58:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id s2so1188980pjr.4
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 16:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xsdODiKgw95BGy1mGMkJONcMGeL67qC+UaoQTuUIqaM=;
 b=BHpTly3reQx3N2INcAdjyyJIS651l1pZ1ue/Y8w9XIoD9lpJaRjYK4k04vZVv/V2qZ
 Tmj9qVWAnPb4++LruYhbV9ZiaunvGfvU3ThbvPLOqU+1KI5xi1eAc6W96l7vq3D4L3Bv
 Oi4y3a21rJLGnxQME+Di8OCK4c1go4fEfbmfr3EMmQeL5QaZia56Ofb4VQPyM1JcHpZa
 g7t+jxTLIS6/hF7mwda53L4tQC01n4CTNb7F0cSPoVsakCmnoWhumCWWx2anhfpRL9eG
 lbfTrf7a660+V6ttlRBCysT333b7dUy8Xeytj7hydgNbFXVJqQtyv/qmeNL6nUOOzBJF
 E2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xsdODiKgw95BGy1mGMkJONcMGeL67qC+UaoQTuUIqaM=;
 b=VHooyi+5eE+uNE2yBjySI+CJi4ecn7O2327IUeYtsqQyHiMC3T/gYGoJS7f5/rL+nO
 fMNMwxRj5ZSiX8wxeiKLmH059IT5VFQUuiJS3YhpIMzcPwbXlVV5MUfDI8hglMG/gcYs
 Um4bdxRS6mFgkhL8q8q7QznWM9tyBc1m2nncnK4vM37dMXzZE2v/lAAdCa6CyT9Z0TmZ
 +53uGgSuETazzWYLceDb46M69WGDEtwauh/52ytvke1XSaa2QaKuC+Gaou8Ms7RuaJxg
 4CTI07xCVaI7wOyA98n/l6qjKux7edcMYDiok8JVkqKVcri+iBSwxtrAyiEvr4qf3Jaj
 Frfw==
X-Gm-Message-State: AOAM530k5m2JGJoDwW9UZb3+/r75U3mbhXTZv9vVpfp9QUxuHNcxarXf
 190R21UKJcavG1VzSvGsBgf7tg==
X-Google-Smtp-Source: ABdhPJxRJZ60gnTQYqclbBafVSF1EkwxDuP6D2CZFnZ/p9zUV0V0ZoocvUbsFtaAtWtrOr2oXR56Cg==
X-Received: by 2002:a17:90a:ab91:: with SMTP id
 n17mr4695301pjq.84.1598745535453; 
 Sat, 29 Aug 2020 16:58:55 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k88sm3077169pjk.19.2020.08.29.16.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 16:58:54 -0700 (PDT)
Subject: Re: [RFC v4 61/70] target/riscv: rvv-1.0: floating-point min/max
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-62-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63211f47-f5bf-c9fc-00ed-1e351e6cfc56@linaro.org>
Date: Sat, 29 Aug 2020 16:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-62-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


