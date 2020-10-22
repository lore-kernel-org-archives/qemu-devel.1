Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199DC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420582080C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 20:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ifv1WhFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420582080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVhZh-0002EH-98
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 16:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhY0-0001Xh-Iw; Thu, 22 Oct 2020 16:50:56 -0400
Received: from mail-eopbgr70101.outbound.protection.outlook.com
 ([40.107.7.101]:62548 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVhXx-0004Q1-4k; Thu, 22 Oct 2020 16:50:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+euqzyqUhcxLTzLBsBuPtIQOpaNA2u38ezrSxm2MW8gOaMbItazo5np7Hbbn+EgsPmDCt9vMAWLBM0n2TO2/YDzdVo/rQnQLMaNnsPrkCbOkxK9ITI1hLNRvYv6ZEim1CjwjtoK/GY/RRdTxvUv3ddRSzq/zdUhExW2jmORWR1Tr5+2/jZ/E7TzJOAS81J/o0ELyBHmZX2ObP2S56mOa5GXTmxm8nNTSLtJz1fy5knSAWYj3myFprVOfpJ9UorZCBBbYY82KUA6jqVp4evAM3QE6JvsnWWmdbOJO5+H7RijjkJVR/tJysOplvqPEOdIyAZK+s5yoVpsDNVQ2WGlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWP8pR8Qt/1Qr+7+dbR0GqRPDIG66FuKMfARLKUbNTE=;
 b=QhF75jJBEcqMb738U5PEIhR4Cep8rXVCoKruu0k+2BONaRZDbwyhKzgggT9W7ERamv1kEfxbMgjn38Epm0fC+xcuwSFhX2cL9jCU9Z3ADNwPtWnWGdA86dHh2KB7gyQkWcbETNm2SeQvT00bms+up1IhnRG0vUyeAsN7g18vtZOvq4JsubFtj/0lr9mmDYMJSvzWBnY7g3Oa662gNnQnZDYCLWqsguL45LsZah0gaSF2zmlzSPjY0XQbT4jITy8djCkWV3H5Z3UQ+ivRG5c4IJ+cPIgZ0N8lmVNBGQJSTuIqeNAp0n7vEQ0r6gtGeSb2yTqrwyf4ZhUGhNdo03tAVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWP8pR8Qt/1Qr+7+dbR0GqRPDIG66FuKMfARLKUbNTE=;
 b=ifv1WhFmL6UR23O4cGSii4EdvP+DrtH83aQX/JH2NdUsbC4oska6+rS/7vZE8X/R12ZNrfTpFn6pfZCAenvskQOY+hwXKUYZsaHcGhIHIBeoyRWlroS2aBlfWsA0JXIv4jRwGgKVDQKn/TCSGE45ReKQLDjdKTGwf6WHDlytsis=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5383.eurprd08.prod.outlook.com (2603:10a6:20b:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 22 Oct
 2020 20:50:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 20:50:46 +0000
Subject: Re: [PATCH v2 08/20] block/block-copy: add block_copy_cancel
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-9-vsementsov@virtuozzo.com>
 <93e0a82c-71eb-66f3-cf02-a06e3be7c9e8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3d3f31e0-e5ca-9a6a-7acb-90302de50ba3@virtuozzo.com>
Date: Thu, 22 Oct 2020 23:50:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <93e0a82c-71eb-66f3-cf02-a06e3be7c9e8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM3PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:207::18)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM3PR04CA0134.eurprd04.prod.outlook.com (2603:10a6:207::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 20:50:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891f5670-7e4e-48a7-c728-08d876cc26b8
X-MS-TrafficTypeDiagnostic: AM7PR08MB5383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538387A91E0648154B344105C11D0@AM7PR08MB5383.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:439;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /42D/iVNxUuqxMFw8yWjrSyNhmUh+kiAu4mGNvb1uqt08sU/V8XaPf+W/Sqfsg4hedNX2VvTFX7OJ8cLmnkHaV6bmO9Enz1aRD0n/xFHd2YmTfdo6zP6D+EtgvOp8bG1lr3CMySWN+HVY6SP4MEuMtx8NnRfdq0TSD2hriuvSuX+t+rvy2yjtZiBCQSCuf/7SRoXCdjP1VSfmP0G3vFNoReFwj2hXHp5kvK8JcMOL07uv/+U2CK6KpcCxAOTSKvEU8KnI/0W9g5aD6rvFIWqRjHcVnE73OFoVBFooD6FfM6pE8iGM2ytDj9XVijM6w9q5pTxoovrBCUUoxAGYkusvtQPFdBiXV/YtwSfoR1PlmEByet7udua1wpn2ArePf0r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39840400004)(16576012)(53546011)(316002)(16526019)(86362001)(478600001)(956004)(31686004)(8936002)(36756003)(26005)(2616005)(8676002)(66946007)(31696002)(4326008)(186003)(66556008)(2906002)(107886003)(52116002)(66476007)(6486002)(5660300002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: H1POSaL8F8kbAy2hz+quua9tRJYgl8oil3EWeONH1bSTvCkZLI9DLh0LmukUFW6+t0StpvGMMro+UX9Wug6ckriYWofPWLdz3pqE0RKLbfUbqfqtbuP0yjI+3ApKGjSvHKiOjnNOg9dCkYfyQkTq0YypEMxvAYDkMDlLmLQbC2BEJlEpCYO536PUFijYvPP9s4zdKFdOwPj7pIdpnq7LNF9HgjDTc5EcySyvfGdAlMMchCXm7GmwFX06eKU6i5LQRoLuw8TC68ekPRtkk/MD4GHOmwTjF5lnBcxFmVBJN9Fh5bjTeONaUK4QZ8ocmnGey/ng1/nxx1YUnJk35/nYRun5l6RiybDqXb6/a8rO3x8FRu4nnQeyW8otv/fGrObZuxFsK7rqSzgfQqxaaoy27vGxP0grYPumvEjDqAfAKlAmAQ92436dOCRW4DfcvqJ3E6OrJDkMpdtmen5vtOaOOIOkr/Sje5a/SWQikgXQYp9zCNWv2MfyP48/dIErTuMgXJe5wSWL2wNCqDQoW0a2vgn34m/kPqc3DXIVxEni9eXWvdVJieJhmI+j9ykGc4X55jWU8NRibsnryOWJ8ziXtBS1WAQ9KoIRpDpVc7SQVrG2dqgZocRP/GfqkVixQGRcwFXRfQFb5SSI65tiWlvDCA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f5670-7e4e-48a7-c728-08d876cc26b8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 20:50:46.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQGC4/HSxZcMOaB04lsdI0xEhjys4VeN63DtHBR39i5kRuGEPRtLVMnlZgOjs7xKN+GP6Pu0nxZr8oz6z1J41lxeTg5PL0TDmI5nF7d8ukg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
Received-SPF: pass client-ip=40.107.7.101;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 16:50:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

22.07.2020 14:28, Max Reitz wrote:
> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>> Add function to cancel running async block-copy call. It will be used
>> in backup.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/block-copy.h |  7 +++++++
>>   block/block-copy.c         | 22 +++++++++++++++++++---
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
>> index d40e691123..370a194d3c 100644
>> --- a/include/block/block-copy.h
>> +++ b/include/block/block-copy.h
>> @@ -67,6 +67,13 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
>>   void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
>>                             uint64_t speed);
>>   
>> +/*
>> + * Cancel running block-copy call.
>> + * Cancel leaves block-copy state valid: dirty bits are correct and you may use
>> + * cancel + <run block_copy with same parameters> to emulate pause/resume.
>> + */
>> +void block_copy_cancel(BlockCopyCallState *call_state);
>> +
>>   BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>>   void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
>>   
>> diff --git a/block/block-copy.c b/block/block-copy.c
>> index 851d9c8aaf..b551feb6c2 100644
>> --- a/block/block-copy.c
>> +++ b/block/block-copy.c
>> @@ -44,6 +44,8 @@ typedef struct BlockCopyCallState {
>>       bool failed;
>>       bool finished;
>>       QemuCoSleepState *sleep_state;
>> +    bool cancelled;
>> +    Coroutine *canceller;
>>   
>>       /* OUT parameters */
>>       bool error_is_read;
>> @@ -582,7 +584,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
>>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>       assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>>   
>> -    while (bytes && aio_task_pool_status(aio) == 0) {
>> +    while (bytes && aio_task_pool_status(aio) == 0 && !call_state->cancelled) {
>>           BlockCopyTask *task;
>>           int64_t status_bytes;
>>   
>> @@ -693,7 +695,7 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>       do {
>>           ret = block_copy_dirty_clusters(call_state);
>>   
>> -        if (ret == 0) {
>> +        if (ret == 0 && !call_state->cancelled) {
>>               ret = block_copy_wait_one(call_state->s, call_state->offset,
>>                                         call_state->bytes);
>>           }
>> @@ -707,13 +709,18 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
>>            * 2. We have waited for some intersecting block-copy request
>>            *    It may have failed and produced new dirty bits.
>>            */
>> -    } while (ret > 0);
>> +    } while (ret > 0 && !call_state->cancelled);
> 
> Would it be cleaner if block_copy_dirty_cluster() just returned
> -ECANCELED?  Or would that pose a problem for its callers or the async
> callback?
> 

I'd prefer not to merge io ret with block-copy logic: who knows what underlying operations may return.. Can't it be _another_ ECANCELED?
And it would be just a sugar for block_copy_dirty_clusters() call, I'll have to check ->cancelled after block_copy_wait_one() anyway.
Also, for the next version I try to make it more obvious that finished block-copy call is in one of thee states:
  - success
  - failed
  - cancelled

Hmm. Also, cancelled should be OK for copy-on-write operations in filter, it just mean that we don't need to care anymore.

>>       if (call_state->cb) {
>>           call_state->cb(ret, call_state->error_is_read,
>>                          call_state->s->progress_opaque);
>>       }
>>   
>> +    if (call_state->canceller) {
>> +        aio_co_wake(call_state->canceller);
>> +        call_state->canceller = NULL;
>> +    }
>> +
>>       call_state->finished = true;
>>   
>>       return ret;
> 


-- 
Best regards,
Vladimir

