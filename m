Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE668C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 02:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA2D20838
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 02:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svYRMJBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA2D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBqxC-0006zE-KI
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 22:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBqwR-0006Tz-43
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 22:50:07 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBqwF-0003cB-Hb
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 22:50:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id j11so498719plk.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ffdk4Spkl+Lz/tuDSx6BMqEeT7Nmd8Lu0O0pOzmDuMk=;
 b=svYRMJBMol6RzaSADRCc+oIaHjxGBmHO0iojj+vJv/exDJsm3qmFpdGJLgMWz1QYVF
 aZuj9xwvmkcu68kmmbxEHiAaQAb9Z+b+SP5/E/36H15qWqT+bEVxzBuIlhOH7snpmhvw
 8xAbsvBzVsB9YDmJ8CbhQWuLSDBd1WJSZUL6a+pr5wi1vjqwXg2UhIIe7k6Q4h9OEQKo
 Pb91rD0xddP3Ig1QcWyLyxoqUWxRVkDu5wEDJmMFGaLC1OAHiu+DupkQhVf8/3A9c4Hi
 lc1OP7m7EvuqhPiAT3k79EYAPyCdLXH00dYZzyH0xxxMj/rzx0you/HsoqTq+DPt+wJy
 PkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ffdk4Spkl+Lz/tuDSx6BMqEeT7Nmd8Lu0O0pOzmDuMk=;
 b=gmdNG2V3mfNxezCRJPR+zPlbCnHDxMhBEG+oBJo/MjltjAQ2aGJDCc412KlUSbJs3D
 fq2oU/H4v8j7KLdmMddEb++Wwx6RQZclQjzktViM3nJyvQN92UQuVHk6spc9zBJFst92
 RwgLuN4om6RQ70gIXwkSwzTXdn/g8K4u+3ne2r+iYYSBOoXStFGt3uYVhWWR5W/uwHFd
 9kNGx3fj16t5FWoHjPU8w2zRvqAt1Ovp07GVO/2dCaT6fXz0E8CNiS3//mbiapCMRWGs
 8rSZhwpW2V/Q2zjWtWECip1OjkavRgObJp7dD5QL7tyCKZ0tJEpdLI1qEAkB/q55N33v
 FqsQ==
X-Gm-Message-State: AOAM533p/v51JO5Z0001PrIYlZfg0SmPAcg2eKyeP9JbU+O+Je+9eijw
 6p0QNummM/Bd06Il920rsA1PwA==
X-Google-Smtp-Source: ABdhPJxT+0I5Pww8jeb6GxdUhuTZpM9u065gSO4O+AyAE6Why2HYULXdHeZ88fX4TPUgynDpFpAPMQ==
X-Received: by 2002:a17:90a:6343:: with SMTP id
 v3mr1506607pjs.163.1598669393648; 
 Fri, 28 Aug 2020 19:49:53 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ev10sm579466pjb.35.2020.08.28.19.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 19:49:52 -0700 (PDT)
