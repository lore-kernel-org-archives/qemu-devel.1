Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6BC206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 01:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6BC206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl0Jw-0000vI-5x
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 21:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jl0JM-0000Nn-BV; Mon, 15 Jun 2020 21:22:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49526 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jl0JK-0003Kt-3x; Mon, 15 Jun 2020 21:22:48 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E3BD2B692E6F6C204C76;
 Tue, 16 Jun 2020 09:22:36 +0800 (CST)
Received: from [10.173.221.230] (10.173.221.230) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 09:22:30 +0800
Subject: Re: [PATCH] migration: Count new_dirty instead of real_dirty
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>
References: <20200601040250.38324-1-zhukeqian1@huawei.com>
 <3205abb1-8e47-fc19-1213-ead621711291@huawei.com>
 <B2D15215269B544CADD246097EACE7474BD38EFD@DGGEMM528-MBX.china.huawei.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <33d07693-eb61-3ba1-b88b-c90bf10b8864@huawei.com>
Date: Tue, 16 Jun 2020 09:22:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7474BD38EFD@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhukeqian1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 21:22:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Wanghaibin \(D\)" <wanghaibin.wang@huawei.com>,
 Chao Fan <fanc.fnst@cn.fujitsu.com>,
 "Huangweidong \(C\)" <weidong.huang@huawei.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jay Zhou,

On 2020/6/15 19:50, Zhoujian (jay) wrote:
> Hi Keqian,
> 
>> -----Original Message-----
>> From: zhukeqian
>> Sent: Monday, June 15, 2020 11:19 AM
>> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Paolo Bonzini
>> <pbonzini@redhat.com>; Zhoujian (jay) <jianjay.zhou@huawei.com>
>> Cc: Juan Quintela <quintela@redhat.com>; Chao Fan <fanc.fnst@cn.fujitsu.com>;
>> Wanghaibin (D) <wanghaibin.wang@huawei.com>
>> Subject: Re: [PATCH] migration: Count new_dirty instead of real_dirty
>>
>> Hi Paolo and Jian Zhou,
>>
>> Do you have any suggestion on this patch?
>>
>> Thanks,
>> Keqian
>>
>> On 2020/6/1 12:02, Keqian Zhu wrote:
>>> DIRTY_LOG_INITIALLY_ALL_SET feature is on the queue. This fixs the
> 
> s/fixs/fixes
Thanks.
> 
>>> dirty rate calculation for this feature. After introducing this
>>> feature, real_dirty_pages is equal to total memory size at begining.
>>> This causing wrong dirty rate and false positive throttling.
> 
> I think it should be tested whether DIRTY_LOG_INITIALLY_ALL_SET is enabled
> in ram_init_bitmaps(maybe?) in order to be compatible with the old path.
Yeah, you are right ;-)

But after I tested old path yesterday, I found that the num_dirty_pages_period
becomes total ram size after log sync in ram_init_bitmaps. The reason is that
bitmap of ramblock is initialized to be all set, so old path counts them as dirty
by mistake.

This bug causes false positive throttling at the end of first ram save iteration,
even without our DIRTY_LOG_INITIALLY_ALL_SET feature.
> 
> Thanks,
> Jay Zhou
> 
>>>
>>> BTW, real dirty rate is not suitable and not very accurate.
>>>
>>> 1. For not suitable: We mainly concern on the relationship between
>>>    dirty rate and network bandwidth. Net increasement of dirty pages
>>>    makes more sense.
>>> 2. For not very accurate: With manual dirty log clear, some dirty pages
>>>    will be cleared during each peroid, our "real dirty rate" is less
>>>    than real "real dirty rate".
> 
I should correct these commit messages for reason above :-)
> 
> 
>>>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
[...]

Thanks,
Keqian

