Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D20C35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954320731
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3954320731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWsWh-0000Cl-Da
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWsWA-00089S-5B
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:13:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3750 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1jWsW8-00025r-Lh
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:13:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 87760471C4CB50CEF83C;
 Fri,  8 May 2020 10:13:21 +0800 (CST)
Received: from [10.184.39.213] (10.184.39.213) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 10:13:14 +0800
Subject: Re: [PATCH] migration/rdma: fix a memleak on error path in
 rdma_start_incoming_migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200420102727.17339-1-pannengyuan@huawei.com>
 <20200424094657.GC3106@work-vm>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <bee9d208-2810-cf69-1247-52e1597d791d@huawei.com>
Date: Fri, 8 May 2020 10:13:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200424094657.GC3106@work-vm>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 22:13:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, euler.robot@huawei.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/24/2020 5:46 PM, Dr. David Alan Gilbert wrote:
> * Pan Nengyuan (pannengyuan@huawei.com) wrote:
>> 'rdma->host' is malloced in qemu_rdma_data_init, but forgot to free on the error
>> path in rdma_start_incoming_migration(), this patch fix that.
>>
>> The leak stack:
>> Direct leak of 2 byte(s) in 1 object(s) allocated from:
>>     #0 0x7fb7add18ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
>>     #1 0x7fb7ad0df1d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
>>     #2 0x7fb7ad0f8b32 in g_strdup (/lib64/libglib-2.0.so.0+0x6cb32)
>>     #3 0x55a0464a0f6f in qemu_rdma_data_init /mnt/sdb/qemu/migration/rdma.c:2647
>>     #4 0x55a0464b0e76 in rdma_start_incoming_migration /mnt/sdb/qemu/migration/rdma.c:4020
>>     #5 0x55a0463f898a in qemu_start_incoming_migration /mnt/sdb/qemu/migration/migration.c:365
>>     #6 0x55a0458c75d3 in qemu_init /mnt/sdb/qemu/softmmu/vl.c:4438
>>     #7 0x55a046a3d811 in main /mnt/sdb/qemu/softmmu/main.c:48
>>     #8 0x7fb7a8417872 in __libc_start_main (/lib64/libc.so.6+0x23872)
>>     #9 0x55a04536b26d in _start (/mnt/sdb/qemu/build/x86_64-softmmu/qemu-system-x86_64+0x286926d)
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Thanks,
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
>> ---
>>  migration/rdma.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index f61587891b..967fda5b0c 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -4056,6 +4056,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
>>      return;
>>  err:
>>      error_propagate(errp, local_err);
>> +    g_free(rdma->host);
>>      g_free(rdma);
>>      g_free(rdma_return_path);
>>  }
>> -- 
>> 2.18.2
>>

Oh, I'm sorry, this may cause a potential nullptr access when taking the first error branch in rdma_start_incoming_migration:

    rdma = qemu_rdma_data_init(host_port, &local_err);

    if (rdma == NULL) {
        goto err;
    }
    ...

Since it has applied, I will send a new patch to fix it.

> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> .
> 