Subject: Re: [RFC PATCH v3 31/34] Hexagon (target/hexagon) translation
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-32-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <00686989-8fdb-2334-d8f3-93c6301c142d@linaro.org>
Date: Fri, 28 Aug 2020 19:49:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-32-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Read the instruction memory
> Create a packet data structure
> Generate TCG code for the start of the packet
> Invoke the generate function for each instruction
> Generate TCG code for the end of the packet
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/translate.h | 103 +++++++
>  target/hexagon/translate.c | 730 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 833 insertions(+)
>  create mode 100644 target/hexagon/translate.h
>  create mode 100644 target/hexagon/translate.c
> 
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> new file mode 100644
> index 0000000..144140f
> --- /dev/null
> +++ b/target/hexagon/translate.h
> @@ -0,0 +1,103 @@
> +/*
> + *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HEXAGON_TRANSLATE_H
> +#define HEXAGON_TRANSLATE_H
> +
> +#include "cpu.h"
> +#include "exec/translator.h"
> +#include "tcg/tcg-op.h"
> +#include "internal.h"
> +
> +typedef struct DisasContext {
> +    DisasContextBase base;
> +    uint32_t mem_idx;
> +    int reg_log[REG_WRITES_MAX];
> +    int reg_log_idx;
> +    int preg_log[PRED_WRITES_MAX];
> +    int preg_log_idx;
> +    uint8_t store_width[STORES_MAX];
> +} DisasContext;
> +
> +static inline void ctx_log_reg_write(DisasContext *ctx, int rnum)
> +{
> +#if HEX_DEBUG
> +    int i;
> +    for (i = 0; i < ctx->reg_log_idx; i++) {
> +        if (ctx->reg_log[i] == rnum) {
> +            HEX_DEBUG_LOG("WARNING: Multiple writes to r%d\n", rnum);
> +        }
> +    }
> +#endif
> +    ctx->reg_log[ctx->reg_log_idx] = rnum;
> +    ctx->reg_log_idx++;
> +}

Why not just keep a bitmask of the rnum written?
Does the order of this log really matter?

> +static inline bool is_preloaded(DisasContext *ctx, int num)
> +{
> +    int i;
> +    for (i = 0; i < ctx->reg_log_idx; i++) {
> +        if (ctx->reg_log[i] == num) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}

It would mean this one becomes constant time.

> +static inline void gen_slot_cancelled_check(TCGv check, int slot_num)
> +{
> +    TCGv mask = tcg_const_tl(1 << slot_num);
> +    TCGv one = tcg_const_tl(1);
> +    TCGv zero = tcg_const_tl(0);
> +
> +    tcg_gen_and_tl(mask, hex_slot_cancelled, mask);
> +    tcg_gen_movcond_tl(TCG_COND_NE, check, mask, zero, one, zero);

This is a bit silly.  Better as

    tcg_gen_extract_i32(check, hex_slot_cancelled, slot_num, 1);


> +static int read_packet_words(CPUHexagonState *env, DisasContext *ctx,
> +                             uint32_t words[])
> +{
> +    bool found_end = false;
> +    int max_words;
> +    int nwords;
> +    int i;
> +
> +    /* Make sure we don't cross a page boundary */
> +    max_words = -(ctx->base.pc_next | TARGET_PAGE_MASK) / sizeof(uint32_t);
> +    if (max_words < PACKET_WORDS_MAX) {
> +        /* Might cross a page boundary */
> +        if (ctx->base.num_insns == 1) {
> +            /* OK if it's the first packet in the TB */
> +            max_words = PACKET_WORDS_MAX;
> +        }
> +    } else {
> +        max_words = PACKET_WORDS_MAX;
> +    }
> +
> +    memset(words, 0, PACKET_WORDS_MAX * sizeof(uint32_t));
> +    for (nwords = 0; !found_end && nwords < max_words; nwords++) {
> +        words[nwords] = cpu_ldl_code(env,
> +                                ctx->base.pc_next + nwords * sizeof(uint32_t));
> +        found_end = is_packet_end(words[nwords]);
> +    }
> +    if (!found_end) {
> +        if (nwords == PACKET_WORDS_MAX) {
> +            /* Read too many words without finding the end */
> +            gen_exception(HEX_EXCP_INVALID_PACKET);
> +            ctx->base.is_jmp = DISAS_NORETURN;
> +            return 0;
> +        }
> +        /* Crosses page boundary - defer to next TB */
> +        ctx->base.is_jmp = DISAS_TOO_MANY;

The problem with this is that the translator has asked for the next insn, and
you havn't provided it.

One way to fix this might be to decrement ctx->base.num_insns, to compensate
for the increment that *will* happen after you return.

Another way, which involves less poking about into internals is to look for the
next packet once you've completed the current packet.  This is what Arm does
for thumb2 insns:

>     if (dc->base.is_jmp == DISAS_NEXT
>         && (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE
>             || (dc->base.pc_next - dc->page_start >= TARGET_PAGE_SIZE - 3
>                 && insn_crosses_page(env, dc)))) {
>         dc->base.is_jmp = DISAS_TOO_MANY;
>     }

I.e. you only have to do this for the few packets that are near enough to the
end of the page that PACKET_WORDS_MAX crosses.

> +    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
> +    tcg_gen_movi_tl(hex_slot_cancelled, 0);
> +    if (pkt->pkt_has_cof) {
> +        tcg_gen_movi_tl(hex_branch_taken, 0);
> +        tcg_gen_movi_tl(hex_next_PC, next_PC);
> +    }
> +    tcg_gen_movi_tl(hex_pred_written, 0);
> +}

