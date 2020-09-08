Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EE72166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apleRjqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EE72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZNu-0001sW-QI
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFZNN-0001LN-AV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29455)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFZNL-0005Sa-Hp
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599555194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlqmizY7lZq/bwqfRWglKnVYiEz9HibXILhojT8dVEg=;
 b=apleRjqSJov5+jOlS9hRb1p9bSGboGIMPy1PnMziIA+zetmSr37hvaxe7Wvp3qF0ar+jEK
 42s/cRlLDJrD86AlwuoW5iB6ID/F9zvgajyIjzVM4SNhidmZnmO6blUlcTrb6WZtYTpXKX
 29ho4bfqKnv0t2v/A8Mv2/qNyb8dKmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-FzWA77r_OiiYJpFCj4AjRQ-1; Tue, 08 Sep 2020 04:53:12 -0400
X-MC-Unique: FzWA77r_OiiYJpFCj4AjRQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5CD057086;
 Tue,  8 Sep 2020 08:53:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7007860C0F;
 Tue,  8 Sep 2020 08:53:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C6AC11132B59; Tue,  8 Sep 2020 10:53:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 1/5] block: add bitmap-populate job
References: <20200902181831.2570048-1-eblake@redhat.com>
 <20200902181831.2570048-2-eblake@redhat.com>
Date: Tue, 08 Sep 2020 10:53:09 +0200
In-Reply-To: <20200902181831.2570048-2-eblake@redhat.com> (Eric Blake's
 message of "Wed, 2 Sep 2020 13:18:27 -0500")
Message-ID: <87mu20d4zu.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, vsementsov@virtuozzo.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> From: John Snow <jsnow@redhat.com>
>
> This job copies the allocation map into a bitmap. It's a job because
> there's no guarantee that allocation interrogation will be quick (or
> won't hang), so it cannot be retrofitted into block-dirty-bitmap-merge.
>
> It was designed with different possible population patterns in mind,
> but only top layer allocation was implemented for now.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json      |  48 +++++++++
>  qapi/job.json             |   6 +-
>  include/block/block.h     |   1 +
>  include/block/block_int.h |  21 ++++
>  block/bitmap-populate.c   | 207 ++++++++++++++++++++++++++++++++++++++
>  blockjob.c                |   3 +-
>  MAINTAINERS               |   1 +
>  block/meson.build         |   1 +
>  8 files changed, 286 insertions(+), 2 deletions(-)
>  create mode 100644 block/bitmap-populate.c
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index db08c58d788c..1cac9a9a8207 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2216,6 +2216,54 @@
>  { 'command': 'block-dirty-bitmap-merge',
>    'data': 'BlockDirtyBitmapMerge' }
>
> +##
> +# @BitmapPattern:
> +#
> +# An enumeration of possible patterns that can be written into a bitmap.
> +#
> +# @allocation-top: The allocation status of the top layer
> +#                  of the attached storage node.

Greek to me.

> +#
> +# Since: 5.2
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
> +# @auto-finalize: When false, this job will wait in a PENDING state after it
> +#                 has finished its work, waiting for @block-job-finalize
> +#                 before making any block graph changes.
> +#                 When true, this job will automatically
> +#                 perform its abort or commit actions.
> +#                 Defaults to true.
> +#
> +# @auto-dismiss: When false, this job will wait in a CONCLUDED state after it
> +#                has completely ceased all work, and awaits @block-job-dismiss.
> +#                When true, this job will automatically disappear from the
> +#                query list without user intervention.
> +#                Defaults to true.
> +#
> +# Since: 5.2
> +##
> +{ 'struct': 'BlockDirtyBitmapPopulate',
> +  'base': 'BlockDirtyBitmap',
> +  'data': { 'job-id': 'str',
> +            'pattern': 'BitmapPattern',
> +            '*on-error': 'BlockdevOnError',
> +            '*auto-finalize': 'bool',
> +            '*auto-dismiss': 'bool' } }
> +
>  ##
>  # @BlockDirtyBitmapSha256:
>  #
> diff --git a/qapi/job.json b/qapi/job.json
> index 280c2f76f136..fb0b606e868d 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -22,10 +22,14 @@
>  #
>  # @amend: image options amend job type, see "x-blockdev-amend" (since 5.1)
>  #
> +# @bitmap-populate: drive bitmap population job type, see
> +#                   "block-dirty-bitmap-populate" (since 5.2)

Dangling reference, healed in PATCH 3.  Job appearing before the command
it wraps is unusual.

What's a "drive bitmap population job"?

The reference provides a clue:

    ##
    # @block-dirty-bitmap-populate:
    #
    # Creates a new job that writes a pattern into a dirty bitmap.

Do you mean "dirty bitmap population job"?

By the way, I think the doc comment would be easier to read with
s/job type/job/.

> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
> +           'bitmap-populate'] }
>
>  ##
>  # @JobStatus:
[...]


