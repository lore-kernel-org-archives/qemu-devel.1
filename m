Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ACCC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 14:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375FD20716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 14:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375FD20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jICh3-0000AH-Aj
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 10:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jICg6-0007hk-4l
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jICg4-0003sF-OM
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 10:43:13 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:35486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jICg4-0003hn-8J; Sat, 28 Mar 2020 10:43:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08220347|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.273993-0.000289021-0.725718;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6i7wTa_1585406580; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6i7wTa_1585406580) by smtp.aliyun-inc.com(10.147.40.7);
 Sat, 28 Mar 2020 22:43:01 +0800
Subject: Re: [PATCH v6 10/61] target/riscv: vector single-width integer add
 and subtract
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-11-zhiwei_liu@c-sky.com>
 <fa027bb9-1427-7c91-c60e-b22c04115c2f@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <49463664-5c32-ff20-63ec-f874790ac84c@c-sky.com>
Date: Sat, 28 Mar 2020 22:42:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fa027bb9-1427-7c91-c60e-b22c04115c2f@linaro.org>
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/28 7:54, Richard Henderson wrote:
> On 3/17/20 8:06 AM, LIU Zhiwei wrote:
>> +    if (a->vm && s->vl_eq_vlmax) {
>> +        gvec_fn(s->sew, vreg_ofs(s, a->rd),
>> +            vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
>> +            MAXSZ(s), MAXSZ(s));
> Indentation is off here.
Do you mean I should adjust the indentation for parameters in gvec_fn like

+    if (a->vm && s->vl_eq_vlmax) {
+        gvec_fn(s->sew, vreg_ofs(s, a->rd),
+                vreg_ofs(s, a->rs2), vreg_ofs(s, a->rs1),
+                MAXSZ(s), MAXSZ(s));

>> +static inline bool
>> +do_opivx_gvec(DisasContext *s, arg_rmrr *a, GVecGen2sFn *gvec_fn,
>> +              gen_helper_opivx *fn)
>> +{
>> +    if (!opivx_check(s, a)) {
>> +        return false;
>> +    }
>> +
>> +    if (a->vm && s->vl_eq_vlmax) {
>> +        TCGv_i64 src1 = tcg_temp_new_i64();
>> +        TCGv tmp = tcg_temp_new();
>> +
>> +        gen_get_gpr(tmp, a->rs1);
>> +        tcg_gen_ext_tl_i64(src1, tmp);
>> +        gvec_fn(s->sew, vreg_ofs(s, a->rd), vreg_ofs(s, a->rs2),
>> +                src1, MAXSZ(s), MAXSZ(s));
>> +
>> +        tcg_temp_free_i64(src1);
>> +        tcg_temp_free(tmp);
>> +        return true;
>> +    } else {
>> +        return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
>> +    }
>> +    return true;
>> +}
> This final return is unreachable, and I'm sure some static analyzer (e.g.
> Coverity) will complain.
>
> Since the if-then has a return, we can drop the else like so:
>
>      if (a->vm && s->vl_eq_vlmax) {
>          ...
>          return true;
>      }
>      return opivx_trans(a->rd, a->rs1, a->rs2, a->vm, fn, s);
Yes, it's tidier. Thanks.

Zhiwei
>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> r~


