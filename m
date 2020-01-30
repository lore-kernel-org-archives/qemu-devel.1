Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D702082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qX5GnY1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D702082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34553 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixC9h-0001EX-F9
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixC8o-00008J-7T
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ixC8m-0002OZ-8D
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:54:01 -0500
Received: from mail-db8eur05on2136.outbound.protection.outlook.com
 ([40.107.20.136]:19936 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ixC8k-0002IO-Kc; Thu, 30 Jan 2020 10:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK+1Y5tdLB1YKfDZPDhusirYEvCr63jmpXqWPVaDZT6K7LFHuKtbwvufLY3+8XDRJr311RAk80FWQ9TKiEvNnfFjDx3LExlBj5a0Uzj0+vYO9htQejCmVgPvQ9Vw6Kqdlyt2YdOyEBsvFEllCv6oVgfGqeXA98fT26isuwZuXnGIo3oZBucLtnves5w9mXb9ME9qxltBOpGg4OHei/wtKQQk2K5+Fmw2nfBIoDk0Dl8nO1jDUIQZChQLbRQRyZVfTu21QwDjNuSwfR95+GdQtaa2YPk8BiMl8ZkrB/oPi7k8lmYJASrHDvyNjbYbHEvdfUrcfYjZyw92QfYbXB3gVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTkSMkgAAoTn4k+ed2DEzYH+dh20WmmnIyxw/aqZn94=;
 b=g/xaYLIZohWxLKoQ4WSa7/ngy0l8tBU5V/KSeX4OVRJz5lsleWJPqzjoCjLQWxMETgYPzlRg/oMZk/CyvyGzA56eF9TQBC5VFKkDm9cRhwmqrygfOGgj3diejVDiRhfotF27FcsDdaahkh4BqActfBIYCOJ59lePqUxuBc96uHP2mNKhQ5XLoATRwryTiXvDHZo4YWs/AsJ7cdAVAmoy7CAaXsxyI4irgbm5A/7vgpCsNqLQRFWdCx0QKVx5z3H10iPBV47Rex4n3PfncGytOpTi04rVKVqGrLUiwowE2TElAAO2GGoELLe1wTS1YB+LBG4B9DquxxyNVH/VnM63lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTkSMkgAAoTn4k+ed2DEzYH+dh20WmmnIyxw/aqZn94=;
 b=qX5GnY1agwICSPklUdJXJIwWeXtWsBHuBcIGXEapXbSlIQ9wqd6XMg35Z6hsgaGQJduro1Z3M4d3gLahCJaOw8PHm0HkMjEy1M6jP6IXNX255gYWw9f73lY+CK9kRi7YTbzbLE08Aj7SYBmK2vkGfP9EKUPqDPsMePFi1oVqQnk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB4005.eurprd08.prod.outlook.com (20.179.0.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Thu, 30 Jan 2020 15:53:55 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::8805:5633:ca46:c8c8%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 15:53:54 +0000
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <6c548cdd-f8c5-20a3-cce2-101e2f4436b0@virtuozzo.com>
Date: Thu, 30 Jan 2020 18:53:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191127180840.11937-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0258.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::34) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0258.eurprd05.prod.outlook.com (2603:10a6:3:fb::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 15:53:54 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6738ad88-dd20-43dd-c577-08d7a59c9bf6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB400592FF58BF4B73AAE94B5CF4040@AM6PR08MB4005.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(396003)(39850400004)(136003)(376002)(189003)(199004)(186003)(4326008)(31686004)(81156014)(8936002)(66946007)(8676002)(66476007)(81166006)(16526019)(66556008)(26005)(44832011)(53546011)(478600001)(2616005)(956004)(52116002)(2906002)(86362001)(36916002)(36756003)(5660300002)(316002)(16576012)(31696002)(6486002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4005;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xNVoDez8MdGKTfI/zOAWQeywQ+bM9dtnuGrYYKbNexhfwd05tiDeeIthAsAG3IXqpJi6Wk3lHCPK+7ocqzqz6RuAdS0N6F/Un1ORlRMoCAAAokveFMjnQM3CSv51LKbhFB36T3ntGvfHwfTVU76aGxi+fCnyo2bkFJLWIT7zp4amKBFQT3R6GdY+ZDOEyWmUup4kminbta+kU1HsqeRMvv6xs4i0t1ENFDLo2x0o7fL26ohyFHOwIOGnnoyqMultq7BmM8fvYgawzwhQmnf6mV2796HTOED71rKG7u2KtsEiVu89/yUzxs+Hljw0ErFpdhzjsEbpyRxxcWOAc++m5/C36ElJUsterelukoA5YoZEh0FBE/PNgpr9TWTtXWzWmJ1sHKwxfCboshaMbjpSH8RVng95OjmfpAlQ06rLLXlSTUOBEEebQ2DSJ+KHgQa
X-MS-Exchange-AntiSpam-MessageData: WOudQh+JgXkwWcWlACA3U8ZNkeLT5id6+eeVpFBYWufOG+d2Q1ebqFyBdkVFhSxOxYjp1Wnz10ch1iGrjGsN2UHO98dqP0YH4OXOZfxYsaSAHPV/TwPkCXIbkgqsp3FEzAQ9V1nAGH9FoGrS0RzrGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6738ad88-dd20-43dd-c577-08d7a59c9bf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 15:53:54.7965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+YOnYKlfIk+wreVqwiZimJiP3X1p7JPTAs6aFmzVPrfPp3GTeL+J3Y/PkhFLCj7Qz2dAkrM/6aJe0v4gNjWAdGbM4Xi6TA+qYPfnODXn7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4005
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.136
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 27/11/2019 21:08, Vladimir Sementsov-Ogievskiy wrote:
> Currently, block_copy operation lock the whole requested region. But
> there is no reason to lock clusters, which are already copied, it will
> disturb other parallel block_copy requests for no reason.
> 
> Let's instead do the following:
> 
> Lock only sub-region, which we are going to operate on. Then, after
> copying all dirty sub-regions, we should wait for intersecting
> requests block-copy, if they failed, we should retry these new dirty
> clusters.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 95 insertions(+), 21 deletions(-)
> 
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 20068cd699..aca44b13fb 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
>       return NULL;
>   }
>   
> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
> -                                                       int64_t offset,
> -                                                       int64_t bytes)
> +/*
> + * If there are no intersecting requests return false. Otherwise, wait for the
> + * first found intersecting request to finish and return true.
> + */
> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t start,
> +                                             int64_t end)
>   {
> -    BlockCopyInFlightReq *req;
> +    BlockCopyInFlightReq *req = block_copy_find_inflight_req(s, start, end);
>   
> -    while ((req = block_copy_find_inflight_req(s, offset, bytes))) {
> -        qemu_co_queue_wait(&req->wait_queue, NULL);
> +    if (!req) {
> +        return false;
>       }
> +
> +    qemu_co_queue_wait(&req->wait_queue, NULL);
> +
> +    return true;
>   }
>   
> +/* Called only on full-dirty region */
>   static void block_copy_inflight_req_begin(BlockCopyState *s,
>                                             BlockCopyInFlightReq *req,
>                                             int64_t offset, int64_t bytes)
>   {
> +    assert(!block_copy_find_inflight_req(s, offset, bytes));
> +
> +    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
> +
>       req->offset = offset;
>       req->bytes = bytes;
>       qemu_co_queue_init(&req->wait_queue);
>       QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>   }
>   
> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightReq *req)
> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *s,
> +        BlockCopyInFlightReq *req, int64_t new_bytes)
>   {
> +    if (new_bytes == req->bytes) {
> +        return;
> +    }
> +
> +    assert(new_bytes > 0 && new_bytes < req->bytes);
> +
> +    bdrv_set_dirty_bitmap(s->copy_bitmap,
> +                          req->offset + new_bytes, req->bytes - new_bytes);
> +
> +    req->bytes = new_bytes;
> +    qemu_co_queue_restart_all(&req->wait_queue);
> +}
> +
> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
> +                                                     BlockCopyInFlightReq *req,
> +                                                     int ret)

