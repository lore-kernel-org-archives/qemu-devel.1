Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F385BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4B520756
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 20:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWwe21Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4B520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jami2-0005nY-UY
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 16:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamhG-0005Hk-7A
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:49:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jamhA-00059F-Gp
 for qemu-devel@nongnu.org; Mon, 18 May 2020 16:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589834947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuz8azvzxVico15+ds8QiTco5WCfvGCYIHKeL7n/Mlo=;
 b=XWwe21Q0Q3Ztrg5KF23BURloDvORmNtZlNeyLGbY7WgCOWF6lDY8kfknmpEBcaO/EEitUa
 KG7c5IruM2z+KyR4lTfq6tXO2c1qxRqI5CKfuz+N9nLjBpjwV+GtqvK688zFrYwKh2C5xH
 HORVKsyOJj9fjvOUKjt6Wn9EqSXSM68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-v5EhEq1YNtyx4oHSFDlT7g-1; Mon, 18 May 2020 16:49:05 -0400
X-MC-Unique: v5EhEq1YNtyx4oHSFDlT7g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974A0107ACF2;
 Mon, 18 May 2020 20:49:03 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4AAB64441;
 Mon, 18 May 2020 20:49:02 +0000 (UTC)
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514034922.24834-1-jsnow@redhat.com>
 <20200514034922.24834-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e426d42a-e1f2-1e6b-f18e-92084bff61a1@redhat.com>
Date: Mon, 18 May 2020 15:49:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514034922.24834-2-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 vsementsov@virtuozzo.com, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 10:49 PM, John Snow wrote:
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofit into block-dirty-bitmap-merge.

retrofitted

> 
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2202,6 +2202,54 @@
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

Presumably, allocated => bits are set.

> +#
> +# Since: 5.0

5.1, now

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

5.1

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

Missing docs that 'bitmap-populate' is since 5.1.

> +++ b/block/bitmap-alloc.c
> @@ -0,0 +1,207 @@

New file, but no MAINTAINERS update.  It is covered by 'Block layer 
core', but shouldn't it also be covered by 'Dirty Bitmaps'?


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

> +
> +    /* NB: new bitmap is anonymous and enabled */
> +    cluster_size = bdrv_dirty_bitmap_granularity(target_bitmap);
> +    new_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
> +    if (!new_bitmap) {
> +        return NULL;
> +    }

This means if the guest writes to the disk while the job is ongoing, the 
bitmap will be updated to mark that portion of the bitmap as set, even 
if it was not allocated at the time the job started.  But then again, 
the guest writes are causing allocation, so this seems like the right 
thing to do.

Do we need to worry about the converse case where the job started with 
something allocated but runs in parallel with the guest trimming, such 
that our bitmap marks something as set even though at the conclusion of 
our job it is no longer allocated?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


