Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38DBC2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 08:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8D120784
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 08:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uyojFtzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D120784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMSaX-0000VK-GW
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 04:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMSZs-0008Ml-26
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 04:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMSZq-0004iS-Po
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 04:30:23 -0400
Received: from mail-vi1eur05on2097.outbound.protection.outlook.com
 ([40.107.21.97]:11360 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMSZm-0004e1-NB; Thu, 09 Apr 2020 04:30:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLQAYdzq29/KaOHnWxOCklt5i2m99U6/SDOd8PzOURgpO88uAKTrVDRTHXX2oioUl4zp9odh3qVWsz+ZI/coiO9cfuotgWLqxHSdM5oOi5y1HgA1aUI0oZZmw0AR/tUkgQkOMvlgPh+hC70gEt4AOTdhnNAIIDoXGrm3YSWLyE2yswgH+tDVmCxp58sjCScJKT84bjuST/x+0xQ5Z9h0ybGhdmpjrkwOBfcEomOUXDZS61VdV3gKPIosHaEO2CCyeMJx970KC2dZNidDeRrTZP1mtscQ2XC6BmFh7jAF/TWrOGJ0f1Fl5voN4nuz+lGxSGM7eyjQRhPZj2fC3klsGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omf4cDTCJhsiwAY/VQQGxJz76P6p1zF0kdn8kjskn8Y=;
 b=DjlARujOTCNoh3cFvaWWWRV0tGSPcJY5JI5mvzBthzAbHmoZmQWWFYTj4C47yeC1nQnD8ieHLeT80ETQMVvUxvtnzCepKFCH2iw2UGWsnPyxF6m5i/66Fp/DKE7YEwRaDXCx5KIixUCDB0ICnWKka+4GJ+Gl/wWyPFUMe1J0lPFLJYDM3+oBL/czvj8BNVh/xtlDGdugEPUAO+4ZZ3vpKXnKY4bMzqnbTZKUvRYaDNS3szoryBtaHsnhwTpTlhW4GTmRVWX689BMAG5t+Vs4a6nIkVufm4ZrBg9uS/BHjXNDEoUY/1mut3XD/UUKDR7XMq7AL7o711adb/5UJT/1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omf4cDTCJhsiwAY/VQQGxJz76P6p1zF0kdn8kjskn8Y=;
 b=uyojFtzxFQyIDzCaxph0z9pv+zPoVmx6G23UbV25kPpx16SQyAUx3unHIsXb2o/cnDsNUbfW9Tu6Qz0g198PSJZ6W/lgHCZCmcAZnsZiMzKpYEC3ecS/QhmY2dlBD2Iod3h73fY5ZeS/Y1oCjDG1mDIH+BJEg9iTl43E57Idar0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 08:30:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 08:30:15 +0000
Subject: Re: [PATCH v4 03/30] qcow2: Add calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <627da7ad090c0b166f3d0294312d956fcddc5a2a.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409113013872
Message-ID: <6a3a60be-9d15-5005-d492-f350f1a150aa@virtuozzo.com>
Date: Thu, 9 Apr 2020 11:30:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <627da7ad090c0b166f3d0294312d956fcddc5a2a.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0602CA0003.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM5PR0602CA0003.eurprd06.prod.outlook.com (2603:10a6:203:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 08:30:14 +0000
X-Tagtoolbar-Keys: D20200409113013872
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd303c21-ccf8-4d19-391c-08d7dc603aa1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527EB2F08499D648631A0C6C1C10@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(39840400004)(346002)(376002)(396003)(366004)(136003)(2616005)(316002)(2906002)(16576012)(66476007)(66556008)(6486002)(8936002)(52116002)(54906003)(66946007)(81166007)(956004)(478600001)(36756003)(5660300002)(16526019)(26005)(186003)(86362001)(4326008)(8676002)(31696002)(81156014)(107886003)(31686004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D9zedy96t+YuLcjp6mA/wSpoCPpkfrVdHi2REm3PULO+mQL8nR2HiUK+EWfHVH4M5myepYxs+FnOIO4EHNkafTH8HxYRlCq7MKffF+k7yQyPaSsy/a1mPt45EMr3NR6QLwzGuNcNFglizZnCDmKU08w/sEd0/teYJa27Ce/LRyaJV3PlA4CnxfqEl0InbRWHr7ikIr+0IIL/BRYuWBk0D4NNt54kv1CtEQlvueF2e3xHMDXph9aG0pTd13aHoMQVQBKUrZBz06ykTbF34gUdURAvEr2Y+kfxJVj9Ny0ps8VwIVTYS57aJlAwrJuIDZHzYC4Ox7cJRjZsORljI7w+6YyQnPpq36tLnKQjqFq+lycwuyIDKnTK99BR3IY7ZaPiJiaBMqB7OLmPftC+nTrKVJJhyNh4B9cige0JLQt4soxV2bHM5TxVhr6XnLi1j0q
X-MS-Exchange-AntiSpam-MessageData: IsqEKFMeh/oUvPhuPAgUjlXrk/lY4P4qN2puBLgHvlQzeTsQUckD7/oAQInA2b3MUFXfoDBJAzc4QEtp+p3rAnsUO53nxW4uVhhxMiOrcJmPHGZL+ikoRxEBMqmsU9BUZznl/4vPkvXQ6vvwtvkLow==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd303c21-ccf8-4d19-391c-08d7dc603aa1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 08:30:15.5865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHCERCw05ETN+PKkb87WOLQ0q9xhyo+DMWh6XC9ZlCuuDACdKKqxTwjTBoLTyqFt3Jp1DZyL7DyFGcL3YMfDG96vPVi8dSPAv+lLrb8mOSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.21.97
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

17.03.2020 21:16, Alberto Garcia wrote:
> handle_alloc() creates a QCowL2Meta structure in order to update the
> image metadata and perform the necessary copy-on-write operations.
> 
> This patch moves that code to a separate function so it can be used
> from other places.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-cluster.c | 77 +++++++++++++++++++++++++++++--------------
>   1 file changed, 53 insertions(+), 24 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 95f04d12cc..802fc599a5 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1039,6 +1039,56 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
>       }
>   }
>   
> +/*
> + * For a given write request, create a new QCowL2Meta structure, add
> + * it to @m and the BDRVQcow2State.cluster_allocs list.
> + *
> + * @host_cluster_offset points to the beginning of the first cluster.
> + *
> + * @guest_offset and @bytes indicate the offset and length of the
> + * request.
> + *
> + * If @keep_old is true it means that the clusters were already
> + * allocated and will be overwritten. If false then the clusters are
> + * new and we have to decrease the reference count of the old ones.
> + */
> +static void calculate_l2_meta(BlockDriverState *bs,
> +                              uint64_t host_cluster_offset,
> +                              uint64_t guest_offset, unsigned bytes,
> +                              QCowL2Meta **m, bool keep_old)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    unsigned cow_start_from = 0;
> +    unsigned cow_start_to = offset_into_cluster(s, guest_offset);
> +    unsigned cow_end_from = cow_start_to + bytes;
> +    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
> +    unsigned nb_clusters = size_to_clusters(s, cow_end_from);
> +    QCowL2Meta *old_m = *m;
> +
> +    *m = g_malloc0(sizeof(**m));
> +    **m = (QCowL2Meta) {
> +        .next           = old_m,
> +
> +        .alloc_offset   = host_cluster_offset,
> +        .offset         = start_of_cluster(s, guest_offset),
> +        .nb_clusters    = nb_clusters,
> +
> +        .keep_old_clusters = keep_old,
> +
> +        .cow_start = {
> +            .offset     = cow_start_from,
> +            .nb_bytes   = cow_start_to - cow_start_from,
> +        },
> +        .cow_end = {
> +            .offset     = cow_end_from,

Hmm. So, you make it equal to requested_bytes from handle_alloc(). But before your change it was MIN(requested_bytes, avail_bytes).. If avail_bytes can be less than requested_bytes the patch breaks it, if not, we'd better drop this MIN.

> +            .nb_bytes   = cow_end_to - cow_end_from,
> +        },
> +    };
> +
> +    qemu_co_queue_init(&(*m)->dependent_requests);
> +    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
> +}
> +
>   /*
>    * Returns the number of contiguous clusters that can be used for an allocating
>    * write, but require COW to be performed (this includes yet unallocated space,
> @@ -1437,35 +1487,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>       uint64_t requested_bytes = *bytes + offset_into_cluster(s, guest_offset);
>       int avail_bytes = nb_clusters << s->cluster_bits;
>       int nb_bytes = MIN(requested_bytes, avail_bytes);
> -    QCowL2Meta *old_m = *m;
> -
> -    *m = g_malloc0(sizeof(**m));
> -
> -    **m = (QCowL2Meta) {
> -        .next           = old_m,
> -
> -        .alloc_offset   = alloc_cluster_offset,
> -        .offset         = start_of_cluster(s, guest_offset),
> -        .nb_clusters    = nb_clusters,
> -
> -        .keep_old_clusters  = keep_old_clusters,
> -
> -        .cow_start = {
> -            .offset     = 0,
> -            .nb_bytes   = offset_into_cluster(s, guest_offset),
> -        },
> -        .cow_end = {
> -            .offset     = nb_bytes,
> -            .nb_bytes   = avail_bytes - nb_bytes,
> -        },
> -    };
> -    qemu_co_queue_init(&(*m)->dependent_requests);
> -    QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
>   
>       *host_offset = alloc_cluster_offset + offset_into_cluster(s, guest_offset);
>       *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
>       assert(*bytes != 0);
>   
> +    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
> +                      m, keep_old_clusters);
> +
>       return 1;
>   
>   fail:
> 


-- 
Best regards,
Vladimir

