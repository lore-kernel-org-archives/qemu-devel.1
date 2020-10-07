Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D5AC4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E036208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 14:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZHC0r6Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E036208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQAhE-0000Op-IY
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 10:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQAeU-0006CT-Jb; Wed, 07 Oct 2020 10:42:46 -0400
Received: from mail-eopbgr50134.outbound.protection.outlook.com
 ([40.107.5.134]:19891 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kQAeR-0005TK-Dn; Wed, 07 Oct 2020 10:42:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP95vTlSOfwS4q7Dr+bYjTjDo7ZNR1+QqCKjHRoeuSd9+5z9lYWLkqkCthgAjze6TBURjsLKL6M87uJnX8G7afnJqjU1bv3kpjuY6//HuyEtpSC8qZz1r0xJ/AZnROU7w7tqKJUI/izQBsX+0+L6/pYZD68+ocK1zcbNVPzAQUq6PAY1ZLQJp7X6p17NWYeb/HVMsJv/gvmhbJymZuNGXW1BpdCMMjo1IMN6r6bNNPl26RBZTo4claJASI/gF1gULwsNQPg1DrMUnyyuL7+1kRtSvBjR7pjNi+G1yAQrLIkXENCi/k4sliOaGGNRkhyMPJtdPJyxfAvBCKnWRc5Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKnopyKz593OmpZnFDVaJIOnSJrxT3bC4bY9h3sgaQU=;
 b=Q7YNkWmCF4F3eRrzx67Uat+NepiO9gaipEYRDTzGMI5UGi/gy1raWbxa0SF/KXL65k/Cu82TNehqCKNxAnHnqQ8Y2FWxXffZulkPmamGo/Wj3k3314MYncylf8AAJm+wJEgUgTtjZd3DTTdWxG0awAbMNAEkyVg3O8p79x8H2yIkRvq8fWWOk4ZRwL1zWUfFtZdFPAezQEHEpQQExfJ/D2ftywnz9NjW+0EuN2B7KnLo45b8OFejN6u+nU6mS+jhl0DAO/LB9ZOSX+m/P2ANysww0eXLtjAuMeBpF9QhnkMItFq4jL/SqespLfu/BrHr0YYKkY/pDbw4onVbGkt4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKnopyKz593OmpZnFDVaJIOnSJrxT3bC4bY9h3sgaQU=;
 b=ZHC0r6Ax08CutCV/efyiueVKC+k0g/aMWP4qC1ZAunBWcH5QS5/qJezZfInSOl+yEQAkh6Y20idzChM0TFF3/Ns6JnZRu+yjLLtq9wkfbZLmLd8ecpLeNDBZ/2sQyd2ovmEFss5P7DuX27R5TF6vPA8AJ2K7Ly9Hurt3ndAEBWI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Wed, 7 Oct
 2020 14:42:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 14:42:38 +0000
Subject: Re: [PATCH] qcow2: Document and enforce the QCowL2Meta invariants
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <20201007115217.18013-1-berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f53af87c-15e3-4de5-42e0-213363759231@virtuozzo.com>
Date: Wed, 7 Oct 2020 17:42:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201007115217.18013-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.87]
X-ClientProxiedBy: FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.87) by
 FRYP281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Wed, 7 Oct 2020 14:42:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ed9aa7-91ad-4d21-0356-08d86acf3cf8
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652FDAEA5D058345E5952A7C10A0@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zc0GxbJZPqWFWHKHyzYOWx1kMZVjjj/+C7rfEi1O1iL2ILYa91BfAqOJ3+Or+ppD0tw6ssOJcknRuHfJiM5GfbZRc3IqUw6hiPemHh7zTOaVSWnR0q87/7F3wTMojIBflr8MSJ4gChIl+vWCtPw6PkBA1ecZiejfzO9ax4PEvdnhT6zRnyimKos8I+dzAuIBVM73L5QQODTER1j5rt0iPiuxNGqUsgtcCw8s/qKKwgEdKs3kf5maNyC/r3P0MF1iQ/Nfi9vO9oxmPIUDQbZW/SK/k4fv1+OJYEPzwktZbW3+Q5PBrS3OpzdsM9JIygAU7hDJnCd31vtlrJRTHjCU4pukEDHa72QDS4t2PHwyFxWWnmqhGDV9bOCVMhDVvg6o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39840400004)(396003)(2616005)(8676002)(316002)(31686004)(66556008)(66476007)(66946007)(6486002)(86362001)(478600001)(54906003)(186003)(16576012)(26005)(16526019)(956004)(31696002)(4326008)(83380400001)(8936002)(2906002)(52116002)(36756003)(5660300002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7+kw2VTmcKirwRByeXdf0a76yD1UxhuJ3K38Xa0/UPJ9SouoyTdcXAHmQoWzhbPLr4RwGK8enwTJ1Ghj+X4/mXoQmpwxajG1AYag1Tg9rXKr3LR/bRNrrpkhqHFg0ebIrEkvsRPcBBSVmqTF/SO1VOG4Kvldt88M3FSPAuH9k6yvHAu1M3NH+fQiQHwQLtkyHVcmY+tCT22+XU0d8U8njVZs/vEy/IXuXT7AGkqPW1iTH60TsoJkLG0atL+j93DMwAts4uzpVisVHaVCzTENU7iQB6m9zINEZuKtRys8v8O4BcdDT15sBpGqcr/tydU0/R6eH1a2c8OcbHqT4Ky7qLBDTBVkgsbEH78UOsH1sgaxBSC1Ao90JzGSR4f2Xuvw50bZvrN8zXxCCnmt5D2X20MoWNSw0Mui5gYqALXKsbkuWPmlZi2sYQmoVXYPh3A1dQ31dWbemy7HZS0e5qElO/438aUKxGh0vCsj/4O+xYJY1N4v2vUIPM73JGfPCLZrT7VzhrBnf4dyPacddAvOhI6vCiiuwnyrmTC6J1iLrGGKobymcyaRFNO8x4V9rRC5bv/0dbJKe+2NLeofChho1QKmwsqtuYvbGwLrn0ZhYLEh0L7P5TVRctBYsETRqSdrvLpYaHZRHoX2Kd7DYqNWUA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ed9aa7-91ad-4d21-0356-08d86acf3cf8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 14:42:38.7442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4PpNgqIpawOXzJTsMnBRriHxPi6YISBJuGgXjmNb1jicp3P1sYXh5kciTXIAf1u1E2GudGvusD6t0Z+3Vph/wa4PBzYNFyFqI3J8auPpHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.5.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 10:42:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

07.10.2020 14:52, Alberto Garcia wrote:
> The QCowL2Meta structure is used to store information about a part of
> a write request that touches clusters that need changes in their L2
> entries. This happens with newly-allocated clusters or subclusters.
> 
> This structure has changed a bit since it was first created and its
> current documentation is not quite up-to-date.
> 
> A write request can span a region consisting on a combination of
> clusters of different types, and qcow2_alloc_host_offset() can
> repeatedly call handle_copied() and handle_alloc() to add more
> clusters to the mix as long as they all are contiguous on the image
> file.
> 
> Because of this a write request has a list of QCowL2Meta structures,
> one for each part of the request that needs changes in the L2
> metadata.
> 
> Each one of them spans nb_clusters and has two copy-on-write regions
> located immediately before and after the middle region that that part
> of the write request touches. Even when those regions themselves are
> empty their offsets must be correct because they are used to know the
> location of the middle region.
> 
> This was not always the case but it is not a problem anymore
> because the only two places where QCowL2Meta structures are created
> (calculate_l2_meta() and qcow2_co_truncate()) ensure that the
> copy-on-write regions are correctly defined, and so do assertions like
> the ones in perform_cow().
> 
> The conditional initialization of the 'written_to' variable is
> therefore unnecessary and is removed by this patch.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.h         | 19 +++++++++++--------
>   block/qcow2-cluster.c |  5 +++--
>   block/qcow2.c         | 19 +++++++++++++++----
>   3 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 125ea9679b..2e0272a7b8 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -435,17 +435,18 @@ typedef struct Qcow2COWRegion {
>   
>   /**
>    * Describes an in-flight (part of a) write request that writes to clusters
> - * that are not referenced in their L2 table yet.
> + * that need to have their L2 table entries updated (because they are
> + * newly allocated or need changes in their L2 bitmaps)
>    */
>   typedef struct QCowL2Meta
>   {
> -    /** Guest offset of the first newly allocated cluster */
> +    /** Guest offset of the first updated cluster */
>       uint64_t offset;
>   
> -    /** Host offset of the first newly allocated cluster */
> +    /** Host offset of the first updated cluster */
>       uint64_t alloc_offset;
>   
> -    /** Number of newly allocated clusters */
> +    /** Number of updated clusters */
>       int nb_clusters;
>   
>       /** Do not free the old clusters */
> @@ -458,14 +459,16 @@ typedef struct QCowL2Meta
>       CoQueue dependent_requests;
>   
>       /**
> -     * The COW Region between the start of the first allocated cluster and the
> -     * area the guest actually writes to.
> +     * The COW Region immediately before the area the guest actually
> +     * writes to. This (part of the) write request starts at
> +     * cow_start.offset + cow_start.nb_bytes.

"starts at" is a bit misleading.. As here is not guest offset, not host offset,
but offset relative to QCowL2Meta.offset

>        */
>       Qcow2COWRegion cow_start;
>   
>       /**
> -     * The COW Region between the area the guest actually writes to and the
> -     * end of the last allocated cluster.
> +     * The COW Region immediately after the area the guest actually
> +     * writes to. This (part of the) write request ends at cow_end.offset

same here

> +     * (which must always be set even when cow_end.nb_bytes is 0).
>        */
>       Qcow2COWRegion cow_end;
>   
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index aa87d3e99b..485b4cb92e 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1049,6 +1049,8 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>       qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>   
>       assert(l2_index + m->nb_clusters <= s->l2_slice_size);
> +    assert(m->cow_end.offset + m->cow_end.nb_bytes <=
> +           m->nb_clusters << s->cluster_bits);

should we also assert that cow_end.offset + cow_end.nb_bytes is not zero?

>       for (i = 0; i < m->nb_clusters; i++) {
>           uint64_t offset = cluster_offset + ((uint64_t)i << s->cluster_bits);
>           /* if two concurrent writes happen to the same unallocated cluster
> @@ -1070,8 +1072,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
>           if (has_subclusters(s) && !m->prealloc) {
>               uint64_t l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index + i);
>               unsigned written_from = m->cow_start.offset;
> -            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes ?:
> -                m->nb_clusters << s->cluster_bits;
> +            unsigned written_to = m->cow_end.offset + m->cow_end.nb_bytes;
>               int first_sc, last_sc;
>               /* Narrow written_from and written_to down to the current cluster */
>               written_from = MAX(written_from, i << s->cluster_bits);
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b05512718c..e7b27fdf25 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2361,15 +2361,26 @@ static bool merge_cow(uint64_t offset, unsigned bytes,
>               continue;
>           }
>   
> -        /* The data (middle) region must be immediately after the
> -         * start region */
> +        /*
> +         * The write request should start immediately after the first
> +         * COW region. This does not always happen because the area
> +         * touched by the request can be larger than the one defined
> +         * by @m (a single request can span an area consisting of a
> +         * mix of previously unallocated and allocated clusters, that
> +         * is why @l2meta is a list).
> +         */
>           if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
> +            /* In this case the request starts before this region */
> +            assert(offset < l2meta_cow_start(m));
> +            assert(m->cow_start.nb_bytes == 0);
>               continue;
>           }
>   
> -        /* The end region must be immediately after the data (middle)
> -         * region */
> +        /* The write request should end immediately before the second
> +         * COW region (see above for why it does not always happen) */
>           if (m->offset + m->cow_end.offset != offset + bytes) {
> +            assert(offset + bytes > m->offset + m->cow_end.offset);
> +            assert(m->cow_end.nb_bytes == 0);
>               continue;
>           }


Then it's interesting, why not to merge if we have this zero-length cow region? What's the problem with it?

So, maybe we can write instead of these two ifs:

If (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
    /* No cow regions */
    continue;
}

if (m->cow_start.nb_bytes) {
   assert(l2meta_cow_start(m) + m->cow_start.nb_bytes == offset)
}

if (m->cow_end.nb_bytes) {
   assert(m->offset + m->cow_end.offset != offset + bytes);
}

But it may be done in separate.

I'm not really good in l2meta list related things, but patch seems OK to me:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

