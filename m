Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9024BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DCE20663
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DCE20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI7R-0000iW-IL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqI6R-0008DH-Hy; Tue, 30 Jun 2020 11:23:19 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqI6M-0008N7-61; Tue, 30 Jun 2020 11:23:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2817314|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0350566-0.00123636-0.963707;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03297; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HvHbvDN_1593530581; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvHbvDN_1593530581)
 by smtp.aliyun-inc.com(10.147.42.241);
 Tue, 30 Jun 2020 23:23:01 +0800
Subject: Re: [PATCH 1/2] tcg/tcg-op: Fix nonatomic_op load with MO_SIGN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200629130731.1080-1-zhiwei_liu@c-sky.com>
 <20200629130731.1080-2-zhiwei_liu@c-sky.com>
 <db9e632e-4fcc-2374-590f-4ea35d1adda6@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <467328c7-1c9d-e352-5a0b-b0a299e7ad70@c-sky.com>
Date: Tue, 30 Jun 2020 23:22:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <db9e632e-4fcc-2374-590f-4ea35d1adda6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:23:01
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/6/30 22:56, Richard Henderson wrote:
> On 6/29/20 6:07 AM, LIU Zhiwei wrote:
>> @@ -3189,7 +3189,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
>>   
>>       memop = tcg_canonicalize_memop(memop, 0, 0);
>>   
>> -    tcg_gen_qemu_ld_i32(t1, addr, idx, memop & ~MO_SIGN);
>> +    tcg_gen_qemu_ld_i32(t1, addr, idx, memop);
>>       gen(t2, t1, val);
>>       tcg_gen_qemu_st_i32(t2, addr, idx, memop);
>>   
>> @@ -3232,7 +3232,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
>>   
>>       memop = tcg_canonicalize_memop(memop, 1, 0);
>>   
>> -    tcg_gen_qemu_ld_i64(t1, addr, idx, memop & ~MO_SIGN);
>> +    tcg_gen_qemu_ld_i64(t1, addr, idx, memop);
>>       gen(t2, t1, val);
>>       tcg_gen_qemu_st_i64(t2, addr, idx, memop);
> This is insufficient for smin/smax -- we also need to extend the "val" input.

Do you mean we should call tcg_gen_ext_i64(val, val, memop) before 
gen(t2, t1, val) for do_nonatomic_op_i64?

I think it will be good if it doesn't have any other side effects.

Zhiwei
>
>
> r~


