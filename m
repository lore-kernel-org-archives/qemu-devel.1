Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F2C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8D52083B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PpQ7gtD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8D52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1iB-0001ra-DA
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1hS-000129-PH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU1hS-0000zx-9Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:25:30 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:17998 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU1hQ-0000xx-Bz; Thu, 30 Apr 2020 01:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCnwjydqFfonbw6Zb5OelOyG9aa5dGwuZcpSOek0XAVt8lNebhlGrvxyaX5K5HGuUyXFVdWtLgy63lD5RSoaKwHr++yIYUuTTE0K48nzhpIJhZ0wjKSDM7BOPf8TUvc4OEWJeM2ueSb4xNQ4X2TqRDcwXeZhjwIHBCuWCzz1oqvPSilc4oTnYT3pK64jIt/tiZ6PNYW7S+Zsj+YmhbPh+CSVuLWZVXw2EDCONg62vGkP2T9+Mpo/zqKTZt0w8RLeLGix7+hrUSbSSsrRsIoCUrYPL7kc9o00pT0ozjs0yXt/QzwoIkSRV/UNUsX0pwPrmg9AkouFJfPt3Vpz2M15Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CdC+XIqCdlrnEytMyvWyL3XqjxIKMyyiEcHeF2NMFE=;
 b=f+77plMjao+gAiW1kjjVO8l9v+84z0OpHv47W33uaeZyPFtKcCA+BKeq3zJXe7/d7D1iSo0/UUQzgDCaKhIdr7Kk+xNhTzHuz1mqovE6JljoL2njTYTcWawOQPIb8+XVZd2dvkRQTUK/FzXLbAzfztJRprnnUltxNCC5w3MCwAo/7rLFdUderpROTduTYbz0ov4QaKNfTKHSNSX4EM6eEyL4WNg86iOVwZAb54o5QKrXrQU7NJnzzINIhha+mH6n1qNxMPRbygwxIqkFT3h7LfEmLykjpVuV4Sf49qDrY86Y8KENZrdScG+q3Ni+yq7oLnp2MC69X5V8qCHKxzs7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CdC+XIqCdlrnEytMyvWyL3XqjxIKMyyiEcHeF2NMFE=;
 b=PpQ7gtD5gV80WAfDfKMLQ12gJ03Oc7Dt3CIFzR0/1cb1Z1TGV13dYdg2d6E8Mm+Yh0SLUEV2azTeCUpEkDs0SX2rGVb7RWNz04gCbvOZfZgJFg7pi9WBL7EahOCilIJAAVJw7+ExEaBgIubvDSIBgQR5p8EkbC/5iJvBWm44ULw=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 05:25:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 05:25:24 +0000
