Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48DAC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A7B20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOBiryRs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A7B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvfJ-0002Km-UC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtveQ-0001FO-1K
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:13:26 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:34039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtveN-0004sW-HL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:13:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id o1so2452483plk.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fBm5hZgFujUHFULHB1pK8zNcNx27ppuWa0g86R80LDc=;
 b=fOBiryRsDmvMf8LymBJsbbKThdTGEet69mf+0w88SlPrGJ/Od1/+XjU4xvuhFzUEo2
 ch1cR4xXroWQv0j6amg9SnpvsNq4mMw0BNlGdSS+NTR+IzrK0YB9Hl/QwtLBg694uCJn
 h4GweWuiElUrYYVixUGzLA0ygVrBVlsL7fUnAKoYjyFEMf2lOT645cFdR/8KSo8ZHDnm
 q/azds4jKesL7Uxv8F9EGgnpclO2J8NrZvU06fWS6AToYxCH8oKmtgINi329t+LhsPL3
 fivLJDBR8/+KGF5g8UkfNfYfYWonKLP+2H6j+md7EMqzd4gFjWQOalGSxbEkq0Au8jn7
 c3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fBm5hZgFujUHFULHB1pK8zNcNx27ppuWa0g86R80LDc=;
 b=jS9v7gTJC0jVn56/Yk3U1m/PdtNSf2SGcXVvq44Ee5IMeIxzP7fcuMyGZ5qpymEZIo
 k4RKHotsasU0TtOGBVEJUhuJ6fd1ioZ+AjVmkYrDyfRQwG+i/tmyvnM+H1zSgc0D09rA
 C26A0v4W9hJs4hRNHhv3RYzzJ2xtXkRreB/QrK88zB2UWFsNwhLgVUU3qPYeQZVwyp1o
 4y0D1MIE1WsZwNyfHeyztIEo7cEBY4J/QmjLU8GjMFx5Lamw3+/Fv0RlA+aE9qCAvOdN
 8Pb6X0OZQxDco8e3YQZYOUfcZDi/hBiQZQmIWuJc7Cs9m7OzEp1bTKMCqdCFPdRh/WXX
 oTvA==
X-Gm-Message-State: AOAM531qNnYbvVcA5GpOE2VbHEaXQ5zZr0p8sZdmX1/Wn+RLMJtuORTZ
 rWzaydTXL9yHduPnsqwIjwE39Q==
X-Google-Smtp-Source: ABdhPJwFv0WTemwCdTxktHM8F0Uk98VEix6QxR3UTTHA4N0KXy/vStiik+w20OB2OWWaXqkA6rRhag==
X-Received: by 2002:a17:902:ab8e:: with SMTP id
 f14mr61844056plr.80.1594397601411; 
 Fri, 10 Jul 2020 09:13:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id bf11sm6068112pjb.48.2020.07.10.09.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:13:20 -0700 (PDT)
Subject: Re: [RFC 02/65] target/riscv: correct the gvec IR called in
 gen_vec_rsub16_i64()
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-3-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <77653025-0e43-be40-07de-d60a76a25b03@linaro.org>
Date: Fri, 10 Jul 2020 09:13:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-3-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Alistair, this one should be queued for 5.1 as a bug fix.


r~


