Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024AAC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF89E24249
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 17:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oy6JRgwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF89E24249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icugq-0003Rp-SL
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 12:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icubC-0005fX-RF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icubA-0006H5-Sy
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:30 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icubA-0006EH-E6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:07:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id k14so3245552otn.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YtGFypd1tT/KDgKKVEQWYE6cS0eFJfLHx2BXKFo+wN4=;
 b=oy6JRgwtThoEKvQtK8rzBh7dRmXkZerjJBWllUk+kPG5maVnwewdrrETeIr4xLyUXz
 U+tdZBte4wkUAiJ5e4TwEuyiYsXhFf5tCpjL/fWzIKPmoAKeW/aUBF0pMq5Ez5IIt+pj
 wYKOcBW6tbuOSxG7lL4hZY4TFMU4MlpdZob6zOEr2KlIZkJCJh2F24vBhC1bbwfEnSY1
 WDV6+rEiGd8CH39CH2ct8Jup6QK4cqP3phHozy174L3uTc4iYJ+uX3js488+jJDa3TcS
 siLeZaUAC8o9FNM8ySoaqKTn4/RjCWz3liY50WIB3wVpVLZm4/HIXeAGtu5yq1bUu9cT
 J7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YtGFypd1tT/KDgKKVEQWYE6cS0eFJfLHx2BXKFo+wN4=;
 b=ujRzJ71NqGpeBhtiqrueKAiP8sks/qz5YXF4goAwSqZfE4l2XmKv5kQux8u08Y0eyT
 gy3uZx9Wg4Cz/NxteEGKPDTGVfOCk4AGYaY72CQRcg/dar4R2jea4a0Xq/NrIe8tcEaO
 rEcV17vGC61FuH6QsWObWLNr9Xt+dWAqrKAofSoG8/Thu6tK6k6LfCwquVAgsL0sVQEI
 QM88fuo047TpSiQcCHoia1+uFN4vCrauZ947ov+2BSxTGEd4jw/Lo9ixXIUeIJmaGW6i
 9yEpUft4S9d+eCyaZDlbanc0yyENxvwjwqNe+m1MJTnvPZ2aRXl8DCisNKkKAhNA3C1p
 aakw==
X-Gm-Message-State: APjAAAVPFFyny6HzG9mMN0N9/XdMCroHVK40KILnuO5W0b/Gz8mYQxyX
 q1o2TDXK4ReVAW+KVb3les3SXjDAet8RCyJdLGmZ6w==
X-Google-Smtp-Source: APXvYqz2mR2AasPVdVaH+r9qdoFx2uqagKbQYNxwSDXpNezm1fTcSiZhd88XiWqWJyI1qXLKFCQHkC7gx+jjessxe78=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr7746462otg.232.1575565647508; 
 Thu, 05 Dec 2019 09:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-12-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 17:07:16 +0000
Message-ID: <CAFEAcA_0pBg57n8wq2j0tS94ewJf1mrYsJYzaWYcQAKvfBFm-g@mail.gmail.com>
Subject: Re: [PATCH v5 11/22] target/arm: Implement LDG, STG, ST2G instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Split out allocation_tag_mem.  Handle atomicity of stores.
> v3: Add X[t] input to these insns; require pre-cleaned addresses.
> v5: Fix !32-byte aligned operation of st2g.
> ---
>  target/arm/helper-a64.h    |   5 ++
>  target/arm/mte_helper.c    | 154 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-a64.c | 115 +++++++++++++++++++++++++++
>  3 files changed, 274 insertions(+)
>

> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -25,8 +25,21 @@
>  #include "exec/helper-proto.h"
>
>
> +static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
> +                                   bool write, uintptr_t ra)
> +{
> +    /* Tag storage not implemented.  */
> +    return NULL;
> +}
> +
>  static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
>  {
> +    uint8_t *mem = allocation_tag_mem(env, ptr, false, ra);
> +
> +    if (mem) {
> +        int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
> +        return extract32(atomic_read(mem), ofs, 4);

Can we have a comment somewhere describing what our tag
storage looks like? I guess from the code that we're doing
it as a byte array where each byte stores 2 4-bit tags
(in which order?), but documenting it would be nice.

> +    }
>      /* Tag storage not implemented.  */
>      return -1;
>  }

> +static void do_st2g(CPUARMState *env, uint64_t ptr1, uint64_t xt,
> +                    uintptr_t ra, stg_store1 store1)
> +{
> +    int el, tag;
> +    uint64_t ptr2, sctlr;
> +    uint8_t *mem1, *mem2;
> +
> +    check_tag_aligned(env, ptr1, ra);
> +
> +    el = arm_current_el(env);
> +    sctlr = arm_sctlr(env, el);
> +    tag = allocation_tag_from_addr(xt);
> +
> +    /*
> +     * Trap if accessing an invalid page(s).
> +     * This takes priority over !allocation_tag_access_enabled.
> +     */
> +    mem1 = allocation_tag_mem(env, ptr1, true, ra);
> +
> +    if (ptr1 & TAG_GRANULE) {
> +        /* The two stores are unaligned and modify two bytes.  */
> +        ptr2 = ptr1 + TAG_GRANULE;
> +        mem2 = allocation_tag_mem(env, ptr2, true, ra);
> +
> +        /* Store if page supports tags and access is enabled.  */
> +        if ((mem1 || mem2) && allocation_tag_access_enabled(env, el, sctlr)) {
> +            if (mem1) {
> +                store1(ptr1, mem1, tag);
> +            }
> +            if (mem2) {
> +                store1(ptr2, mem2, tag);
> +            }
> +        }
> +    } else {
> +        /* The two stores are aligned 32, and modify one byte.  */

Not sure what the '32' means here?

> +        if (mem1 && allocation_tag_access_enabled(env, el, sctlr)) {
> +            tag |= tag << 4;
> +            atomic_set(mem1, tag);
> +        }
> +    }
> +}

> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index cf341c98d3..c17b36ebb2 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -3559,6 +3559,118 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
>      }
>  }
>
> +/*
> + * Load/Store memory tags
> + *
> + *  31 30 29         24     22  21     12    10      5      0
> + * +-----+-------------+-----+---+------+-----+------+------+
> + * | 1 1 | 0 1 1 0 0 1 | op1 | 1 | imm9 | op2 |  Rn  |  Rt  |
> + * +-----+-------------+-----+---+------+-----+------+------+
> + */
> +static void disas_ldst_tag(DisasContext *s, uint32_t insn)
> +{
> +    int rt = extract32(insn, 0, 5);
> +    int rn = extract32(insn, 5, 5);
> +    uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
> +    int op2 = extract32(insn, 10, 3);

Typo ? op2 is only 2 bits, not 3.

> +    int op1 = extract32(insn, 22, 2);

The Arm ARM calls this field 'opc', fwiw.

> +    bool is_load = false, is_pair = false, is_zero = false;
> +    int index = 0;
> +    TCGv_i64 dirty_addr, clean_addr, tcg_rt;
> +
> +    if ((insn & 0xff200000) != 0xd9200000
> +        || !dc_isar_feature(aa64_mte_insn_reg, s)) {
> +        goto do_unallocated;
> +    }

Bits 28:24 are already checked by the decode that got us here.

I did wonder about maybe doing the decode of
[31:30] and [21] in the caller (which would match the
structure of the decode tables in the manual), but
we do the same sort of thing for bit [31] in
disas_ldst_multiple_struct() and disas_ldst_single_struct(),
so this is fine.

Not all the insns in this encoding group are present
for the mte_insn_reg cut-down implementation:
LDGM, STGM and STZGM should UNDEF unless we have
full-fat MTE. We haven't added any of those in this patch,
but it might affect how you want to structure the
conditional for doing the feature bit test. (Looking
ahead, patch 13 which adds those insns doesn't update the
feature bit test.)


> +
> +    switch (op1) {
> +    case 0: /* STG */
> +        if (op2 != 0) {
> +            /* STG */
> +            index = op2 - 2;

What does 'index' represent? It looks from the rest of
the code like it's some sort of tristate between
'preindex', 'postindex' and 'not indexed'; if so
a comment explaining what the valid values and meanings
are would be helpful. Alternatively, follow the approach
of disas_ldst_reg_imm9() and just have separate
'post_index' and 'writeback' bools.

> +            break;
> +        }
> +        goto do_unallocated;
> +    case 1:
> +        if (op2 != 0) {
> +            /* STZG */
> +            is_zero = true;
> +            index = op2 - 2;
> +        } else {
> +            /* LDG */
> +            is_load = true;
> +        }
> +        break;
> +    case 2:
> +        if (op2 != 0) {
> +            /* ST2G */
> +            is_pair = true;
> +            index = op2 - 2;
> +            break;
> +        }
> +        goto do_unallocated;
> +    case 3:
> +        if (op2 != 0) {
> +            /* STZ2G */
> +            is_pair = is_zero = true;
> +            index = op2 - 2;
> +            break;
> +        }
> +        goto do_unallocated;
> +
> +    default:
> +    do_unallocated:
> +        unallocated_encoding(s);
> +        return;
> +    }

Should there be a
    if (rn == 31) {
        gen_check_sp_alignment(s);
    }
here?

> +
> +    dirty_addr = read_cpu_reg_sp(s, rn, true);
> +    if (index <= 0) {
> +        /* pre-index or signed offset */
> +        tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
> +    }
> +
> +    clean_addr = clean_data_tbi(s, dirty_addr, false);
> +    tcg_rt = cpu_reg(s, rt);

I think this is only correct for LDG, where the Rt field
is 'specifies the Xt register to use'; for STG and ST2G
it's an '<Xn|SP>' form where 31 means "use SP" and you
want cpu_reg_sp() for those.


> +
> +    if (is_load) {
> +        gen_helper_ldg(tcg_rt, cpu_env, clean_addr, tcg_rt);
> +    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +        if (is_pair) {
> +            gen_helper_st2g_parallel(cpu_env, clean_addr, tcg_rt);
> +        } else {
> +            gen_helper_stg_parallel(cpu_env, clean_addr, tcg_rt);
> +        }
> +    } else {
> +        if (is_pair) {
> +            gen_helper_st2g(cpu_env, clean_addr, tcg_rt);
> +        } else {
> +            gen_helper_stg(cpu_env, clean_addr, tcg_rt);
> +        }
> +    }
> +
> +    if (is_zero) {
> +        TCGv_i64 tcg_zero = tcg_const_i64(0);
> +        int mem_index = get_mem_index(s);
> +        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
> +
> +        for (i = 0; i < n; i += 8) {
> +            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_Q);
> +            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
> +        }
> +        tcg_temp_free_i64(tcg_zero);
> +    }
> +
> +    if (index != 0) {
> +        /* pre-index or post-index */
> +        if (index > 0) {
> +            /* post-index */
> +            tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
> +        }
> +        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
> +    }
> +}

thanks
-- PMM

