Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217CCC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8E502145D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E502145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChj0-0007QL-3Z
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kChi0-0005kk-L4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:10:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4676 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kChhy-0000xJ-PV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:10:44 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DF633C797E7B8D6D9A63;
 Mon, 31 Aug 2020 19:10:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 31 Aug 2020
 19:10:32 +0800
Subject: Re: [PATCH v6 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598669577-76914-1-git-send-email-zhengchuan@huawei.com>
 <1598669577-76914-8-git-send-email-zhengchuan@huawei.com>
 <m23643chag.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <c878051f-4be9-3ede-0f3f-6752eddb3f94@huawei.com>
Date: Mon, 31 Aug 2020 19:10:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m23643chag.fsf@dme.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:10:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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
Cc: alex.chen@huawei.com, ann.zhuangyanying@huawei.com,
 zhang.zhanghailiang@huawei.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/31 17:10, David Edmondson wrote:
> On Saturday, 2020-08-29 at 10:52:52 +08, Chuan Zheng wrote:
> 
>> Compare page hash results for recorded sampled page.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index f4967fd..9cc2cbb 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -193,6 +193,69 @@ static int record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
>>      return 0;
>>  }
>>  
>> +static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
>> +{
>> +    uint32_t crc;
>> +    int i;
>> +
>> +    for (i = 0; i < info->sample_pages_count; i++) {
>> +        crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
>> +        if (crc != info->hash_result[i]) {
>> +            info->sample_dirty_count++;
>> +        }
>> +    }
>> +}
>> +
>> +static struct RamblockDirtyInfo *
>> +find_page_matched(RAMBlock *block, int count,
>> +                  struct RamblockDirtyInfo *infos)
>> +{
>> +    int i;
>> +    struct RamblockDirtyInfo *matched;
>> +
>> +    for (i = 0; i < count; i++) {
>> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (i == count) {
>> +        return NULL;
>> +    }
>> +
>> +    if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
>> +        infos[i].ramblock_pages !=
>> +            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
>> +        return NULL;
>> +    }
>> +
>> +    matched = &infos[i];
>> +
>> +    return matched;
>> +}
>> +
>> +static int compare_page_hash_info(struct RamblockDirtyInfo *info,
>> +                                  int block_index)
>> +{
>> +    struct RamblockDirtyInfo *block_dinfo = NULL;
>> +    RAMBlock *block = NULL;
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        block_dinfo = find_page_matched(block, block_index + 1, info);
>> +        if (block_dinfo == NULL) {
>> +            continue;
>> +        }
>> +        calc_page_dirty_rate(block_dinfo);
>> +        update_dirtyrate_stat(block_dinfo);
>> +    }
>> +
>> +    if (!DirtyStat.total_sample_count) {
> 
> total_sample_count isn't a boolean or pointer - comparing against 0
> would be clearer.
> OK, will fix it in V7

>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>>  {
>>      /* todo */
>> -- 
>> 1.8.3.1
> 
> dme.
> 


