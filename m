Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DC2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9811F20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="naWDRdtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9811F20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjpu-0008UJ-G9
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSjo7-0007GE-Vh; Wed, 14 Oct 2020 12:39:19 -0400
Received: from mail-eopbgr60099.outbound.protection.outlook.com
 ([40.107.6.99]:59450 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSjo5-00061N-CL; Wed, 14 Oct 2020 12:39:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAoNqW01s7QlD9Rt8d5yolxXuDsFQW/y+jDqrYJKTMoc/Uo7qr9nA45dnNN37YRP7jbOdd0JA6NUDIBkpN+LZWsz2bU+6kKplS8e1/ly/dcxZTPydA9GgJU10GirTEJCecnBMSwF3qf62AyiBawqZgP5Go6lVBdMhPvj4vBFP3AJZnkHIoeZcCRMRM5ov/odVXAcMvayeZ6OcYhaat4LmJ5o6PFMetM3H8vuhyEEFH5wK9Lllt5ElNUMU3wHHP2oEG5xl5UB5Uy51v/t/qMNGUaMQw5cVmlYkQtqD8F2iQ9EerErH3bmhgb1VeOhAQmi9LsMttWWoKbF9LE0reWgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd318Db1pqA8pcDNvf0dcoS5aRyD/aVTgBHeEks7KGA=;
 b=Uycz17caaomFmIJ7wnnAsseGuLY2RYOfCfvDcK6EZ/c/Csnj2jDIK87w0K5y/4V25dQ7gI2WVMnGNkPZHFswVcHkLhgtfygh4jOUz+SZbcxzzRJvjNqCSIs6jY3rMcGGyIaGs8GvUWzey9zpwoR58+m+/FrXnJ++s8SkUy0ABPJSESzlosH9K6o2S9IO9KL/ze3TckaEDiQxAWVbOo+vSuYp+3bdkksQVnjWIK38QSpg+O+Z1ye2PDypUQDx9ISUJ0PMEe+SUOKr8TrdZiGszyeAow0UNA5SmpLjcCVmp6Ot08efSAzwOKr6kuRS24wQDucH4EpiifM6eDPSWvKsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd318Db1pqA8pcDNvf0dcoS5aRyD/aVTgBHeEks7KGA=;
 b=naWDRdtxHIAmUif51wKzK8TCWC/jdJj26M1R0qciNcBX6y7B0VnahkeNqQqqtJzimaLshrBk4WDOqyrohVhU1D30v0xxsPh5Txl4qiKe+vmpMDXwcGj4MYplAC7xJWOtlywL+/Kc6yC931efhs1rXzeIL35uBz0VB+ExewYF3ms=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 16:39:14 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 16:39:14 +0000
Subject: Re: [PATCH v11 09/13] copy-on-read: skip non-guest reads if no copy
 needed
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <59ff1f29-149a-0870-b600-1a54f0421c05@redhat.com>
 <c363d263-1854-d766-e9d3-c8ae8008740f@virtuozzo.com>
 <bc862a74-6223-3c8d-d354-36f62bee2d3a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <cf5c632f-3edf-6526-c275-7c8c9d3460cd@virtuozzo.com>
Date: Wed, 14 Oct 2020 19:39:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <bc862a74-6223-3c8d-d354-36f62bee2d3a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:208:55::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.26 via Frontend Transport; Wed, 14 Oct 2020 16:39:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e3a2e0-b7d3-4ebf-3308-08d8705faf97
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652425D8EC833149A83AE20C1050@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnrclyunknugRl2U/cjxvXmZ2OPeWq9BmIBUzX1bL575mBztwU3hMX44E9xrK7gaXCRk/pPVL+jV8+fOCRYCIL/wAQrqvA3yuEsLjGDRuPy2PE45SQDwQByo7Yizx9zrg2Qmx7eZpsiambV7N2W6irw7EigeUOdH0To8yZnZqZfyBq6vlhtLHxX70XPkmVxCvH9w4OfT7lYz3yHohp89RU6RoeSZV2DpRPG28hTL597fnZtRCyiC4fRctDa+aCMNlvoknXJzIHu2nLaEySZpI3LWbNwb56a2cKrxu4Mix+ilt88S+1SvXGv/F7vJQfsae7Ld15gFT2BRHzAC2lagNDGfOPFPUbeGrcSL+Jg+NX3wcl9hn14AHbZIB7NWZBeZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39830400003)(316002)(31696002)(2906002)(66476007)(83380400001)(66556008)(36756003)(31686004)(52116002)(53546011)(16576012)(26005)(107886003)(110136005)(186003)(7416002)(16526019)(86362001)(5660300002)(2616005)(956004)(4326008)(6486002)(8676002)(66946007)(478600001)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: TcIDEupdoGI/wGqXTwnQ7MqvOHj07MJ64b9XpI1k2vrcDAjHqqBbumQALZXdtMh5GXshWeikWNLbNjx8jVedn8wdvKIvn201nWZfVT8GvR7iJWt9WZeKdbBN/7EtF8e2xFbzQw35eHzStPEhCghnYsIiKU9hIt3KJt+4mriQuRkqc1eNcgEvM3JPVTF++yh1ROd3N1bs+Q3yRfV6HgjAZ/CUFMzn62USuWN9LoPiJ943E3HmnTe2U+c0tuP/T/NelXPaooBlveL018/g3EBxSc7foQ9zhQ5mbscXV/zIpCUH2Mvks3XJfTWJ5/CAJKU/UONEmd06rt/8YTeReyjgtxqztXlMJoG6p0U4IV7hRh5H/TE4t+eGYwPde2mB/2ZJM8IMCGSvkIJ47+2vvdOa3ndo+Wp4d0SW3k+T/Yl8HQ5BWeG9LhpF5bRXsgxCEFJ2iDkXuqX5P+DPtEXo1FeHj/r6dP4PLA9TVRXB34TM6wSywQACQrmgX5SWq3bYUmlMrYnk93x41JCKccdD/Hp9I1nSYNdxdP3lcMf5iCexrc8obEVufRynQTvXbSPuBKtSIxAj0qzx8OO1row8aVvNboRgA/+7lCwcZYj7f7gZ4icN8KOGaz61g+Qhm+otugnFKhkKqlRuKdsN5AM7QGsnIg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e3a2e0-b7d3-4ebf-3308-08d8705faf97
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:39:14.4345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ5+7TsroR9dAR9WFwdAhuiv7QCMF1EFEN1JZ+bcK7VBHAwX8blQ56EAprAAQYhgtKfLx5G0zRVWCXlqZVF5gHuuQ6caU27H9WcyOZtXe0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.6.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 12:39:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
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

