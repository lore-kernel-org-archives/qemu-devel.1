Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EEFC4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B102074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B102074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsvu-0004f7-2B
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kMsm8-0004hM-Uh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:01:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35066 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kMsm3-0000EF-IJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:01:04 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8E0D6C31EF5B88D17BD7;
 Mon, 28 Sep 2020 21:00:44 +0800 (CST)
Received: from [10.174.186.4] (10.174.186.4) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 28 Sep 2020 21:00:36 +0800
Subject: Re: [PATCH] migration/dirtyrate: present dirty rate only when
 querying the rate has completed
To: David Edmondson <david.edmondson@oracle.com>, <quintela@redhat.com>,
 <eblake@redhat.com>, <dgilbert@redhat.com>, <berrange@redhat.com>
References: <1601182520-130450-1-git-send-email-zhengchuan@huawei.com>
 <m2mu1af5uj.fsf@oracle.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <a4a04f59-a230-08f7-96bf-9518e0e0ee8b@huawei.com>
Date: Mon, 28 Sep 2020 21:00:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <m2mu1af5uj.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.4]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=zhengchuan@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:00:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: alex.chen@huawei.com, wanghao232@huawei.com, zhang.zhanghailiang@huawei.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/9/28 20:23, David Edmondson wrote:
> On Sunday, 2020-09-27 at 12:55:20 +08, Chuan Zheng wrote:
> 
>> Make dirty_rate field optional, present dirty rate only when querying
>> the rate has completed.
>> The qmp results is shown as follow:
>> @unstarted:
>> {"return":{"status":"unstarted","start-time":0,"calc-time":0},"id":"libvirt-12"}
>> @measuring:
>> {"return":{"status":"measuring","start-time":0,"calc-time":0},"id":"libvirt-14"}
> 
> Not this patch, but the "measuring" state could include both the
> start-time and the calc-time, allowing a caller to determine when they
> should expect to come back looking for a result.
> 
Hi, David.
Yes, maybe we should record start-time and calc-time in reset_dirtyrate_stat() and move it forward just after
setting CalculatingState status succeed in get_dirtyrate_thread.

>> @measured:
>> {"return":{"status":"measured","dirty-rate":4,"start-time":150146,"calc-time":1},"id":"libvirt-15"}
>>
>> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> 
> With the minor wording changes below...
> 
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> 
>> ---
>>  migration/dirtyrate.c | 3 +--
>>  qapi/migration.json   | 9 ++++-----
>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> index 68577ef..9024b0f 100644
>> --- a/migration/dirtyrate.c
>> +++ b/migration/dirtyrate.c
>> @@ -69,9 +69,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
>>      struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
>>  
>>      if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
>> +        info->has_dirty_rate = true;
>>          info->dirty_rate = dirty_rate;
>> -    } else {
>> -        info->dirty_rate = -1;
>>      }
>>  
>>      info->status = CalculatingState;
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index ce2216c..6e428f7 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1743,10 +1743,9 @@
>>  #
>>  # Information about current dirty page rate of vm.
>>  #
>> -# @dirty-rate: @dirtyrate describing the dirty page rate of vm
>> -#          in units of MB/s.
>> -#          If this field returns '-1', it means querying has not
>> -#          yet started or completed.
>> +# @dirty-rate: dirty-rate describing the dirty page rate of vm
>> +#              in units of MB/s, present only when querying the
>> +#              rate has completed.
> 
> How about:
> 
> @dirty-rate: an estimate of the dirty page rate of the VM in units of
> 	     MB/s, present only when estimating the rate has completed.
> 
That's better, thanks.

>>  #
>>  # @status: status containing dirtyrate query status includes
>>  #          'unstarted' or 'measuring' or 'measured'
>> @@ -1759,7 +1758,7 @@
>>  #
>>  ##
>>  { 'struct': 'DirtyRateInfo',
>> -  'data': {'dirty-rate': 'int64',
>> +  'data': {'*dirty-rate': 'int64',
>>             'status': 'DirtyRateStatus',
>>             'start-time': 'int64',
>>             'calc-time': 'int64'} }
>> -- 
>> 1.8.3.1
> 
> dme.
> 

