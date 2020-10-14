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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383CFC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABB422227
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sv2+x0nQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABB422227
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiZ7-00079l-6f
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiCV-0001Nf-BY; Wed, 14 Oct 2020 10:56:23 -0400
Received: from mail-eopbgr60125.outbound.protection.outlook.com
 ([40.107.6.125]:38246 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kSiCS-0000jW-48; Wed, 14 Oct 2020 10:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm0sLHaesdkLR2hYS1qXSlO3K0eEpYfaYA3JfvfI5bYWTgPdz6mqI/F2R88oHxAdQQ9Ey0Q3N76QCGAzN/m5YdzupfWL8dDcoiOqX46DLkCtQYRVIq+KszlKhj6+RgtBnLZRQjychEShepjOAu/AMPoD2LZdcI4C6teAW/N7uJiFMzNPazvdoI+uYD/3LCFU1FQYqBFjdAQvDJCyBR5QSpFLP/7nYubnlggELUWzVTq2iTywRGKn82PknyJQZrJJtNF0awcG9R6F8PutDEEOP/P2dGLE8rCGHMo78FVRfypfaBa/JQ7gCzV9ua7wO16/5100MIcz5aK7V9NPen/YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSBTFxGuLa9XimlCv7h19xJSFABkaDzX1+wvntWm38k=;
 b=lzJbUbukhPIcKp/GVMm7u5F6sBImIABWeoQwj9zuOidIEWWknYuFz3F30cpbrrKkAFFZRwLODSj3wyUxyzRAyw9uhC0P45+JaolvHZJpeUKtTmTkPMdKwSS+QW+NonlaJzusGp1wDfUsA67ldqPlXeyz38CY46t2GgLIz5AoMvmftsM14ioZckjWWtsZyzOUXFcrTQhjqdrfX6IiS34tKFpFqG0aaWQo4UM/YjRRgzYq/89/k+k/lyhi24H+36Td3PzjqSO1jrhGoDJjsC2VKgMPwpN9Sh3Ghf6jNtICBme0KCxBEUAGQ46FrbZUB/qzLUwcPLeCnYZCsSHkChN5Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSBTFxGuLa9XimlCv7h19xJSFABkaDzX1+wvntWm38k=;
 b=sv2+x0nQFRiBaD1kytbLEWTiEn8WCQM/S0PxspZLl1UMWO/SFX6tsFjnQ7jn7keV97t8esfhqPOI+2qjf66y17Xyns2aNyUJFRsk3w3oYFsQbdF6yQs21vjYVAIv/rY8r/6yLEysfatk6tFeHCdits9SOoZxSxGQLyOQVbrDtb0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4915.eurprd08.prod.outlook.com (2603:10a6:20b:d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.25; Wed, 14 Oct
 2020 14:56:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3455.031; Wed, 14 Oct 2020
 14:56:17 +0000
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
To: Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
 <bbcb3d60-fbc2-b22c-2660-5e9d8dc4ce5e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <380352ca-2450-e4be-885f-c826296618df@virtuozzo.com>
Date: Wed, 14 Oct 2020 17:56:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <bbcb3d60-fbc2-b22c-2660-5e9d8dc4ce5e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.122]
X-ClientProxiedBy: AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.122) by
 AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 14:56:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01c0b8dd-fb0d-4321-b2d0-08d870514d8b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4915266E2AE2051F187F9558C1050@AM6PR08MB4915.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goTMQcqP90d22B4ecfiKfGOL96SxB6Z2XWLOE1JrSGFb39I+sFDV9T/MDRjfOXKIAqe4NuCWA/OMi8Vo3busSkVChE2S5b4iTPEqNNjIiPWvx1akawcbbYlKObxIsHaIR35neqfygV3HunZiMHO/2JG94kFphR9XbHrYVvbD2SubLd4j7ePeLPV7GQL75wN/YrqML7+qSrFbBgX3tNVf80KhMhRqerGxWcH4EUzqrKFYvm8Ip7zRBauunDBGjr35+8/vFjOYbuRPNYptXqsPWRKjtx1L7xf8dOpYeRnU7XEodflARtDFO8WCcelTYCxoW/1057JQHWT4c08ol48UhT6NpoRx56pwXhxU+wygSAX2UHlUM5xncl62mSMh9zAr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(396003)(346002)(136003)(110136005)(2616005)(5660300002)(26005)(16576012)(8676002)(316002)(956004)(31686004)(7416002)(66476007)(6486002)(4326008)(107886003)(66946007)(66556008)(36756003)(8936002)(53546011)(31696002)(86362001)(478600001)(16526019)(186003)(83380400001)(2906002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: OeTgfJvcmpvRqCFTs14ny/2V+NjYeqU796G7R1fpj3gY0KuOBl7ZBgfRJKULKXVlCP70DkNwLvnKZHhIOmhjs21Pv4DuGpyNo2raVexJl33+1yjokfpDbKnJ2CKEAzPt9s5WzQpDHEtUwpoih5xC/3apmyp9+RbsoHGEfEEFJIwChfZ5vAUJalxAvUCMlDBVP3DE1ruXZP8P2/TlywHIfhQd4vwRulzxEeeeFkjBDfVpLGsYwwjBswrG4hktQX5r7jI4V37xWAOa7RlJBlzHPwvajEnKKyxKjyrWonjdHMsgXISMgPL5DvHirIvLIpO4WD/3Sp64vIb5yAbk05ZOEHPBV77m41VcKsXiPB13cBiVXYphx/TlJDd7Se1e6B+RhwVoK1dTRRcyjUV1TzBiLe2KGf3cYZq6lpJxr4uUKlht56nzER5dbxbNMvPll0SerjGm25sHWG2X6PPmyucw2BaB1Zn5HrBgMUvIgU5OauroHHrURCM6dAbrw97mdAnE/3u0QtvpECVoQ9ZfoTojRE0ilSeUXFKutFbw074UbpN30Up59F1mY2nDlJN8kVUzfaJkURHmnlZNr1os5EOG+I/VdxVk/XMatUTdr9bP3ELdrCcLK+JMO485f5SVExZuzxM+142TaafhERLK/hMNCg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c0b8dd-fb0d-4321-b2d0-08d870514d8b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 14:56:16.9772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99JZBtyBz3LB7ludnZNXNht5TOuq7GvBiyY54himiPBant/aqm2QcbzuBaw5XllNT9v8yJTK8vUd2t5hrgfJJz92CWIfElakMxkM78KUirE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4915
Received-SPF: pass client-ip=40.107.6.125;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 10:56:17
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

14.10.2020 14:57, Max Reitz wrote:
> On 14.10.20 13:09, Max Reitz wrote:
>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>> We are going to use the COR-filter for a block-stream job.
>>> To limit COR operations by the base node in the backing chain during
>>> stream job, pass the name of overlay base node to the copy-on-read
>>> driver as base node itself may change due to possible concurrent jobs.
>>> The rest of the functionality will be implemented in the patch that
>>> follows.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>
>> Is there a reason why you didn’t add this option to QAPI (as part of a
>> yet-to-be-created BlockdevOptionsCor)?  Because I’d really like it there.
>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index bcccf0f..c578b1b 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -24,19 +24,24 @@
>>>   #include "block/block_int.h"
>>>   #include "qemu/module.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>>   #include "qapi/qmp/qdict.h"
>>>   #include "block/copy-on-read.h"
>>>   
>>>   
>>>   typedef struct BDRVStateCOR {
>>>       bool active;
>>> +    BlockDriverState *base_overlay;
>>>   } BDRVStateCOR;
>>>   
>>>   
>>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>                       Error **errp)
>>>   {
>>> +    BlockDriverState *base_overlay = NULL;
>>>       BDRVStateCOR *state = bs->opaque;
>>> +    /* We need the base overlay node rather than the base itself */
>>> +    const char *base_overlay_node = qdict_get_try_str(options, "base");
>>
>> Shouldn’t it be called base-overlay or above-base then?
> 
> While reviewing patch 5, I realized this sould indeed be base-overlay
> (i.e. the next allocation-bearing layer above the base, not just a
> filter on top of base), but that should be noted somewhere, of course.
> Best would be the QAPI documentation for this option. O:)
> 

What about naming it just "bottom" or "bottom-node"? If we don't have base, it's strange to have something "relative to base". And we can document, that "bottom" must be a non-filter node in a backing chain of "top".


-- 
Best regards,
Vladimir

