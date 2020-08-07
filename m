Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF3DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CF220866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CF220866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3vdi-0002El-Iw
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3vd7-0001o1-6S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 02:13:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4166 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k3vd4-000452-PQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 02:13:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8128E1198C186B948EAA;
 Fri,  7 Aug 2020 14:13:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 7 Aug 2020
 14:13:06 +0800
Subject: Re: [RFC PATCH 0/8] *** A Method for evaluating dirty page rate ***
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <20200804161902.GC2659@work-vm>
 <fdb4afcb-8c99-1a97-a211-5eaa0573398d@huawei.com>
 <20200806165811.GI2711@work-vm>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <d1758e94-df96-87ab-3b53-51b5290b97ab@huawei.com>
Date: Fri, 7 Aug 2020 14:13:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200806165811.GI2711@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:13:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/7 0:58, Dr. David Alan Gilbert wrote:
> * Zheng Chuan (zhengchuan@huawei.com) wrote:
>>
>>
>> On 2020/8/5 0:19, Dr. David Alan Gilbert wrote:
>>> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>>>> From: Zheng Chuan <zhengchuan@huawei.com>
>>>
>>> Hi,
>>>
>>>> Sometimes it is neccessary to evaluate dirty page rate before migration.
>>>> Users could decide whether to proceed migration based on the evaluation
>>>> in case of vm performance loss due to heavy workload.
>>>> Unlikey simulating dirtylog sync which could do harm on runnning vm,
>>>> we provide a sample-hash method to compare hash results for samping page.
>>>> In this way, it would have hardly no impact on vm performance.
>>>>
>>>> We evaluate the dirtypage rate on running vm.
>>>> The VM specifications for migration are as follows:
>>>> - VM use 4-K page;
>>>> - the number of VCPU is 32;
>>>> - the total memory is 32Gigabit;
>>>> - use 'mempress' tool to pressurize VM(mempress 4096 1024);
>>>>
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>> |                      |    dirtyrate    |
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>> | no mempress          |     4MB/s       |
>>>> ------------------------------------------
>>>> | mempress 4096 1024   |    1204MB/s     |
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>> | mempress 4096 4096   |    4000Mb/s     |
>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>
>>> This is quite neat; I know we've got other people who have asked
>>> for a similar feature!
>>> Have you tried to validate these numbers against a real migration - e.g.
>>> try setting mempress to dirty just under 1GByte/s and see if you can
>>> migrate it over a 10Gbps link?
>>>
>>> Dave
>>>
>> Hi, Dave.
>> Thank you for your review.
>>
>> Note that, the original intention is evaluating dirty rate before migration.
> 
> Right, but the reason you want to evaluate the dirty rate is, I guess,
> to figure out whether a migration is likely to coverge?
> 
Yes, in our practice, we use this feature to evaluate dirty rate before migration.
if the dirty rate is too high, users could consider do not migration in case of
migration failure and vm performance.
However, i think it could extend to use at all stages of migration which includes the migrating stage:)

>> However, I test dirty rate against a real migration over a bandwidth of 10Gps with various mempress, which shows as below:
>> ++++++++++++++++++++++++++++++++++++++++++
>> |                      |    dirtyrate    |
>> ++++++++++++++++++++++++++++++++++++++++++
>> | no mempress          |     8MB/s       |
>> ------------------------------------------
>> | mempress 4096 1024   |    1188MB/s     |
>> ++++++++++++++++++++++++++++++++++++++++++
>>
>> It looks still close to actual dirty rate:)
> 
> I don't quite understand that comparison you just gave.
> But what I was expecting was that a mempress that
> just fits teh ~1100MB/s is just the limit of what you can get down
> a 10Gbps link.
> 
> Dave
> 
Well, what i mean is that the comparison between before-migration and migrating stage under 10Gbps link,
the dirty-rate calculating by our method is very close.
We could use this method both at the stage of before-migration and migrating.

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
|                   |                          |    dirtyrate       |
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
| before migration  |   mempress 4096 1024     |     1204MB/s       |
--------------------------------------------------------------------
| migrating         |   mempress 4096 1024     |     1188MB/s       |
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

I am not sure if it is the comparison you want.
if not, please let me know and i'll supplement it in V2:)

>> Test results against a real migration will be posted in V2.
>>
>>>> Test dirtyrate by qmp command like this:
>>>> 1.  virsh qemu-monitor-command [vmname] '{"execute":"cal_dirty_rate", "arguments": {"value": [sampletime]}}'
>>>> 2.  virsh qemu-monitor-command [vmname] '{"execute":"get_dirty_rate"}'
>>>>
>>>> Further test dirtyrate by libvirt api like this:
>>>> virsh getdirtyrate [vmname] [sampletime]
>>>>
>>>> Zheng Chuan (8):
>>>>   migration/dirtyrate: Add get_dirtyrate_thread() function
>>>>   migration/dirtyrate: Add block_dirty_info to store dirtypage info
>>>>   migration/dirtyrate: Add dirtyrate statistics series functions
>>>>   migration/dirtyrate: Record hash results for each ramblock
>>>>   migration/dirtyrate: Compare hash results for recorded ramblock
>>>>   migration/dirtyrate: Implement get_sample_gap_period() and
>>>>     block_sample_gap_period()
>>>>   migration/dirtyrate: Implement calculate_dirtyrate() function
>>>>   migration/dirtyrate: Implement
>>>>     qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
>>>>
>>>>  migration/Makefile.objs |   1 +
>>>>  migration/dirtyrate.c   | 424 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  migration/dirtyrate.h   |  67 ++++++++
>>>>  qapi/migration.json     |  24 +++
>>>>  qapi/pragma.json        |   3 +-
>>>>  5 files changed, 518 insertions(+), 1 deletion(-)
>>>>  create mode 100644 migration/dirtyrate.c
>>>>  create mode 100644 migration/dirtyrate.h
>>>>
>>>> -- 
>>>> 1.8.3.1
>>>>
>>> --
>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>
>>>
>>> .
>>>
>>


