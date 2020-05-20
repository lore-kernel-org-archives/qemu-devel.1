Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B97C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B056A206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgwgzXl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B056A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKmY-0007fw-QR
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKjA-0003d6-MC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:09:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbKj8-0003ja-VF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589965765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBTAoMuxH+m3lDr8TQ5QWV9hwsOBiQMDZeBabeIDz9M=;
 b=fgwgzXl4Qu1GroEfFCw2hhqOxcfXlzmZs4yHikXWBxtXAedaPualtxO4VDIRZzFv6oJUIl
 x4991pYxhREYzFl3zY4GWcT1s55xt2fbytKFNxmPeocjljaPYWXugIaRaVSdqY6C23JbS5
 bLFB/hplZJ85BjeTnVADw3hvRD3WSNY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-KErJAwRcPj-PQ1C21MvxDQ-1; Wed, 20 May 2020 05:09:22 -0400
X-MC-Unique: KErJAwRcPj-PQ1C21MvxDQ-1
Received: by mail-wr1-f71.google.com with SMTP id q13so1131814wrn.14
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 02:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kBTAoMuxH+m3lDr8TQ5QWV9hwsOBiQMDZeBabeIDz9M=;
 b=nyr9cDZyhuWuOTe3NsSG8MLH9AMREGlsdUuv6l/QjL8X4Bvz7/Kmcxv57F4Whc+UbS
 WJEPS8D4vRUqYT0NcAuuy8fE2EQSWYwm2u5erZlYJ8azjxE3WbhkRx0vO4BdKO9kM8sS
 l2nKxzdOEWGAwHjNMhxd6U3NR1nhZYBrhHx5XYRcMc72rRKpjJt6XP+DN3VmvI766uGc
 GcoFr+HxjfMkP0uma6OO0U/h+95ch3eRVhjC7fHjPNLFnv5MG2Q4BmDMfYfR3R3AKWz/
 L4WPbpqBbvgYAxi1NADFwzsMk0JMEJ7R+Er7rp9ojChkzweMvNUgA/06fCL4tfmZAgUG
 f8lA==
X-Gm-Message-State: AOAM531bmDQhzv0wkEQd72eooxwC1eOo4Ti1wmtLP9KQpkT47mA7rb13
 lgoSXdoP3w6iZ5Ijru+CoaD74VU4Gg0l93ovTUoaTI7pClSypxA9zJg5Jb712v3iuoeGNGWs3yY
 LjaJhvJNUl+cAtRk=
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr1913494wrr.350.1589965761456; 
 Wed, 20 May 2020 02:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkjRVPfllG28sHIp8g7j31oxnO2rPN0LUi7x1DpYqXJl0u5sDxyHPyMj4jltQ8Bz+ZFZlrkg==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr1913455wrr.350.1589965761064; 
 Wed, 20 May 2020 02:09:21 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z3sm2275998wrm.81.2020.05.20.02.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 02:09:20 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] block: Factor out bdrv_run_co()
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-2-kwolf@redhat.com>
 <5f019ab2-076f-4537-9138-9ed93484a727@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb50696f-4680-ca07-4e4f-bcbe1e5c2468@redhat.com>
