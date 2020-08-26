Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE862071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE862071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArvw-0003XK-Pg
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kArv8-0002g1-M9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:40:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4654 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kArv6-0008Np-35
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:40:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4CBEC4DA4C2DCC287681;
 Wed, 26 Aug 2020 17:40:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 17:40:23 +0800
Subject: Re: [PATCH v5 03/12] migration/dirtyrate: Add RamlockDirtyInfo to
 store sampled page info
To: David Edmondson <dme@dme.org>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-4-git-send-email-zhengchuan@huawei.com>
 <m2lfi1lpqj.fsf@dme.org>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <a689e7ed-c685-231d-e9f8-61cc2167a71f@huawei.com>
Date: Wed, 26 Aug 2020 17:40:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2lfi1lpqj.fsf@dme.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:40:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.602,
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



On 2020/8/26 17:29, David Edmondson wrote:
> On Monday, 2020-08-24 at 17:14:31 +08, Chuan Zheng wrote:
> 
>> Add RamlockDirtyInfo to store sampled page info of each ramblock.
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> ---
>>  migration/dirtyrate.h | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>> index 33669b7..70000da 100644
>> --- a/migration/dirtyrate.h
>> +++ b/migration/dirtyrate.h
>> @@ -19,6 +19,11 @@
>>   */
>>  #define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
>>  
>> +/*
>> + * Record ramblock idstr
>> + */
>> +#define RAMBLOCK_INFO_MAX_LEN                     256
>> +
>>  /* Take 1s as default for calculation duration */
>>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>>  
>> @@ -27,6 +32,19 @@ struct DirtyRateConfig {
>>      int64_t sample_period_seconds; /* time duration between two sampling */
>>  };
>>  
>> +/*
>> + * Store dirtypage info for each ramblock.
>> + */
>> +struct RamblockDirtyInfo {
>> +    char idstr[RAMBLOCK_INFO_MAX_LEN]; /* idstr for each ramblock */
>> +    uint8_t *ramblock_addr; /* base address of ramblock we measure */
>> +    uint64_t ramblock_pages; /* ramblock size in 4K-page */
> 
> It's probably a stupid question, but why not store a pointer to the
> RAMBlock rather than copying some of the details?
> 
>> +    uint64_t *sample_page_vfn; /* relative offset address for sampled page */
>> +    uint64_t sample_pages_count; /* count of sampled pages */
>> +    uint64_t sample_dirty_count; /* cout of dirty pages we measure */
> 
> "cout" -> "count"
> 
Hi, David.
Thank you for review.
Actually I have resent [PATCH V5], but it's my fault to forget to add resent tag which may lead to confusing.
In new patch series, this spell mistake is fixed.
Please refer to the newer patch series:)

>> +    uint32_t *hash_result; /* array of hash result for sampled pages */
>> +};
>> +
>>  void *get_dirtyrate_thread(void *arg);
>>  #endif
>>  
>> -- 
>> 1.8.3.1
> 
> dme.
> 


