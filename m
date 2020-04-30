Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474A7C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8822073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n5LbKAzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8822073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1oD-0006Et-4r
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1mh-0004i1-3u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1mg-0002ad-Kq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:30:54 -0400
Received: from mail-vi1eur05on2132.outbound.protection.outlook.com
 ([40.107.21.132]:2945 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU1me-0002aH-RM; Thu, 30 Apr 2020 01:30:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5O2g52Gwrww5jpOTzXYPqg9pDhlFSR6N7qvrXcEgwJOryrnEf9FQHWlyWN5LVI1GHqifIjx71UUvfIpBPOBiOTE1mNjYPAYiFek5gFN+mRR+s/PQ2Q1K9KtkCHOhlFfSnaYUK2pMKAVC3WJLGGhAANtnFpsC7EyifS0vgL44za8qGsb6VIcuruE3ecrRLDaWZscxazB0Hiy1PparutiO8ccNf5xGyG96xVMGU9W9AS7xaC19Z/LJoeIcVRbr8tAqJezJEi2btwV80NR0NXqH822MGzK0XUu/vcTfXfLw3F/2tjIk3RyLZ23smEKpQTBNZwPu0oNFrBigybVOdcl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo7rqsBMpQoB3qYC1jd02PqSc04LX3TsboIuhxPsRHY=;
 b=Z+Ke82gm9Wpxppni8/sfDFkZ2Uebb2RILnFRXd9zFXku4G2ht14wA2Mu22s6KRqlK8wi1Vsadjrgesx5dX3drLMQojsO+XCJY/fnrxaeLvq7SAAUn1anArjTMyz2Ei+HZHTonREtEh97liNPvM7tY6hyavVxqtUjJtb6dPvbzvd+B2qA6GMMq8a+Qnr2azKJevwaTycgtX0Bdowy6l2bOA/eq2tQfLFFP6KKjH6XswQh7zDYmmQuXhoAknzZrZt0S87bdSoUJUuczxsGRUguuGRjx6kYkNk+UP8GQLUGOwons3dYs6v1ZUgFf/caPLb6Sk9qTxDFq4LN2pi6anRiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo7rqsBMpQoB3qYC1jd02PqSc04LX3TsboIuhxPsRHY=;
 b=n5LbKAzh7ZoLjaReeHZ7Le3/gUr2Jjx5Dcw6mKM21DDxTFr5Rfqcg20tVnhLVncVUgzcqYYzSlgLmQPW5fQ+KDJHPB2FZTmzZWtTgz8ZlH3pTBK+8kaOpYzxdEIhUoxBgNJDQQKIRFS4vdZw1TBEjRtWfezOBAUdkenHCz80t5c=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5464.eurprd08.prod.outlook.com (2603:10a6:20b:10a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 30 Apr
 2020 05:30:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 05:30:49 +0000
Subject: Re: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-7-vsementsov@virtuozzo.com>
 <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
 <7d64fb96-87b3-f0d8-144b-68e3775ed9d0@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430083047145
Message-ID: <3b8fd6f0-21bf-0a52-1168-36970afd3d02@virtuozzo.com>
Date: Thu, 30 Apr 2020 08:30:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <7d64fb96-87b3-f0d8-144b-68e3775ed9d0@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0060.eurprd07.prod.outlook.com
 (2603:10a6:207:4::18) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM3PR07CA0060.eurprd07.prod.outlook.com (2603:10a6:207:4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 05:30:48 +0000
X-Tagtoolbar-Keys: D20200430083047145
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e57d18-6d7a-4043-5321-08d7ecc7a422
X-MS-TrafficTypeDiagnostic: AM7PR08MB5464:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5464B6B84291535C3E01AA64C1AA0@AM7PR08MB5464.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(52116002)(16526019)(2906002)(498600001)(31686004)(16576012)(966005)(53546011)(8676002)(2616005)(956004)(26005)(86362001)(66556008)(66476007)(31696002)(8936002)(186003)(4326008)(36756003)(66946007)(5660300002)(6486002)(107886003)(7416002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVfhKNUa6UI3jYcdmRjI08Ig2RMgw4z0qLB1rQ1raRM/drZ05taEO0WutnBtklGMd6tgZzRZLci7IT/YQ2iJMyd52EjMQVz9+qKrdAOoavLYoHmLNgdzYxiZs8lg3WY6lr4+o+G4uYDWhK/xUaJcq+zmBhNw4L4ScY2HOEayzgS64zyLPak/g3wqXixI8dWikfRysGQ1haR9/jlmEKBEox4YHZZTfkyivk95Xi6Y21HCwlsRaKLaY1NexduVBEaPjHlYrxSKuJ7so1TYFXIjKYc6s4n96Gn/gsNk8Ppd+JJ1gUdX2I3jg34GRp2X1S3kYrslitppnVReXhYgQodBpULNar6kht7CgREwskaT+M5uJpRUwZpGbcsVKqsThuUKI3Aa4mYxcpCCzcDbM4IShjpwzWc1mf2ts0KyOB34qkuG5S5Vz4oKcjx2rNA3iHsWcOmhnQdk0nvDtMETAGAj/5cD6rwAPuFR/Lc3IpVeTI4NMcs8B+gfsKD5gA83+BWqN+r6g8/ZB9VYmaVT7KzUVw==
X-MS-Exchange-AntiSpam-MessageData: BjiSR4/1aC+SkMl9o5dqPK5NSXzyhHVvdMBmNI1CjRv26nvPn8BvuX7PcQIoffS+XFlwRoHiKsDp4SNtikPJeT7tv0Q6475Y7QEksaKeOJK5I02CJ5BCHp8jhB3JMEwGgjiem5j3oLNnXDTsfGN4XHHX9V2Ph+iWRMf7Q4CkjrJ329o1qi9Z8ZW1uzrSsc0qlMbFg6aONPev2A5xHjlj3iywB7eDcecy6FmXENtp5XZwJ/Cnh8rxeo+9hKzyTpPg+xBfo8wxZK22zUfin9zEkleWTbOYcjhquyKepbwRrLVv8ekGRykGApXXDThoEhOGwDII5+g6i+QW0+zKNVbkGQjT9U5BxbLIUnu1zrXTwf1otGkIiLOjiWrFIjjbi7ZKMXpBHx57yC64j+X0B6akEBjjE6UhXPpSrTwUU8fONRbyF4cJHoN5FiAdz2TTpmKPL/dfA8kpbOa6Ml249hYAn/JS0UVaykyY6sOK4q7YxbZpCZuRHGMMy5iBDBqyCImSynDTLEkLoRc50FzQwU/MSHW9CKribxaCRhhv6oJbLkcgiPLGyh21YirNqzB3vzmo1Jh17YjuUr4NNgouk1jDhxEQ63zg5XwGAOeG0n/cTYUgjedKgpcJor2VZvsko6n82sxWiwazWQ6Stl6h8iCRutn7sDJ63aqL7WgshznNi9pNxRPCWON8ZqbeTIYM/c5hJQovNkw1WqhUMA+W3HsQ97A1YRq6FlqLcjabSMOfSdpopp2+HhWOQBQnzz2iswaut+TPpKtFq4azuZRrJ982zjrIUh/RC7t/xD/FTizC/R4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e57d18-6d7a-4043-5321-08d7ecc7a422
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 05:30:49.3649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2qovEhB4M38PF6pIdbm/1Y96rVfReHeDsgz+fNJL6TYw4DvHeZq4Gt5evjOM3qJOj1835fiwO5nwuA6pE/5lCpH5JycsA7dJVakVFUMUg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5464
Received-SPF: pass client-ip=40.107.21.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:30:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.132
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

30.04.2020 8:25, Vladimir Sementsov-Ogievskiy wrote:
> 30.04.2020 1:04, Eric Blake wrote:
>> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We are generally moving to int64_t for both offset and bytes parameters
>>> on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
>>> dependencies: bdrv_co_write_req_prepare() and
>>> bdrv_co_write_req_finish() to signed type bytes)
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   block/io.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/io.c b/block/io.c
>>> index c8c30e3699..fe19e09034 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1854,7 +1854,7 @@ fail:
>>>   }
>>>   static inline int coroutine_fn
>>> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>>> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>>>                             BdrvTrackedRequest *req, int flags)
>>>   {
>>
>> No change in size.  First, check usage within function:
>>      int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
>> Changes computation from uint64_t to int64_t.  This causes a borderline bug on images between INT64_MAX-511 and INT64_MAX (nbdkit can produce such images over NBD, although they are atypical on disk), where DIV_ROUND_UP() would give the right answer as uint64_t but a negative answer with int64_t.  As those images are not sector-aligned, maybe we don't need to care?
>> all other uses appear to be within asserts related to offset+bytes being positive, so that's what we should check for.
>>
>> Callers:
>> bdrv_aligned_pwritev() - changed in this patch to 'int64_t', analyzed below [1]
>> bdrv_co_pdiscard() - already passes 'int64_t', also checks for offset+bytes overflow - safe
>> bdrv_co_copy_range_internal() - 'uint64_t', but already analyzed for 3/17 how it was capped < 2M - safe
>> bdrv_co_truncate() - already passes 'int64_t', passes new_bytes computed by subtracting from a positive 'int64_t offset' - safe
>>
>>
>> [1] except I hit the end of my work day, so my analysis will have to continue tomorrow...
>>
> 
> Thanks for reviewing!
> 
> I'm very sorry, I just need to say once again: the series should be rebased on "[PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections", as it is already mostly reviewed by Stefan. Seems, that your analysis will be still valid after it, although patches will change. I'll do it now to see, can I keep your r-b's.
> 

I mean "[PATCH v2 0/9] block/io: safer inc/dec in_flight sections" of course
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04559.html


-- 
Best regards,
Vladimir

