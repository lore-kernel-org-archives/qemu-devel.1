Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A30C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01022177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01022177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBD38-0000C4-UY
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBD1p-0007WK-7V
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:13:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4657 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kBD1m-0003Di-0T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:13:00 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AF4F1B516FCFAB544C7F;
 Thu, 27 Aug 2020 16:12:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.4) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 16:12:43 +0800
Subject: Re: [PATCH v5 09/12] migration/dirtyrate: Implement
 get_sample_page_period() and block_sample_page_period()
From: Zheng Chuan <zhengchuan@huawei.com>
To: David Edmondson <dme@dme.org>, <quintela@redhat.com>, <eblake@redhat.com>, 
 <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-10-git-send-email-zhengchuan@huawei.com>
 <m23649lni4.fsf@dme.org> <c044b58d-a211-9494-70f1-2648c7891576@huawei.com>
Message-ID: <350d1f93-dcb2-dbbb-24eb-5063d2787dcc@huawei.com>
Date: Thu, 27 Aug 2020 16:12:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c044b58d-a211-9494-70f1-2648c7891576@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:12:47
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



On 2020/8/27 16:01, Zheng Chuan wrote:
> 
> 
> On 2020/8/26 18:17, David Edmondson wrote:
>> On Monday, 2020-08-24 at 17:14:37 +08, Chuan Zheng wrote:
>>
>>> Implement get_sample_page_period() and set_sample_page_period() to
>>> sleep specific time between sample actions.
>>>
>>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>>> ---
>>>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>>>  migration/dirtyrate.h |  2 ++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>>> index bd398b7..d1c0a78 100644
>>> --- a/migration/dirtyrate.c
>>> +++ b/migration/dirtyrate.c
>>> @@ -28,6 +28,30 @@
>>>  static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
>>>  static struct DirtyRateStat DirtyStat;
>>>  
>>> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time)
>>> +{
>>> +    int64_t current_time;
>>> +
>>> +    current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>> +    if ((current_time - initial_time) >= msec) {
>>> +        msec = current_time - initial_time;
>>> +    } else {
>>> +        g_usleep((msec + initial_time - current_time) * 1000);
>>> +    }
>>> +
>>> +    return msec;
>>> +}
>>> +
>>> +static int64_t get_sample_page_period(int64_t sec)
>>> +{
>>> +    if (sec <= MIN_FETCH_DIRTYRATE_TIME_SEC ||
>>
>> Shouldn't the minimum value be allowed?
>>
>> That is, this test should be "sec < MIN_FETCH_DIRTYRATE_TIME_SEC" and
>> MIN_FETCH_DIRTYRATE_TIME_SEC should be 1.
>>
> Well, Actually we could measure dirtyrate within duration below 1s, like 0.5s.
> Howerver, I am reconsider that maybe taking 0.5s as MIN_FETCH_DIRTYRATE_TIME_SEC is better in case of someone to do nasty thing like setting
> a meaningless time duration which is close to 0:)
> 
Ouch, since i define sec as int64_t，it could never be 0.5s:-).
I will take 1s as minimum value because it will take about 100ms for large vm to hash its result.
Thanks for your review.

>>> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
>>> +        sec = DEFAULT_FETCH_DIRTYRATE_TIME_SEC;
>>> +    }
>>> +
>>> +    return sec;
>>> +}
>>> +
>>>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>>>  {
>>>      assert(new_state < DIRTY_RATE_STATUS__MAX);
>>> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
>>> index 41bc264..50a5636 100644
>>> --- a/migration/dirtyrate.h
>>> +++ b/migration/dirtyrate.h
>>> @@ -51,6 +51,8 @@
>>>  
>>>  /* Take 1s as default for calculation duration */
>>>  #define DEFAULT_FETCH_DIRTYRATE_TIME_SEC          1
>>> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              0
>>> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
>>>  
>>>  struct DirtyRateConfig {
>>>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>>> -- 
>>> 1.8.3.1
>>
>> dme.
>>