Date: Wed, 20 May 2020 11:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5f019ab2-076f-4537-9138-9ed93484a727@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 01:34:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, s.reiter@proxmox.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 5:37 PM, Eric Blake wrote:
> On 5/12/20 9:43 AM, Kevin Wolf wrote:
>> We have a few bdrv_*() functions that can either spawn a new coroutine
>> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
>> alreeady running in a coroutine. All of them duplicate basically the
> 
> already
> 
>> same code.
>>
>> Factor the common code into a new function bdrv_run_co().
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>   block/io.c | 104 +++++++++++++++--------------------------------------
>>   1 file changed, 28 insertions(+), 76 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 7d30e61edc..c1badaadc9 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -891,6 +891,22 @@ static int 
>> bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
>>       return 0;
>>   }
>> +static int bdrv_run_co(BlockDriverState *bs, CoroutineEntry *entry,
>> +                       void *opaque, int *ret)
>> +{
>> +    if (qemu_in_coroutine()) {
>> +        /* Fast-path if already in coroutine context */
>> +        entry(opaque);
>> +    } else {
>> +        Coroutine *co = qemu_coroutine_create(entry, opaque);
>> +        *ret = NOT_DONE;
>> +        bdrv_coroutine_enter(bs, co);
>> +        BDRV_POLL_WHILE(bs, *ret == NOT_DONE);
> 
> For my reference, NOT_DONE is defined as INT_MAX, which does not seem to 
> be used as a return value in other situations.
> 
>> @@ -923,25 +939,15 @@ static int bdrv_prwv_co(BdrvChild *child, 
>> int64_t offset,
>>                           QEMUIOVector *qiov, bool is_write,
>>                           BdrvRequestFlags flags)
>>   {
>> -    Coroutine *co;
>>       RwCo rwco = {
>>           .child = child,
>>           .offset = offset,
>>           .qiov = qiov,
>>           .is_write = is_write,
>> -        .ret = NOT_DONE,
>>           .flags = flags,
>>       };
>> -    if (qemu_in_coroutine()) {
>> -        /* Fast-path if already in coroutine context */
>> -        bdrv_rw_co_entry(&rwco);
>> -    } else {
>> -        co = qemu_coroutine_create(bdrv_rw_co_entry, &rwco);
>> -        bdrv_coroutine_enter(child->bs, co);
>> -        BDRV_POLL_WHILE(child->bs, rwco.ret == NOT_DONE);
>> -    }
>> -    return rwco.ret;
>> +    return bdrv_run_co(child->bs, bdrv_rw_co_entry, &rwco, &rwco.ret);
> 
> So code that previously looped on NOT_DONE is obviously safe, while...
> 
>>   }
>>   int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
>> @@ -2230,7 +2236,6 @@ typedef struct BdrvCoBlockStatusData {
>>       int64_t *map;
>>       BlockDriverState **file;
>>       int ret;
>> -    bool done;
>>   } BdrvCoBlockStatusData;
>>   int coroutine_fn bdrv_co_block_status_from_file(BlockDriverState *bs,
>> @@ -2492,7 +2497,6 @@ static void coroutine_fn 
>> bdrv_block_status_above_co_entry(void *opaque)
>>                                              data->want_zero,
>>                                              data->offset, data->bytes,
>>                                              data->pnum, data->map, 
>> data->file);
>> -    data->done = true;
>>       aio_wait_kick();
> 
> ...code that looped on something else now has to be checked that 
> data->ret is still being set to something useful.  Fortunately that is 
> true here.
> 
>> @@ -2669,22 +2663,13 @@ static inline int
>>   bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>>                   bool is_read)
>>   {
>> -    if (qemu_in_coroutine()) {
>> -        return bdrv_co_rw_vmstate(bs, qiov, pos, is_read);
>> -    } else {
>> -        BdrvVmstateCo data = {
>> -            .bs         = bs,
>> -            .qiov       = qiov,
>> -            .pos        = pos,
>> -            .is_read    = is_read,
>> -            .ret        = -EINPROGRESS,
>> -        };
>> -        Coroutine *co = 
>> qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
>> -
>> -        bdrv_coroutine_enter(bs, co);
>> -        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
>> -        return data.ret;
> 
> It's a little harder to see whether -EINPROGRESS might ever be returned 
> by a driver, but again this looks safe.

Maybe add a comment regarding -EINPROGRESS before calling bdrv_run_co() 
in bdrv_rw_vmstate()?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Here, it's a little less obvious whether any driver might return 
> -EINPROGRESS, but it looks like if they did that,
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> Conflicts with Vladimir's patches which try to add more coroutine 
> wrappers (but those need a rebase anyway):
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04559.html
> 


