Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B3122203
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 23:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1xuSydV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B3122203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTZUU-0007aI-DL
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 19:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZTR-0006gG-M5
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:49:25 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTZTQ-0007lr-3G
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 19:49:25 -0400
Received: by mail-pf1-x444.google.com with SMTP id x13so2369231pfa.9
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ve3PdkzHk4n5IOoMJJoojGyBFL6xlq+mocWgSsAMnlE=;
 b=t1xuSydVaKl9uk78Fp87cEsMP8g2eK7MDl8MDZqA5FI7neOvoRUvmhblYC7NWHuALN
 5j/uW+gg/Cykb9QZwmnw+7UFa7XQ9Q8PECUg23y1p9rmgCbnHal3KSXD3AebIJUUvFTx
 Zsrvy1QD3JkOZZwdLNWZl6kdDJmV24/MU66bSq+drL5vEQRbsbh+QyEAQJ57ra69WUi4
 BpfyzSmHyq4cqbk6jlROpyHuTYs9telzYOtX/1Mh0zl6ErZQrxYSn6rJ1nklOEviaBKi
 dhQBlegcoqrMAQc8OrZR41fVvxwnEUwx3/dqoZn0mK1mNcZUb56Ea7/PxwYOvgw7Rs0w
 L8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ve3PdkzHk4n5IOoMJJoojGyBFL6xlq+mocWgSsAMnlE=;
 b=XdlzJprCma8U1ik75tx9V4N6FCqxCT5DOjs72roDg34fjDaIF4T7x7xNs2x/lIV9z+
 mFjjTxZopZbxr3kB36jk2dsr+W/wbccepTz7h9PHMpFmnYrOgZ3iF5LplXTVslW5KEYA
 82O4Yk9rsHNTwohhIMQ/91dCYn/w2DOeBaaKBh+n6xY5oeCZLW0q7kH6yZh+OuaWLTu5
 tz/0tbTdVdi0TGv22fwrFX+xyM+hOCbrI1Sb4hh45DslcfF7b9CnZj8DEz/tpszSLRnk
 R1pdZuV7s0Z2/762s/GjxmjIk3mdNfx1zhTJIlbjMKf8yAoJVOhny3nqc2YUstAouuZ+
 jmpg==
X-Gm-Message-State: AOAM5322cA8E1eMME4F95ohnmTKNwLtMIIIX80j0nGebh7Feb7C1CT8v
 n6L1hrc7OOVJeaQnB4UHQHiUUw==
X-Google-Smtp-Source: ABdhPJw25wbNCvg0FmWP85CAEIInKx+8diFx0XY0rkS47+jtZWmgNhkRBiQM5zl3VTh8eIW66lXkOw==
X-Received: by 2002:a62:37c4:0:b029:155:ebd8:304c with SMTP id
 e187-20020a6237c40000b0290155ebd8304cmr6267384pfa.73.1602892162721; 
 Fri, 16 Oct 2020 16:49:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t12sm3925121pgk.32.2020.10.16.16.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 16:49:22 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201016221138.10371-1-space.monkey.delivers@gmail.com>
 <20201016221138.10371-4-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08b76ff3-a2a9-8ed5-a117-4168720a31a9@linaro.org>
Date: Fri, 16 Oct 2020 16:49:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016221138.10371-4-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 space.monkey.delivers@gmail.com, Alistair.Francis@wdc.com,
 kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 3:11 PM, Alexey Baturo wrote:
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/cpu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


