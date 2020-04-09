Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F503C2D0EA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C14206F7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 06:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wYr4Zd+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C14206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMR1Q-0007E1-FF
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 02:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMR0e-0006fE-TU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jMR0d-0006Tl-In
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 02:49:56 -0400
Received: from mail-am6eur05on2100.outbound.protection.outlook.com
 ([40.107.22.100]:54721 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jMR0Y-0006Os-IH; Thu, 09 Apr 2020 02:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8ButHiQngoNB25esXDdtNV2wFFGRiVs7Bhml+u3hTgUcb2AQEItQwYZTkcp8cfcKs355wi3Qv2TiEp8t3rw3Nd10zbvHtSgVl6R3/89lhjsggJyWUzDsOWqapvaJNwk+pQb53SBwJlcEdceSGIApmhgITmO72kglDLxbRiW7gmsDFT8vzcIrightxyUbxcIC9YFvEGLdXnd8k0SWuX7CeH9hkKyTWSeut+Dw8WV+y3o1E8PjV36I/PUzxYpURrwhRfsvKYMklzDnA50sAXnu1l3aYqs49Elup4pWO2gMtFmDWZCzYe4jUMXgHX9tF2fJ+TNbF5DmtYsuG+85lzEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iZ4ypS9VgVdxMZ9KE497HWy+tjd6i+OhD7qf780/24=;
 b=OJvMgbPiWZEtXaXGG3toF6jLsDDkTEu/vR/FcbRT3EbmSMiqcFmGVsS+21e9/qX544ZMKu9FSTSjpv8gFXyDjApj+6gxl/Zy8qH024ydL91IEL6L9jXZNs/aoL4ZI+jZ7b2b1igSbcmt2Px23HIQSeRChF6rNmURj8BCmr3N5ylxEUo+8o6GC60h6QA4UaH8TPIykEsifMvwzvOzfsEdUNePvY4BZKJ961vRHtfx6cyOAL+BHfhehYzldwvSr6GUvc51nLZsinpAUUPX+karYiG2IM5GsnNNgZIPrK6UV4IdnHj5GaNGWOatyQh4zs5VF7mUAe9aiVdwxjTkxmxW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iZ4ypS9VgVdxMZ9KE497HWy+tjd6i+OhD7qf780/24=;
 b=wYr4Zd+Kav/Pv/f7eMfFPzzpvdqC2cDkYTp5gIJ9vKfqjr2oY/osqApXdmrSss8G2kjE9NdHj0LJg+PZK6jw4ddV2IMZdRGivDQPsKpXxF4ptpVw7ckvfsGgY2XnIkBqz7nnRFBr+ZvIYGHIJ7oEY//hpdaqTWw2d9YbJeoLgpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 06:49:47 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 06:49:47 +0000
Subject: Re: [PATCH v4 01/30] qcow2: Make Qcow2AioTask store the full host
 offset
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200409094944549
Message-ID: <f8576554-c785-1553-a463-201ac1f36cad@virtuozzo.com>
Date: Thu, 9 Apr 2020 09:49:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <d5e20c41da4fa7821704ad1125167fd507eaf7a7.1584468723.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.186) by
 ZR0P278CA0007.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 06:49:45 +0000
