Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099BFC3F2CE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 02:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D245A2469B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 02:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D245A2469B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7VA5-0003a6-1x
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 21:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7V9Y-00038W-J4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 21:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7V9X-0003us-Lp
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 21:13:24 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44411)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j7V9X-0003tk-7X; Thu, 27 Feb 2020 21:13:23 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1120611|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.14291-0.0101709-0.846919;
 DS=CONTINUE|ham_system_inform|0.0302222-0.00325334-0.966524;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03310; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GtTcBTv_1582855997; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GtTcBTv_1582855997)
 by smtp.aliyun-inc.com(10.147.43.95); Fri, 28 Feb 2020 10:13:18 +0800
Subject: Re: [PATCH v4 3/5] target/riscv: add vector index load and store
 instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-4-zhiwei_liu@c-sky.com>
 <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <fa363f84-33cd-5ca6-a3c7-383462665e84@c-sky.com>
Date: Fri, 28 Feb 2020 10:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/28 3:49, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
>> +vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
>> +vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
>> +vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
>> +vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
>> +vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
>> +vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
>> +vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
> These can be merged, with a comment, like
>
> # Vector ordered-indexed and unordered-indexed store insns.
> vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
>
> which means you don't need these:
Good.
>> +static bool trans_vsuxb_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxb_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxh_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxh_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxw_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxw_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxe_v(s, a);
>> +}
>> +static inline void vext_ld_index(void *vd, void *v0, target_ulong base,
>> +        void *vs2, CPURISCVState *env, uint32_t desc,
>> +        vext_get_index_addr get_index_addr,
>> +        vext_ld_elem_fn ld_elem,
>> +        vext_ld_clear_elem clear_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> Similar comment about merging vext_ld_index and vext_st_index.
Good idea. Thanks.

Zhiwei
>
> r~


