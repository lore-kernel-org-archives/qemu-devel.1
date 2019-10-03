Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE57C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 05:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547C6222BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 05:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547C6222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFtmJ-0004ik-Dm
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 01:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFtlT-00048Q-FB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 01:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFtlR-0007iY-Io
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 01:34:59 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2081)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFtlQ-0007dy-Vt
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 01:34:57 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d95886c0dc-a7e68;
 Thu, 03 Oct 2019 13:34:37 +0800 (CST)
X-RM-TRANSID: 2ee35d95886c0dc-a7e68
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.5.184] (unknown[180.107.17.228])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25d95886b4aa-72669;
 Thu, 03 Oct 2019 13:34:36 +0800 (CST)
X-RM-TRANSID: 2ee25d95886b4aa-72669
Subject: Re: [PATCH v2 1/3] tests/migration: mem leak fix
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <9b8662b94d89030b1f33193246c645baac2eedd7.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <2731f5b5-f43d-cf97-0a1a-30f3cbd21ae0@vivier.eu>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <b9857d90-554b-5aaa-0930-529a52fa11ec@cmss.chinamobile.com>
Date: Thu, 3 Oct 2019 13:34:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2731f5b5-f43d-cf97-0a1a-30f3cbd21ae0@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/1/19 11:31 PM, Laurent Vivier wrote:
> Le 11/09/2019 à 05:31, Mao Zhongyi a écrit :
>> ‘data’ has the possibility of memory leaks， so use the
>> glic macros g_autofree recommended by CODING_STYLE.rst
>> to automatically release the memory that returned from
>> g_malloc().
>>
>> Cc: armbru@redhat.com
>> Cc: laurent@vivier.eu
>> Cc: tony.nguyen@bt.com
>> Cc: alex.bennee@linaro.org
>>
>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>> ---
>>   tests/migration/stress.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>> index d9aa4afe92..6cbb2d49d3 100644
>> --- a/tests/migration/stress.c
>> +++ b/tests/migration/stress.c
>> @@ -170,10 +170,10 @@ static unsigned long long now(void)
>>   static int stressone(unsigned long long ramsizeMB)
>>   {
>>       size_t pagesPerMB = 1024 * 1024 / PAGE_SIZE;
>> -    char *ram = malloc(ramsizeMB * 1024 * 1024);
>> +    g_autofree char *ram = malloc(ramsizeMB * 1024 * 1024);
>>       char *ramptr;
>>       size_t i, j, k;
>> -    char *data = malloc(PAGE_SIZE);
>> +    g_autofree char *data = malloc(PAGE_SIZE);
> So perhaps g_malloc() could be a better choice as it will exit on
> allocation failure?

right,  will fix it in next.

Thanks,
Mao
>
> Thanks,
> Laurent
>
>