Subject: Re: [PATCH v2 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-7-vsementsov@virtuozzo.com>
 <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200430082522694
Message-ID: <7d64fb96-87b3-f0d8-144b-68e3775ed9d0@virtuozzo.com>
Date: Thu, 30 Apr 2020 08:25:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <f45f380b-8e7b-1483-d685-4e7d4729562a@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:207:3::22) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.138) by
 AM3PR05CA0144.eurprd05.prod.outlook.com (2603:10a6:207:3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 05:25:23 +0000
X-Tagtoolbar-Keys: D20200430082522694
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca6f89a-044f-477a-75a4-08d7ecc6e2b0
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530167FD52E65F88B0AD8A8FC1AA0@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gxKNkr1BzA1o7enJAd/Z3TuQuR1AXPrHMsIewUvNV9IM08l5PQAa1dmS5jdOkbY1bm8b+4KhD4ArRfZmWuYD8TfRVQbjydx16ziLPPdigI1wkwZRe9iKWDtMEnRO/vEiSarUvb8006+JyXNTUeMKz2pVhEL6OIkEsQL4xqBaGV11EOnkkdPYzx6ysycv1O5L5JIXotr3y5Ohmjw+cdLm+a084GTPjPSwLNV5DjMSK4gNivelqO62FkxjzYix424/mlz7dSIwRQ32VrG+mS9USSp29GS0RkEU/zHs6d0CEJqOp78Mm/SY5WxAmDU85YpxFjLY1jHqMk2DXPRCD+FLQKPFojxgu1Tvyc1Joi356LUo/8CKBf6ofdItJEJkm88VkFae+2LzYjUT2ZnVG4MyK5KWMy+JGUwyxPqR/EI6S0KkY+1U1YuWpu5pu4ElOC+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(346002)(376002)(366004)(136003)(396003)(2906002)(31686004)(36756003)(186003)(5660300002)(6486002)(26005)(53546011)(956004)(52116002)(2616005)(16526019)(4326008)(86362001)(107886003)(31696002)(316002)(16576012)(7416002)(478600001)(8676002)(66556008)(66946007)(8936002)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rPut1iHhoj89xAJ+w06xHn5MqOYA186Zf1IBBPlE3W1H9dGTCuhNkrM4U1yUuL/O0eglUybdbdYUPQ5mn1IFZvwPiw5IygQrHoQFDzYTtDVwBKRfyrTflH5erpqnQd+NDxIB61a23zOIERVLYxYRAdliVR/sBDXAqQik5R9zh6/gbIQLd1B6wMcyinvx14PLDJK9cYPorpEpede6oJzL0rWpjFLORAdx/n08s+v//zgdYTpcPM9YF4cH6OOByD+3HBdrv81R+qLVlFpoVR+IjpdN77j5RYZMupA/C0xvUrTF3f/kgvdXDSFhHHxYQb2/tn0oEsqQsS4O5tVlmWlm+gy+YDOHSTSPLl99RXXMLVcA5wTEOAxqs5o3uZNTzlumdC3jjKSPNhvlPIYZ56orJ7urbXOPLrWyPBmELh74p9rSxqPjXl05p/sVeQMkfmmVd6gT+L5b8lvKgypUo6E8dUPp8MWow3WXELna1q8ZGucxIhPsiNCOVEs2qwBRZo19VdlLHaxAj6BDuNFR+ROFQd5mqkot2DNwE5eZMy+CB7zcalIh7xCPjC/RZkjtOgLnZ1uiLC4m0R+thazLUQzD+N/LxlBB22bFz/DQw612TQ4BIwuc1prvt2I9Pr9sjD5/h4Yt/vx8zF5uSOqRI3IA0pJe9Xj4vVLGP2GxjJyikiR7H+UKghmpjJys1ANTA4OhFodzdJfYaRV0x8gpEdhL/GS+obGs9STqgjuBPaePfrfV0t0Yx7uGP7tbzz+sY8NeX0CB12bYkCZtA1susZ9+O2/8iBpYi7F+aXA1oJK4zLM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca6f89a-044f-477a-75a4-08d7ecc6e2b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 05:25:24.8473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LRwRB3dJ/AMLTBEr9Q2m3n2JPNrgTwb8BbU7vIFIAf52MN03M31rFwynJyy5ZRYHTT3UgWhBHnBpp8ORNb9+piuO+TgjK783No4UyIXZhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:25:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.120
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

30.04.2020 1:04, Eric Blake wrote:
> On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We are generally moving to int64_t for both offset and bytes parameters
>> on all io paths. Prepare bdrv_aligned_pwritev() now (and convert the
>> dependencies: bdrv_co_write_req_prepare() and
>> bdrv_co_write_req_finish() to signed type bytes)
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/io.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index c8c30e3699..fe19e09034 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1854,7 +1854,7 @@ fail:
>>   }
>>   static inline int coroutine_fn
>> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>>                             BdrvTrackedRequest *req, int flags)
>>   {
> 
> No change in size.  First, check usage within function:
>      int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
> Changes computation from uint64_t to int64_t.  This causes a borderline bug on images between INT64_MAX-511 and INT64_MAX (nbdkit can produce such images over NBD, although they are atypical on disk), where DIV_ROUND_UP() would give the right answer as uint64_t but a negative answer with int64_t.  As those images are not sector-aligned, maybe we don't need to care?
> all other uses appear to be within asserts related to offset+bytes being positive, so that's what we should check for.
> 
> Callers:
> bdrv_aligned_pwritev() - changed in this patch to 'int64_t', analyzed below [1]
> bdrv_co_pdiscard() - already passes 'int64_t', also checks for offset+bytes overflow - safe
> bdrv_co_copy_range_internal() - 'uint64_t', but already analyzed for 3/17 how it was capped < 2M - safe
> bdrv_co_truncate() - already passes 'int64_t', passes new_bytes computed by subtracting from a positive 'int64_t offset' - safe
> 
> 
> [1] except I hit the end of my work day, so my analysis will have to continue tomorrow...
> 

Thanks for reviewing!

I'm very sorry, I just need to say once again: the series should be rebased on "[PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections", as it is already mostly reviewed by Stefan. Seems, that your analysis will be still valid after it, although patches will change. I'll do it now to see, can I keep your r-b's.


-- 
Best regards,
Vladimir