14.10.2020 19:30, Max Reitz wrote:
> On 14.10.20 17:22, Vladimir Sementsov-Ogievskiy wrote:
>> 14.10.2020 15:51, Max Reitz wrote:
>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>>> If the flag BDRV_REQ_PREFETCH was set, pass it further to the
>>>> COR-driver to skip unneeded reading. It can be taken into account for
>>>> the COR-algorithms optimization. That check is being made during the
>>>> block stream job by the moment.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>    block/copy-on-read.c | 13 +++++++++----
>>>>    block/io.c           |  3 ++-
>>>>    2 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>>> index b136895..278a11a 100644
>>>> --- a/block/copy-on-read.c
>>>> +++ b/block/copy-on-read.c
>>>> @@ -148,10 +148,15 @@ static int coroutine_fn
>>>> cor_co_preadv_part(BlockDriverState *bs,
>>>>                }
>>>>            }
>>>>    -        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov,
>>>> qiov_offset,
>>>> -                                  local_flags);
>>>> -        if (ret < 0) {
>>>> -            return ret;
>>>> +        if (!!(flags & BDRV_REQ_PREFETCH) &
>>>
>>> How about dropping the double negation and using a logical && instead of
>>> the binary &?
>>>
>>>> +            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
>>>> +            /* Skip non-guest reads if no copy needed */
>>>> +        } else {
>>>
>>> Hm.  I would have just written the negated form
>>>
>>> (!(flags & BDRV_REQ_PREFETCH) || (local_flags & BDRV_REQ_COPY_ON_READ))
>>>
>>> and put the “skip” comment above that condition.
>>>
>>> (Since local_flags is initialized to flags, it can be written as a
>>> single comparison, but that’s a matter of taste and I’m not going to
>>> recommend either over the other:
>>>
>>> ((local_flags & (BDRV_REQ_PREFETCH | BDRV_REQ_COPY_ON_READ)) !=
>>> BDRV_REQ_PREFETCH)
>>>
>>> )
>>>
>>>> +            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov,
>>>> qiov_offset,
>>>> +                                      local_flags);
>>>> +            if (ret < 0) {
>>>> +                return ret;
>>>> +            }
>>>>            }
>>>>              offset += n;
>>>> diff --git a/block/io.c b/block/io.c
>>>> index 11df188..bff1808 100644
>>>> --- a/block/io.c
>>>> +++ b/block/io.c
>>>> @@ -1512,7 +1512,8 @@ static int coroutine_fn
>>>> bdrv_aligned_preadv(BdrvChild *child,
>>>>          max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
>>>>        if (bytes <= max_bytes && bytes <= max_transfer) {
>>>> -        ret = bdrv_driver_preadv(bs, offset, bytes, qiov,
>>>> qiov_offset, 0);
>>>> +        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset,
>>>> +                                 flags & bs->supported_read_flags);
>>
>>
>> When BDRV_REQ_PREFETCH is passed, qiov may be (and generally should be)
>> NULL. This means, that we can't just drop the flag when call the driver
>> that doesn't support it.
> 
> True. :/
> 
>> Actually, if driver doesn't support the PREFETCH flag we should do nothing.
> 
> Hm.  But at least in the case of COR, PREFETCH is not something that can
> be optimized to be a no-op (unless the COR is a no-op); it still denotes
> a command that must be executed.
> 
> So if we can’t pass it to the driver, I don’t think we should do
> nothing, but to return an error.  Or maybe we could even assert that it
> isn’t set for drivers that don’t support it, because at least right now
> such a case would just be a bug.

Hmm. Reasonable..

So, let me summarize the cases:

1. bdrv_co_preadv(.. , PREFETCH | COR)

   In this case generic layer should handle both flags and pass flags=0 to driver

2. bdrv_co_preadv(.., PREFETCH)

2.1 driver supporst PREFETCH
   
   OK, pass PREFETCH to driver, no problems

2.2 driver doesn't support PREFETCH

   We can just abort() here, as the only source of PREFETCH without COR would be
   stream job driver, which must read from COR filter.

   More generic solution is to allocate temporary buffer (at least if qiov is NULL)
   and call underlying driver .preadv with flags=0 on that temporary buffer. But
   just abort() is simpler and should work for now.

> 
>>> Ah, OK.  I see.  I expected this to be a separate patch.  I still wonder
>>> why it isn’t.
>>>
>>
>>
>> Could it be part of patch 07? I mean introduce new field
>> supported_read_flags and handle it in generic code in one patch, prior
>> to implementing support for it in COR driver.
> 
> Sure.
> 
> Max
> 


-- 
Best regards,
Vladimir

