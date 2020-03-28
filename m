Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89B4C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A961F20716
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A961F20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIE6e-000127-T8
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 12:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIE5v-0000MD-PT
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jIE5t-0002yW-Fq
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:13:58 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60513)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jIE5s-0002rb-Vp; Sat, 28 Mar 2020 12:13:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.2579638|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0190046-0.000301582-0.980694;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03312; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6ju01._1585412024; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6ju01._1585412024)
 by smtp.aliyun-inc.com(10.147.42.253);
 Sun, 29 Mar 2020 00:13:45 +0800
Subject: Re: [PATCH v6 18/61] target/riscv: vector single-width integer
 multiply instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-19-zhiwei_liu@c-sky.com>
 <1a5900d9-dc26-04f2-74b2-0bada246a0e7@linaro.org>
 <8be612c0-4345-c1f2-3b82-73a9a1ea4133@c-sky.com>
 <53209745-9b54-00b3-2b1f-1271f0843021@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <5dabf936-6a4f-5d76-0d16-ff357d1ee376@c-sky.com>
Date: Sun, 29 Mar 2020 00:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <53209745-9b54-00b3-2b1f-1271f0843021@linaro.org>
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



On 2020/3/28 23:47, Richard Henderson wrote:
> On 3/28/20 8:17 AM, LIU Zhiwei wrote:
>>> Missed the improvement here.  See tcg_gen_mulsu2_i64.
>> Though I have not gotten the principle, the code in tcg_gen_mulsu2_i64 is much
>> tidier.
> Let A = signed operand,
>      B = unsigned operand
>      P = unsigned product
>
> If the sign bit A is set, then P is too large.
> In that case we subtract 2**64 * B to fix that:
>
>      HI_P -= (A < 0 ? B : 0)
>
> where the conditional is computed as (A >> 63) & B.

I think I get it.

LET  A = 2 ** 64  - X

THEN

X = 2 ** 64 - A
SIGNED_P = -X * B

if (A * B == P) then

(2 ** 64  - X) * B == P
2 **64 * B - X * B == P

-X *B == P - 2**64*B

HI_P -= (A < 0 ? B ：0）

Zhiwei
>
> r~


