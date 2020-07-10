Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BABC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9920D20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/zpWb7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9920D20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwpd-0007Ww-Tg
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwoA-0005kY-9f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:27:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:35336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtwo7-0006fu-BM
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:27:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id x9so2530779plr.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MGw1xnIhMlU3+HyGZ+q0KK/sZgrz0+mONwYEG3A9hmE=;
 b=O/zpWb7dilaa4B9k/DHhXwpxKsU6ltfE8Pwc6SrppMyGw88dbNOrlAqdozfEl37yRh
 mVy6nbhdZ7OSs5j3FTrVNYv80fvRRBP0mvyed4ViX5qMEFHwqgEtB0ofyxJKIsO6GTi/
 bpx3VTtek7FCaYzgFFuV+704Dd2np1AfLCEs9iqJVGql7AaoSkiGb+flYb2cruUBhpN9
 DVFeCoZgaIKOLUdBgvET6AgHvWcPCI1ZQ9eDYRi2srrFNhFOmGUAZqn/P7YkEBbnjxci
 +LkWqbv/8k/tvcRGFKqWS4KxwwJx3iAPYG/ljXbyVS70975Egm3m+ttUf7hWVRGlZVwc
 lX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MGw1xnIhMlU3+HyGZ+q0KK/sZgrz0+mONwYEG3A9hmE=;
 b=ErAiRfjsdxwtNR0dB/NiL7NTVnUFxs+lBOyfodGLB0r4FpeNWWvoV2Nb8l8N2BnGSS
 L2/uBKKOpG8d4s3/8CdmWnki94Wc+8vOWm0EqAvuNS76/s/JuZaSSk/NCb9Ag91ZNnEY
 48FhBqDkxojnB3JrHpZxHrCjidUv9oiTWNE9Wo0cxXb96gdhlIwXNyGhTJZLO9TY5BBa
 2FbzC/65BCaRAqI7KwI8sI3xILc3sRr5nEClm1Hah4LWlJXXAaLjOaGH0O4YOMB2awDz
 1Zc5hUe2fUgTddeeGyQpx0XqiQVU3RFxOkKBJ/sBMdqDPCjTVUZUbTIpr+ld9V8hqN9a
 TUyg==
X-Gm-Message-State: AOAM532D1XloJmzj5OZvKhGWvIixOaEI3aW0N09hCx/QhGVQ1ytu+XGL
 ym89p2kbc9Cx+kXbCEY1R0Hbig==
X-Google-Smtp-Source: ABdhPJzo7HaYnOJlSXveXMoQH8G7sNhEagbCrbuMGjPmGg7dIrbFcVpLDNxImBnoqakxCJ3Nm8viYQ==
X-Received: by 2002:a17:902:c411:: with SMTP id
 k17mr56177688plk.165.1594402049873; 
 Fri, 10 Jul 2020 10:27:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g8sm6338215pgr.70.2020.07.10.10.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:27:29 -0700 (PDT)
Subject: Re: [RFC 07/65] target/riscv: rvv-0.9: add vector context status
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-8-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <52547eb2-4bda-e97a-3c5e-8565da3579de@linaro.org>
Date: Fri, 10 Jul 2020 10:27:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-8-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> From: LIU Zhiwei <zhiwei_liu@c-sky.com>
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu.h                      |  4 ++
>  target/riscv/cpu_bits.h                 |  1 +
>  target/riscv/cpu_helper.c               | 13 ++++++
>  target/riscv/csr.c                      | 25 ++++++++++-
>  target/riscv/insn_trans/trans_rvv.inc.c | 57 +++++++++++++++++++++----
>  target/riscv/translate.c                | 32 ++++++++++++++
>  6 files changed, 123 insertions(+), 9 deletions(-)

BTW, I think this should be split.

One patch for the csr.c changes, another for the translate changes.


r~

