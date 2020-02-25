Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64977C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210452072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qlwUl7mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210452072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6chk-0007Z5-9V
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6ch4-00071k-GF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6ch2-0004Fn-L0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:04:22 -0500
Received: from mail-db8eur05on2093.outbound.protection.outlook.com
 ([40.107.20.93]:60884 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6cgx-0004AP-4o; Tue, 25 Feb 2020 11:04:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES4bVNf2DnO630B9UlUVesTtyFjfclmqKY5cOQ4Vh4dXbzGJ+GbRYhI9j0+PBUfstuhcA/SYjj0tUntAs2Kx+3RlKsEhy6052x02U0oLPZSCJUo58ztLXipKR1uvIuJeqRd3+3YJ0pJA99vSCoa4WeyruuPKupo9gnFjtx+R1empHS4T4itPGxLwnc4HbIzjvaEFPpkOw/GhVz6rRctxRTRBxMozhM9XQtn5TP9vFphchwLAkqwzzPVM1YhQBzBFDFacEJPXPf/9WyTIIZPbq+ttZ7sjMMQlgUB+3+NkZl/6oLiKllb7gB9lIb60zVpyQmWwugVZLCaDkzpDBxdflA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=navoHTVyL/7mYsiKNDFJkkSI1AF+Ghn26CnCDzOxSCA=;
 b=P9uGtzCFWSKKRPhAXeqR+CzcbYHCnMosgaGQYy1lw4pGXcG3td1aLXjpncFuOmyN1cNvGZ6Ddl6qouu1yUeYsFmgEA8n7cYI/Qwl/dCXo9613bHTbobtfWBIXegawRytoWKrJPNuaCWcJx0QgXQdQ3CJfaeY/acEAi3QhgToh0fI2yCNvOuv1QEXYSN8cYsaAy9VTZYyMYe5jRZrCWYtEQzvNc83OMQx/IdLwbAeF7s8NtselhVwgpjSLphVp75JCCrzvmc6aus4e8NWaW0lAhaNq9YKruQhfWgl59A7na8y5eZAmCNjMEfglc29iBru99d+YG1Kr/mBtXVHVcvDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=navoHTVyL/7mYsiKNDFJkkSI1AF+Ghn26CnCDzOxSCA=;
 b=qlwUl7mFC3JhbjBw0CKFzZhuTFKGC9v82BTHuPMYuUti1KOIeqAUDyt7dsszRMMRpVOJeUJxl5nsmx8EVsVImcwI5jZVSd4IAEyU810YEhUg5Uz87QXhRUBcOlOdwUUAV9pp1+qt7DA/cG42hDobZt6CPm9bfpcKIlomW2MjeHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5270.eurprd08.prod.outlook.com (10.255.121.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 16:04:12 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 16:04:12 +0000
Subject: Re: [PATCH 1/6] block: add bitmap-populate job
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-2-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225190409713
Message-ID: <ede1d2b6-0af9-0002-dc33-b82aa870119f@virtuozzo.com>
Date: Tue, 25 Feb 2020 19:04:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200225005641.5478-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0501CA0015.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::25) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0501CA0015.eurprd05.prod.outlook.com (2603:10a6:3:1a::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 25 Feb 2020 16:04:11 +0000
X-Tagtoolbar-Keys: D20200225190409713
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c31cb44-acf5-4904-c983-08d7ba0c5ab8
X-MS-TrafficTypeDiagnostic: AM6PR08MB5270:
X-Microsoft-Antispam-PRVS: <AM6PR08MB527086E2179E320B352F451DC1ED0@AM6PR08MB5270.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(81156014)(8676002)(2616005)(81166006)(16576012)(66556008)(956004)(26005)(66946007)(66476007)(186003)(16526019)(478600001)(8936002)(30864003)(5660300002)(36756003)(7416002)(86362001)(52116002)(31686004)(6486002)(54906003)(316002)(31696002)(2906002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5270;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vTS+D325xLR1VJMJ95hM/KPSolM578vhnVp7hPsp+0UuvDhaISFwQFeIK9eForwaOnm/QIRkcsfsVJXm3p1r2UZeAYvACNpnO5sR6HGaVfStDizuvqTiI9U1P/RWYFh10B801NRjVEqf2rPMEgOt7YObpbd591n4hurxgo1haLXICJ4ujihNE2AdfpKt839MT6OgLKc+3MPTDcEdRrBb75BYqpHgJTGu7THYJQGjVql4GhWI/pWdsrMC9EuDlrjg98ARgwjzBtb6zUPSYRvfjzQA3SSnpA+7F2Upxveugxk5hR6CAPiBncEtYJd9zFlAzAH82p5UDc2AsWqksR3MtiuEyi3Zb+PGE/eonbPXSUfNSSNoWqH4t0ynDo8IFZtxs64GdW8x21EVS0Etdvi+GqqbD2+k9/jAWmlrgk47HWq1iHLNy0NxmEgv+t6bdZ+z
X-MS-Exchange-AntiSpam-MessageData: buv/or+xaV0kZ+x7wj4lWaRYHoFB7AEumzJeDH/X5nC0tNpdvQot4Nw42qpefJ6JhOoHomfnovbXG4XFF4TXBBRlXoIyxj1ENcEnr2+DRwkdZ36k++Djf9qdhRFU8vlRp3G+12jV5ECsTnOf1HrQsg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c31cb44-acf5-4904-c983-08d7ba0c5ab8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 16:04:12.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJaBepdwQdKJ3nHdhsIrTX0tH7XXVnTiD1H8dJ9asU5IVnNBirVpDwm8HgNQyucPioY5hJZzqDr8oFEPNWgoUaDckCeyzpYbuHDEMt7kGkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5270
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.20.93
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 3:56, John Snow wrote:
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
> 
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/block-core.json      |  48 +++++++++
>   qapi/job.json             |   2 +-
>   include/block/block_int.h |  21 ++++
>   block/bitmap-alloc.c      | 207 ++++++++++++++++++++++++++++++++++++++
>   blockjob.c                |   3 +-
>   block/Makefile.objs       |   1 +
>   6 files changed, 280 insertions(+), 2 deletions(-)
>   create mode 100644 block/bitmap-alloc.c
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 85e27bb61f..df1797681a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2245,6 +2245,54 @@
>         { 'command': 'block-dirty-bitmap-merge',
>           'data': 'BlockDirtyBitmapMerge' }
>   
> +##
> +# @BitmapPattern:
> +#
> +# An enumeration of possible patterns that can be written into a bitmap.
> +#
> +# @allocation-top: The allocation status of the top layer
> +#                  of the attached storage node.
> +#
> +# Since: 5.0
> +##
> +{ 'enum': 'BitmapPattern',
> +  'data': ['allocation-top'] }
> +
> +##
> +# @BlockDirtyBitmapPopulate:
> +#
> +# @job-id: identifier for the newly-created block job.
> +#
> +# @pattern: What pattern should be written into the bitmap?
> +#
> +# @on-error: the action to take if an error is encountered on a bitmap's
> +#            attached node, default 'report'.
> +#            'stop' and 'enospc' can only be used if the block device supports
> +#            io-status (see BlockInfo).
> +#
> +# @auto-finalize: When false, this job will wait in a PENDING state after it has
> +#                 finished its work, waiting for @block-job-finalize before
> +#                 making any block graph changes.

sounds a bit strange in context of bitmap-population job

> +#                 When true, this job will automatically
> +#                 perform its abort or commit actions.
> +#                 Defaults to true.
> +#
> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> +#                has completely ceased all work, and awaits @block-job-dismiss.
> +#                When true, this job will automatically disappear from the query
> +#                list without user intervention.
> +#                Defaults to true.
> +#
> +# Since: 5.0
> +##
> +{ 'struct': 'BlockDirtyBitmapPopulate',
> +  'base': 'BlockDirtyBitmap',
> +  'data': { 'job-id': 'str',
> +            'pattern': 'BitmapPattern',
> +            '*on-error': 'BlockdevOnError',
> +            '*auto-finalize': 'bool',
> +            '*auto-dismiss': 'bool' } }
> +
>   ##
>   # @BlockDirtyBitmapSha256:
>   #
> diff --git a/qapi/job.json b/qapi/job.json
> index 5e658281f5..5f496d4630 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -22,7 +22,7 @@
>   # Since: 1.7
>   ##
>   { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'bitmap-populate'] }
>   
>   ##
>   # @JobStatus:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 6f9fd5e20e..a5884b597e 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -1215,6 +1215,27 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
>                               BlockCompletionFunc *cb, void *opaque,
>                               JobTxn *txn, Error **errp);
>   
> +/*
> + * bitpop_job_create: Create a new bitmap population job.
> + *
> + * @job_id: The id of the newly-created job.
> + * @bs: Block device associated with the @target_bitmap.
> + * @target_bitmap: The bitmap to populate.
> + * @on_error: What to do if an error on @bs is encountered.
> + * @creation_flags: Flags that control the behavior of the Job lifetime.
> + *                  See @BlockJobCreateFlags
> + * @cb: Completion function for the job.
> + * @opaque: Opaque pointer value passed to @cb.
> + * @txn: Transaction that this job is part of (may be NULL).
> + */
> +BlockJob *bitpop_job_create(const char *job_id, BlockDriverState *bs,
> +                            BdrvDirtyBitmap *target_bitmap,
> +                            BitmapPattern pattern,
> +                            BlockdevOnError on_error,
> +                            int creation_flags,
> +                            BlockCompletionFunc *cb, void *opaque,
> +                            JobTxn *txn, Error **errp);
> +
>   void hmp_drive_add_node(Monitor *mon, const char *optstr);
>   
>   BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
> diff --git a/block/bitmap-alloc.c b/block/bitmap-alloc.c
> new file mode 100644
> index 0000000000..47d542dc12
> --- /dev/null
> +++ b/block/bitmap-alloc.c
> @@ -0,0 +1,207 @@
> +/*
> + * Async Dirty Bitmap Populator
> + *
> + * Copyright (C) 2020 Red Hat, Inc.
> + *
> + * Authors:
> + *  John Snow <jsnow@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "trace.h"
> +#include "block/block.h"
> +#include "block/block_int.h"
> +#include "block/blockjob_int.h"
> +#include "block/block_backup.h"
> +#include "block/block-copy.h"

I hope, not all includes are needed :)

> +#include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
> +#include "qemu/ratelimit.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/block-backend.h"
> +#include "qemu/bitmap.h"
> +#include "qemu/error-report.h"
> +
> +typedef struct BitpopBlockJob {
> +    BlockJob common;
> +    BlockDriverState *bs;
> +    BdrvDirtyBitmap *target_bitmap;
> +    BdrvDirtyBitmap *new_bitmap;
> +    BlockdevOnError on_error;
> +    uint64_t len;
> +} BitpopBlockJob;
> +
> +static const BlockJobDriver bitpop_job_driver;
> +
> +static void bitpop_commit(Job *job)
> +{
> +    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
> +
> +    bdrv_dirty_bitmap_merge_internal(s->target_bitmap, s->new_bitmap,
> +                                     NULL, true);

Hmm, so you populate new_bitmap, and then merge to target. Why can't we work
directly with target bitmap? The most probable case is that libvirt will
create bitmap specifically to use as target in this operation, or not?

Hmm, just to make it possible to cancel the job and keep the target bitmap in
original state? Is it really needed? I think on failure target bitmap will be
removed anyway..

> +}
> +
> +/* no abort needed; just clean without committing. */
> +
> +static void bitpop_clean(Job *job)
> +{
> +    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
> +
> +    bdrv_release_dirty_bitmap(s->new_bitmap);
> +    bdrv_dirty_bitmap_set_busy(s->target_bitmap, false);
> +}
> +
> +static BlockErrorAction bitpop_error_action(BitpopBlockJob *job, int error)
> +{
> +    return block_job_error_action(&job->common, job->on_error, true, error);
> +}
> +
> +static bool coroutine_fn yield_and_check(Job *job)
> +{
> +    if (job_is_cancelled(job)) {
> +        return true;
> +    }
> +
> +    job_sleep_ns(job, 0);
> +
> +    if (job_is_cancelled(job)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static int coroutine_fn bitpop_run(Job *job, Error **errp)
> +{
> +    BitpopBlockJob *s = container_of(job, BitpopBlockJob, common.job);
> +    int ret = 0;
> +    int64_t offset;
> +    int64_t count;
> +    int64_t bytes;
> +
> +    for (offset = 0; offset < s->len; ) {
> +        if (yield_and_check(job)) {
> +            ret = -ECANCELED;
> +            break;
> +        }
> +
> +        bytes = s->len - offset;
> +        ret = bdrv_is_allocated(s->bs, offset, bytes, &count);
> +        if (ret < 0) {
> +            if (bitpop_error_action(s, -ret) == BLOCK_ERROR_ACTION_REPORT) {
> +                break;
> +            }
> +            continue;
> +        }
> +
> +        if (!count) {
> +            ret = 0;

Hmm, I think it's impossible case.. If so, better to make an assertion or ignore..

> +            break;
> +        }
> +
> +        if (ret) {
> +            bdrv_set_dirty_bitmap(s->new_bitmap, offset, count);
> +            ret = 0;
> +        }
> +
> +        job_progress_update(job, count);
> +        offset += count;
> +    }
> +
> +    return ret;
> +}
> +
> +static const BlockJobDriver bitpop_job_driver = {
> +    .job_driver = {
> +        .instance_size          = sizeof(BitpopBlockJob),
> +        .job_type               = JOB_TYPE_BITMAP_POPULATE,
> +        .free                   = block_job_free,
> +        .user_resume            = block_job_user_resume,
> +        .run                    = bitpop_run,
> +        .commit                 = bitpop_commit,
> +        .clean                  = bitpop_clean,
> +    }
> +};
> +
> +
> +BlockJob *bitpop_job_create(
> +    const char *job_id,
> +    BlockDriverState *bs,
> +    BdrvDirtyBitmap *target_bitmap,
> +    BitmapPattern pattern,
> +    BlockdevOnError on_error,
> +    int creation_flags,
> +    BlockCompletionFunc *cb,
> +    void *opaque,
> +    JobTxn *txn,
> +    Error **errp)
> +{
> +    int64_t len;
> +    BitpopBlockJob *job = NULL;
> +    int64_t cluster_size;
> +    BdrvDirtyBitmap *new_bitmap = NULL;
> +
> +    assert(bs);
> +    assert(target_bitmap);
> +
> +    if (!bdrv_is_inserted(bs)) {
> +        error_setg(errp, "Device is not inserted: %s",
> +                   bdrv_get_device_name(bs));
> +        return NULL;
> +    }

Why this?

> +
> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
> +        return NULL;
> +    }

and this?

> +
> +    if (bdrv_dirty_bitmap_check(target_bitmap, BDRV_BITMAP_DEFAULT, errp)) {
> +        return NULL;
> +    }
> +
> +    if (pattern != BITMAP_PATTERN_ALLOCATION_TOP) {
> +        error_setg(errp, "Unrecognized bitmap pattern");
> +        return NULL;
> +    }
> +
> +    len = bdrv_getlength(bs);
> +    if (len < 0) {
> +        error_setg_errno(errp, -len, "unable to get length for '%s'",
> +                         bdrv_get_device_name(bs));
> +        return NULL;
> +    }
> +
> +    /* NB: new bitmap is anonymous and enabled */
> +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> +    if (!new_bitmap) {
> +        return NULL;
> +    }
> +
> +    /* Take ownership; we reserve the right to write into this on-commit. */
> +    bdrv_dirty_bitmap_set_busy(target_bitmap, true);

Honestly, I still have bad understanding about how should we use dirty bitmap mutex,
but note that bdrv_dirty_bitmap_set_busy locks the mutex. And it is (may be) possible,
that busy status of the bitmap is changed after bdrv_dirty_bitmap_check but before
bdrv_dirty_bitmap_set_busy.  So, more correct would be do both operation under one
critical section. Still, I don't know is the situation possible.

> +
> +    job = block_job_create(job_id, &bitpop_job_driver, txn, bs,
> +                           BLK_PERM_CONSISTENT_READ,

Do we need it? We are not going to read..

> +                           BLK_PERM_ALL & ~BLK_PERM_RESIZE,
> +                           0, creation_flags,
> +                           cb, opaque, errp);
> +    if (!job) {
> +        bdrv_dirty_bitmap_set_busy(target_bitmap, false);
> +        bdrv_release_dirty_bitmap(new_bitmap);
> +        return NULL;
> +    }
> +
> +    job->bs = bs;
> +    job->on_error = on_error;
> +    job->target_bitmap = target_bitmap;
> +    job->new_bitmap = new_bitmap;
> +    job->len = len;
> +    job_progress_set_remaining(&job->common.job, job->len);
> +
> +    return &job->common;
> +}
> diff --git a/blockjob.c b/blockjob.c
> index 5d63b1e89d..7e450372bd 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -56,7 +56,8 @@ static bool is_block_job(Job *job)
>       return job_type(job) == JOB_TYPE_BACKUP ||
>              job_type(job) == JOB_TYPE_COMMIT ||
>              job_type(job) == JOB_TYPE_MIRROR ||
> -           job_type(job) == JOB_TYPE_STREAM;
> +           job_type(job) == JOB_TYPE_STREAM ||
> +           job_type(job) == JOB_TYPE_BITMAP_POPULATE;
>   }
>   
>   BlockJob *block_job_next(BlockJob *bjob)
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 3bcb35c81d..f3cfc89d90 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -36,6 +36,7 @@ block-obj-$(CONFIG_LIBSSH) += ssh.o
>   block-obj-y += accounting.o dirty-bitmap.o
>   block-obj-y += write-threshold.o
>   block-obj-y += backup.o
> +block-obj-y += bitmap-alloc.o
>   block-obj-$(CONFIG_REPLICATION) += replication.o
>   block-obj-y += throttle.o copy-on-read.o
>   block-obj-y += block-copy.o
> 


-- 
Best regards,
Vladimir