X-Tagtoolbar-Keys: D20200409094944549
X-Originating-IP: [185.215.60.186]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b170a32-9579-4003-585f-08d7dc523120
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336E4FD084A9952ADB89DFCC1C10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(366004)(39830400003)(376002)(396003)(136003)(66946007)(2616005)(4326008)(6486002)(31686004)(31696002)(107886003)(2906002)(956004)(5660300002)(66556008)(16576012)(8936002)(86362001)(186003)(8676002)(54906003)(52116002)(478600001)(66476007)(81166007)(316002)(81156014)(26005)(36756003)(16526019);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7a152bHs5DgtRlfTmdLvk9emYVe29L/zSp1yD5kj2FAYcQahz1JdWnlq/EoHoyurRs5yH96agP+DIsFzJ4XtgITGktSfkbWp6b/lx/1Nqyne8fHIU1qHGG4/dTnmFfqc2qYPCX1firSEfNRlawp+VVCHHLXmFY6U3jJsd9WQuO7zHDCKWd0ijiXUAAzmERK037TToxAFBPUnk+NAzFtSRwwThenTncVq1dwPbpz2EZ9X15xEN3ZsXVgsl3a2SYvgnImPF3L4bIIDnEXlDlI4CZjffwjJ9wtTONvQ3/Xw6gLYD9KZDyeVpuzKw3qpJazzYT5gwtoIXLW74tCRO8wIuhvgnjvXs59IX2Bvej5cD/x89hxD/TnQ71Z+oh5TNFxhthjyGnMR3Yist36v//Mhv0QfHnWrHdiuiR2yX+ZikS75DXmJZ0Xs6dq2bLdrwWgL
X-MS-Exchange-AntiSpam-MessageData: 4eSTDekgiMMef6X3PnNqLlc3fXDFoOuPcoXnubL8vbbdSTTRgf8Rq+5UlgxOmY+XunvsXBy+/yunh5OQ4WczHb9DmdCLeFoOOBYjtrYKRLgTbN+dtb85Hsk3n9ABRGcTDK3DGYbSzUYuGCANnh1TPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b170a32-9579-4003-585f-08d7dc523120
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 06:49:47.0476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +g/70Xf+P0ARzOpv1v65AOvbhG+BeCVHl8pfvKYPwQ+NLvKztB0HeIMuDCl01NYNcCbqtwan3IIpfU+uvUb0rjMtDV96meVuDyQ2ifP/6Yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.22.100
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

