Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0492073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Z3J67CmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0492073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwel-00040R-DB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqwe3-00035o-1O; Thu, 02 Jul 2020 06:40:43 -0400
Received: from mail-eopbgr80131.outbound.protection.outlook.com
 ([40.107.8.131]:52130 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqwdz-0006WX-I3; Thu, 02 Jul 2020 06:40:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGtfwEoXMAoKoLzclGZwCqeVYdanVavNBgCBnaW6yaQ69w8gTNGtcG3UiGWMQcjC7ecNyPoijQQFmxszT632JyijiINtCV3liSU9V6mIDYjMHqkIrnxW6KULolcyuKl0Ordfwo6nZqYWW+YcYpJAIoyAq1oaudy86Ehi54ay7flG0c3toz47BKH0pcvV+oGObClNBA9jk8DuJTsbJzw4I1lYcn01w3J4TAvEKuM51uQ2yfC4q7zxQgx9NOSKaV9HcIUVVKFhoK65iNSL3DQXZYFEArA/k3Fh70CVD0qn60RXb6yvQO/I3+KbGLjixc8opkD1nl5G8zuA2MJZsmOHNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxk5YIIu+44N1HUSCjNSxoLGDnzkA6BEmOJAG27HgTE=;
 b=AkFvpQZ3MRt6hFM/zlL2iVJlKKAweXFbmdUNdCY7M7bQr9LzHOo+D8PLlFyBe4W/Ow+jNRezxaYWYT6+7xo0fDNhambUanXHrZMn4FnPa9fHzYQph5UXA59nGn9yQS2sPTIpxnGpu4wlanqrHN9iDCfgr438wLewSBHgbRX0WpWr6ATwIaxEncXbjNB503gblt/MT1a8cPI7eYcoNqgNGkW0Dk17qKJ641g5KBD7tqSrz321TcRK8KrBlK7YhZ0bgG7ma3k9ljX1ocLzoSq+6lsYZa3afy9iJ1XOQ4xe8RbGSxuLhyIwtwrCCmbyNyVSbwDdbIVla0vqXhj5Juzytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxk5YIIu+44N1HUSCjNSxoLGDnzkA6BEmOJAG27HgTE=;
 b=Z3J67CmMGSiInqHaYjnbIqk6SyptkLZVKp9GfZIHFG8fXbRnhFLWsd7EXF+Of/16R6akPe76rzyEebOCt+hM7M1XjI6xTdX6liNgHjZADi0czWJOOD2xqNSgkRBNG+7OO49KCaBokoc7TD0kPZiJ4/6KNgQI1uIOP7Cseikwc94=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3382.eurprd08.prod.outlook.com (2603:10a6:20b:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 10:40:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 10:40:34 +0000
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
 <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
 <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
 <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2f881827-eee9-b1a3-0ea9-b32d2275ae18@virtuozzo.com>
Date: Thu, 2 Jul 2020 13:40:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.54) by
 AM3PR04CA0145.eurprd04.prod.outlook.com (2603:10a6:207::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Thu, 2 Jul 2020 10:40:33 +0000
X-Originating-IP: [185.215.60.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2513346c-5f35-4abf-7b79-08d81e745967
X-MS-TrafficTypeDiagnostic: AM6PR08MB3382:
X-Microsoft-Antispam-PRVS: <AM6PR08MB33828EDF0C260AAB0A55A696C16D0@AM6PR08MB3382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpXdVCk64phbwsw0dC74mOIFQc1otj3JhoVSO1fToClij4TXdCWzH6JWR+cICFVTfAVc/zL7T7Ve1BtR73FNJ467nGn7o//j/Djf1AJd440AOt8UD6ZqQ9hjj9AjOeVbPDVPtHMIeZ5lCRZneFaTKqxYBNluFRvpBWTYVq55cF37S6GbMeopIVMs2JwPDv1GfWt/y7RqepuLKDPLdk9LfrKPtlTweOXHfzk7pX4Sn9kU3FtRvII4YqjaAudRVsbNCRom3HRiJY0AxRD8lKF+CaSbsAA+LVLMNCZQ7imxb0yhxIeXwf/2vtPF2fRnDgRJQp/ZWj4Rz5rmXZE+0r/mC1W6WiEZ5wIeUkEuLUy8MatMY5j9AmC7dfnrxzJBK6Xv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(366004)(376002)(39840400004)(136003)(66946007)(478600001)(53546011)(83380400001)(5660300002)(2616005)(6486002)(66476007)(66556008)(26005)(186003)(4326008)(52116002)(54906003)(8936002)(16526019)(956004)(16576012)(316002)(86362001)(31686004)(36756003)(31696002)(2906002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qXGzB2b9kFta+JcJrPIQ2mz2h2uOT6zKTAQyOt45wG1ckJu7xRuJDVHZdJJSVcW5BDvQ9zL8wa2QxIClIcwBEMADKN/mug8Mot75vMiq7amRh1m5mBY7gkzMnRs7L2eBNEcLmcD7eZAITJkywLYrgLCTLcPH50wxm6rmGO5Iw7hqe4txYTgwmm6YPU8ZgQ9ev4/JQuQz33RUhizP9WYr9VCHgWWkvLNoZVx6L4NDuGEIpHrLQGd08GkZ7zcdPOz9zNzzhPQ3Bi7RuBKt6NQSR+DPg9ZCwKxETHGlDpU/zgYC85m78EDQrXqsIgOCCQhDrVU5KsfbYzjUOVWrk3FwFhN0mTnqUvjW6afxMqjaoZ+ci6B+GGY1npY07Ten4isJswz1A1h1P+NCyHyKupFyypvjzB8rcrVGxvkmt+pX9RVbO+/SKFHQ/jQr+B+/50zfU44pzPOMvBnFkH+KPkUq6sfgiNlo+tkfJcpamRhrt6E=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2513346c-5f35-4abf-7b79-08d81e745967
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 10:40:33.9292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urlF0cd3OIp/ux4jKZ/+97NV/kfukwExK0/oxNygxb0cnsAW2PdHvRhdQOlOixxaBgBpLTHVlidPaNNGmLQY2OUlFFj5KAfbtWgWS00bbgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3382
Received-SPF: pass client-ip=40.107.8.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 06:40:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.07.2020 12:41, Max Reitz wrote:
> On 02.07.20 11:19, Vladimir Sementsov-Ogievskiy wrote:
>> 02.07.2020 11:09, Max Reitz wrote:
>>> On 01.07.20 16:34, Vladimir Sementsov-Ogievskiy wrote:
>>>> 30.06.2020 11:45, Max Reitz wrote:
>>>>> This migration parameter allows mapping block node names and bitmap
>>>>> names to aliases for the purpose of block dirty bitmap migration.
>>>>>
>>>>> This way, management tools can use different node and bitmap names on
>>>>> the source and destination and pass the mapping of how bitmaps are
>>>>> to be
>>>>> transferred to qemu (on the source, the destination, or even both with
>>>>> arbitrary aliases in the migration stream).
>>>>>
>>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>     qapi/migration.json            |  83 +++++++-
>>>>>     migration/migration.h          |   3 +
>>>>>     migration/block-dirty-bitmap.c | 372
>>>>> ++++++++++++++++++++++++++++-----
>>>>>     migration/migration.c          |  29 +++
>>>>>     4 files changed, 432 insertions(+), 55 deletions(-)
>>>>>
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index d5000558c6..5aeae9bea8 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -507,6 +507,44 @@
>>>>>       'data': [ 'none', 'zlib',
>>>>>                 { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>>>>>     +##
>>>>> +# @BitmapMigrationBitmapAlias:
>>>>> +#
>>>>> +# @name: The name of the bitmap.
>>>>> +#
>>>>> +# @alias: An alias name for migration (for example the bitmap name on
>>>>> +#         the opposite site).
>>>>> +#
>>>>> +# Since: 5.1
>>>>> +##
>>>>> +{ 'struct': 'BitmapMigrationBitmapAlias',
>>>>> +  'data': {
>>>>> +      'name': 'str',
>>>>> +      'alias': 'str'
>>>>> +  } }
>>>>> +
>>>>> +##
>>>>> +# @BitmapMigrationNodeAlias:
>>>>> +#
>>>>> +# Maps a block node name and the bitmaps it has to aliases for dirty
>>>>> +# bitmap migration.
>>>>> +#
>>>>> +# @node-name: A block node name.
>>>>> +#
>>>>> +# @alias: An alias block node name for migration (for example the
>>>>> +#         node name on the opposite site).
>>>>> +#
>>>>> +# @bitmaps: Mappings for the bitmaps on this node.
>>>>> +#
>>>>> +# Since: 5.1
>>>>> +##
>>>>> +{ 'struct': 'BitmapMigrationNodeAlias',
>>>>> +  'data': {
>>>>> +      'node-name': 'str',
>>>>> +      'alias': 'str',
>>>>> +      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>>>>
>>>> So, we still can't migrate bitmaps from one node to different nodes,
>>>> but we
>>>> also don't know a usecase for it, so it seems OK. But with such
>>>> scheme we
>>>> can select and rename bitmaps in-flight, and Peter said about
>>>> corresponding
>>>> use-case.
>>>>
>>>> I'm OK with this, still, just an idea in my mind:
>>>>
>>>> we could instead just have a list of
>>>>
>>>> BitmapMigrationAlias: {
>>>>    node-name
>>>>    bitmap-name
>>>>    node-alias
>>>>    bitmap-alias
>>>> }
>>>>
>>>> so, mapping is set for each bitmap in separate.
>>>
>>> Well, OK, but why?
>>
>> But why not :) Just thinking out loud. May be someone will imaging good
>> reasons for it.
> 
> The reason for “Why not” is that this code now exists. ;)

Exactly :) But another arguments may appear, who knows. If not - great.

Actual reason is more flexible interface: you can migrate any bitmap to any node with any name (except for conflicts of course). But do we need it, I don't know. I'd like to hear Peter's opinion, if he don't have preference, then I don't care too.

-- 
Best regards,
Vladimir

