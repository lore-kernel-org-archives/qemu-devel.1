Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9078AC10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BA2206D5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BA2206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jARDU-0004Kx-FX
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 23:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jARCo-0003sp-R5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 23:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jARCn-000410-0f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 23:36:54 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60689)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jARCm-0003vK-LC; Fri, 06 Mar 2020 23:36:52 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436282|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.128998-0.000226695-0.870775;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GxQEFs0_1583555804; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GxQEFs0_1583555804)
 by smtp.aliyun-inc.com(10.147.41.187);
 Sat, 07 Mar 2020 12:36:45 +0800
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
 <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <a225d9e7-f7ee-71c4-db90-cc27f25470ed@c-sky.com>
Date: Sat, 7 Mar 2020 12:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/28 3:17, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
>> +{
>> +    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
>> +
>> +    return !((s->lmul == 0x3 && widen) || (reg % legal));
>> +}
>> +
>> +static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
>> +{
>> +    return !(s->lmul > 1 && vm == 0 && vd == 0);
>> +}
>> +
>> +static bool vext_check_nf(DisasContext *s, uint32_t nf)
>> +{
>> +    return s->lmul * (nf + 1) <= 8;
>> +}
> Some commentary would be good here, quoting the rule being applied.  E.g. "The
> destination vector register group for a masked vector instruction can only
> overlap the source mask regis-
> ter (v0) when LMUL=1. (Section 5.3)"
>
>> +static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
>> +{
>> +    uint8_t nf = a->nf + 1;
> Perhaps NF should have the +1 done during decode, so that it cannot be
> forgotten here or elsewhere.  E.g.
>
> %nf      31:3  !function=ex_plus_1
> @r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... \
>           &r2nfvm %nf %rs1 %rd
>
> Where ex_plus_1 is the obvious modification of ex_shift_1().
>
>> +static inline uint32_t vext_nf(uint32_t desc)
>> +{
>> +    return (simd_data(desc) >> 11) & 0xf;
>> +}
>> +
>> +static inline uint32_t vext_mlen(uint32_t desc)
>> +{
>> +    return simd_data(desc) & 0xff;
>> +}
>> +
>> +static inline uint32_t vext_vm(uint32_t desc)
>> +{
>> +    return (simd_data(desc) >> 8) & 0x1;
>> +}
>> +
>> +static inline uint32_t vext_lmul(uint32_t desc)
>> +{
>> +    return (simd_data(desc) >> 9) & 0x3;
>> +}
> You should use FIELD() to define the fields, and then use FIELD_EX32 and
> FIELD_DP32 to reference them.
I define fields shared between vector helpers and decode code.
FIELD(VDATA, MLEN, 0, 8)
FIELD(VDATA, VM, 8, 1)
FIELD(VDATA, LMUL, 9, 2)
FIELD(VDATA, NF， 11， 4）

But I can't find a  good place to place the fields. There is not a 
"translate.h" in target/riscv.
  Is cpu.h OK？

Zhiwei
>> +/*
>> + * This function checks watchpoint before real load operation.
>> + *
>> + * In softmmu mode, the TLB API probe_access is enough for watchpoint check.
>> + * In user mode, there is no watchpoint support now.
>> + *
>> + * It will triggle an exception if there is no mapping in TLB
> trigger.
>
>> + * and page table walk can't fill the TLB entry. Then the guest
>> + * software can return here after process the exception or never return.
>> + */
>> +static void probe_read_access(CPURISCVState *env, target_ulong addr,
>> +        target_ulong len, uintptr_t ra)
>> +{
>> +    while (len) {
>> +        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
>> +        const target_ulong curlen = MIN(pagelen, len);
>> +
>> +        probe_read(env, addr, curlen, cpu_mmu_index(env, false), ra);
>> +        addr += curlen;
>> +        len -= curlen;
>> +    }
>> +}
>> +
>> +static void probe_write_access(CPURISCVState *env, target_ulong addr,
>> +        target_ulong len, uintptr_t ra)
>> +{
>> +    while (len) {
>> +        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
>> +        const target_ulong curlen = MIN(pagelen, len);
>> +
>> +        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
>> +        addr += curlen;
>> +        len -= curlen;
>> +    }
>> +}
> A loop is overkill -- the access cannot span to 3 pages.  These two functions
> can be merged using probe_access and MMU_DATA_{LOAD,STORE}.
>
>> +
>> +#ifdef HOST_WORDS_BIGENDIAN
>> +static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
>> +{
>> +    /*
>> +     * Split the remaining range to two parts.
>> +     * The first part is in the last uint64_t unit.
>> +     * The second part start from the next uint64_t unit.
>> +     */
>> +    int part1 = 0, part2 = tot - cnt;
>> +    if (cnt % 64) {
>> +        part1 = 64 - (cnt % 64);
>> +        part2 = tot - cnt - part1;
>> +        memset(tail & ~(63ULL), 0, part1);
>> +        memset((tail + 64) & ~(63ULL), 0, part2);
> You're confusing bit and byte offsets -- cnt and tot are both byte offsets.
>
>> +static inline int vext_elem_mask(void *v0, int mlen, int index)
>> +{
>> +
>> +    int idx = (index * mlen) / 8;
>> +    int pos = (index * mlen) % 8;
>> +
>> +    switch (mlen) {
>> +    case 8:
>> +        return *((uint8_t *)v0 + H1(index)) & 0x1;
>> +    case 16:
>> +        return *((uint16_t *)v0 + H2(index)) & 0x1;
>> +    case 32:
>> +        return *((uint32_t *)v0 + H4(index)) & 0x1;
>> +    case 64:
>> +        return *((uint64_t *)v0 + index) & 0x1;
>> +    default:
>> +        return (*((uint8_t *)v0 + H1(idx)) >> pos) & 0x1;
>> +    }
> This is not what I had in mind, and looks wrong as well.
>
>      int idx = (index * mlen) / 64;
>      int pos = (index * mlen) % 64;
>      return (((uint64_t *)v0)[idx] >> pos) & 1;
>
> You also might consider passing log2(mlen), so the multiplication could be
> strength-reduced to a shift.
>
>> +#define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)              \
>> +static void vext_##NAME##_ld_elem(CPURISCVState *env, abi_ptr addr, \
>> +        uint32_t idx, void *vd, uintptr_t retaddr)                  \
>> +{                                                                   \
>> +    int mmu_idx = cpu_mmu_index(env, false);                        \
>> +    MTYPE data;                                                     \
>> +    ETYPE *cur = ((ETYPE *)vd + H(idx));                            \
>> +    data = cpu_##LDSUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);    \
>> +    *cur = data;                                                    \
>> +}                                                                   \
> If you're going to use cpu_mmu_index, you might as well use cpu_SUFF_data_ra(),
> which does not require the mmu_idx parameter.
>
>> +#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
>> +static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
>> +        uint32_t idx, void *vd, uintptr_t retaddr)                    \
>> +{                                                                     \
>> +    int mmu_idx = cpu_mmu_index(env, false);                          \
>> +    ETYPE data = *((ETYPE *)vd + H(idx));                             \
>> +    cpu_##STSUF##_mmuidx_ra(env, addr, data, mmu_idx, retaddr);       \
>> +}
> Likewise.
>
>> +/*
>> + *** unit-stride: load vector element from continuous guest memory
>> + */
>> +static inline void vext_ld_us_mask(void *vd, void *v0, target_ulong base,
>> +        CPURISCVState *env, uint32_t desc,
>> +        vext_ld_elem_fn ld_elem,
>> +        vext_ld_clear_elem clear_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    uint32_t i, k;
>> +    uint32_t mlen = vext_mlen(desc);
> You don't need to pass mlen, since it's
>
>> +/* unit-stride: store vector element to guest memory */
>> +static void vext_st_us_mask(void *vd, void *v0, target_ulong base,
>> +        CPURISCVState *env, uint32_t desc,
>> +        vext_st_elem_fn st_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    uint32_t i, k;
>> +    uint32_t nf = vext_nf(desc);
>> +    uint32_t mlen = vext_mlen(desc);
>> +    uint32_t vlmax = vext_maxsz(desc) / esz;
>> +
>> +    /* probe every access*/
>> +    for (i = 0; i < env->vl; i++) {
>> +        if (!vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        probe_write_access(env, base + nf * i * msz, nf * msz, ra);
>> +    }
>> +    /* store bytes to guest memory */
>> +    for (i = 0; i < env->vl; i++) {
>> +        k = 0;
>> +        if (!vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        while (k < nf) {
>> +            target_ulong addr = base + (i * nf + k) * msz;
>> +            st_elem(env, addr, i + k * vlmax, vd, ra);
>> +            k++;
>> +        }
>> +    }
>> +}
> I'll note that vext_ld_us_mask and vext_st_us_mask are identical, except for:
>
> 1) probe_read/write_access (which I already suggested merging, using
> MMUAccessType),
>
> 2) the name of the ld_elem/st_elem variable (the function types are already
> identical), and
>
> 3) the clear loop at the end of the load (which could be conditional on
> clear_elem != NULL; after inlining, this should be optimized away).
>
>> +static void vext_st_us(void *vd, target_ulong base,
>> +        CPURISCVState *env, uint32_t desc,
>> +        vext_st_elem_fn st_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> Similarly.
>
>
> r~


