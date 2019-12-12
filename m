Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C8FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D2222C4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D2222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifD2I-0000Wf-C2
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ifD1h-0008Vc-F4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ifD1g-0006t0-6u
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:12:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2224 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ifD1X-0006aV-7V
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:12:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1F2BC4122FC504586F5A;
 Thu, 12 Dec 2019 09:12:02 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 09:11:52 +0800
Subject: Re: [PATCH] vhost-user-test: fix a memory leak
To: Laurent Vivier <lvivier@redhat.com>, <thuth@redhat.com>,
 <pbonzini@redhat.com>
References: <1576025722-41720-1-git-send-email-pannengyuan@huawei.com>
 <42a2d54e-622a-2023-3d58-70dffa71027d@redhat.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <a29e8aeb-d15a-a3f6-a50c-25899d99983f@huawei.com>
Date: Thu, 12 Dec 2019 09:11:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <42a2d54e-622a-2023-3d58-70dffa71027d@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/11 15:48, Laurent Vivier wrote:
> On 11/12/2019 01:55, pannengyuan@huawei.com wrote:
>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>
>> Spotted by ASAN.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
>> ---
>>  tests/vhost-user-test.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
>> index 91ea373..54be931 100644
>> --- a/tests/vhost-user-test.c
>> +++ b/tests/vhost-user-test.c
>> @@ -717,6 +717,8 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
>>      guint64 size;
>>  
>>      if (!wait_for_fds(s)) {
>> +        g_free(uri);
>> +        test_server_free(dest);
>>          return;
>>      }
>>  
> 
> Don't we need also a g_string_free(dest_cmdline)?
> 
> I think it is also missing at the end of the function.
> 
Yes, you are right. But I'm surprised that it hasn't been detected by asan.

I will continue to try it and send a new version.

> Thanks,
> Laurent
> 
> 