I suggest substituting the 'int ret' parameter with someone like 'bool 
set_dirty' and pass the expression 'ret < 0' as the input parameter in 
calling function. The 'int ret' is used in QEMU as a local return 
variable traditionally.

> +{
> +    if (ret < 0) {
> +        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
> +    }
>       QLIST_REMOVE(req, list);
>       qemu_co_queue_restart_all(&req->wait_queue);
>   }
> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
>       return ret;
>   }
>   
> -int coroutine_fn block_copy(BlockCopyState *s,
> -                            int64_t offset, uint64_t bytes,
> -                            bool *error_is_read)
> +/*
> + * block_copy_dirty_clusters
> + *
> + * Copy dirty clusters in @start/@bytes range.
> + * Returns 1 if dirty clusters found and successfully copied, 0 if no dirty
> + * clusters found and -errno on failure.
> + */
> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
> +                                                  int64_t offset, int64_t bytes,
> +                                                  bool *error_is_read)
>   {
>       int ret = 0;
> -    BlockCopyInFlightReq req;
> +    bool found_dirty = false;
>   
>       /*
>        * block_copy() user is responsible for keeping source and target in same
> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>       assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>       assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
>   
> -    block_copy_wait_inflight_reqs(s, offset, bytes);
> -    block_copy_inflight_req_begin(s, &req, offset, bytes);
> -
>       while (bytes) {
> +        BlockCopyInFlightReq req;
>           int64_t next_zero, cur_bytes, status_bytes;
>   
>           if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>               continue; /* already copied */
>           }
>   
> +        found_dirty = true;
> +
>           cur_bytes = MIN(bytes, s->copy_size);
>   
>           next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>               assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
>               cur_bytes = next_zero - offset;
>           }
> +        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
>   
>           ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
> +        block_copy_inflight_req_shrink(s, &req, status_bytes);
>           if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
> -            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes);
> +            block_copy_inflight_req_end(s, &req, 0);
>               s->progress_reset_callback(s->progress_opaque);
>               trace_block_copy_skip_range(s, offset, status_bytes);
>               offset += status_bytes;
> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
>   
>           trace_block_copy_process(s, offset);
>   
> -        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
> -
>           co_get_from_shres(s->mem, cur_bytes);
>           ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
>                                    error_is_read);
>           co_put_to_shres(s->mem, cur_bytes);
> +        block_copy_inflight_req_end(s, &req, ret);
>           if (ret < 0) {
> -            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
> -            break;
> +            return ret;
>           }
>   
>           s->progress_bytes_callback(cur_bytes, s->progress_opaque);
> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>           bytes -= cur_bytes;
>       }
>   
> -    block_copy_inflight_req_end(&req);
> +    return found_dirty;
> +}
>   
> -    return ret;
> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
> +                            bool *error_is_read)
> +{
> +    while (true) {
> +        int ret = block_copy_dirty_clusters(s, start, bytes, error_is_read);
> +
> +        if (ret < 0) {
> +            /*
> +             * IO operation failed, which means the whole block_copy request
> +             * failed.
> +             */
> +            return ret;
> +        }
> +        if (ret) {
> +            /*
> +             * Something was copied, which means that there were yield points
> +             * and some new dirty bits may appered (due to failed parallel
> +             * block-copy requests).
> +             */
> +            continue;
> +        }
> +
> +        /*
> +         * Here ret == 0, which means that there is no dirty clusters in
> +         * requested region.
> +         */
> +
> +        if (!block_copy_wait_one(s, start, bytes)) {
> +            /* No dirty bits and nothing to wait: the whole request is done */
> +            break;
> +        }
> +    }
> +
> +    return 0;
>   }
> 

-- 
With the best regards,
Andrey Shinkevich

