Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE5C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA53208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DvYNQKGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA53208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlZV-0007oe-3s
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlYh-00073d-Pz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTlYh-0000UK-2c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:11:23 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:46663 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTlYg-0000Or-56; Wed, 29 Apr 2020 08:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrAIM00kOmtKyo6m+cg2Mw4KEi65/Fv9J+A5bQrIwDq5eBvOvNxSXEwMY6vfKcSQ1bMSdIloV+R4kWZ5m+kASbvD/sLJaSnNeKwAdgdXzu22uNJoqj2wPpCPW9GV2LWolPsO7i+ZhrW6QjjIHCPcewC6abt6OOQi0XyS0oao+leYwNQ6yn7HIxLHuOL0jz6fcuDUEh2m1sC2QTHw8syv17ck9eoNIuV+vY3ba99G1TvKFp7e6UruvT3wREajtPT8LaB1T8Hbw0BQUnsDpxF7N7vElGDv8ErqUT8R5fYBPoTZPBvui4NV/IOXWwPW71iXTrLT62qAN81Z2fBLxR3NSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC+LxIXoBnqmGvIeyKY1seNAjrwdC63Rnly+d0q5l0s=;
 b=MiLIaXmhIxIMxnp8USpId9k4SuUSV44l78lt+vjDzFr9AWgmGwGDdi7tggvOI5kqztxI5QHps+yTM887r6ZvjCFmiagCjVSpX7oCPiKz6g6uG6lSwQ6Nb2tnpBHyfjLUE3d3dm6my5z8LcQpssg9xnkSQDPIXH9y+pZkA90uUNmEUpPxO/yBaekZ6lX+uHJJRNkNKS9YXAqg6tB6RmxWa/crBzI7VuCgiyRoRnufdM2YVVMG4ubJFuJpT4uTjrbmjgZ3GW1Da7QKdzOpR8gdlemzSCv36IDNkwCLzMHWcxo+65rU2Cg90A9rWpidajfs3ttTyt2Ud8A20uIhRU1Mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC+LxIXoBnqmGvIeyKY1seNAjrwdC63Rnly+d0q5l0s=;
 b=DvYNQKGGI/8pCN6RBTPt2oeYKT5ktlzdv8o21tWyzvw+Ww4ZIPY2UJ8VF2o7dC8lCqWb74K2DBB0bhJdTizJGifLD+1DEu49tCpp2gF2rXCRRT4BVUmH8uSSWLz+BiaHPO03yWkF1r75Sfa20Um+UIzjCTZ2I7gZYK4Za01wPc0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 12:11:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 12:11:19 +0000
Subject: Re: [PATCH v3 5/5] block/block-copy: use aio-task-pool API
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-6-vsementsov@virtuozzo.com>
 <1abe2617-4cc6-85c5-8c81-e2fa1fe4b5dc@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200429151117799
Message-ID: <6379bdc2-a256-418f-c550-26222554d4f8@virtuozzo.com>
Date: Wed, 29 Apr 2020 15:11:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1abe2617-4cc6-85c5-8c81-e2fa1fe4b5dc@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0101CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.184) by
 AM4PR0101CA0067.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 12:11:18 +0000
