Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A1FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28BF2468F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="c4/yRQVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28BF2468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdvC-0007Hx-R0
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBdu3-0006OL-Bk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jBdu1-0001np-NT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:22:31 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com
 ([40.107.7.134]:58951 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jBdtw-0000ll-Fq; Tue, 10 Mar 2020 08:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4WzGJlc1MGFuMDbhZNPH2h5IjivcD05d93+32AKme4HLOYHQV9leO4MKEhBkI9hRLeAdclGpPyTvGDsI8ssAtRcENaUmlCIpKuUiQTGw3wW4aqkbHoJIDru1MUbb8za0rZyN0pQWHWxlxevtr3r6B3RUol39tfgvg7/gWMfEldjoBdWRPBIW4Fx/jKZY6rMCmdYVsco5DuRxVxV0nzRDlYN3MjrxeL/J42otxAZdyF4hrVgkFpegXfibCN5mGD6zzXLsutHpTNtEwtvcH553n5axl8x1MRZqblpZS/fXMktalUvQh36sCedNSLGQb1yL3MHBZbZBfWdPc43f/Vlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkGJJKmCNs4oHtRKeJmrz2UMdnNNBhd4rRQlwUu8+WA=;
 b=EtnqCq4DSOGAEGLoblu1L3rbUbmKFZh2gNBkusSOq+jtqaPfUkg4mMEKgwpg8ScY0D5PB0DeopQD1JtG/hefP3Ju4Z5h63tHPdgOSfO26QVZCWoC7zFfN9C/Is+lkoEgoZX/TLbN1go5L5llBbSN+2bg/vjd4Zcjoo2QBv2i8T98W1zNR9ZPDoTXksgef8lr4FVeF68UR5O6Rh2uM9uWbd+7/U1xaaCXVMXGvrtLP+A6JPihUtRaQlE/GKpQm4Dau1aqciD9t5XXwbWuuctx+XEu/PR4xKI3dZ+F1kXuJsqq2d7gV45RYgQk/zVDu8fI+na8On3T6a9gvwt8iPztKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkGJJKmCNs4oHtRKeJmrz2UMdnNNBhd4rRQlwUu8+WA=;
 b=c4/yRQViCyO1cIYTFYLggiH3DHRd6C4XL3djbmJHQkI26otU/0XnsYO4u06az8mvzb4fQOhrJ15aRaJ3Pbs7I6aXtIDB62HpXL6gTNbR1z9DznUOkinXf7fBURvehQoL/g09d98KJOiKSttFh2G0a/Q6nApMFcI816+HZUj4+eg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5063.eurprd08.prod.outlook.com (10.255.120.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 12:22:21 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::41e2:2f20:9b54:a0f5%7]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 12:22:21 +0000
Subject: Re: [PATCH v3 1/9] job: refactor progress to separate object
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-2-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <2807c754-8528-ee58-bf67-beeaea13cdfd@virtuozzo.com>
Date: Tue, 10 Mar 2020 15:22:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200306073831.7737-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0263.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::15) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0263.eurprd05.prod.outlook.com (2603:10a6:3:fc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 12:22:20 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2996ee74-ddf9-4a29-3509-08d7c4edae9e
X-MS-TrafficTypeDiagnostic: AM6PR08MB5063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50638D7DC54E5FE9374FEC30F4FF0@AM6PR08MB5063.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(136003)(39850400004)(346002)(366004)(199004)(189003)(66556008)(36916002)(53546011)(5660300002)(52116002)(316002)(66946007)(66476007)(6486002)(16576012)(86362001)(36756003)(2616005)(44832011)(2906002)(478600001)(16526019)(186003)(4326008)(956004)(81156014)(81166006)(31696002)(31686004)(8936002)(8676002)(26005)(309714004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5063;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8u+vRzNUDaVv9ecL+zUBnu1lloktbbfmx4R3632uO8gOztteXgceaAvgWceMS8rGIHuPPQdu3TRzMD+iuB/w3R5WTrJAzrCU7cEkXA8yRAoHDC/Vo8ZTkN4AdnvCwjc6aBd2xjkv6H4bm8qedBXSuuDdAO+sZEJ5nugau4FyTVa0S1v0XUofr378dHx14LSzKu/BG7lbdcLuCojAy20smNhuIgFY8jBttOJUjhZKOa/PEIhKbiHS2wxG0hwIxj0e4+bNfEWBQQz6OYZgwp8EBItTvDMy+5Xz/LhyN7mDD2ISRB7Yu5Z4goDgOxfTWHxaZuBGMfW8TJe+NHmgKXcPNooP8ocaVjt5+UHy05QlBSRKy5tYfsa+Rhds+7v+aEEd/r8bWyGpnWimt0/9ymnt8lD5G+2ZxHtu79DN2v6Dlk/5Zh/Xx0CZeg4+7TaVBqj5LrNGqkdMmdN2Iw/j1k2Of3eygLhjpbwcIpigGb0f1eikHukgyXm3mtiQ01oi2Nt
X-MS-Exchange-AntiSpam-MessageData: fsFQinJXhpiSo+rMhtJks0TKIOkLgqaH67Vzp3Wn0IY/2AFlOlGBRa2G9mXarxh81U5psiW8/HYAVMp6xba/ipBSvjxGkJmjBAKPmDAVC7Lbp/ESnRv7GhH3iFOHLZ4VW1QfmhHVKGvX8t8pkz56xw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2996ee74-ddf9-4a29-3509-08d7c4edae9e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 12:22:21.3430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkznZjutOsaXQvjhxq9h3xZky91/5SjxzFv0OifeoU+j7S7h8ijB80lj2Zh+cHuABeU+9zNYuYMhcccnir8xnhWZ+XmHkQDTJx24lJwSo08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5063
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.134
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
Cc: kwolf@redhat.com, qemu-stable@nongnu.org, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/03/2020 10:38, Vladimir Sementsov-Ogievskiy wrote:
> We need it in separate to pass to the block-copy object in the next
> commit.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   include/qemu/job.h            | 11 ++-----
>   include/qemu/progress_meter.h | 58 +++++++++++++++++++++++++++++++++++
>   blockjob.c                    | 16 +++++-----
>   job-qmp.c                     |  4 +--
>   job.c                         |  6 ++--
>   qemu-img.c                    |  6 ++--
>   6 files changed, 76 insertions(+), 25 deletions(-)
>   create mode 100644 include/qemu/progress_meter.h
> 
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index bd59cd8944..32aabb1c60 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -28,6 +28,7 @@
>   
>   #include "qapi/qapi-types-job.h"
>   #include "qemu/queue.h"
> +#include "qemu/progress_meter.h"
>   #include "qemu/coroutine.h"
>   #include "block/aio.h"
>   
> @@ -117,15 +118,7 @@ typedef struct Job {
>       /** True if this job should automatically dismiss itself */
>       bool auto_dismiss;
>   
> -    /**
> -     * Current progress. The unit is arbitrary as long as the ratio between
> -     * progress_current and progress_total represents the estimated percentage
> -     * of work already done.
> -     */
> -    int64_t progress_current;
> -
> -    /** Estimated progress_current value at the completion of the job */
> -    int64_t progress_total;
> +    ProgressMeter progress;
>   
>       /**
>        * Return code from @run and/or @prepare callback(s).
> diff --git a/include/qemu/progress_meter.h b/include/qemu/progress_meter.h
> new file mode 100644
> index 0000000000..9a23ff071c
> --- /dev/null
> +++ b/include/qemu/progress_meter.h
> @@ -0,0 +1,58 @@
> +/*
> + * Helper functionality for some process progress tracking.
> + *
> + * Copyright (c) 2011 IBM Corp.
> + * Copyright (c) 2012, 2018 Red Hat, Inc.
> + * Copyright (c) 2020 Virtuozzo International GmbH
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef QEMU_PROGRESS_METER_H
> +#define QEMU_PROGRESS_METER_H
> +
> +typedef struct ProgressMeter {
> +    /**
> +     * Current progress. The unit is arbitrary as long as the ratio between
> +     * current and total represents the estimated percentage
> +     * of work already done.
> +     */
> +    uint64_t current;
> +
> +    /** Estimated current value at the completion of the process */
> +    uint64_t total;
> +} ProgressMeter;
> +
> +static inline void progress_work_done(ProgressMeter *pm, uint64_t done)
> +{
> +    pm->current += done;
> +}
> +
> +static inline void progress_set_remaining(ProgressMeter *pm, uint64_t remaining)
> +{
> +    pm->total = pm->current + remaining;
> +}
> +
> +static inline void progress_increase_remaining(ProgressMeter *pm,
> +                                               uint64_t delta)
> +{
> +    pm->total += delta;
> +}
> +
> +#endif /* QEMU_PROGRESS_METER_H */
> diff --git a/blockjob.c b/blockjob.c
> index 5d63b1e89d..fc850312c1 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -299,8 +299,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
>       info->device    = g_strdup(job->job.id);
>       info->busy      = atomic_read(&job->job.busy);
>       info->paused    = job->job.pause_count > 0;
> -    info->offset    = job->job.progress_current;
> -    info->len       = job->job.progress_total;
> +    info->offset    = job->job.progress.current;
> +    info->len       = job->job.progress.total;
>       info->speed     = job->speed;
>       info->io_status = job->iostatus;
>       info->ready     = job_is_ready(&job->job),
> @@ -330,8 +330,8 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
>   
>       qapi_event_send_block_job_cancelled(job_type(&job->job),
>                                           job->job.id,
> -                                        job->job.progress_total,
> -                                        job->job.progress_current,
> +                                        job->job.progress.total,
> +                                        job->job.progress.current,
>                                           job->speed);
>   }
>   
> @@ -350,8 +350,8 @@ static void block_job_event_completed(Notifier *n, void *opaque)
>   
>       qapi_event_send_block_job_completed(job_type(&job->job),
>                                           job->job.id,
> -                                        job->job.progress_total,
> -                                        job->job.progress_current,
> +                                        job->job.progress.total,
> +                                        job->job.progress.current,
>                                           job->speed,
>                                           !!msg,
>                                           msg);
> @@ -379,8 +379,8 @@ static void block_job_event_ready(Notifier *n, void *opaque)
>   
>       qapi_event_send_block_job_ready(job_type(&job->job),
>                                       job->job.id,
> -                                    job->job.progress_total,
> -                                    job->job.progress_current,
> +                                    job->job.progress.total,
> +                                    job->job.progress.current,
>                                       job->speed);
>   }
>   
> diff --git a/job-qmp.c b/job-qmp.c
> index fbfed25a00..fecc939ebd 100644
> --- a/job-qmp.c
> +++ b/job-qmp.c
> @@ -143,8 +143,8 @@ static JobInfo *job_query_single(Job *job, Error **errp)
>           .id                 = g_strdup(job->id),
>           .type               = job_type(job),
>           .status             = job->status,
> -        .current_progress   = job->progress_current,
> -        .total_progress     = job->progress_total,
> +        .current_progress   = job->progress.current,
> +        .total_progress     = job->progress.total,
>           .has_error          = !!job->err,
>           .error              = job->err ? \
>                                 g_strdup(error_get_pretty(job->err)) : NULL,
> diff --git a/job.c b/job.c
> index 04409b40aa..134a07b92e 100644
> --- a/job.c
> +++ b/job.c
> @@ -369,17 +369,17 @@ void job_unref(Job *job)
>   
>   void job_progress_update(Job *job, uint64_t done)
>   {
> -    job->progress_current += done;
> +    progress_work_done(&job->progress, done);
>   }
>   
>   void job_progress_set_remaining(Job *job, uint64_t remaining)
>   {
> -    job->progress_total = job->progress_current + remaining;
> +    progress_set_remaining(&job->progress, remaining);
>   }
>   
>   void job_progress_increase_remaining(Job *job, uint64_t delta)
>   {
> -    job->progress_total += delta;
> +    progress_increase_remaining(&job->progress, delta);
>   }
>   
>   void job_event_cancelled(Job *job)
> diff --git a/qemu-img.c b/qemu-img.c
> index 804630a368..59a720abf6 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -882,9 +882,9 @@ static void run_block_job(BlockJob *job, Error **errp)
>       do {
>           float progress = 0.0f;
>           aio_poll(aio_context, true);
> -        if (job->job.progress_total) {
> -            progress = (float)job->job.progress_current /
> -                       job->job.progress_total * 100.f;
> +        if (job->job.progress.total) {
> +            progress = (float)job->job.progress.current /
> +                       job->job.progress.total * 100.f;
>           }
>           qemu_progress_print(progress, 0);
>       } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

