Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7508C432C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:29:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9388A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 03:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9388A206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icLLc-0004jO-Ls
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 22:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1icL6J-0001O6-Pz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1icL6D-0002HM-KV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 22:13:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54518 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1icL5y-0001e3-Dr; Tue, 03 Dec 2019 22:12:55 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 574B5F9B48D6C18F8201;
 Wed,  4 Dec 2019 11:12:32 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 11:12:22 +0800
Subject: Re: [PATCH V3 1/2] block/nbd: extract the common cleanup code
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
References: <1575012326-51324-1-git-send-email-pannengyuan@huawei.com>
 <77f53371-aa58-849a-b0e4-2d6b4e4557d4@virtuozzo.com>
From: pannengyuan <pannengyuan@huawei.com>
Message-ID: <7d06d51d-12a5-03e1-d695-8f4faf754bec@huawei.com>
Date: Wed, 4 Dec 2019 11:12:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <77f53371-aa58-849a-b0e4-2d6b4e4557d4@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.120.177.99]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: "liyiting@huawei.com" <liyiting@huawei.com>,
 "kuhn.chenqun@huawei.com" <kuhn.chenqun@huawei.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/12/4 1:38, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
> 
> First, please, when sending more than one patch, create a cover-letter. Also,
> summarize (in cover letter) what was changed since previous version.
In previous version, I only send one patch(2/2 in this version), so I
only add a change summarize in 2/2 patch in this version. should I add a
summarize in 1/2 patch too if 1/2 patch is a new one?

> 
> 29.11.2019 10:25, pannengyuan@huawei.com wrote:
>> From: PanNengyuan <pannengyuan@huawei.com>
> 
> Strange line. Check you git preferences. Such line appears (and make sense)
> when you are sending patches authored by someone else.. But here is your name,
> the same as in email's From:.

Thanks for your reminding. I will correct it in next version.

> 
>>
>> The BDRVNBDState cleanup code is common in two places, add
>> nbd_free_bdrvstate_prop() function to do these cleanups (suggested by
>> Stefano Garzarella).
>>
>> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
>> ---
>>   block/nbd.c | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 1239761..5805979 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -94,6 +94,8 @@ typedef struct BDRVNBDState {
>>   
>>   static int nbd_client_connect(BlockDriverState *bs, Error **errp);
>>   
>> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s);
>> +
>>   static void nbd_channel_error(BDRVNBDState *s, int ret)
>>   {
>>       if (ret == -EIO) {
>> @@ -1486,6 +1488,15 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
>>       }
>>   }
>>   
>> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s)
>> +{
>> +    object_unref(OBJECT(s->tlscreds));
>> +    qapi_free_SocketAddress(s->saddr);
>> +    g_free(s->export);
>> +    g_free(s->tlscredsid);
>> +    g_free(s->x_dirty_bitmap);
>> +}
>> +
>>   /*
>>    * Parse nbd_open options
>>    */
>> @@ -1855,10 +1866,7 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
>>   
>>    error:
>>       if (ret < 0) {
>> -        object_unref(OBJECT(s->tlscreds));
>> -        qapi_free_SocketAddress(s->saddr);
>> -        g_free(s->export);
>> -        g_free(s->tlscredsid);
>> +        nbd_free_bdrvstate_prop(s);
>>       }
>>       qemu_opts_del(opts);
>>       return ret;
>> @@ -1937,12 +1945,7 @@ static void nbd_close(BlockDriverState *bs)
>>       BDRVNBDState *s = bs->opaque;
>>   
>>       nbd_client_close(bs);
>> -
>> -    object_unref(OBJECT(s->tlscreds));
>> -    qapi_free_SocketAddress(s->saddr);
>> -    g_free(s->export);
>> -    g_free(s->tlscredsid);
>> -    g_free(s->x_dirty_bitmap);
>> +    nbd_free_bdrvstate_prop(s);
>>   }
>>   
>>   static int64_t nbd_getlength(BlockDriverState *bs)
>>
> 
> 


