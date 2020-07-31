Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3002C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFEEA2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gs/ZHg37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEEA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YUB-0000td-26
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YTL-0008ST-HS
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:05:31 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:40948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YTJ-0004xz-OF
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:05:31 -0400
Received: by mail-pj1-x102e.google.com with SMTP id t15so8155336pjq.5
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AolTBA6M4oIIOZ6Ux3+wZLzORQvKME0Ssg6A7cfe4Ys=;
 b=Gs/ZHg37gAbmnuXfw3jvbLCzWb23JnC2m4uQlSY9wxDUDZ5kLih18Of4PlGP1oUmNc
 q2z3FAOQdX95RgXMYxjdyGWCyoTfKuLZ398bcRqTsnssCuwv6ahh+VFV8HfOIXWnRwgs
 dE62HpV6Xp2wKDY03E4+eFOiwheFx4le8G0RlF1qzaGfuq+//Je02adc8aZ1mppLm0o1
 8QKOCXdQ0FFZNq7Df3BxqbQU9vbiDI6wc9phk4EizRwPBnY2ulRaO1ir/xNbkoYjFpOR
 MWmgiV5yEVG8xVAbx2cwJMaqY1YNdye+rEfUDuCSFdh46jqTisdcZn9gHfLqJhjB5q8a
 YujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AolTBA6M4oIIOZ6Ux3+wZLzORQvKME0Ssg6A7cfe4Ys=;
 b=hDFP+ABvq5cczfx6ozLxH1j1Zw+9bMMUNsUk5rba36v5I8IJAM+KKCCC9hNhgZxEJl
 Xd23rmieeGTntjaKx75h/3PqTSxMSOcav6MbScjMx+6NTD03XjipGIrFLKu5NEmOseCF
 7k2dO0zHiZA4do4lvkC4BAqyPgThP85OWY3eCM1PwQluPlW50pDnPWIwenaObyOByyiE
 rTzocTfb3DCGQmCnAAxb5em1jWLtYufqyKdeBx0kOKbYiW5TJOJueV6rJXxuLeZxGFWW
 RNb9JXRaisvx+9SetzPLUl1dwqliN3tUxs1BEjEIDbvv7x5459BhiZP8kNp1uqRCKRph
 uKdw==
X-Gm-Message-State: AOAM532C2o2BwiOpcEUDkc0uVwpO/5CW3fuLaGz1MCiqU+ikt9nfCAl8
 50DgYc84l1IB9v6kSMblhRDlMA==
X-Google-Smtp-Source: ABdhPJwXnRinfFTBCgInEJFADjkU7D2pqzL/qhyjdEU6IhrD5NM8ROrjqh5c6Mpm8gRg59tdJ52eYw==
X-Received: by 2002:a17:90b:124c:: with SMTP id
 gx12mr5119002pjb.191.1596215128094; 
 Fri, 31 Jul 2020 10:05:28 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e125sm5376980pfh.69.2020.07.31.10.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 10:05:27 -0700 (PDT)
Subject: Re: [RFC v2 67/76] target/riscv: rvv-0.9: remove integer extract
 instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-68-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74776653-55a3-6ffb-c765-3a5382c1a6c5@linaro.org>
Date: Fri, 31 Jul 2020 10:05:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-68-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
>  target/riscv/insn32.decode              |  1 -
>  target/riscv/insn_trans/trans_rvv.inc.c | 23 -----------------------
>  2 files changed, 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


