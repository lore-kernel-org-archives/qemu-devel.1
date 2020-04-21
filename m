Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D796C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F3A2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wCayBmHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F3A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs9c-0002MZ-JR
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs8W-0001aj-4y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQs8V-00041I-C5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:36:23 -0400
Received: from mail-db8eur05on2139.outbound.protection.outlook.com
 ([40.107.20.139]:11648 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQs8U-00040j-W9; Tue, 21 Apr 2020 08:36:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj3dt9wC20aiLerpOUgPnwcxkmFamKLL+vVVRa8/ackhpsOD2f79/8SuXrvbPkHtQajBVVpyERFZ2bXQ1oEcZh+wQpNnF5HzAm8cU9jFvJodApYxyktMCYvUirXgPq+9W+tYvDBrL4oT61M/6QOlHyG8SsKf/+Z95rNozwXtXZyZlDBNjrYyEUp+gy2XgmWRGrc+WIHK4iGbpC1R5HR41tu2UeihP/HHKIjSk3zNoHCRdoRvck1aDx5r6HJCtZlq3dRwyIQa8cxXv3eJiA+gBNiUeLthI4sCN4Uj1NEMrmnEjgSiSaP2tLjTt0hqtXhboAGYStfKSKBYbAmn258kOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HpnI1JOjwpuiI9gIt9m7xD3EHfKpWC15W+q2Jr1q3Y=;
 b=FwmEkwiUFkZdR76+TZ6RksXJYg38qoTafFsShU/jK8PnPQBAjtfaZES+2FBnI7ag+9MqHIj9SSvjbAsFhC28E2dm+OyVslZQJ1EYhXGSw70b3f13PLa4JKCpYTISwAQEAZmkpqcturLj4Fn2sTJ7Sxntwthd8MeoI+G8ZxYmol5eb2nCHf3oalSzIIDhQg6zqtP/gTC5SdmCj1kSmHcof96DcslJa4k4cEEafWhfK9EJzVu7Z7yHi12s6YuYkues70E3w67vbi6OORiRAtTj6KWx73zxzel6FdTmDVpp0FeaiRmzz+bLvjDMt+iGIixc1Ba2xn3qQSIGhBOkrClAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HpnI1JOjwpuiI9gIt9m7xD3EHfKpWC15W+q2Jr1q3Y=;
 b=wCayBmHyimAdwUmXk9zj1dQM1tx+wbYUftH70D4Nyl2f7CqOU7vyWeq+Tmq/Oju8e//g5T5BC4jor6aJezBpFooorK2Za6t7iqQaBCM0Mm1oDXjUQNrKQhgpDtm1kxedwR+itbQneK1pTUERWsSJRaz1C2hna5dw2R4zEBas6QM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 12:36:20 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 12:36:20 +0000
Subject: Re: [PATCH 4/7] copy-on-read: Support refreshing filename
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1587407806-109784-5-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421153617016
Message-ID: <a2142b91-7fad-34d9-5ebd-29c345d2bfe4@virtuozzo.com>
Date: Tue, 21 Apr 2020 15:36:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <1587407806-109784-5-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:207:3::20) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM3PR05CA0142.eurprd05.prod.outlook.com (2603:10a6:207:3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26 via Frontend Transport; Tue, 21 Apr 2020 12:36:19 +0000
X-Tagtoolbar-Keys: D20200421153617016
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26898729-29c6-4f96-c48b-08d7e5f09858
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53523D26F8E1C5C450963626C1D50@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
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
X-Microsoft-Antispam-Message-Info: PuVj0APSyO1teJHz0H1cvQ/kWk4AdUiyhre47faLMHrQCO0HYl2BeDVpDKZSrhJjVILy0vJYMgmnNbiNY83eSR3rdzn55xcan79rQKPIxfdsoDwC/kqFeueNZjG/rwJGJ7vIQHazhhhO98hJwy2hA95t6UzLDr6Cmpv/OXLipGCtUTiEwZHEeILKy8n97cpIE0OHY889EivC/VqiO0sHvTeXNd8IKWlYYCmgpWgsS6tAIRWAQYBWpT26MlS5dqSGs9phYoZVsvp8rH7ZDPVRgXhZs5MfaxoWoWTUN4UIy6Nvqr85k3oTrsrTtiAfiXIlUqmAUhsfQfWgqwQCeKJyWofuAep5jz/wab0f38+oBWJegnq5v9kBNSQrDC3xMJWT002wJqenEUIwibGkBLDJAq9HvMg5jswt3yWG3Y+reb7Rr7lJZ6acRvQafNylqcEH
X-MS-Exchange-AntiSpam-MessageData: eNlZSGLPFj/jkeUuSKdmOXAsWHdQwkoCsGOsZQcJPLXsbBDwqT+oFZJOQn+vvLKofnJKwiGdc5f9p3C+nnQk1tq/G3PcwICnywLhtOXLaJegcF1dU5UyvRSdvC4qdQ5sXVXvUuy82XtpN2V2Pzw0fQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26898729-29c6-4f96-c48b-08d7e5f09858
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:36:20.8374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjnVmxKJnzjl2LqKQ63dY+lzwtjCXLr945v3tA2Vnmc532uXpjRVl3YnJT9NPQ+Xrf3NB0j2EuCipwQwVMSCk4BiEBe5dy6PxCSov2llzQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.20.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:36:21
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.20.139
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

Some information about why we need it would be nice.

Still I see same function in commit.c, so most probably it's OK.


20.04.2020 21:36, Andrey Shinkevich wrote:
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/copy-on-read.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
> index ad6577d..e45eab9 100644
> --- a/block/copy-on-read.c
> +++ b/block/copy-on-read.c
> @@ -21,6 +21,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>   #include "block/block_int.h"
>   #include "qemu/module.h"
>   
> @@ -141,6 +142,11 @@ static bool cor_recurse_is_first_non_filter(BlockDriverState *bs,
>       return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
>   }
>   
> +static void cor_refresh_filename(BlockDriverState *bs)
> +{
> +    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
> +            bs->file->bs->filename);
> +}
>   
>   static BlockDriver bdrv_copy_on_read = {
>       .format_name                        = "copy-on-read",
> @@ -161,6 +167,7 @@ static BlockDriver bdrv_copy_on_read = {
>       .bdrv_lock_medium                   = cor_lock_medium,
>   
>       .bdrv_recurse_is_first_non_filter   = cor_recurse_is_first_non_filter,
> +    .bdrv_refresh_filename              = cor_refresh_filename,
>   
>       .has_variable_length                = true,
>       .is_filter                          = true,
> 


-- 
Best regards,
Vladimir

