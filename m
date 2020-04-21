Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F845C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AC82071C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UQkKBD9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AC82071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs7N-00080j-Az
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs62-0006JQ-Us
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs61-0002aB-8L
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:33:49 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com
 ([40.107.20.105]:59330 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQs60-0002ZW-QO; Tue, 21 Apr 2020 08:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbvSxPKjPIKYlc0h50pePJxi7DIzxLJQGT+nH4y2hRHCgFu31zYjjIyqBppqYQev5i46FY/Ofzb2z7nMKxqtvj6zpQ9pFLYjXPhKsiKiDtTX8fbE1/yHO6e4RV3lfv/UlpgmBRAuUmeVkTS/7W9gOpYIGe0DGfSng7UQdJFKPBH7axUVxOvQbrlNkjriyIuPcJlMGBZ6K/i44IF+ZW5vrF3DEiSr3HISnQ8jOw58t3/w/fWHCYwdYrIcCvwZYbppS9eAFHEvcY1QGoA61/23h5nr/+Ml7lu+f7rfw/ZsXmkzVo6fXwoD5shdmdEtUGPccUGFv24nSmufgo9fXq6aCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/ao4Sjnt/bfuImEbqEN7w08SAArXdEloFuHmlYCwmQ=;
 b=DuJi2Q2nLPmc9mLy3oYA1AQFMrfua8+R2r6ag/bFZkfHP+FQJlThdkC/i1pgghZk9V7o2eeHv1x/ZnkiUcjZpSoZcbJ7H3AFrYoz8Ym68xC9NaVGtSqVtiA1DJKmGubogTNzJa1m3wA5TIKPhX+cnh7uGvspA+M+Kqr3xMelnbZdv5C/VfNQmTgO6UmNWA1xrOkeAYQ2+FRb/GwpATrTpSAkRXbOYkPkU5atEcOJjQcZOthaQswRUym4gTzdV+RS0dPYkaGz8ecY7P/8Wo8tHTcncrw8j00symE6B4IPEIsL70TnHXLrzlVow41qQXI9KIUbMKpKfsXUr6J48oa68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/ao4Sjnt/bfuImEbqEN7w08SAArXdEloFuHmlYCwmQ=;
 b=UQkKBD9WSa/5Bs4FuBpaTu4naXWuXsc7z5jsAcWI5zZKexW2Va9/uO8fVAkT9/wFxf06fdSn1QIMpb7MBvONH/Uxsfl42CChI9U0tTZDXKGKexluw7GyBY9CKc/T7zSfFd2pfeuHdF4WXQRZFhfsOo4Uro9dGYG45UoExeYChGk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 12:33:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:33:46 +0000
Subject: Re: [PATCH 3/7] block: protect parallel jobs from overlapping
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421153343985
Message-ID: <89ef6a1f-17d3-fe88-21a7-4e849bc54d9f@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:33:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0129.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::34) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR01CA0129.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend
 Transport; Tue, 21 Apr 2020 12:33:45 +0000
X-Tagtoolbar-Keys: D20200421153343985
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41e0b60a-5326-4c0a-7ddd-08d7e5f03c05
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5352B437F18990E7B63BC336C1D50@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(478600001)(66946007)(66556008)(66476007)(81156014)(2906002)(8936002)(36756003)(16526019)(52116002)(107886003)(2616005)(86362001)(8676002)(26005)(956004)(186003)(6486002)(31686004)(4326008)(31696002)(316002)(16576012)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tfIY2R9GEb/gVmPEFP5qAiSJbYk0azQ7QKW8KMNvuym1JwGebXILWeJGWuoxcdp8Ir6cWf/FtN3I1m23SyQA+AyDiRTMpMr0ZSxs5jqf4QijYvk7mlI5u6JsZjgPPJRmhrApwJ+3a8UEWCdE+rmuAuBlL+WFwGjDi+v4Kp7rC+RaNnZ9qSVojRB0KKW5DyfSj8v01kVbg1XRkLOlFuZc3kghFvD8CTX4eQRmeOzleg4CXxAamyMajDVakiY+B2qyp0IOEPquHOzkBsqcnbbWPVme0MajqwaZooWzMPTkTuUC76jXVM2ePQcb4zs5RNDnpkRhqrWkQApaMGwzZopqfQJR31IEf3aG+mRoNgzFzIhD0obPD5AKkpgelbI2ZImDtuxEWdF8D6lQdmxiD4jFUxU6GJ1jDPBUPYhmLDw5/Zhs2HkYdXI8WoHhgV9FHr4y
X-MS-Exchange-AntiSpam-MessageData: wnXUX9WHT3johULOC6Z4k1hb8bp0V8kQuvtKIcu4I2MnI0KnM/gNkzqnIRLRbUj3XI2aGHXhNUFRXj5Xfy59pSSywUFIJzFxsQyvJ3CgeBuAaLwYG2wKDFrzUf08YYGlDyipFzhQy8X/1ABo4iS/Cg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e0b60a-5326-4c0a-7ddd-08d7e5f03c05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:33:46.3097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08i6bsEP3JhfmR2T4s3NMmEJgqFKxKxF7/iCgGwk9gsInzNkKvyBiIq6cKAyyRYuVGv9NYd6jQ1goMDuhfQmaLr7EUaNtMMtuI79moAwUeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.20.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:33:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.105
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 21:36, Andrey Shinkevich wrote:
> When it comes to the check for the blocked operations, the node may be
> a filter linked to blk.

"blk" commonly refers to BlockBackend, which is unrelated here. You mean just a filter.

> In that case, do not miss to set blocked
> operations for the underlying node.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   blockjob.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/blockjob.c b/blockjob.c
> index 73d9f1b..2898929 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -189,7 +189,14 @@ void block_job_remove_all_bdrv(BlockJob *job)
>       GSList *l;
>       for (l = job->nodes; l; l = l->next) {
>           BdrvChild *c = l->data;
> -        bdrv_op_unblock_all(c->bs, job->blocker);
> +        BlockDriverState *bs = c->bs;
> +        bdrv_op_unblock_all(bs, job->blocker);
> +        if (bs->drv && bs->drv->is_filter) {
> +            bs = bdrv_filtered_bs(bs);
> +            if (bs) {
> +                bdrv_op_unblock_all(bs, job->blocker);
> +            }
> +        }
>           bdrv_root_unref_child(c);
>       }
>       g_slist_free(job->nodes);
> @@ -230,6 +237,12 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
>   
>       job->nodes = g_slist_prepend(job->nodes, c);
>       bdrv_op_block_all(bs, job->blocker);
> +    if (bs->drv && bs->drv->is_filter) {
> +        bs = bdrv_filtered_bs(bs);
> +        if (bs) {
> +            bdrv_op_block_all(bs, job->blocker);

This will lead to setting op blocker twice, if there are filters inside backing chain. Is it safe?

Still, I don't think it's correct thing. Job should add all it's nodes by hand. If it add some
filter node, but don't add it's filtered node, it is definitely doing something wrong (see my
answer to 1/7).


> +        }
> +    }
>   
>       return 0;
>   }
> 


-- 
Best regards,
Vladimir