17.03.2020 21:15, Alberto Garcia wrote:
> The file_cluster_offset field of Qcow2AioTask stores a cluster-aligned
> host offset. In practice this is not very useful because all users(*)
> of this structure need the final host offset into the cluster, which
> they calculate using
> 
>     host_offset = file_cluster_offset + offset_into_cluster(s, offset)
> 
> There is no reason why Qcow2AioTask cannot store host_offset directly
> and that is what this patch does.
> 
> (*) compressed clusters are the exception: in this case what
>      file_cluster_offset was storing was the full compressed cluster
>      descriptor (offset + size). This does not change with this patch
>      but it is documented now.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c | 68 +++++++++++++++++++++++++--------------------------
>   1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d44b45633d..a00b0c8e45 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -74,7 +74,7 @@ typedef struct {
>   
>   static int coroutine_fn
>   qcow2_co_preadv_compressed(BlockDriverState *bs,
> -                           uint64_t file_cluster_offset,
> +                           uint64_t cluster_descriptor,
>                              uint64_t offset,
>                              uint64_t bytes,
>                              QEMUIOVector *qiov,
> @@ -2041,7 +2041,7 @@ out:
>   
>   static coroutine_fn int
>   qcow2_co_preadv_encrypted(BlockDriverState *bs,
> -                           uint64_t file_cluster_offset,
> +                           uint64_t host_offset,
>                              uint64_t offset,
>                              uint64_t bytes,
>                              QEMUIOVector *qiov,
> @@ -2068,16 +2068,12 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
>       }
>   
>       BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
> -    ret = bdrv_co_pread(s->data_file,
> -                        file_cluster_offset + offset_into_cluster(s, offset),
> -                        bytes, buf, 0);
> +    ret = bdrv_co_pread(s->data_file, host_offset, bytes, buf, 0);
>       if (ret < 0) {
>           goto fail;
>       }
>   
> -    if (qcow2_co_decrypt(bs,
> -                         file_cluster_offset + offset_into_cluster(s, offset),
> -                         offset, buf, bytes) < 0)
> +    if (qcow2_co_decrypt(bs, host_offset, offset, buf, bytes) < 0)
>       {
>           ret = -EIO;
>           goto fail;
> @@ -2095,7 +2091,7 @@ typedef struct Qcow2AioTask {
>   
>       BlockDriverState *bs;
>       QCow2ClusterType cluster_type; /* only for read */
> -    uint64_t file_cluster_offset;
> +    uint64_t host_offset; /* or full descriptor in compressed clusters */
>       uint64_t offset;
>       uint64_t bytes;
>       QEMUIOVector *qiov;
> @@ -2108,7 +2104,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
>                                          AioTaskPool *pool,
>                                          AioTaskFunc func,
>                                          QCow2ClusterType cluster_type,
> -                                       uint64_t file_cluster_offset,
> +                                       uint64_t host_offset,
>                                          uint64_t offset,
>                                          uint64_t bytes,
>                                          QEMUIOVector *qiov,
> @@ -2123,7 +2119,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
>           .bs = bs,
>           .cluster_type = cluster_type,
>           .qiov = qiov,
> -        .file_cluster_offset = file_cluster_offset,
> +        .host_offset = host_offset,
>           .offset = offset,
>           .bytes = bytes,
>           .qiov_offset = qiov_offset,
> @@ -2132,7 +2128,7 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
>   
>       trace_qcow2_add_task(qemu_coroutine_self(), bs, pool,
>                            func == qcow2_co_preadv_task_entry ? "read" : "write",
> -                         cluster_type, file_cluster_offset, offset, bytes,
> +                         cluster_type, host_offset, offset, bytes,

Please, update also the trace-point in block/trace-events

>                            qiov, qiov_offset);
>   
>       if (!pool) {
> @@ -2146,13 +2142,12 @@ static coroutine_fn int qcow2_add_task(BlockDriverState *bs,
>   


Maybe, add comment
/* host_offset: host offset, or cluster descriptor for compressed cluster */
>   static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
>                                                QCow2ClusterType cluster_type,
> -                                             uint64_t file_cluster_offset,
> +                                             uint64_t host_offset,
>                                                uint64_t offset, uint64_t bytes,
>                                                QEMUIOVector *qiov,
>                                                size_t qiov_offset)
>   {
>       BDRVQcow2State *s = bs->opaque;
> -    int offset_in_cluster = offset_into_cluster(s, offset);
>   
>       switch (cluster_type) {
>       case QCOW2_CLUSTER_ZERO_PLAIN:
> @@ -2168,19 +2163,17 @@ static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
>                                      qiov, qiov_offset, 0);
>   
>       case QCOW2_CLUSTER_COMPRESSED:
> -        return qcow2_co_preadv_compressed(bs, file_cluster_offset,
> +        return qcow2_co_preadv_compressed(bs, host_offset,
>                                             offset, bytes, qiov, qiov_offset);
>   
>       case QCOW2_CLUSTER_NORMAL:
> -        assert(offset_into_cluster(s, file_cluster_offset) == 0);
>           if (bs->encrypted) {
> -            return qcow2_co_preadv_encrypted(bs, file_cluster_offset,
> +            return qcow2_co_preadv_encrypted(bs, host_offset,
>                                                offset, bytes, qiov, qiov_offset);
>           }
>   
>           BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
> -        return bdrv_co_preadv_part(s->data_file,
> -                                   file_cluster_offset + offset_in_cluster,
> +        return bdrv_co_preadv_part(s->data_file, host_offset,
>                                      bytes, qiov, qiov_offset, 0);
>   
>       default:
> @@ -2196,7 +2189,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
>   
>       assert(!t->l2meta);
>   
> -    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->file_cluster_offset,
> +    return qcow2_co_preadv_task(t->bs, t->cluster_type, t->host_offset,
>                                   t->offset, t->bytes, t->qiov, t->qiov_offset);
>   }
>   
> @@ -2232,11 +2225,20 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
>           {
>               qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
>           } else {
> +            /*
> +             * For compressed clusters the variable cluster_offset
> +             * does not actually store the offset but the full
> +             * descriptor. We need to leave it unchanged because
> +             * that's what qcow2_co_preadv_compressed() expects.
> +             */

Hmm, good to document it for qcow2_get_cluster_offset function. May be you did it in next patch.

With at least updated trace-event:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

