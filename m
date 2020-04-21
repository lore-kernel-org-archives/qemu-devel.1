Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB75C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196382075E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="npEkIvoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196382075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQqy1-00030O-8A
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 07:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqwJ-0001WC-5J
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQqwI-0005o2-Ll
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 07:19:42 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com
 ([40.107.6.138]:59638 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQqwI-0005jw-8i; Tue, 21 Apr 2020 07:19:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsSOCJrfvWR8Pp59q5zykr8J0aXDSNs3wRNcqLjP9f6UJr1bvmS8JXJdJctzPK1KSqcBE+Aq96VkKQwi9Pm7kjP/cK9LNPI7cLV2HdEy0eFgo98eVkmgvZ0G4GL7uDyEl2mJFHyQxTrPLSt7gzBc4RdsE0V5MYFvpi09igcyNiRZwMFdl1unXO3lhXnE3VQ+ST8T/9MvdROrzf88+R3PPaSnZLt7xmh/PhQc9e3/1cn4xW8EKTrIIv3Oq6P/l3MHcHDXHQ4VGz67CvA+qOjdyn/mOk3F4XZWRc65VsKhnrBKyTkwJS8DqPfjqPFwlWh3+qLeU95IviMmzWRWhpbRWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+fgjRMBmg2Tdl+JwBHRdwn6WnHe7FM7IxXAqf/hezw=;
 b=f9KSJ3ch73MV8+fXYIhP0/cVBfJKCKdNzKDLzlpbzpbbiHKHSew7wUQQF3LIOEIP7xPMF7iLv6bzSDuB2qO3D739nnYBAVH3wwJjxmCoYhSGhzvFx7CXpBBHYVjVCjF4oag4zKBoUsAv6tWc3QIO2Af8AvkwE3OQx5DzvKJxufmxAU9SWgAJD0ujywC41sLer2okhUBfm5M111rFZRYh/82a7hkRMVXLDH2NrgX14NW6jqn0lxlrtgM190nlHjqkhrVokJWLnc2vhkulLQ1VhSAONotiDOThJz67cQB64VbyGPyGLaduAJaaTO+My5kgI2ubHzhX6v8XBXtPb2tNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+fgjRMBmg2Tdl+JwBHRdwn6WnHe7FM7IxXAqf/hezw=;
 b=npEkIvoPlnLXL8N4ZNrQOKgF8X/5Hr4kRfQPiQV3ZOiMBhbAKXDVjWWImLQMKHriQVmGVrtWPgxd4aKJXBWoXRopHezsq0ok1fPjfIsrIwYArzPgD4OamUP+NFA9Zz5aidj43nNGUYXvDqXxhOrZqlYK60ywqTJcPGF7EgRPsVc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5368.eurprd08.prod.outlook.com (2603:10a6:20b:103::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 11:19:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 11:19:38 +0000
Subject: Re: [PATCH v4 7/9] block: truncate: Don't make backing file data
 visible
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-8-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421141937262
Message-ID: <e679a19c-1fac-b2d7-b09e-04d5e5f1c122@virtuozzo.com>
Date: Tue, 21 Apr 2020 14:19:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-8-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 11:19:38 +0000
X-Tagtoolbar-Keys: D20200421141937262
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47637249-f3d5-4eeb-a6f5-08d7e5e5e14a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5368:
X-Microsoft-Antispam-PRVS: <AM7PR08MB53688CFABC9C1E4E33FBE1A2C1D50@AM7PR08MB5368.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(346002)(366004)(39840400004)(376002)(136003)(52116002)(66476007)(66556008)(16576012)(86362001)(36756003)(4326008)(5660300002)(6486002)(316002)(8676002)(8936002)(31686004)(81156014)(956004)(31696002)(478600001)(16526019)(2616005)(66946007)(2906002)(26005)(186003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 090X0EhJ2h8KRzwN2hNCWkpUgjgi/DRY497vuwYZixcNfr++lUGZS4TXp6wcymBl/qf8qoxZkiZY7LJQqstwL0GRtvYemvw0ZRRjgCLVDQzUvVVYL4QZumtIC38/fQ6SMcUYtM2bicnIiOiZffas/oZcCIAEa7TWBrjFnjEhizGdRighI/zp39okXyXPuLh9s8vDFurw51VHCSnX+owT7tBp6jTrCLnmNsvN1JfOd0eBvr/VQHWVq6tixzphq+eaWyhG9PX65BG45Y8Dcy0Briot4304bK7e+O69hWt4rHhkiYn1ywEpBv9rMMBlrZwsLkodePk0IYXl5yAANkMcLx/X2UbfFzdrt+8Rpk2T89EbXjIg9blL+j89C5HjKWV2Yrc5VwgDAwTjQwDoGZCyiUZcjibfCg5qcC7ioL2MEQ5EXGDhxcvZrRnuP5Nv9/7L
X-MS-Exchange-AntiSpam-MessageData: 1OKjDM0cZFvN83CX/wXQ8xzSJMTPPx5b7YseAMVUWoZxu893oOByX25ONcCvLtE0ap6M7e1AT0xKzNGLnvFl5oepN3pOO041VWNLY/lzPc5vZe+P+TItQEspk4iUq79EdYmZksdJkbYzaxAmnbJjjQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47637249-f3d5-4eeb-a6f5-08d7e5e5e14a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 11:19:38.7357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VKVfpk9EmPbO6q7jSVarVLNUjULsB/NOQfPx+tPzL2YLGd0icAxR/mPvI4lwv4XRgbwnHOTPjya2ASGL4T4Fln+0JJbGC9MeliEMsmiaMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5368
Received-SPF: pass client-ip=40.107.6.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 07:19:39
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.138
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> When extending the size of an image that has a backing file larger than
> its old size, make sure that the backing file data doesn't become
> visible in the guest, but the added area is properly zeroed out.
> 
> Consider the following scenario where the overlay is shorter than its
> backing file:
> 
>      base.qcow2:     AAAAAAAA
>      overlay.qcow2:  BBBB
> 
> When resizing (extending) overlay.qcow2, the new blocks should not stay
> unallocated and make the additional As from base.qcow2 visible like
> before this patch, but zeros should be read.
> 
> A similar case happens with the various variants of a commit job when an
> intermediate file is short (- for unallocated):
> 
>      base.qcow2:     A-A-AAAA
>      mid.qcow2:      BB-B
>      top.qcow2:      C--C--C-
> 
> After commit top.qcow2 to mid.qcow2, the following happens:
> 
>      mid.qcow2:      CB-C00C0 (correct result)
>      mid.qcow2:      CB-C--C- (before this fix)
> 
> Without the fix, blocks that previously read as zeros on top.qcow2
> suddenly turn into A.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/io.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/block/io.c b/block/io.c
> index 795075954e..f149dff3ba 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3394,6 +3394,20 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
>           goto out;
>       }
>   
> +    /*
> +     * If the image has a backing file that is large enough that it would
> +     * provide data for the new area, we cannot leave it unallocated because
> +     * then the backing file content would become visible. Instead, zero-fill
> +     * the area where backing file and new area overlap.

hmm, actually, you zero-fill the whole new area, not the overlap.

> +     *
> +     * Note that if the image has a backing file, but was opened without the
> +     * backing file, taking care of keeping things consistent with that backing
> +     * file is the user's responsibility.
> +     */
> +    if (new_bytes && bs->backing) {
> +        flags |= BDRV_REQ_ZERO_WRITE;
> +    }
> +
>       if (drv->bdrv_co_truncate) {
>           if (flags & ~bs->supported_truncate_flags) {
>               error_setg(errp, "Block driver does not support requested flags");
> 


-- 
Best regards,
Vladimir

