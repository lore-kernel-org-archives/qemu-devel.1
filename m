Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D55C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 11:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F7C20771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="EIX9KMdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F7C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMUvV-0002eh-Of
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 07:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMUuV-00026m-L5
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMUuT-0008OL-Ai
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:59:51 -0400
Received: from mail-am6eur05on2125.outbound.protection.outlook.com
 ([40.107.22.125]:28682 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMUuM-0008MC-LF; Thu, 09 Apr 2020 06:59:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjmWkSo3xjF80yLOGIStv6h901FU1A7G5QwEd5/decnZ5smR1g0UYccSQJ94DhySO8axN0gjNMbaKE78rlGjNT8HKRH0yrqG3imYeddgXHduX95+F6wtlTd8732O2AZp2+dmA6GcX3apjgTVkRrGB5cUTLRAaDaJTeLmKK9zCAGCqVaGyRAbO46kQPbz3RamXcNprNKb5CrL342EG66MpfmabAAJeYi+7GaLQkYSN4Gg8iOyWCHvxm5+hCjCA4rXPXMX/jk3EM2LcR9XmbQ2oLQ/nNOj7aD7Yw8k28ZmMAaLXXdK9+9Sr3C9eyFu/N90ScQ51BX38ApPpsMzTCICIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM96pcseyGKBFxULoQGwWHT1XeDoyBcoNYpFGQXWvXQ=;
 b=DTh4G8jIOtBZguM04WvmHOgX090bfobCD08AGaTQ6pmwLA6q2Qat8fWzSCpMbzJTQiT4Keap4FGWhI3/CYABY4/LJ7ok0geLOqY7m2c8o5voa4MP83G3HPqj2OeGrxeFcR055Ved4wjz+rHxoVHWy3aUBq3NJFE4PrI8Cnuc4Srme7y1G0Gi2lcRSBKFFYLUQDprHvcu5kd5N6LQ8fWqnUvyQks2htAJEWDKQeMBN0TCk87ZuAMoSxCmitXsSYd52Ay1Mkul9aSnk/R8uUCVifjmP8dfb3joYQKAmMn3fTHUT+8ZqqHqdF9ftu+DRCUnDpmvbBWgY08qHt3u3EFuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM96pcseyGKBFxULoQGwWHT1XeDoyBcoNYpFGQXWvXQ=;
 b=EIX9KMdIB4ElToinskBtS/X63YxQPstizbXkarq3gFHGarPs5oZwmweeMTE+d0PmZpI0iHdz8dF9GFEIeaY8XVOQwLcUiQ9xiJjDvR6SHbl5iCYUAH4YcFHA43yaHR65+cH2CyuYpT4O8JxPODuxDAsnaxcbg8uxQZtTpmT6DKM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5397.eurprd08.prod.outlook.com (2603:10a6:20b:dd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 10:59:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 10:59:39 +0000
Subject: Re: [PATCH v4 05/30] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters
 in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <42c52037c0c975e2d1cd23b470e7b61cbd0b3fa3.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409135930002
Message-ID: <66273cab-85f3-209e-1e8f-1b09ad8ff97b@virtuozzo.com>
Date: Thu, 9 Apr 2020 13:59:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <42c52037c0c975e2d1cd23b470e7b61cbd0b3fa3.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0065.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 AM6P192CA0065.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 10:59:38 +0000
X-Tagtoolbar-Keys: D20200409135930002
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2108160f-a4c0-4f4c-40e2-08d7dc751995
X-MS-TrafficTypeDiagnostic: AM7PR08MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53970B4E8AA70846D11068EDC1C10@AM7PR08MB5397.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(396003)(376002)(366004)(136003)(39840400004)(66556008)(8676002)(6486002)(31686004)(31696002)(66476007)(36756003)(5660300002)(86362001)(478600001)(66946007)(8936002)(54906003)(16576012)(2906002)(16526019)(6666004)(4326008)(2616005)(81156014)(52116002)(107886003)(956004)(316002)(81166007)(26005)(186003)(30864003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0nyJxUfc20/OUzlxZBJPo/MEwRTOGj2e54Zy6DJuj5/wifBDTSkevOqp7dpPhw2RNetb0NdPyT/Jj5YMoe0/kAPq2TvJ48zS/VGoAT/vmeqBwUtFqsklfiwVA/qPEtwp9TWf8j7PYeBwfQ3/hZsoH+a0Iv3CGieX+80lRAd2ZA4aQc0kF+6pRIMmd5dftOnnyzZZtypflErCSzgw3E7+c075SbQai5ErKgnNzFlQf+HlJzs8gd7htz+4sUKyg6PDMTpRL2tJvr9P3rrkIhzeHFZazVwx938wteo69cyVwT0WPUJ6JgkSCgsXxyCkfNbw/rPWAtEXlIGLUEMU4Lk0/JsCWaQz/hvlUxdzjBhnWb9bf/R3YvyyBWrT0LHEUBDA4e1V4OxhjlzpoxpZszhlp+KkfnBNyh04D8g/ncZhLXbsczFIHlWZ0xXDtFetlOk
X-MS-Exchange-AntiSpam-MessageData: ncE3hI4bfuUYT6wTMVAzqnKYEcT31qopRopgOFBI/qqaLwayhR4FmZfvxbw5OxShzY9nmz0sZaaODtaqe/4UrCgcEWQ+iaKihCdOvFJA89aR4SyDTmm18sPN3YS+CzIvcPoGBY0uNrM6WuzckNfo/g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2108160f-a4c0-4f4c-40e2-08d7dc751995
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 10:59:39.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JI2Xksz3Y/caGnVDCPfcDtoX69llhx1oK32l1Yax2yM6rvUUPJb3eSBz1pjYvE2vNChqDQIcSd2cIyMy3fVezjiQkD4MAa6+/kkzNiurWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5397
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.125
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

I'm sorry that I'm joining only now and may ask questions already discussed in previous versions :(

17.03.2020 21:16, Alberto Garcia wrote:
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
> 
>     - handle_copied() looks for normal data clusters that are already
>       allocated and have a reference count of 1. In those clusters we
>       can simply write the data and there is no need to perform any
>       copy-on-write.
> 
>     - handle_alloc() looks for clusters that do need copy-on-write,
>       either because they haven't been allocated yet, because their
>       reference count is != 1 or because they are ZERO_ALLOC clusters.
> 
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
> 
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
> 
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
> 
>     - handle_copied() looks for clusters that are already allocated and
>       which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>       reference count of 1).
> 
>     - handle_alloc() looks for clusters for which we need a new
>       allocation (all other cases).
> 
> One important difference after this change is that clusters found
> in handle_copied() may now require copy-on-write, but this will be
> necessary anyway once we add support for subclusters.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2-cluster.c | 230 ++++++++++++++++++++++++------------------
>   1 file changed, 130 insertions(+), 100 deletions(-)
> 
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e251d00890..5c81046c34 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1041,13 +1041,18 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
>   
>   /*
>    * For a given write request, create a new QCowL2Meta structure, add
> - * it to @m and the BDRVQcow2State.cluster_allocs list.
> + * it to @m and the BDRVQcow2State.cluster_allocs list. If the write
> + * request does not need copy-on-write or changes to the L2 metadata
> + * then this function does nothing.
>    *
>    * @host_cluster_offset points to the beginning of the first cluster.
>    *
>    * @guest_offset and @bytes indicate the offset and length of the
>    * request.
>    *
> + * @l2_slice contains the L2 entries of all clusters involved in this
> + * write request.
> + *
>    * If @keep_old is true it means that the clusters were already
>    * allocated and will be overwritten. If false then the clusters are
>    * new and we have to decrease the reference count of the old ones.
> @@ -1055,15 +1060,53 @@ void qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m)
>   static void calculate_l2_meta(BlockDriverState *bs,
>                                 uint64_t host_cluster_offset,
>                                 uint64_t guest_offset, unsigned bytes,
> -                              QCowL2Meta **m, bool keep_old)
> +                              uint64_t *l2_slice, QCowL2Meta **m, bool keep_old)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    unsigned cow_start_from = 0;
> +    int l2_index = offset_to_l2_slice_index(s, guest_offset);
> +    uint64_t l2_entry;
> +    unsigned cow_start_from, cow_end_to;
>       unsigned cow_start_to = offset_into_cluster(s, guest_offset);
>       unsigned cow_end_from = cow_start_to + bytes;
> -    unsigned cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
>       unsigned nb_clusters = size_to_clusters(s, cow_end_from);
>       QCowL2Meta *old_m = *m;
> +    QCow2ClusterType type;
> +
> +    assert(nb_clusters <= s->l2_slice_size - l2_index);
> +
> +    /* Return if there's no COW (all clusters are normal and we keep them) */
> +    if (keep_old) {
> +        int i;
> +        for (i = 0; i < nb_clusters; i++) {
> +            l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
> +            if (qcow2_get_cluster_type(bs, l2_entry) != QCOW2_CLUSTER_NORMAL) {

Could we also allow full ZERO_ALLOC clusters here?

> +                break;
> +            }
> +        }
> +        if (i == nb_clusters) {
> +            return;
> +        }
> +    }
> +
> +    /* Get the L2 entry of the first cluster */
> +    l2_entry = be64_to_cpu(l2_slice[l2_index]);
> +    type = qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_start_from = cow_start_to;
> +    } else {
> +        cow_start_from = 0;
> +    }
> +
> +    /* Get the L2 entry of the last cluster */
> +    l2_entry = be64_to_cpu(l2_slice[l2_index + nb_clusters - 1]);
> +    type = qcow2_get_cluster_type(bs, l2_entry);
> +
> +    if (type == QCOW2_CLUSTER_NORMAL && keep_old) {
> +        cow_end_to = cow_end_from;
> +    } else {
> +        cow_end_to = ROUND_UP(cow_end_from, s->cluster_size);
> +    }

These two ifs may be moved into if (keep_old), and drop "&& keep_old" from conditions.
This also will allow to drop extra calculations, move new variables to if (keep_old) {} block and allow to pass l2_slice=NULL together with keep_old=false.


>   
>       *m = g_malloc0(sizeof(**m));
>       **m = (QCowL2Meta) {
> @@ -1089,18 +1132,22 @@ static void calculate_l2_meta(BlockDriverState *bs,
>       QLIST_INSERT_HEAD(&s->cluster_allocs, *m, next_in_flight);
>   }
>   
> -/* Returns true if writing to a cluster requires COW */
> -static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
> +/*
> + * Returns true if writing to the cluster pointed to by @l2_entry
> + * requires a new allocation (that is, if the cluster is unallocated
> + * or has refcount > 1 and therefore cannot be written in-place).
> + */
> +static bool cluster_needs_new_alloc(BlockDriverState *bs, uint64_t l2_entry)
>   {
>       switch (qcow2_get_cluster_type(bs, l2_entry)) {
>       case QCOW2_CLUSTER_NORMAL:
> +    case QCOW2_CLUSTER_ZERO_ALLOC:
>           if (l2_entry & QCOW_OFLAG_COPIED) {
>               return false;
>           }
>       case QCOW2_CLUSTER_UNALLOCATED:
>       case QCOW2_CLUSTER_COMPRESSED:
>       case QCOW2_CLUSTER_ZERO_PLAIN:
> -    case QCOW2_CLUSTER_ZERO_ALLOC:
>           return true;
>       default:
>           abort();
> @@ -1108,20 +1155,38 @@ static bool cluster_needs_cow(BlockDriverState *bs, uint64_t l2_entry)
>   }
>   
>   /*
> - * Returns the number of contiguous clusters that can be used for an allocating
> - * write, but require COW to be performed (this includes yet unallocated space,
> - * which must copy from the backing file)
> + * Returns the number of contiguous clusters that can be written to
> + * using one single write request, starting from @l2_index.
> + * At most @nb_clusters are checked.
> + *
> + * If @new_alloc is true this counts clusters that are either
> + * unallocated, or allocated but with refcount > 1 (so they need to be
> + * newly allocated and COWed).
> + *
> + * If @new_alloc is false this counts clusters that are already
> + * allocated and can be overwritten in-place (this includes clusters
> + * of type QCOW2_CLUSTER_ZERO_ALLOC).
>    */
> -static int count_cow_clusters(BlockDriverState *bs, int nb_clusters,
> -    uint64_t *l2_slice, int l2_index)
> +static int count_single_write_clusters(BlockDriverState *bs, int nb_clusters,
> +                                       uint64_t *l2_slice, int l2_index,
> +                                       bool new_alloc)
>   {
> +    BDRVQcow2State *s = bs->opaque;
> +    uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index]);
> +    uint64_t expected_offset = l2_entry & L2E_OFFSET_MASK;
>       int i;
>   
>       for (i = 0; i < nb_clusters; i++) {
> -        uint64_t l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
> -        if (!cluster_needs_cow(bs, l2_entry)) {
> +        l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
> +        if (cluster_needs_new_alloc(bs, l2_entry) != new_alloc) {
>               break;
>           }
> +        if (!new_alloc) {
> +            if (expected_offset != (l2_entry & L2E_OFFSET_MASK)) {
> +                break;
> +            }
> +            expected_offset += s->cluster_size;
> +        }
>       }
>   
>       assert(i <= nb_clusters);
> @@ -1192,10 +1257,10 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
>   }
>   
>   /*
> - * Checks how many already allocated clusters that don't require a copy on
> - * write there are at the given guest_offset (up to *bytes). If *host_offset is
> - * not INV_OFFSET, only physically contiguous clusters beginning at this host
> - * offset are counted.
> + * Checks how many already allocated clusters that don't require a new
> + * allocation there are at the given guest_offset (up to *bytes).
> + * If *host_offset is not INV_OFFSET, only physically contiguous clusters
> + * beginning at this host offset are counted.
>    *
>    * Note that guest_offset may not be cluster aligned. In this case, the
>    * returned *host_offset points to exact byte referenced by guest_offset and
> @@ -1204,12 +1269,12 @@ static int handle_dependencies(BlockDriverState *bs, uint64_t guest_offset,
>    * Returns:
>    *   0:     if no allocated clusters are available at the given offset.
>    *          *bytes is normally unchanged. It is set to 0 if the cluster
> - *          is allocated and doesn't need COW, but doesn't have the right
> - *          physical offset.
> + *          is allocated and can be overwritten in-place but doesn't have
> + *          the right physical offset.
>    *
> - *   1:     if allocated clusters that don't require a COW are available at
> - *          the requested offset. *bytes may have decreased and describes
> - *          the length of the area that can be written to.
> + *   1:     if allocated clusters that can be overwritten in place are
> + *          available at the requested offset. *bytes may have decreased
> + *          and describes the length of the area that can be written to.
>    *
>    *  -errno: in error cases
>    */
> @@ -1239,7 +1304,8 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>   
>       l2_index = offset_to_l2_slice_index(s, guest_offset);
>       nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
> -    assert(nb_clusters <= INT_MAX);
> +    /* Limit total byte count to BDRV_REQUEST_MAX_BYTES */
> +    nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);
>   
>       /* Find L2 entry for the first involved cluster */
>       ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
> @@ -1249,18 +1315,17 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>   
>       cluster_offset = be64_to_cpu(l2_slice[l2_index]);

It would be good to s/cluster_offset/l2_entry/

And, "cluster_offset & L2E_OFFSET_MASK" is used so many times, so, I'd not substitute, but
keep both variables: l2_entry and cluster_offset..

>   
> -    /* Check how many clusters are already allocated and don't need COW */
> -    if (qcow2_get_cluster_type(bs, cluster_offset) == QCOW2_CLUSTER_NORMAL
> -        && (cluster_offset & QCOW_OFLAG_COPIED))
> -    {
> +    if (!cluster_needs_new_alloc(bs, cluster_offset)) {
>           /* If a specific host_offset is required, check it */
>           bool offset_matches =
>               (cluster_offset & L2E_OFFSET_MASK) == *host_offset;
>   
>           if (offset_into_cluster(s, cluster_offset & L2E_OFFSET_MASK)) {
> -            qcow2_signal_corruption(bs, true, -1, -1, "Data cluster offset "
> +            qcow2_signal_corruption(bs, true, -1, -1, "%s cluster offset "
>                                       "%#llx unaligned (guest offset: %#" PRIx64
> -                                    ")", cluster_offset & L2E_OFFSET_MASK,
> +                                    ")", cluster_offset & QCOW_OFLAG_ZERO ?
> +                                    "Preallocated zero" : "Data",
> +                                    cluster_offset & L2E_OFFSET_MASK,
>                                       guest_offset);
>               ret = -EIO;
>               goto out;
> @@ -1273,15 +1338,17 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
>           }
>   
>           /* We keep all QCOW_OFLAG_COPIED clusters */
> -        keep_clusters =
> -            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      &l2_slice[l2_index],
> -                                      QCOW_OFLAG_COPIED | QCOW_OFLAG_ZERO);
> +        keep_clusters = count_single_write_clusters(bs, nb_clusters, l2_slice,
> +                                                    l2_index, false);
>           assert(keep_clusters <= nb_clusters);
>   
>           *bytes = MIN(*bytes,
>                    keep_clusters * s->cluster_size
>                    - offset_into_cluster(s, guest_offset));
> +        assert(*bytes != 0);
> +
> +        calculate_l2_meta(bs, cluster_offset & L2E_OFFSET_MASK, guest_offset,
> +                          *bytes, l2_slice, m, true);
>   
>           ret = 1;
>       } else {
> @@ -1357,9 +1424,10 @@ static int do_alloc_cluster_offset(BlockDriverState *bs, uint64_t guest_offset,
>   }
>   
>   /*
> - * Allocates new clusters for an area that either is yet unallocated or needs a
> - * copy on write. If *host_offset is not INV_OFFSET, clusters are only
> - * allocated if the new allocation can match the specified host offset.
> + * Allocates new clusters for an area that is either still unallocated or
> + * cannot be overwritten in-place. If *host_offset is not INV_OFFSET,
> + * clusters are only allocated if the new allocation can match the specified
> + * host offset.
>    *
>    * Note that guest_offset may not be cluster aligned. In this case, the
>    * returned *host_offset points to exact byte referenced by guest_offset and
> @@ -1382,12 +1450,10 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>       BDRVQcow2State *s = bs->opaque;
>       int l2_index;
>       uint64_t *l2_slice;
> -    uint64_t entry;
>       uint64_t nb_clusters;
>       int ret;
> -    bool keep_old_clusters = false;
>   
> -    uint64_t alloc_cluster_offset = INV_OFFSET;
> +    uint64_t alloc_cluster_offset;
>   
>       trace_qcow2_handle_alloc(qemu_coroutine_self(), guest_offset, *host_offset,
>                                *bytes);
> @@ -1402,10 +1468,8 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>   
>       l2_index = offset_to_l2_slice_index(s, guest_offset);
>       nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
> -    assert(nb_clusters <= INT_MAX);
> -
> -    /* Limit total allocation byte count to INT_MAX */
> -    nb_clusters = MIN(nb_clusters, INT_MAX >> s->cluster_bits);
> +    /* Limit total allocation byte count to BDRV_REQUEST_MAX_BYTES */
> +    nb_clusters = MIN(nb_clusters, BDRV_REQUEST_MAX_BYTES >> s->cluster_bits);
>   
>       /* Find L2 entry for the first involved cluster */
>       ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
> @@ -1413,67 +1477,32 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>           return ret;
>       }
>   
> -    entry = be64_to_cpu(l2_slice[l2_index]);
> -    nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index);
> +    nb_clusters = count_single_write_clusters(bs, nb_clusters,
> +                                              l2_slice, l2_index, true);
>   
>       /* This function is only called when there were no non-COW clusters, so if
>        * we can't find any unallocated or COW clusters either, something is
>        * wrong with our code. */
>       assert(nb_clusters > 0);
>   
> -    if (qcow2_get_cluster_type(bs, entry) == QCOW2_CLUSTER_ZERO_ALLOC &&
> -        (entry & QCOW_OFLAG_COPIED) &&
> -        (*host_offset == INV_OFFSET ||
> -         start_of_cluster(s, *host_offset) == (entry & L2E_OFFSET_MASK)))
> -    {
> -        int preallocated_nb_clusters;
> -
> -        if (offset_into_cluster(s, entry & L2E_OFFSET_MASK)) {
> -            qcow2_signal_corruption(bs, true, -1, -1, "Preallocated zero "
> -                                    "cluster offset %#llx unaligned (guest "
> -                                    "offset: %#" PRIx64 ")",
> -                                    entry & L2E_OFFSET_MASK, guest_offset);
> -            ret = -EIO;
> -            goto fail;
> -        }
> -
> -        /* Try to reuse preallocated zero clusters; contiguous normal clusters
> -         * would be fine, too, but count_cow_clusters() above has limited
> -         * nb_clusters already to a range of COW clusters */
> -        preallocated_nb_clusters =
> -            count_contiguous_clusters(bs, nb_clusters, s->cluster_size,
> -                                      &l2_slice[l2_index], QCOW_OFLAG_COPIED);
> -        assert(preallocated_nb_clusters > 0);
> -
> -        nb_clusters = preallocated_nb_clusters;
> -        alloc_cluster_offset = entry & L2E_OFFSET_MASK;
> -
> -        /* We want to reuse these clusters, so qcow2_alloc_cluster_link_l2()
> -         * should not free them. */
> -        keep_old_clusters = true;
> +    /* Allocate at a given offset in the image file */
> +    alloc_cluster_offset = *host_offset == INV_OFFSET ? INV_OFFSET :
> +        start_of_cluster(s, *host_offset);
> +    ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
> +                                  &nb_clusters);
> +    if (ret < 0) {
> +        goto out;
>       }
>   
> -    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);

actually we don't need l2_slice for keep_old=false in calculate_l2_meta, so if
calculate_l2_meta modified a bit, change of function tail is not needed..

Still, may be l2_slice will be used in calculate_l2_meta() in further patches? Will see..

> -
> -    if (alloc_cluster_offset == INV_OFFSET) {
> -        /* Allocate, if necessary at a given offset in the image file */
> -        alloc_cluster_offset = *host_offset == INV_OFFSET ? INV_OFFSET :
> -                               start_of_cluster(s, *host_offset);
> -        ret = do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_offset,
> -                                      &nb_clusters);
> -        if (ret < 0) {
> -            goto fail;
> -        }
> -
> -        /* Can't extend contiguous allocation */
> -        if (nb_clusters == 0) {
> -            *bytes = 0;
> -            return 0;
> -        }
> -
> -        assert(alloc_cluster_offset != INV_OFFSET);
> +    /* Can't extend contiguous allocation */
> +    if (nb_clusters == 0) {
> +        *bytes = 0;
> +        ret = 0;
> +        goto out;
>       }
>   
> +    assert(alloc_cluster_offset != INV_OFFSET);
> +
>       /*
>        * Save info needed for meta data update.
>        *
> @@ -1496,13 +1525,14 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
>       *bytes = MIN(*bytes, nb_bytes - offset_into_cluster(s, guest_offset));
>       assert(*bytes != 0);
>   
> -    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes,
> -                      m, keep_old_clusters);
> +    calculate_l2_meta(bs, alloc_cluster_offset, guest_offset, *bytes, l2_slice,
> +                      m, false);
>   
> -    return 1;
> +    ret = 1;
>   
> -fail:
> -    if (*m && (*m)->nb_clusters > 0) {
> +out:
> +    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> +    if (ret < 0 && *m && (*m)->nb_clusters > 0) {
>           QLIST_REMOVE(*m, next_in_flight);
>       }


Hmm, unrelated to the patch, but why do we remove meta, which we didn't create?


-- 
Best regards,
Vladimir

