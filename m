Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00638C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB05E2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB05E2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB8Fw-0006EI-1K
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 23:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kB8FM-0005mx-Rb
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 23:06:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49796 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kB8FK-0006xK-JN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 23:06:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BE1E33EB540013107354;
 Thu, 27 Aug 2020 11:06:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.46) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 11:06:19 +0800
Subject: Re: [PATCH 08/12] migration/colo: Plug memleaks in
 colo_process_incoming_thread
To: Li Qiang <liq3ea@gmail.com>
References: <20200814160241.7915-1-pannengyuan@huawei.com>
 <20200814160241.7915-9-pannengyuan@huawei.com>
 <CAKXe6SJfvxo8k+an27YkNP9aA-pQvNJ=CqDgxfw7DyCfE-GRBw@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <0f13b812-0248-3aad-ad9b-9a82a2f3e978@huawei.com>
Date: Thu, 27 Aug 2020 11:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJfvxo8k+an27YkNP9aA-pQvNJ=CqDgxfw7DyCfE-GRBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.46]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 23:06:29
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/26 20:37, Li Qiang wrote:
> Pan Nengyuan <pannengyuan@huawei.com> 于2020年8月14日周五 下午6:52写道：
>>
>> 'local_err' forgot to free in colo_process_incoming_thread error path.
>> Fix that.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> ---
>>  migration/colo.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/migration/colo.c b/migration/colo.c
>> index ea7d1e9d4e..17b5afc6b5 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -870,6 +870,7 @@ void *colo_process_incoming_thread(void *opaque)
>>      replication_start_all(REPLICATION_MODE_SECONDARY, &local_err);
>>      if (local_err) {
>>          qemu_mutex_unlock_iothread();
>> +        error_report_err(local_err);
>>          goto out;
>>      }
>>  #else
>> @@ -882,6 +883,7 @@ void *colo_process_incoming_thread(void *opaque)
>>      colo_send_message(mis->to_src_file, COLO_MESSAGE_CHECKPOINT_READY,
>>                        &local_err);
>>      if (local_err) {
>> +        error_report_err(local_err);
>>          goto out;
>>      }
>>
> 
> Could we arrange 'error_report_err' in 'out' label?
> Like this:
> 
> if (local_err) {
>     error_report_err(local_err);
> }

Similar to the other place in the same function, I didn't arrange them in 'out' label:

    while (mis->state == MIGRATION_STATUS_COLO) {
        colo_wait_handle_message(mis, fb, bioc, &local_err);
        if (local_err) {
            error_report_err(local_err);
            break;
        }

But I think it's a good idea to arrange them in 'out' label. I will change it.

Thanks.

> 
> Thanks,
> Li Qiang
> 
> 
> 
>> --
>> 2.18.2
>>
>>
> .
> 