Surely you don't need to actually set PC for every PC?
Nor set hex_slot_cancelled if the packet contains nothing that can cancel
anything.  Nor set hex_pred_written if no predicates are written.

> +    TCGv cancelled = tcg_temp_local_new();
> +    TCGLabel *label_end = gen_new_label();
> +
> +    /* Don't do anything if the slot was cancelled */
> +    gen_slot_cancelled_check(cancelled, slot_num);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, cancelled, 0, label_end);

cancelled does not need to be local; it is consumed by the branch and not
consumed afterward.  Just free it here.

> +        /*
> +         * If we know the width from the DisasContext, we can
> +         * generate much cleaner code.
> +         * Unfortunately, not all instructions execute the fSTORE
> +         * macro during code generation.  Anything that uses the
> +         * generic helper will have this problem.  Instructions
> +         * that use fWRAP to generate proper TCG code will be OK.
> +         */

OMG.  How disgusting.

> +            value = tcg_temp_new();
> +            tcg_gen_mov_tl(value, hex_store_val32[slot_num]);
> +            tcg_gen_qemu_st8(value, address, ctx->mem_idx);
> +            tcg_temp_free(value);

Why are you copying to a temporary?

> +        default:
> +            /*
> +             * If we get to here, we don't know the width at
> +             * TCG generation time, we'll generate branching
> +             * based on the width at runtime.
> +             */
> +            label_w2 = gen_new_label();
> +            label_w4 = gen_new_label();
> +            label_w8 = gen_new_label();
> +            TCGv width = tcg_temp_local_new();

You might as well make this a helper.  This is going to generate a *lot* of code.

> +static void gen_exec_counters(packet_t *pkt)
> +{
> +    int num_insns = pkt->num_insns;
> +    int num_real_insns = 0;
> +    int i;
> +
> +    for (i = 0; i < num_insns; i++) {
> +        if (!pkt->insn[i].is_endloop &&
> +            !pkt->insn[i].part1 &&
> +            !GET_ATTRIB(pkt->insn[i].opcode, A_IT_NOP)) {
> +            num_real_insns++;
> +        }
> +    }
> +
> +    tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_PKT_CNT],
> +                    hex_gpr[HEX_REG_QEMU_PKT_CNT], 1);
> +    if (num_real_insns) {
> +        tcg_gen_addi_tl(hex_gpr[HEX_REG_QEMU_INSN_CNT],
> +                        hex_gpr[HEX_REG_QEMU_INSN_CNT], num_real_insns);
> +    }

tcg_gen_addi_tl will check for the immediate == 0.

As with updating PC for every insn, this is going to be expensive.

You could accumulate these values through the TB and then update them at the
end.  You'd need to store the intermediate values in the space managed by
TARGET_INSN_START_EXTRA_WORDS, so that you can update them on any exceptional
path out of the TB, in restore_state_to_opc().

> +    if (end_tb) {
> +        tcg_gen_exit_tb(NULL, 0);

This misses out on ctx->base.singlestep_enabled, and almost certainly belongs
in hexagon_tr_tb_stop.  Use

#define DISAS_EXIT  DISAS_TARGET_0

or some other appropriate naming.


r~

