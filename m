Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E880C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245DE206D7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245DE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAR6j-00035m-8D
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 23:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jAR64-0002cL-82
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 23:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jAR61-0005kf-Ic
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 23:29:54 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41645)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jAR60-0005Dd-17; Fri, 06 Mar 2020 23:29:52 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07448132|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0308801-0.000130499-0.968989;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16378; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GxPv1Mv_1583555381; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GxPv1Mv_1583555381)
 by smtp.aliyun-inc.com(10.147.41.138);
 Sat, 07 Mar 2020 12:29:42 +0800
Subject: Re: [PATCH v4 2/5] target/riscv: add vector stride load and store
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-3-zhiwei_liu@c-sky.com>
 <0e806ca9-7991-baf7-58d1-50cddf9ce4ef@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <3257fc99-8c07-550d-151e-0f88ab46840d@c-sky.com>
Date: Sat, 7 Mar 2020 12:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0e806ca9-7991-baf7-58d1-50cddf9ce4ef@linaro.org>
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



On 2020/2/28 3:36, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +GEN_VEXT_LD_ELEM(vlsb_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_h, int8_t,  int16_t, H2, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_w, int8_t,  int32_t, H4, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_d, int8_t,  int64_t, H8, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsh_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsh_v_w, int16_t, int32_t, H4, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsh_v_d, int16_t, int64_t, H8, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsw_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlsw_v_d, int32_t, int64_t, H8, ldl)
>> +GEN_VEXT_LD_ELEM(vlse_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vlse_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vlse_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlse_v_d, int64_t, int64_t, H8, ldq)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_b, uint8_t,  uint8_t,  H1, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_h, uint8_t,  uint16_t, H2, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_w, uint8_t,  uint32_t, H4, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_d, uint8_t,  uint64_t, H8, ldub)
>> +GEN_VEXT_LD_ELEM(vlshu_v_h, uint16_t, uint16_t, H2, lduw)
>> +GEN_VEXT_LD_ELEM(vlshu_v_w, uint16_t, uint32_t, H4, lduw)
>> +GEN_VEXT_LD_ELEM(vlshu_v_d, uint16_t, uint64_t, H8, lduw)
>> +GEN_VEXT_LD_ELEM(vlswu_v_w, uint32_t, uint32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlswu_v_d, uint32_t, uint64_t, H8, ldl)
> Why do you need to define new functions identical to the old ones?  Are you
> doing this just to make the names match up?
>
>
>> +GEN_VEXT_ST_ELEM(vssb_v_b, int8_t,  H1, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_h, int16_t, H2, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_w, int32_t, H4, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_d, int64_t, H8, stb)
>> +GEN_VEXT_ST_ELEM(vssh_v_h, int16_t, H2, stw)
>> +GEN_VEXT_ST_ELEM(vssh_v_w, int32_t, H4, stw)
>> +GEN_VEXT_ST_ELEM(vssh_v_d, int64_t, H8, stw)
>> +GEN_VEXT_ST_ELEM(vssw_v_w, int32_t, H4, stl)
>> +GEN_VEXT_ST_ELEM(vssw_v_d, int64_t, H8, stl)
>> +GEN_VEXT_ST_ELEM(vsse_v_b, int8_t,  H1, stb)
>> +GEN_VEXT_ST_ELEM(vsse_v_h, int16_t, H2, stw)
>> +GEN_VEXT_ST_ELEM(vsse_v_w, int32_t, H4, stl)
>> +GEN_VEXT_ST_ELEM(vsse_v_d, int64_t, H8, stq)
> Likewise.
>
>> +static void vext_st_stride(void *vd, void *v0, target_ulong base,
>> +        target_ulong stride, CPURISCVState *env, uint32_t desc,
>> +        vext_st_elem_fn st_elem, uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    uint32_t i, k;
>> +    uint32_t nf = vext_nf(desc);
>> +    uint32_t vm = vext_vm(desc);
>> +    uint32_t mlen = vext_mlen(desc);
>> +    uint32_t vlmax = vext_maxsz(desc) / esz;
>> +
>> +    /* probe every access*/
>> +    for (i = 0; i < env->vl; i++) {
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        probe_write_access(env, base + stride * i, nf * msz, ra);
>> +    }
>> +    /* store bytes to guest memory */
>> +    for (i = 0; i < env->vl; i++) {
>> +        k = 0;
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        while (k < nf) {
>> +            target_ulong addr = base + stride * i + k * msz;
>> +            st_elem(env, addr, i + k * vlmax, vd, ra);
>> +            k++;
>> +        }
>> +    }
>> +}
> Similar comments wrt unifying the load and store helpers.
>
> I'll also note that vext_st_stride and vext_st_us_mask could be unified by
> passing sizeof(ETYPE) as stride, and vm = true as a parameter.
Maybe it is msz * nf as stride.

For element index  i,  the base load memory address for stride load is 
"i * stride".
For unit stride load ,  the base load memory address is "i * nf * msz".

Zhiwei
>
> r~


