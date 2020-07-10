Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94595C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD51206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 07:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD51206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtn4k-0002PG-P5
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 03:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jtn46-0001wg-KD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:03:22 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jtn43-0002qm-A2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 03:03:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09653334|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0905496-0.00455873-0.904892;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03278; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.I.T0lbu_1594364584; 
Received: from 30.225.208.52(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I.T0lbu_1594364584)
 by smtp.aliyun-inc.com(10.147.42.197);
 Fri, 10 Jul 2020 15:03:04 +0800
Subject: Re: [PATCH 0/6] target/riscv: NaN-boxing for multiple precison
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <6d2e6876-18a8-b32a-0879-565693b6d446@linaro.org>
 <3c139607-9cac-a28a-c296-b0e147b3b20f@c-sky.com>
 <53a00d93-be8b-6cc2-e091-215c71661453@c-sky.com>
 <0d484d59-ceeb-862b-4c44-e57065b914c0@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <2d2eb1ec-22fa-cf2c-9a45-ee954a23fa63@c-sky.com>
Date: Fri, 10 Jul 2020 15:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d484d59-ceeb-862b-4c44-e57065b914c0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 03:03:06
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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



On 2020/7/8 23:35, Richard Henderson wrote:
> On 7/7/20 2:45 PM, LIU Zhiwei wrote:
>>> On 2020/7/3 1:37, Richard Henderson wrote:
>>>> I think it would be better to do all of the nan-boxing work inside of the
>>>> helpers, including the return values.
>>> Do you mean a helper function just for nan-boxing work?
> No, that's not what I mean.
>
>>> I don't think so.
>>>
>>> The inputs are flushed to canonical NAN only when they are
>>> not legal nan-boxed values.
>>>
>>> The result is nan-boxed before writing  to  destination register.
>>>
>>> Both of them have some relations to nan-boxing, but they are not the same.
> I mean
>
> uint64_t helper_fadd_s(CPURISCVState *env, uint64_t frs1,
>                         uint64_t frs2)
> {
>      float32 in1 = check_nanbox(frs1);
>      float32 in2 = check_nanbox(frs2);
>      float32 res = float32_add(in1, in2, &env->fp_status);
>
>      return gen_nanbox(res);
> }
>
> I.e., always require nan-boxed inputs and return a nan-boxed output.
>
>>>> If, for RVF && !RVD, we always maintain the invariant that the values are
>>>> nanboxed anyway, then we do not even have to check for RVD at runtime.
>>> Do you mean if FMV.X.S and FLW are nan-boxed, then we will not get the
>>> invalid values？
> No, I mean that if !RVD, there is no way to put an unboxed value into the fp
> registers because...
>
>>> First, FMV.X.D can transfer any 64 bits value to float register.
>>> Second, users may set  invalid values  to float register by GDB.
> ... FMV.X.D does not exist for !RVD, nor does FLD.
>
> The check_nanbox test will always succeed for !RVD, so we do not need to check
> that RVD is set before performing check_nanbox.
>
> Because the check is inexpensive, and because we expect !RVD to be an unusual
> configuration, we do not bother to provide a second set of helpers that do not
> perform the nan-boxing.
Get it.

The comment is moving both inputs check and the result nan-boxing code 
to helper functions.

In my opinion, it doesn't matter whether put them into helper functions 
or into translation functions.
More importantly, we should add inputs check and result nan-boxing for 
all single float point instructions.

If you insist on we should move it to helper functions, I'd like to.:-)

Zhiwei
>
> r~


