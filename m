Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60A9C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EA5221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EA5221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDFyX-0005UQ-SZ
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDFxq-00053K-5J
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDFxo-0004dM-FT
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:13:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39675)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDFxo-0004N8-3t; Sat, 14 Mar 2020 19:13:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07534365|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.00105651-2.04243e-05-0.998923;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H.Yz2uD_1584227575; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H.Yz2uD_1584227575)
 by smtp.aliyun-inc.com(10.147.44.129);
 Sun, 15 Mar 2020 07:12:55 +0800
Subject: Re: [PATCH v5 24/60] target/riscv: vector single-width averaging add
 and subtract
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-25-zhiwei_liu@c-sky.com>
 <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
 <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <d48f77ee-ad99-26fa-a597-6cdcd2d55508@c-sky.com>
Date: Sun, 15 Mar 2020 07:12:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/14 16:25, Richard Henderson wrote:
> On 3/14/20 1:14 AM, Richard Henderson wrote:
>> I think you should have 4 versions of aadd8, for each of the rounding modes,
>>
>>> +RVVCALL(OPIVV2_ENV, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd8)
>> then use this, or something like it, to define 4 functions containing main
>> loops, which will get the helper above inlined.
> Alternately, a set of inlines, where a (constant) vxrm is passed down from above.

I am not sure whether I get it. In my opinion, the code should be modified like

static inline int8_t aadd8_rnu(CPURISCVState *env, int8_t a, int8_t b)
{
     int16_t res = (int16_t)a + (int16_t)b;
     uint8_t round = res & 0x1;
     res   = (res >> 1) + round;
     return res;
}

static inline int8_t aadd8_rne(CPURISCVState *env, int8_t a, int8_t b)
{
     int16_t res = (int16_t)a + (int16_t)b;
     uint8_t round = ((res & 0x3) == 0x3);
     res   = (res >> 1) + round;
     return res;
}

static inline int8_t aadd8_rdn(CPURISCVState *env, int8_t a, int8_t b)
{
     int16_t res = (int16_t)a + (int16_t)b;
     res   = (res >> 1);
     return res;
}

static inline int8_t aadd8_rod(CPURISCVState *env, int8_t a, int8_t b)
{
     int16_t res = (int16_t)a + (int16_t)b;
     uint8_t round = ((res & 0x3) == 0x1);
    res   = (res >> 1) + round;
     return res;
}

RVVCALL(OPIVV2_ENV, vaadd_vv_b_rnu, OP_SSS_B, H1, H1, H1, aadd8_rnu)
RVVCALL(OPIVV2_ENV, vaadd_vv_b_rne, OP_SSS_B, H1, H1, H1, aadd8_rne)
RVVCALL(OPIVV2_ENV, vaadd_vv_b_rdn, OP_SSS_B, H1, H1, H1, aadd8_rdn)
RVVCALL(OPIVV2_ENV, vaadd_vv_b_rod, OP_SSS_B, H1, H1, H1, aadd8_rod)

void do_vext_vv_env(void *vd, void *v0, void *vs1,
                     void *vs2, CPURISCVState *env, uint32_t desc,
                     uint32_t esz, uint32_t dsz,
                     opivv2_fn *fn, clear_fn *clearfn)
{
     uint32_t vlmax = vext_maxsz(desc) / esz;
     uint32_t mlen = vext_mlen(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t vl = env->vl;
     uint32_t i;
     for (i = 0; i < vl; i++) {
         if (!vm && !vext_elem_mask(v0, mlen, i)) {
             continue;
         }
         fn(vd, vs1, vs2, i, env);
     }
     if (i != 0) {
         clear_fn(vd, vl, vl * dsz,  vlmax * dsz);
     }
}

#define GEN_VEXT_VV_ENV(NAME, ESZ, DSZ, CLEAR_FN)         \
void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
                   void *vs2, CPURISCVState *env,          \
                   uint32_t desc)                          \
{                                                         \
     static opivv2_fn *fns[4] = {                          \
         NAME##_rnu, NAME##_rne,                           \
         NAME##_rdn, NAME##_rod                            \
     }                                                     \
     return do_vext_vv_env(vd, v0, vs1, vs2, env, desc,    \
                           ESZ, DSZ, fns[env->vxrm],       \
			  CLEAR_FN);                      \
}

Is it true?

Zhiwei

>> Then use a final outermost wrapper to select one of the 4 functions based on
>> env->vxrm.
> The outermost wrapper could look like
>
>      switch (env->vxrm) {
>      case 0:  somefunc(some, args, 0); break;
>      case 1:  somefunc(some, args, 1); break;
>      case 2:  somefunc(some, args, 2); break;
>      default: somefunc(some, args, 3); break;
>      }
>
> so that somefunc (and its subroutines) are expanded with a constant, and we
> switch on that constant at the outermost level.
>
>
> r~


