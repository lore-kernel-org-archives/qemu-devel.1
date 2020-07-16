Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1325C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725232065F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GjPV6yb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725232065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5lq-0004Ve-NV
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5kv-0003p7-Kx; Thu, 16 Jul 2020 11:25:06 -0400
Received: from mail-eopbgr80109.outbound.protection.outlook.com
 ([40.107.8.109]:6017 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jw5ks-0002al-U9; Thu, 16 Jul 2020 11:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og7BAEciCxx2FJLOOvFSCAIl1CRra3eVhHKBNOSv3b3xRbM45IwRFdbb5DrVBGPh49s5xJelvC07Pr6ynHS4BJpWu6aL/G/Kb2ZrSRjyOMPPqdJsKyy/GZUgIkNo5WQQOz0ckfY41ERyEQnVPDcxJoMiA14qLawBBdWMVOEMzJdIrKkLMhYhZPRGbKw0F12kBh8Zxf4L4FnAHhlaWRKdxsJEvsdb+7NNjVF//mG0Y6bUJcQZNvMQqV5VhNeW8AIsIh0VgzXAPziKdhGN0eOGXIPkGy4c5BM4/Duv3v1uriG3h+FIs/dy5o05VBgJ6lE1CXLtS6jDDJrOLFRsQtnJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5aDjRxBwBAoQiZOVtYQDBfZv7P53MOZPC5OkRNrF9o=;
 b=n3Uwyr/tdpj95SfWeBYxsPcoL4elp+vEX/OoFQwAD8gwJnpuvAvFMnlaa2t+no+sST/yLOtoJW6wLos91fjp2wgtzBD7s7sWmJ2cdn3cYHFUiVGlj8UzO5LVzRdaaHKDqcmN0gwnH/tCz3MUIedv1mjhCJJZkxajRAkRc6wnQ58MPRVr28mADJ4Hti6114a8rT2NK44RnoQG9S6UUpzanZcuWBP+Y+/GJbQ3x7PADmsE7R1d1Cp3bsN0iR8V+mdqVFIhF3ZMxzUZnWfHHQ1c0ileefZWuTg1aY80KgNCaOjxgZ4p3tNqlj5PnRoXaThMX3e6gc3+S3qGJ0YX8biv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5aDjRxBwBAoQiZOVtYQDBfZv7P53MOZPC5OkRNrF9o=;
 b=GjPV6yb2cbrcgfIJc8DHwLgBqn8ie/tpFhL+8wvtB1dodIXONx4ek+mq4vEp++6Wujk6qBqbz8P8AVTxcE4pDuTRtbzc9L7CB6QRHI9MtLJ1RsIt1I2JfjqGV8gA4ViUFRlZJ/PehUc8hN8UTE2wS8KK/RRSCLnZzjxqxlafjlU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3720.eurprd08.prod.outlook.com (2603:10a6:20b:8f::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 15:24:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 15:24:59 +0000
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
 <697fa19f-b68f-f45d-7fab-a0d746c44557@virtuozzo.com>
 <b058f66a-41ba-e560-dd2e-292b79359b9c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bad5461b-dfc9-0b52-f9e6-7fa70d6b2114@virtuozzo.com>
Date: Thu, 16 Jul 2020 18:24:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <b058f66a-41ba-e560-dd2e-292b79359b9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.164) by
 AM0PR01CA0136.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend
 Transport; Thu, 16 Jul 2020 15:24:59 +0000
X-Originating-IP: [185.215.60.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e476caf3-bc6c-47b5-9073-08d8299c6735
X-MS-TrafficTypeDiagnostic: AM6PR08MB3720:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37200F28AF0E820F926A8129C17F0@AM6PR08MB3720.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3suUIMbJAARyMX7XnnpUg6K8e/5JCtFYL1aWauad1vriIFfFhtpZAoQaDlWVBbVYA8tkjbszc2B4fNr+7q9+v+PBO1k4mqo0U8q5IKVP+lO5xwB+qeLna+pH0UdVOntc8zlZs29nRFHMumERjoHDkYZXcsKtOlaR4OUraNwz3oZyuqaYRRefReEeUUT21xqpNU9Hh8ituz9h/Ytqs0SgSMuh/ui4YqMXhV8YarG+eu1sA7L+LzXiqAyxHf7+Cxr2ZpypsJHgMb04HqqlSGQRPthVgqrqRFAK7NMnIiE76wjJt16NJE3QVxXA4tKDGwmGqDQ5RhauZyUe9NNprYRdFJwV8CSCsRk6tYqqPux9GkP7Ll2OjF1THNCaWH4VrvnmHBeSTV2OVpmrZtlNOkXq1xbWXEJVGNZVy5oempBd+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(136003)(39840400004)(396003)(66476007)(26005)(53546011)(86362001)(5660300002)(6486002)(186003)(16526019)(52116002)(8936002)(31696002)(8676002)(36756003)(4326008)(16576012)(2616005)(956004)(66946007)(31686004)(316002)(66556008)(478600001)(83380400001)(2906002)(245554002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: R+prZCftfQ5nkDD1uxD1yTIJqpdcUOxIpxqzgvpZD8ZStDXvpKNDB1/98UzpjdTqv0Wu2TEIzrRa/2nl6Dgzp6s+I0+lkce7NTHrehO6NV5zCT/jdS9el2JJ1mkWZqRmgiUYPvUHIIAA29UTWt6HbKGbgyVdUDdVpuK11YgBTZcEzwXHhNmsf3G3RGTTE5wJgOPp5dvbQtrS8ooEBKy3pYy8Hfq/UbgGZDbrABs1lg318hH4NQSM/qS90QVkAXLb6v/1Rd1XH6FxNz7RJZpVe4rfl83pKLBLrGkr8B/5DQMdJayCP7crx8rMfpNrlDQzt3+/AtG2KUSFqx+0lkDg9HOg/FBChTKZTDTuYlDrP4kyTnBS7TLyOT1IWO4xOWORncS9VbF04sMS/ZBgq6UxXx6CPSzUXNdGOyIyc/X/yRpHJ5vebFka24oHcdsEaR27+1LlrTMmUEWKcK7LCSRUkF4773OpF+J36mUFOYNj0H3qSWs4hPvE+MM18zqNTBAP
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e476caf3-bc6c-47b5-9073-08d8299c6735
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:24:59.7350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yW0iSBVt5D3JxvPJrjPgxn4L7TsIW6NP0DVKEo+EVOOjSH2v74ODRO9qTQpYgxNsz9Ljfn3JCFKMOQi2/NqEKmTwwO7id+qgfb2mLNIJro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3720
Received-SPF: pass client-ip=40.107.8.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:25:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 17:50, Max Reitz wrote:
> On 13.07.20 12:18, Vladimir Sementsov-Ogievskiy wrote:
>> 25.06.2020 18:21, Max Reitz wrote:
>>> Add some helper functions for skipping filters in a chain of block
>>> nodes.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>    include/block/block_int.h |  3 +++
>>>    block.c                   | 55 +++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 58 insertions(+)
>>>
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index bb3457c5e8..5da793bfc3 100644
>>
>>
>> This patch raises two questions:
>>
>> 1. How to treat filters at the end of the backing chain?
> 
> It was my understanding that this configuration would be impossible.

OK for me, but I'd prefer to have a comment and assertions.

> 
>> - child-access function will return no filter child for such nodes, it's
>> correct of course
>> - filer skipping functions will return this filter.. How much is it
>> correct - I don't know.
>>
>>
>> Consider a chain
>>
>> top --- backing ---> filter-with-no-child
> 
> How would it be possible to have filter without a child?
> 
>> if bdrv_backing_chain_next(top) returns NULL, it's incorrect, because
>> top actually have backing, and on read it will read from it for
>> unallocated clusters (and this should crash). So, probably, returning
>> filter as a backing-chain-next is a valid thing to do. Or we should
>> assert that we are not in such situation (which may crash more often
>> than trying to really read from nonexistent child).
>>
>> so, returning NULL, may even less correct than returning a filter..
>>
>>
>> 2. How to tread nodes with drv=NULL, but with filter child (with
>> BDRV_CHILD_FILTERED role).
> 
> drv=NULL is a bug on its own that should be fixed...  (The idea we had
> at some point was to introduce a special driver that just always returns
> -EIO on everything, and to replace corrupt qcow2 nodes by that.  Or,
> well, we might just return -EIO from the qcow2 driver, actually, if we
> never use drv=NULL anywhere else.)
> 
> In any case, drv=NULL is an edge case that I think never has anything to
> do with filters.

So, again some good comment and assertion won't hurt.

> 
>> - child-access functions returns no filtered child for such nodes
>> - filter skipping functions will stop on it..
>>
>> =======
>>
>> Isn't it better to drop drv->is_filter at all? And call filter nodes
>> with a bs->file or bs->backing
>> child in BDRV_CHILD_FILTERED role? This automatically closes the two
>> questions:
>>
>> - node without a child in BDRV_CHILD_FILTERED is automatically
>> non-filter. So, filter driver is responsible for having such child.
>> - node without a drv may still be a filter if it have
>> BDRV_CHILD_FILTERED.. Still, not very useful.
>>
>> Anyway, is_filter and BDRV_CHILD_FILTERED are in contradiction, and it
>> seems good to get rid of is_filter. But I may miss something.
>>
>> [..]
>>
>>> +
>>> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
>>> +                                              bool
>>> stop_on_explicit_filter)
>>> +{
>>> +    BdrvChild *c;
>>> +
>>> +    if (!bs) {
>>> +        return NULL;
>>> +    }
>>> +
>>> +    while (!(stop_on_explicit_filter && !bs->implicit)) {
>>> +        c = bdrv_filter_child(bs);
>>> +        if (!c) {
>>> +            break;
>>> +        }
>>> +        bs = c->bs;
>>> +    }
>>> +    /*
>>> +     * Note that this treats nodes with bs->drv == NULL as not being
>>> +     * filters (bs->drv == NULL should be replaced by something else
>>> +     * anyway).
>>> +     * The advantage of this behavior is that this function will thus
>>> +     * always return a non-NULL value (given a non-NULL @bs).
>>
>> I don't see, how it is follows from first sentence? We can skip nodes
>> with a child of BDRV_CHILD_FILTERED and drv=NULL as well, and still return
>> non-NULL bs at the end...
> 
> My idea was that nodes with bs->drv == NULL might not even have
> children.  If we treated them like filters and skipped through them, we
> would have to return NULL if there is no child.
> 
>> Didn't you mean "treat nodes without filter child as not being filters,
>> even if they have drv->is_filter == true"? This is a real reason for the
>> second sentence.
> 
> Hm.  I implicitly always assume that filters always have a filter child,
> so I tend to not even question that part.
> 

Hmm. Still, the relationship in the comment seems unclear to me, the code itself is simpler :)

Okay, I'm actually OK with this all. I'd prefer to have assertions and comments on corner-cases I mentioned, but patch is OK as is:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir

