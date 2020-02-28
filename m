Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A274FC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782B2205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782B2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Yy8-0004n6-Ho
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 01:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7YxV-00043d-QX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7YxU-0004P2-Jl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:17:13 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:50518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j7YxU-0004N8-5i; Fri, 28 Feb 2020 01:17:12 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1105056|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.668689-0.00268013-0.328631;
 DS=CONTINUE|ham_system_inform|0.01643-0.000390589-0.983179;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GtZaCA3_1582870620; 
Received: from 192.168.43.249(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GtZaCA3_1582870620)
 by smtp.aliyun-inc.com(10.147.44.145);
 Fri, 28 Feb 2020 14:17:01 +0800
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
 <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
 <287bde05-421c-f49c-2404-fdee183c9e12@c-sky.com>
 <10e50ea8-7614-f094-a827-38ed09462f29@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <30622566-09d2-17b6-edc1-8726dce8cbd8@c-sky.com>
Date: Fri, 28 Feb 2020 14:16:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <10e50ea8-7614-f094-a827-38ed09462f29@linaro.org>
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



On 2020/2/28 11:33, Richard Henderson wrote:
> On 2/27/20 5:50 PM, LIU Zhiwei wrote:
>>> This is not what I had in mind, and looks wrong as well.
>>>
>>>      int idx = (index * mlen) / 64;
>>>      int pos = (index * mlen) % 64;
>>>      return (((uint64_t *)v0)[idx] >> pos) & 1;
>>>
>>> You also might consider passing log2(mlen), so the multiplication could be
>>> strength-reduced to a shift.
>> I don't think so. For example, when mlen is 8 bits and index is 0, it will
>> reduce to
>>
>> return (((uint64_t *)v0)[0]) & 1
>>
>> And it's not right.
>>
>> The right bit is first bit in vector register 0. And in host big endianess,
>> it will be  the first bit of the seventh byte.
> You've forgotten that we've just done an 8-byte big-endian load, which means
> that we *are* looking at the first bit of the byte at offset 7.
>
> It is right.
Yes, that's it.
>   
>>> You don't need to pass mlen, since it's
>> Yes.
> I finally remembered all of the bits that go into mlen and thought I had
> deleted that sentence -- apparently I only removed half.  ;-)
>
>
> r~