X-Tagtoolbar-Keys: D20200429151117799
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3b0af2-7822-4fcc-963c-08d7ec366ca4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5478A8D2D7A08F4FE7E1E536C1AD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(366004)(376002)(346002)(396003)(36756003)(4326008)(52116002)(956004)(2906002)(26005)(53546011)(2616005)(107886003)(5660300002)(31686004)(8676002)(186003)(16526019)(16576012)(6486002)(66556008)(66946007)(66476007)(86362001)(31696002)(478600001)(316002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCZLJhYoRgDiJ3t6ug9fLQmFzRq1TWOhiZMdTR4oaHmx/YTU7tx9aBC4PaEqwFfp/RHHfOslTkClPnNiyXIP0YpjrG8Tp83v0GfZBFHq2LczwUYCJJjoh3NhgNyu/AIlJrDAM5MGeDZS64yNsG+UI9HdnVC3QlvVpzF+2M660Hj+iA6j0JTYUaKuy49yBx48PDNJw/WjVf32CP/UIYXk3aGlNUVVGYTUI2ACCKFEFHyyrli/62TF/kcozz6vNtb5B5yRv4MY1qlnTzAVVsxgRn/Rz0wZlkksHAQSWiGM6c2vRURHEspOPyi1ARhDS7TTgZyF3vlGXqLc9xaz6JhnfXtfPdoYsJvLlxPLt0mwa1Sjl3xaSf45neiygA40x58fGSKD1W49odyTXKPXfG9zjoNL+K4iWtROe2VPgTymXytMFpttio0xZ+tFNypIWb+B
X-MS-Exchange-AntiSpam-MessageData: VQehLpm4zigZq5zVTy/lRucvdA38RebwZJXteOavRnQgYdeAWquoqXISgObDDN/IU08ZEf+sfUANyjI1hHEYE3NNxLtZIRFyciNcibMZFNdqEFHtOholraxl8rWmp0a350/l+/1XdooFJ6HBclR1UlAhgZqFfHInWataP3x6r7phN1q5armkRS0gK7uJiMAGi6y7gutjvf1GLcloIpAnY9sDtl6IKBkM17FQmvZxSYdQsPQZAV4Qcq2gvbQwnweJeh1X1MaqHWE5poyc2QJaxaC/cJZgMqdQpoAKzjVoSe7yZ5TaO/oHJ6j2+fOQ6jS9t8zyXODUaQtSfn1mHClkD42UWMB2sixu7/8EUD1bEkAVMZHCr0pF0Bd7eawP/0hZuopFJVPLNMlnt0wIpjltQ4YGfOUVt/jYoPFlJby+E8d3RwV+PdO5hPDyoeDKUR1NcgonbrHYVHh4sMzgw82XjSflhjeGoA9C2/gFGUZqcShyLFDjlIWxg8jwJQfx2F8JjmXkZle5oswX3hmFVvnZHdFxWJT8yXfUK3x6PC9srMNyJCQ/W2P7Th74RUpWkERkTRkiyttvkvG8wFXcRu46oIk8acyvA9/7hE65CKc/WcR/mbR9jieOJ3MKEzHorDLyomGHDrjXiD+tuNy5UwO3jD0U9NFN29q/HnFxRp6U5xW+H+gue3jRKnO3wIZOtTj7kRi3lyUcH/9cqm6YklKJkbQz3+XIA2tufNia/5qXsp02Ho8aArTW+Lc5ye2KMQBf8zb5mk3RFs5IohLDy4fFPakeYNni5wwNw77uSK1VsTU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3b0af2-7822-4fcc-963c-08d7ec366ca4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 12:11:19.2763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy/+TsuIZpKdAqYtjsaEjXAp4YTt0AcSh0DME5ORx5JiSEPEvB0NVVCed9IARaRWTuxLBmDbkhXyWgOuTZrSeOyb2DPdq8eLwcM/UvXWl8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 08:11:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.4.94
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.04.2020 14:55, Max Reitz wrote:
> On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
>> Run block_copy iterations in parallel in aio tasks.
>>
>> Changes:
>>    - BlockCopyTask becomes aio task structure. Add zeroes field to pass
>>      it to block_copy_do_copy
>>    - add call state - it's a state of one call of block_copy(), shared
>>      between parallel tasks. For now used only to keep information about
>>      first error: is it read or not.
>>    - convert block_copy_dirty_clusters to aio-task loop.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/block-copy.c | 104 +++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 91 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 5cf032c4d8..f5ef91f292 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
> 
> [...]
> 
>> @@ -261,6 +278,30 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
>>       s->progress = pm;
>>   }
>>   
>> +/* Takes ownership on @task */
> 
> Still *of

Ohhh, very sorry for it, I really forget to update the patch :(

> 
>> +static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
>> +                                            BlockCopyTask *task)
>> +{
>> +    if (!pool) {
>> +        int ret = task->task.func(&task->task);
>> +
>> +        g_free(task);
>> +        return ret;
>> +    }
>> +
>> +    aio_task_pool_wait_slot(pool);
>> +    if (aio_task_pool_status(pool) < 0) {
>> +        co_put_to_shres(task->s->mem, task->bytes);
>> +        block_copy_task_end(task, -EAGAIN);
> 
> It looks like you may have missed my nit picks on v2 regarding this
> patch, so I’m going to ask again whether -ECANCELED might be better here
> (even though it still doesn’t really matter).

Hmm yes, sounds better in the context. And I don't see any specific usage of it, and don't remember why I've chosen EAGAIN :) Let's use ECANCELED.

> 
>> +        g_free(task);
>> +        return aio_task_pool_status(pool);
> 
> And whether it may be better to return a constant like -ECANCELED here,
> because how a previous task failed shouldn’t really concern this task
> (or its error code).

Looks correct, will change.

> 
>> +    }
>> +
>> +    aio_task_pool_start_task(pool, &task->task);
>> +
>> +    return 0;
>> +}
>> +
>>   /*
>>    * block_copy_do_copy
>>    *
> 
> [...]
> 
>> @@ -525,25 +590,38 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
> 
> [...]
> 
>> +out:
>> +    if (aio) {
>> +        aio_task_pool_wait_all(aio);
>> +        if (ret == 0) {
>> +            ret = aio_task_pool_status(aio);
>> +        }
>> +        g_free(aio);
> 
> I’d still prefer aio_task_pool_free().
> 

a thousand apologies :(


-- 
Best regards,
Vladimir

