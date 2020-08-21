Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF83207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF83207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93rW-0001yw-RI
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93qD-0000f6-GJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4263 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k93qB-00070t-H5
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:00:09 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 56555A07D81680628B15;
 Fri, 21 Aug 2020 18:00:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 21 Aug 2020
 17:59:58 +0800
From: Zheng Chuan <zhengchuan@huawei.com>
Subject: Re: [PATCH v3 09/10] migration/dirtyrate: Implement
 calculate_dirtyrate() function
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
 <1597634433-18809-10-git-send-email-zhengchuan@huawei.com>
 <20200820175722.GR2664@work-vm>
Message-ID: <b5edce1e-4237-b7f3-8ea3-61474da3e98c@huawei.com>
Date: Fri, 21 Aug 2020 17:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200820175722.GR2664@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:59:52
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



On 2020/8/21 1:57, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> Implement calculate_dirtyrate() function.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 4bbfcc3..041d0c6 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -184,6 +184,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>>  }
>>  
>> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, int count)
>> +{
>> +    int i;
>> +
>> +    if (!infos) {
>> +        return;
>> +    }
>> +
>> +    for (i = 0; i < count; i++) {
>> +        g_free(infos[i].sample_page_vfn);
>> +        g_free(infos[i].hash_result);
>> +    }
>> +    g_free(infos);
>> +}
>> +
>>  static struct RamblockDirtyInfo *
>>  alloc_ramblock_dirty_info(int *block_index,
>>                            struct RamblockDirtyInfo *block_dinfo)
>> @@ -341,8 +356,35 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>>  
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>> -    /* todo */
>> -    return;
>> +    struct RamblockDirtyInfo *block_dinfo = NULL;
>> +    int block_index = 0;
>> +    int64_t msec = 0;
>> +    int64_t initial_time;
>> +
>> +    rcu_register_thread();
>> +    reset_dirtyrate_stat();
>> +    initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> +    rcu_read_lock();
>> +    if (record_ramblock_hash_info(&block_dinfo, config, &block_index) < 0) {
>> +        goto out;
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    msec = config.sample_period_seconds * 1000;
>> +    msec = set_sample_page_period(msec, initial_time);
>> +
>> +    rcu_read_lock();
>> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
>> +        goto out;
>> +    }
>> +
>> +    update_dirtyrate(msec);
> 
> I think this is OK, so:
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> However, please try the following test,  set it to 60 seconds,
> start the dirty rate check, and in that time, shut the guest down
> (e.g. shutdown -h now in the guest) - what happens?
> 
> Dave
> 
It is ok when shutdown corcurrent with query dirtyrate, the get_dirtyrate
thread is terminated by qemu.

>> +
>> +out:
>> +    rcu_read_unlock();
>> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
>> +    rcu_unregister_thread();
>> +
>>  }
>>  
>>  void *get_dirtyrate_thread(void *arg)
>> -- 
>> 1.8.3.1
>>


