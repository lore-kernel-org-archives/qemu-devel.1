Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9601206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGhSfbZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9601206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgllz-0003MD-50
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jglkz-00024C-Po
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:01:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32640
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jglky-0003ix-9l
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591261306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YwZWWcDTlU1r+nqAXIHEiCWp5PWO4Oi8F4mh+APohlw=;
 b=PGhSfbZx742/WgWwrCljkD0rj4rC/qW3qGQgQ+TwdekjdVBquS3ic9xoG70DGI8UJody1Y
 9+0nvYkE2nEO0OmlsxI3p15fhcmU+JZtw4hja7go/6ey+FV4oKtYMQNtPjfeikoPnjx3wX
 LbQMGmrvm7N5FKwM4n9nO0Lf6ctobNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-vVPr2YOdNUK136iEMToEJw-1; Thu, 04 Jun 2020 05:01:45 -0400
X-MC-Unique: vVPr2YOdNUK136iEMToEJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 399311005512;
 Thu,  4 Jun 2020 09:01:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D874410013C0;
 Thu,  4 Jun 2020 09:01:41 +0000 (UTC)
Date: Thu, 4 Jun 2020 11:01:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200604090140.GB4512@linux.fritz.box>
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com,
 Cleber Rosa <crosa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 05:49 hat John Snow geschrieben:
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.
> 
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json      |  48 +++++++++
>  qapi/job.json             |   2 +-
>  include/block/block_int.h |  21 ++++
>  block/bitmap-alloc.c      | 207 ++++++++++++++++++++++++++++++++++++++

bitmap-populate.c to be more consistent with the actual job name?

>  blockjob.c                |   3 +-
>  block/Makefile.objs       |   1 +
>  6 files changed, 280 insertions(+), 2 deletions(-)
>  create mode 100644 block/bitmap-alloc.c

[...]

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
> +
> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
> +        return NULL;
> +    }

What does this protect? And why does BACKUP_SOURCE describe acccurately
what this job does?

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

This operates on the node level, so bdrv_get_device_or_node_name() is
necessary to avoid empty strings in the message.

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
> +
> +    job = block_job_create(job_id, &bitpop_job_driver, txn, bs,
> +                           BLK_PERM_CONSISTENT_READ,

I don't think we actually rely on CONSISTENT_READ, but then, using the
job on inconsistent nodes probably makes little sense and we can always
relax the restriction later if necessary.

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

Kevin


