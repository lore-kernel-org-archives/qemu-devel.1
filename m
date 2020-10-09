Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64681C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892BD21527
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892BD21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQlfM-0003qb-GG
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kQleX-0003PQ-EV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:13:17 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kQleT-00063K-I1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:13:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07455379|-1; BR=01201311R541ec; CH=green;
 DM=|CONTINUE|false|; DS=AD|ad_normal|0.0135401-0.791964-0.194496;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047209; MF=zhiwei_liu@c-sky.com; NM=1;
 PH=DS; RN=3; RT=3; SR=0; TI=SMTPD_---.Igwxp3G_1602223981; 
Received: from 30.225.208.47(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Igwxp3G_1602223981)
 by smtp.aliyun-inc.com(10.147.41.137);
 Fri, 09 Oct 2020 14:13:02 +0800
Subject: Re: [PATCH v3 45/81] target/arm: Implement SVE2 HISTCNT, HISTSEG
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stephen Long <steplong@quicinc.com>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-46-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <46ba7fd1-cffb-f9e2-e727-c487b0531a12@c-sky.com>
Date: Fri, 9 Oct 2020 14:13:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918183751.2787647-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:13:03
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.214,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/19 2:37, Richard Henderson wrote:
> From: Stephen Long <steplong@quicinc.com>
>
> Signed-off-by: Stephen Long <steplong@quicinc.com>
> Message-Id: <20200416173109.8856-1-steplong@quicinc.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Fix overlap between output and input vectors.
> ---
>   target/arm/helper-sve.h    |   7 +++
>   target/arm/sve.decode      |   6 ++
>   target/arm/sve_helper.c    | 124 +++++++++++++++++++++++++++++++++++++
>   target/arm/translate-sve.c |  19 ++++++
>   4 files changed, 156 insertions(+)
>
> diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
> index 9e8641e1c0..34bbb767ef 100644
> --- a/target/arm/helper-sve.h
> +++ b/target/arm/helper-sve.h
> @@ -2551,6 +2551,13 @@ DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_b, TCG_CALL_NO_RWG,
>   DEF_HELPER_FLAGS_5(sve2_nmatch_ppzz_h, TCG_CALL_NO_RWG,
>                      i32, ptr, ptr, ptr, ptr, i32)
>   
> +DEF_HELPER_FLAGS_5(sve2_histcnt_s, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_5(sve2_histcnt_d, TCG_CALL_NO_RWG,
> +                   void, ptr, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(sve2_histseg, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
>   DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_h, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, ptr, i32)
>   DEF_HELPER_FLAGS_6(sve2_faddp_zpzz_s, TCG_CALL_NO_RWG,
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index 3121eabbf8..0edb72d4fb 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -146,6 +146,7 @@
>                   &rprrr_esz rn=%reg_movprfx
>   @rdn_pg_rm_ra   ........ esz:2 . ra:5  ... pg:3 rm:5 rd:5 \
>                   &rprrr_esz rn=%reg_movprfx
> +@rd_pg_rn_rm   ........ esz:2 . rm:5 ... pg:3 rn:5 rd:5       &rprr_esz
>   
>   # One register operand, with governing predicate, vector element size
>   @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
> @@ -1336,6 +1337,11 @@ RSUBHNT         01000101 .. 1 ..... 011 111 ..... .....  @rd_rn_rm
>   MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
>   NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
>   
> +### SVE2 Histogram Computation
> +
> +HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd_pg_rn_rm
> +HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
> +
>   ## SVE2 floating-point pairwise operations
>   
>   FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 19fbf94189..fa4848bc5c 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -7095,3 +7095,127 @@ DO_PPZZ_MATCH(sve2_nmatch_ppzz_b, MO_8, true)
>   DO_PPZZ_MATCH(sve2_nmatch_ppzz_h, MO_16, true)
>   
>   #undef DO_PPZZ_MATCH
> +
> +void HELPER(sve2_histcnt_s)(void *vd, void *vn, void *vm, void *vg,
> +                            uint32_t desc)
> +{
> +    ARMVectorReg scratch;
> +    intptr_t i, j;
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    uint32_t *d = vd, *n = vn, *m = vm;
> +    uint8_t *pg = vg;
> +
> +    if (d == n) {
> +        n = memcpy(&scratch, n, opr_sz);
> +        if (d == m) {
> +            m = n;
> +        }
> +    } else if (d == m) {
> +        m = memcpy(&scratch, m, opr_sz);
> +    }
> +
> +    for (i = 0; i < opr_sz; i += 4) {
> +        uint64_t count = 0;
> +        uint8_t pred;
> +
> +        pred = pg[H1(i >> 3)] >> (i & 7);
> +        if (pred & 1) {
> +            uint32_t nn = n[H4(i >> 2)];
> +
> +            for (j = 0; j <= i; j += 4) {
> +                pred = pg[H1(j >> 3)] >> (j & 7);
> +                if ((pred & 1) && nn == m[H4(j >> 2)]) {
> +                    ++count;
> +                }
> +            }
> +        }
> +        d[H4(i >> 2)] = count;
> +    }
> +}
> +
> +void HELPER(sve2_histcnt_d)(void *vd, void *vn, void *vm, void *vg,
> +                            uint32_t desc)
> +{
> +    ARMVectorReg scratch;
> +    intptr_t i, j;
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    uint64_t *d = vd, *n = vn, *m = vm;
> +    uint8_t *pg = vg;
> +
> +    if (d == n) {
> +        n = memcpy(&scratch, n, opr_sz);
> +        if (d == m) {
> +            m = n;
> +        }
> +    } else if (d == m) {
> +        m = memcpy(&scratch, m, opr_sz);
> +    }
> +
> +    for (i = 0; i < opr_sz / 8; ++i) {
> +        uint64_t count = 0;
> +        if (pg[H1(i)] & 1) {
> +            uint64_t nn = n[i];
> +            for (j = 0; j <= i; ++j) {
> +                if ((pg[H1(j)] & 1) && nn == m[j]) {
> +                    ++count;
> +                }
> +            }
> +        }
> +        d[i] = count;
> +    }
> +}
> +
> +/*
> + * Returns the number of bytes in m0 and m1 that match n.
> + * See comment for do_match2().
> + * */
> +static inline uint64_t do_histseg_cnt(uint8_t n, uint64_t m0, uint64_t m1)
> +{
> +    int esz = MO_8;
> +    int bits = 8 << esz;
> +    uint64_t ones = dup_const(esz, 1);
> +    uint64_t signs = ones << (bits - 1);
> +    uint64_t cmp0, cmp1;
> +
> +    cmp1 = dup_const(esz, n);
> +    cmp0 = cmp1 ^ m0;
> +    cmp1 = cmp1 ^ m1;
> +    cmp0 = (cmp0 - ones) & ~cmp0 & signs;
> +    cmp1 = (cmp1 - ones) & ~cmp1 & signs;
> +
Hi Richard,

Although we can detect zero byte with this method, we can't use it to 
count the zero bytes.

For example,
IF
     cmp1 =  0x0100010001000100 , ones = 0x101010101010101, signs = 
0x8080808080808080,
THEN
     cmp1 = (cmp1 - ones) & ~cmp1 & signs = 0x8080808080808080
So
     cmp1 will have 6 zeros by this method. In fact, cmp1 only have 4 
zeros instead of 6 zeros.

I don't  find  a "bit twiddling" way,  if you find it, please let me know.

Best Regards,
Zhiwei
> +    /*
> +     * Combine the two compares in a way that the bits do
> +     * not overlap, and so preserves the count of set bits.
> +     * If the host has an efficient instruction for ctpop,
> +     * then ctpop(x) + ctpop(y) has the same number of
> +     * operations as ctpop(x | (y >> 1)).  If the host does
> +     * not have an efficient ctpop, then we only want to
> +     * use it once.
> +     */
> +    return ctpop64(cmp0 | (cmp1 >> 1));
> +}
> +
> +void HELPER(sve2_histseg)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t i, j;
> +    intptr_t opr_sz = simd_oprsz(desc);
> +
> +    for (i = 0; i < opr_sz; i += 16) {
> +        uint64_t n0 = *(uint64_t *)(vn + i);
> +        uint64_t m0 = *(uint64_t *)(vm + i);
> +        uint64_t n1 = *(uint64_t *)(vn + i + 8);
> +        uint64_t m1 = *(uint64_t *)(vm + i + 8);
> +        uint64_t out0 = 0;
> +        uint64_t out1 = 0;
> +
> +        for (j = 0; j < 64; j += 8) {
> +            uint64_t cnt0 = do_histseg_cnt(n0 >> j, m0, m1);
> +            uint64_t cnt1 = do_histseg_cnt(n1 >> j, m0, m1);
> +            out0 |= cnt0 << j;
> +            out1 |= cnt1 << j;
> +        }
> +
> +        *(uint64_t *)(vd + i) = out0;
> +        *(uint64_t *)(vd + i + 8) = out1;
> +    }
> +}
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index e947a0ff25..4e792c9b9a 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -7509,6 +7509,25 @@ static bool trans_##NAME(DisasContext *s, arg_rprr_esz *a)                  \
>   DO_SVE2_PPZZ_MATCH(MATCH, match)
>   DO_SVE2_PPZZ_MATCH(NMATCH, nmatch)
>   
> +static bool trans_HISTCNT(DisasContext *s, arg_rprr_esz *a)
> +{
> +    static gen_helper_gvec_4 * const fns[2] = {
> +        gen_helper_sve2_histcnt_s, gen_helper_sve2_histcnt_d
> +    };
> +    if (a->esz < 2) {
> +        return false;
> +    }
> +    return do_sve2_zpzz_ool(s, a, fns[a->esz - 2]);
> +}
> +
> +static bool trans_HISTSEG(DisasContext *s, arg_rrr_esz *a)
> +{
> +    if (a->esz != 0) {
> +        return false;
> +    }
> +    return do_sve2_zzz_ool(s, a, gen_helper_sve2_histseg);
> +}
> +
>   static bool do_sve2_zpzz_fp(DisasContext *s, arg_rprr_esz *a,
>                               gen_helper_gvec_4_ptr *fn)
>   {


