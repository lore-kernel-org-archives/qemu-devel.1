Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FEFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC342074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 22:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC342074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCt0j-0005LR-J8
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 18:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCt07-0004uA-LM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jCt04-0005mK-7q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 18:41:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jCt03-0005T3-4s; Fri, 13 Mar 2020 18:41:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; BR=01201311R141ec; CH=green;
 DM=||false|; DS=SPAM|spam_education_ad|0.830845-0.000596479-0.168558;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03303; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.4qaF3_1584139302; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.4qaF3_1584139302)
 by smtp.aliyun-inc.com(10.147.42.135);
 Sat, 14 Mar 2020 06:41:42 +0800
Subject: Re: [PATCH v5 07/60] target/riscv: add fault-only-first unit stride
 load
To: Alistair Francis <alistair23@gmail.com>
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-8-zhiwei_liu@c-sky.com>
 <CAKmqyKMSUHtMSVBRLBfxm1oOJ4swS-5mrUobVd+VSY+S0No2+Q@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <77d0ec72-cdad-9375-b736-2478a37c8f34@c-sky.com>
Date: Sat, 14 Mar 2020 06:41:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMSUHtMSVBRLBfxm1oOJ4swS-5mrUobVd+VSY+S0No2+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Chih-Min Chao <chihmin.chao@sifive.com>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/14 6:24, Alistair Francis wrote:
> On Thu, Mar 12, 2020 at 8:13 AM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
>> The unit-stride fault-only-fault load instructions are used to
>> vectorize loops with data-dependent exit conditions(while loops).
>> These instructions execute as a regular load except that they
>> will only take a trap on element 0.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/helper.h                   |  22 +++++
>>   target/riscv/insn32.decode              |   7 ++
>>   target/riscv/insn_trans/trans_rvv.inc.c |  69 +++++++++++++++
>>   target/riscv/vector_helper.c            | 111 ++++++++++++++++++++++++
>>   4 files changed, 209 insertions(+)
>>
>> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
>> index f9b3da60ca..72ba4d9bdb 100644
>> --- a/target/riscv/helper.h
>> +++ b/target/riscv/helper.h
>> @@ -218,3 +218,25 @@ DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
>>   DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
>>   DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
>>   DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
>> +DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhff_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vleff_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vleff_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vleff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vleff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbuff_v_b, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbuff_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbuff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlbuff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhuff_v_h, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
>> +DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
>> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>> index bc36df33b5..b76c09c8c0 100644
>> --- a/target/riscv/insn32.decode
>> +++ b/target/riscv/insn32.decode
>> @@ -224,6 +224,13 @@ vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
>>   vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
>>   vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
>>   vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
>> +vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
>> +vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
>> +vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
>> +vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
>> +vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
>> +vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
>> +vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
>>   vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
>>   vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
>>   vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
>> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
>> index 5d1eeef323..9d9fc886d6 100644
>> --- a/target/riscv/insn_trans/trans_rvv.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
>> @@ -531,3 +531,72 @@ GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
>>   GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
>>   GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
>>   GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
>> +
>> +/*
>> + *** unit stride fault-only-first load
>> + */
>> +static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
>> +        gen_helper_ldst_us *fn, DisasContext *s)
>> +{
>> +    TCGv_ptr dest, mask;
>> +    TCGv base;
>> +    TCGv_i32 desc;
>> +
>> +    dest = tcg_temp_new_ptr();
>> +    mask = tcg_temp_new_ptr();
>> +    base = tcg_temp_new();
>> +    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
>> +
>> +    gen_get_gpr(base, rs1);
>> +    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
>> +    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
>> +
>> +    fn(dest, mask, base, cpu_env, desc);
>> +
>> +    tcg_temp_free_ptr(dest);
>> +    tcg_temp_free_ptr(mask);
>> +    tcg_temp_free(base);
>> +    tcg_temp_free_i32(desc);
>> +    return true;
>> +}
>> +
>> +static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
>> +{
>> +    uint32_t data = 0;
>> +    gen_helper_ldst_us *fn;
>> +    static gen_helper_ldst_us * const fns[7][4] = {
>> +        { gen_helper_vlbff_v_b,  gen_helper_vlbff_v_h,
>> +          gen_helper_vlbff_v_w,  gen_helper_vlbff_v_d },
>> +        { NULL,                  gen_helper_vlhff_v_h,
>> +          gen_helper_vlhff_v_w,  gen_helper_vlhff_v_d },
>> +        { NULL,                  NULL,
>> +          gen_helper_vlwff_v_w,  gen_helper_vlwff_v_d },
>> +        { gen_helper_vleff_v_b,  gen_helper_vleff_v_h,
>> +          gen_helper_vleff_v_w,  gen_helper_vleff_v_d },
>> +        { gen_helper_vlbuff_v_b, gen_helper_vlbuff_v_h,
>> +          gen_helper_vlbuff_v_w, gen_helper_vlbuff_v_d },
>> +        { NULL,                  gen_helper_vlhuff_v_h,
>> +          gen_helper_vlhuff_v_w, gen_helper_vlhuff_v_d },
>> +        { NULL,                  NULL,
>> +          gen_helper_vlwuff_v_w, gen_helper_vlwuff_v_d }
>> +    };
>> +
>> +    fn =  fns[seq][s->sew];
>> +    if (fn == NULL) {
>> +        return false;
>> +    }
>> +
>> +    data = FIELD_DP32(data, VDATA, MLEN, s->mlen);
>> +    data = FIELD_DP32(data, VDATA, VM, a->vm);
>> +    data = FIELD_DP32(data, VDATA, LMUL, s->lmul);
>> +    data = FIELD_DP32(data, VDATA, NF, a->nf);
>> +    return ldff_trans(a->rd, a->rs1, data, fn, s);
>> +}
>> +
>> +GEN_VEXT_TRANS(vlbff_v, 0, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vlhff_v, 1, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vlwff_v, 2, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
>> +GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
>> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
>> index 35cb9f09b4..3841301b74 100644
>> --- a/target/riscv/vector_helper.c
>> +++ b/target/riscv/vector_helper.c
>> @@ -574,3 +574,114 @@ GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t,  idx_b, ste_b)
>>   GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t, idx_h, ste_h)
>>   GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t, idx_w, ste_w)
>>   GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t, idx_d, ste_d)
>> +
>> +/*
>> + *** unit-stride fault-only-fisrt load instructions
>> + */
>> +static inline void vext_ldff(void *vd, void *v0, target_ulong base,
>> +        CPURISCVState *env, uint32_t desc,
>> +        vext_ldst_elem_fn ldst_elem,
>> +        vext_ld_clear_elem clear_elem,
>> +        int mmuidx, uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    void *host;
>> +    uint32_t i, k, vl = 0;
>> +    uint32_t mlen = vext_mlen(desc);
>> +    uint32_t nf = vext_nf(desc);
>> +    uint32_t vm = vext_vm(desc);
>> +    uint32_t vlmax = vext_maxsz(desc) / esz;
>> +    target_ulong addr, offset, remain;
>> +
>> +    if (env->vl == 0) {
>> +        return;
>> +    }
>> +    /* probe every access*/
>> +    for (i = 0; i < env->vl; i++) {
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        addr = base + nf * i * msz;
>> +        if (i == 0) {
>> +            probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
>> +        } else {
>> +            /* if it triggers an exception, no need to check watchpoint */
>> +            offset = -(addr | TARGET_PAGE_MASK);
> You can move this assign into the while loop below
>
>> +            remain = nf * msz;
>> +            while (remain > 0) {
>> +                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmuidx);
>> +                if (host) {
>> +#ifdef CONFIG_USER_ONLY
>> +                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
>> +                        vl = i;
>> +                        goto ProbeSuccess;
>> +                    }
>> +#else
>> +                    probe_pages(env, addr, nf * msz, ra, MMU_DATA_LOAD);
>> +#endif
>> +                } else {
>> +                    vl = i;
>> +                    goto ProbeSuccess;
>> +                }
>> +                if (remain <=  offset) {
>> +                    break;
>> +                }
>> +                remain -= offset;
>> +                addr += offset;
>> +                offset = -(addr | TARGET_PAGE_MASK);
> and then remove this
Good idea. Thanks.
I will move it next patch set.

Zhiwei
>
>> +            }
>> +        }
>> +    }
>> +ProbeSuccess:
>> +    /* load bytes from guest memory */
>> +    if (vl != 0) {
>> +        env->vl = vl;
>> +    }
>> +    for (i = 0; i < env->vl; i++) {
>> +        k = 0;
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        while (k < nf) {
>> +            target_ulong addr = base + (i * nf + k) * msz;
>> +            ldst_elem(env, addr, i + k * vlmax, vd, ra);
>> +            k++;
>> +        }
>> +    }
>> +    /* clear tail elements */
>> +    if (vl != 0) {
>> +        return;
>> +    }
>> +    for (k = 0; k < nf; k++) {
>> +        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
>> +    }
>> +}
>> +
>> +#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, MMUIDX, LOAD_FN, CLEAR_FN)  \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong base,              \
>> +        CPURISCVState *env, uint32_t desc)                            \
>> +{                                                                     \
>> +    vext_ldff(vd, v0, base, env, desc, LOAD_FN, CLEAR_FN, MMUIDX,     \
>> +        sizeof(ETYPE), sizeof(MTYPE), GETPC());                       \
>> +}
>> +GEN_VEXT_LDFF(vlbff_v_b,  int8_t,   int8_t,   MO_SB,   ldb_b,  clearb)
>> +GEN_VEXT_LDFF(vlbff_v_h,  int8_t,   int16_t,  MO_SB,   ldb_h,  clearh)
>> +GEN_VEXT_LDFF(vlbff_v_w,  int8_t,   int32_t,  MO_SB,   ldb_w,  clearl)
>> +GEN_VEXT_LDFF(vlbff_v_d,  int8_t,   int64_t,  MO_SB,   ldb_d,  clearq)
>> +GEN_VEXT_LDFF(vlhff_v_h,  int16_t,  int16_t,  MO_LESW, ldh_h,  clearh)
>> +GEN_VEXT_LDFF(vlhff_v_w,  int16_t,  int32_t,  MO_LESW, ldh_w,  clearl)
>> +GEN_VEXT_LDFF(vlhff_v_d,  int16_t,  int64_t,  MO_LESW, ldh_d,  clearq)
>> +GEN_VEXT_LDFF(vlwff_v_w,  int32_t,  int32_t,  MO_LESL, ldw_w,  clearl)
>> +GEN_VEXT_LDFF(vlwff_v_d,  int32_t,  int64_t,  MO_LESL, ldw_d,  clearq)
>> +GEN_VEXT_LDFF(vleff_v_b,  int8_t,   int8_t,   MO_SB,   lde_b,  clearb)
>> +GEN_VEXT_LDFF(vleff_v_h,  int16_t,  int16_t,  MO_LESW, lde_h,  clearh)
>> +GEN_VEXT_LDFF(vleff_v_w,  int32_t,  int32_t,  MO_LESL, lde_w,  clearl)
>> +GEN_VEXT_LDFF(vleff_v_d,  int64_t,  int64_t,  MO_LEQ,  lde_d,  clearq)
>> +GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t,  MO_UB,   ldbu_b, clearb)
>> +GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, MO_UB,   ldbu_h, clearh)
>> +GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, MO_UB,   ldbu_w, clearl)
>> +GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, MO_UB,   ldbu_d, clearq)
>> +GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, MO_LEUW, ldhu_h, clearh)
>> +GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, MO_LEUW, ldhu_w, clearl)
>> +GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, MO_LEUW, ldhu_d, clearq)
>> +GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, MO_LEUL, ldwu_w, clearl)
>> +GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, MO_LEUL, ldwu_d, clearq)
> Otherwise looks good.
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
>> --
>> 2.23.0
>>


