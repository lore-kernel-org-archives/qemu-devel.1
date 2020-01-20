Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF925C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A439F207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A439F207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSkj-0007oP-Py
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1itSk9-0007KH-UJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1itSk8-0000uZ-P0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:49:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2744 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1itSk4-0000rh-VW; Mon, 20 Jan 2020 03:49:05 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6DE9CE4C475D73C71C55;
 Mon, 20 Jan 2020 16:49:00 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 20 Jan
 2020 16:48:53 +0800
Subject: Re: [PATCH] backup-top: fix a memory leak in bdrv_backup_top_append()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>
References: <20200120074725.22948-1-pannengyuan@huawei.com>
 <74dad363-83df-9cc0-2b3f-58ed2f23f730@virtuozzo.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <9729023e-7d3a-bc52-7149-a949bb3187a2@huawei.com>
Date: Mon, 20 Jan 2020 16:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <74dad363-83df-9cc0-2b3f-58ed2f23f730@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/20/2020 4:38 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi Pan!
> 
> Better is to drop extra allocation. Correct patch already posted here:
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg05067.html
> 

Yes, it's better.

Thanks.

> 20.01.2020 10:47, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> top->opaque is aleardy malloced in bdrv_new_open_driver(), and then change
>> the pointer but without freeing it. It will cause a memory leak, the leak
>> stack is as follow:
>>
>> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>>    #0 0x7ff6f7be4970 (/lib64/libasan.so.5+0xef970)  ??:?
>>    #1 0x7ff6f723849d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
>>    #2 0x564c0d44caae (./x86_64-softmmu/qemu-system-x86_64+0x3b40aae)  /mnt/sdb/qemu/block.c:1289
>>    #3 0x564c0d44dbaf (./x86_64-softmmu/qemu-system-x86_64+0x3b41baf)  /mnt/sdb/qemu/block.c:1359
>>    #4 0x564c0d71618f (./x86_64-softmmu/qemu-system-x86_64+0x3e0a18f)  /mnt/sdb/qemu/block/backup-top.c:190
>>    #5 0x564c0d7001be (./x86_64-softmmu/qemu-system-x86_64+0x3df41be)  /mnt/sdb/qemu/block/backup.c:439
>>    #6 0x564c0c8ebef8 (./x86_64-softmmu/qemu-system-x86_64+0x2fdfef8)  /mnt/sdb/qemu/blockdev.c:3580
>>    #7 0x564c0c8ed0cb (./x86_64-softmmu/qemu-system-x86_64+0x2fe10cb)  /mnt/sdb/qemu/blockdev.c:3690
>>    #8 0x564c0c8ed177 (./x86_64-softmmu/qemu-system-x86_64+0x2fe1177)  /mnt/sdb/qemu/blockdev.c:3704
>>    #9 0x564c0d316388 (./x86_64-softmmu/qemu-system-x86_64+0x3a0a388)  /mnt/sdb/qemu/build/qapi/qapi-commands-block-core.c:439
>>    #10 0x564c0d7ff7fa (./x86_64-softmmu/qemu-system-x86_64+0x3ef37fa)  /mnt/sdb/qemu/qapi/qmp-dispatch.c:132
>>    #11 0x564c0d7ffcb8 (./x86_64-softmmu/qemu-system-x86_64+0x3ef3cb8)  /mnt/sdb/qemu/qapi/qmp-dispatch.c:175 (discriminator 4)
>>    #12 0x564c0d2704ef (./x86_64-softmmu/qemu-system-x86_64+0x39644ef)  /mnt/sdb/qemu/monitor/qmp.c:145
>>    #13 0x564c0d2712de (./x86_64-softmmu/qemu-system-x86_64+0x39652de)  /mnt/sdb/qemu/monitor/qmp.c:234 (discriminator 4)
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>   block/backup-top.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/backup-top.c b/block/backup-top.c
>> index 818d3f26b4..d565f05520 100644
>> --- a/block/backup-top.c
>> +++ b/block/backup-top.c
>> @@ -196,6 +196,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>>       }
>>   
>>       top->total_sectors = source->total_sectors;
>> +    g_free(top->opaque);
>>       top->opaque = state = g_new0(BDRVBackupTopState, 1);
>>   
>>       bdrv_ref(target);
>>
> 
> 

