Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F2322B47
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F2322B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBD6U-0002jL-OL
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBD5b-0001Xl-9w
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:16:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4272 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBD5X-0003g0-Rf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:16:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 7E05873DD17458A1FD82;
 Thu, 27 Aug 2020 16:16:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 16:16:33 +0800
Subject: Re: [PATCH v5 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-11-git-send-email-zhengchuan@huawei.com>
 <m2zh6hk8rf.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <0d7ec003-8248-5d82-8ca2-ac038b550065@huawei.com>
Date: Thu, 27 Aug 2020 16:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2zh6hk8rf.fsf@dme.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:09:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 18:21, David Edmondson wrote:
> On Monday, 2020-08-24 at 17:14:38 +08, Chuan Zheng wrote:
> 
>> Implement calculate_dirtyrate() function.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index d1c0a78..9f52f5f 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -171,6 +171,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
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
>> @@ -316,8 +331,34 @@ static int compare_page_hash_info(struct RamblockDirtyInfo *info,
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
> 
> Page dirtying that happens while acquiring the lock will not be
> accounted for, but is within the time window. Could we store the time
> after acquiring the lock?
> 
Yes, it would be better.
will fix in V6.

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
>> +
>> +out:
>> +    rcu_read_unlock();
> 
> Is it necessary to hold the lock across update_dirtyrate()?
> 
There is no need for that.
Will fix it in V6.

>> +    free_ramblock_dirty_info(block_dinfo, block_index + 1);
>> +    rcu_unregister_thread();
>>  }
>>  
>>  void *get_dirtyrate_thread(void *arg)
>> -- 
>> 1.8.3.1
> 
> dme.
> 


