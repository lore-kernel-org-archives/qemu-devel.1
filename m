Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638CBC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D15420830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooqUJN8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D15420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8SBU-0004E9-Cz
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SAU-0003nR-4v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SAS-0001Ih-Gv
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:42:01 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:32768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8SAS-0001HU-BL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:42:00 -0400
Received: by mail-qk1-x743.google.com with SMTP id x134so25140702qkb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YS9/Qq3kpBdzCw97IrsBJ1Krr6ZKQtQ/hWzHljt+FAY=;
 b=ooqUJN8K+KqObp2dM6XItRBaaZyVxpKRwxjl3f+r8+AQ+z5nemU8Nuuu1WlbVV1von
 5/cEUQ/0WNdlWml3QlBQ91CNDPMnnl9uvHMwuhFy8SU7YQHl2svVkJfupzAf/ASlNMFh
 O8rGGu6Mdwgj6FwQ7qTH9ypvLSrwd1jMDQ1e8M5UONBsxTPHrgOKI0Yv827bkGVY+mLJ
 tAqrgZpWMwblyNmNLLcehcCC1EcNPNun+WjiILvd/HW03O+0hdUkyaSJoA0HDjM6+Zqu
 txMmu3H+eRSuRc2Wn9iLNbhIVOHUt6s9rvCKf5SdpI7lYkPSiVGR5NhNAHY/b5SAgA9f
 +VQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YS9/Qq3kpBdzCw97IrsBJ1Krr6ZKQtQ/hWzHljt+FAY=;
 b=ZLb8nObMWczitQ5fYB8eoB00NsXNCX6e4b2K3hVC8zJoBnUrc4h9hFsabh6ErQxrEe
 VaI+pVunHgE1oRVL68lTkz7Kq6ztZXqK+4HNYylPA1sBCBvbxJtJfYqBP3DTYUx2h6sY
 oiIuc7g2rPUO53jJWiypbQBBz2YTA83okLKbbjjuge/y2J7YV/lffCpBM/byXxOit2/P
 B74TL1ZPegrlAxi2TGRoQ4uTMOH23OhBP4dl2ZUchC88OqpG2lecbTHqnklC/C6IUdb6
 I57tWvyn5xvA+aGUQkVPhojDqxMF4Vn7bZ4VYjddnvUO2uSJwyIrzZlh6oCqepEoJS5w
 AAVA==
X-Gm-Message-State: APjAAAVQ8PnxdAKGYu46DPI40nYHJai+emUf7a6NdQFIQZi36/Pui6jL
 MvGbgVzC9fQFZIFqltuhN9acbg==
X-Google-Smtp-Source: APXvYqxZ6SPy95lWXReYTkumfT22PmbslAKm1zpIMKEw/unfxEXFGNn3tQu7RWllupWf+6XbWr7ICg==
X-Received: by 2002:a37:9544:: with SMTP id x65mr43714433qkd.100.1568306519036; 
 Thu, 12 Sep 2019 09:41:59 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id j137sm11104368qke.64.2019.09.12.09.41.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 09:41:58 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-10-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2d4c21ee-3c2c-7c14-82f7-9916b66444cc@linaro.org>
Date: Thu, 12 Sep 2019 12:41:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-10-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: Re: [Qemu-devel] [PATCH v2 09/17] RISC-V: add vector extension
 integer instructions part2, bit/shift
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
> +void VECTOR_HELPER(vand_vv)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
> +{
> +    int i, j, vl;
> +    uint32_t lmul, width, src1, src2, dest, vlmax;
> +
> +    vl = env->vfp.vl;
> +    lmul  = vector_get_lmul(env);
> +    width   = vector_get_width(env);
> +    vlmax = vector_get_vlmax(env);
> +
> +    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return;
> +    }
> +    vector_lmul_check_reg(env, lmul, rs1, false);
> +    vector_lmul_check_reg(env, lmul, rs2, false);
> +    vector_lmul_check_reg(env, lmul, rd, false);
> +
> +    for (i = 0; i < vlmax; i++) {
> +        src1 = rs1 + (i / (VLEN / width));
> +        src2 = rs2 + (i / (VLEN / width));
> +        dest = rd + (i / (VLEN / width));
> +        j = i % (VLEN / width);
> +        if (i < env->vfp.vstart) {
> +            continue;
> +        } else if (i < vl) {
> +            switch (width) {
> +            case 8:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    env->vfp.vreg[dest].u8[j] = env->vfp.vreg[src1].u8[j]
> +                        & env->vfp.vreg[src2].u8[j];
> +                }
> +                break;

Note that a non-predicated logical operation need not consider the width.  All
of the widths perform the same operation, and therefore having the host operate
on u64 is fastest.  This is another good reason to notice vm=1 within the
translator and use separate helper functions for masked vs non-masked.

> +void VECTOR_HELPER(vand_vx)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
...
> +void VECTOR_HELPER(vand_vi)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)

As with the previous set of arithmetic instructions, these should be a single
helper that is passed a 64-bit scalar.

Note that scalars smaller than 64-bit can be replicated with dup_const().  At
which point the logical operation is easily performed in 64-bit units instead
of any smaller unit.

Note that predication can be handled via logical masking.  For ARM SVE, we have
a set of functions that map the active bits of a predicate mask to byte masks.
 See e.g.

static inline uint64_t expand_pred_b(uint8_t byte)
static inline uint64_t expand_pred_h(uint8_t byte)
static inline uint64_t expand_pred_s(uint8_t byte)

so that the predicated logical and operation looks like

    mask = expand_pred_n(env->vfp.vreg[0].u8[i]);
    result = in1 & in2;
    dest = (result & mask) | (dest & ~mask);


r~

