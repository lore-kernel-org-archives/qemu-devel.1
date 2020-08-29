Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B63C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38CE207DF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+9cJs31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38CE207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7Hh-0004tu-0k
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7H4-0004Q2-4d
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:16:30 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:46120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7H2-0007JF-KV
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:16:29 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 31so2120720pgy.13
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bCrPokc/91BVai+tc3RhUD6fQovVNYVuKlbILtdd53s=;
 b=G+9cJs310rX0yjl1QM9hUEluKgPFJdNa7MNRp0N8ZSRsaMXN005DT05BBHYAvSLyyg
 qxYctMTAtRydo7U1nh9MTsaCMyh+Mo/RuKHXmrjhArU0I66y8BmiCaVAHrxuF8l+1AS0
 NfH2PJm6bKeRoX2i8vGiHVCfnyeGKfgh1KAOa9W8/UfhsMAEm1/W3wHC52Rx3Nxj0U+P
 nGcGfbRPO6CnFF84+7zd5m1MzFWcOGsFPlVmYyxbm9hE1QECuOy3ywq9mtvTJgkjVakJ
 l7jA9ARg5O/wirtOAyqzzsLtTVpZvEPZEccRgTaWBt8RWq1Oef4XFo1qcAEzZkIL9kYm
 Kc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bCrPokc/91BVai+tc3RhUD6fQovVNYVuKlbILtdd53s=;
 b=AsgkJAxZvzEgeGhMV6Gc5Ro26LaVZ05ibnkp4JAjPsKgS/8BUZXX0PzYJfpeha9KvF
 qHy7muL8vWaH09I0kNdiu02RskKJ1g5kbmTIdKr9jdOZdn/GO3FgteaekExOXh6Km3MH
 Iz30HgS/gbs6s9UyUPZ8vZtkteoi4dVTiii8KPc/97h3iWtjz8gw+PY+cMt5C0xrq+1D
 jEv3RhvBJnmglnAYJs6XqWUJphbOmpFM0oT8TGegFNLkVtH+uvXYQDU4BzCgQoWHsiQI
 HISQLMwtOF2PnOQSM9DmdkBAHR7BILGD6hNrkXuBX0wqmzN5WDJ+x5H7XUlFXpH8h1dR
 lVXw==
X-Gm-Message-State: AOAM533GKfuP2NLnzabDaPMlE4jiRYuAu/YjgILIfKl1ntQDVaKWouOS
 4ptM8xd+wv6CdZUS4bgZPCaJ7w==
X-Google-Smtp-Source: ABdhPJyNb+L6LBNJUC82D0UGEC5fT6hUUI/J6/MoxWrZ3aqe7KuWGQcklHiV91AbuS6WtkdEIEgzRQ==
X-Received: by 2002:aa7:8a50:: with SMTP id n16mr4042147pfa.81.1598732187091; 
 Sat, 29 Aug 2020 13:16:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s129sm3397364pfb.39.2020.08.29.13.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:16:26 -0700 (PDT)
Subject: Re: [RFC v4 42/70] target/riscv: rvv-1.0: integer
 add-with-carry/subtract-with-borrow
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-43-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <170d8651-afcc-b11a-6645-de6ab3e3d52d@linaro.org>
Date: Sat, 29 Aug 2020 13:16:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-43-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
> Clear tail elements only if VTA is agnostic.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn32.decode              | 20 ++++++++++----------
>  target/riscv/insn_trans/trans_rvv.inc.c |  2 +-
>  target/riscv/vector_helper.c            | 14 ++++----------
>  3 files changed, 15 insertions(+), 21 deletions(-)

The patch description is wrong, but the code is correct.

One nit:

> -        uint8_t carry = vext_elem_mask(v0, i);                \
> +        uint8_t carry = !vm ? vext_elem_mask(v0, i) : 0;      \

    ETYPE carry = !vm && vext_elem_mask(v0, i);


r~

