Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59C0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9E6B206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 08:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E6B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Psn-0006zY-2W
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 04:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k5PsG-0006Yp-D4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:43:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42218 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1k5PsC-0003dz-K8
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:43:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 645DF1AAC9E31959AF76;
 Tue, 11 Aug 2020 16:42:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 16:42:46 +0800
Subject: Re: [RFC PATCH 5/8] migration/dirtyrate: Compare hash results for
 recorded ramblock
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1595646669-109310-1-git-send-email-zhengchuan@huawei.com>
 <1595646669-109310-6-git-send-email-zhengchuan@huawei.com>
 <20200804172901.GH2659@work-vm>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <1832934c-4aa1-3628-2bb4-8e517eca3a3c@huawei.com>
Date: Tue, 11 Aug 2020 16:42:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200804172901.GH2659@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:42:56
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



On 2020/8/5 1:29, Dr. David Alan Gilbert wrote:
> * Chuan Zheng (zhengchuan@huawei.com) wrote:
>> From: Zheng Chuan <zhengchuan@huawei.com>
>>
>> Compare hash results for recorded ramblock.
>>
>> Signed-off-by: Zheng Chuan <zhengchuan@huawei.com>
>> Signed-off-by: YanYing Zhang <ann.zhuangyanying@huawei.com>
>> ---
>>  migration/dirtyrate.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 45cfc91..7badc53 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -202,6 +202,83 @@ static int record_block_hash_info(struct dirtyrate_config config,
>>      return 0;
>>  }
>>  
>> +static int cal_block_dirty_rate(struct block_dirty_info *info)
>> +{
>> +    uint8_t *md = NULL;
>> +    size_t hash_len;
>> +    int i;
>> +    int ret = 0;
>> +
>> +    hash_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_MD5);
>> +    md = g_new0(uint8_t, hash_len);
> 
> Is 'hash_len' actually constant for a given algorithm, like MD5 ?
> i.e. can we just have a nice fixed size array?
> 
>> +    for (i = 0; i < info->sample_pages_count; i++) {
>> +        ret = get_block_vfn_hash(info, info->sample_page_vfn[i], &md, &hash_len);
>> +        if (ret < 0) {
>> +            goto out;
>> +        }
>> +
>> +        if (memcmp(md, info->hash_result + i * hash_len, hash_len) != 0) {
>> +            info->sample_dirty_count++;
> 
> When the page doesn't match, do we have to update info->hash_result with
> the new hash?   If the page is only modified once, and we catch it on
> this cycle, we wouldn't want to catch it next time around.
> 
For now, we only support calculate once for each qmp command, thus there is no need
to update it.

However, it is indeed in our plan to add support for calculate multiple times for each qmp command to enhance
dirty rate preciseness:)

>> +        }
>> +    }
>> +
>> +out:
>> +    g_free(md);
>> +    return ret;
>> +}
>> +
>> +static bool find_block_matched(RAMBlock *block, struct block_dirty_info *infos,
>> +                               int count, struct block_dirty_info **matched)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < count; i++) {
>> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (i == count) {
>> +        return false;
>> +    }
>> +
>> +    if (infos[i].block_addr != qemu_ram_get_host_addr(block) ||
>> +        infos[i].block_pages !=
>> +            (qemu_ram_get_used_length(block) >> DIRTYRATE_PAGE_SIZE_SHIFT)) {
> 
> How does this happen?
> 
>> +        return false;
>> +    }
>> +
>> +    *matched = &infos[i];
>> +    return true;
>> +}
>> +
>> +static int compare_block_hash_info(struct block_dirty_info *info, int block_index)
>> +{
>> +    struct block_dirty_info *block_dinfo = NULL;
>> +    RAMBlock *block = NULL;
>> +
>> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>> +        if (ram_block_skip(block) < 0) {
>> +            continue;
>> +        }
>> +        block_dinfo = NULL;
>> +        if (!find_block_matched(block, info, block_index + 1, &block_dinfo)) {
>> +            continue;
>> +        }
>> +        if (cal_block_dirty_rate(block_dinfo) < 0) {
>> +            return -1;
>> +        }
>> +        update_dirtyrate_stat(block_dinfo);
>> +    }
>> +    if (!dirty_stat.total_sample_count) {
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +
>>  static void calculate_dirtyrate(struct dirtyrate_config config, int64_t time)
>>  {
>>      /* todo */
>> -- 
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> .
> 


