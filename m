Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB3C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D983922210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 17:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dThDufOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D983922210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6nf-0007nd-PY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 13:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6cU-0004RQ-D7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:00:51 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kT6cQ-0002U9-3V
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 13:00:49 -0400
Received: by mail-pl1-x643.google.com with SMTP id v12so1918035ply.12
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WUcro0B6YtCjpSxkj0AVtOY2ca08tCL+vDTY0sH+OJM=;
 b=dThDufOYA325BNWT05DanacpRjHPAUw6+QK8IkiW38oRjIZbEJNDyFhYezbDPI6bon
 GayQbDScYCypBHEjAsbJfGD8oP+3K8q6oXikb9giIcbjH5W9iYWTH9UHkBr44fWrkBTR
 hV44GmdMNgX4vLdJD4fJact8sjfjGkDfwU/sHfqnlqirDl2oRgqazOClLDFTRSmKGfiT
 Bqxq5JPTk00r5CweWctnh3twFeIW/6WdbtA+0nHzrtKlciVzarGSO0VZR9wNuBT7uJy5
 7Kq9LE+6sOB2BlP/gud8KkmGfEQHdZkj5DGHuOGHmNG9ncjR3qUHuZtP16b7rOkHKwk8
 rSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WUcro0B6YtCjpSxkj0AVtOY2ca08tCL+vDTY0sH+OJM=;
 b=RH5sB0JyQejTHkCsla5uV5j2bXD98nnK3JLXSCX3PmpjFTrP2UD3vV8Ip+w91yXtX2
 x6X+gCZZYe0j8fou4gjkjPXVi1O/8z+3OZt7nxShLyuXMU5001FT0EoxV/iY+05YHEyd
 MG2/5f0SPN2XRkHBs9znxipyVin+KO0QdCLkjAZ6es6s9+fho/9twJvKdmd0LjwKtnK3
 ED7+PvI8iFA9otMYp61TgJ3qMAB6OWJn6UIPu3qEm+JycJJpj6/WwewdVKsKl8g7t7Jk
 rVJtgrO+ooXjVh2owTpiuNwKWb55mrffvGC9pAzBvbrNAaKbV7wpOnqkQksQG7Cp+HsD
 MjqA==
X-Gm-Message-State: AOAM530e4BYuOz+WS3vg4X1DnwkXaCzF2S5AZdzc3TPZDwsduke6BR31
 HAMWdFc0aaRrxcPcGlW61vBqyQ==
X-Google-Smtp-Source: ABdhPJwJSUUPi9DotEIeVxzBO1I3tZ8qo6jaGsctNBosFDU2K+aSr7QrGyQC40ztTPmVaap6Ypagvg==
X-Received: by 2002:a17:90a:d901:: with SMTP id
 c1mr4743891pjv.81.1602781243503; 
 Thu, 15 Oct 2020 10:00:43 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w205sm3847938pfc.78.2020.10.15.10.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 10:00:42 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-4-space.monkey.delivers@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d7e10ff-b560-4f16-9f53-516dc26156a0@linaro.org>
Date: Thu, 15 Oct 2020 10:00:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015152139.28903-4-space.monkey.delivers@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, GAPPY_SUBJECT=0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/15/20 8:21 AM, Alexey Baturo wrote:
> Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rva.c.inc |  3 +++
>  target/riscv/insn_trans/trans_rvd.c.inc |  2 ++
>  target/riscv/insn_trans/trans_rvf.c.inc |  2 ++
>  target/riscv/insn_trans/trans_rvi.c.inc |  2 ++
>  target/riscv/translate.c                | 14 ++++++++++++++
>  5 files changed, 23 insertions(+)

Looks ok.

It does occur to me to wonder how this is intended to work with unaligned
addresses, or large memory operations such as with RVV.

Without changes in the generic tcg code, an unaligned memory op that crosses
the mask will not wrap the second half.  E.g.

  upmbase = 0
  upmmask = 0xffff
  address = 0xfffe
  size    = 8

will read [0x10005 : 0xfffe] and not
[0x0005 : 0x0000] | [0xffff : 0xfffe] as a true wrapping would lead you do believe.


r~

