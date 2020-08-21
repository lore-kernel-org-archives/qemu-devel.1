Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A600C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2BF207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfcMUQuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2BF207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99Jn-0006et-7A
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k99J7-00067A-L8
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:50:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k99J4-00016S-L6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598025017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzIkl9V9e0SIycHz9VaEEeYCyExnXVw787EO1m2Y35g=;
 b=OfcMUQuWwlQsZHXqUU3FZH/1m3J7VwO92x4g8Mf0bYVSLbbMubCox++RaSTR7j5DwP4N5C
 dB7se4GUlvwaGhMzSz53ixhFZ5zC2VkaUIqRJDwbEiL0XlE/Wo+GlnLJl7dWYHr1Yhw6li
 hRcK0y66yPQ8qKnFt7Ml3v/Rfwd8RFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-zVCjBmEMMPOrtF-qFNPHfg-1; Fri, 21 Aug 2020 11:50:15 -0400
X-MC-Unique: zVCjBmEMMPOrtF-qFNPHfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 525B210ABDA0;
 Fri, 21 Aug 2020 15:50:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-251.ams2.redhat.com [10.36.113.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5F27E30F;
 Fri, 21 Aug 2020 15:50:13 +0000 (UTC)
Date: Fri, 21 Aug 2020 17:50:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 39/47] blockdev: Fix active commit choice
Message-ID: <20200821155011.GA26691@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-40-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-40-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> We have to perform an active commit whenever the top node has a parent
> that has taken the WRITE permission on it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  blockdev.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 402f1d1df1..237fffbe53 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>      AioContext *aio_context;
>      Error *local_err = NULL;
>      int job_flags = JOB_DEFAULT;
> +    uint64_t top_perm, top_shared;
>  
>      if (!has_speed) {
>          speed = 0;
> @@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>          goto out;
>      }
>  
> -    if (top_bs == bs) {
> +    /*
> +     * Active commit is required if and only if someone has taken a
> +     * WRITE permission on the top node.

...or if someone wants to take a WRITE permission while the job is
running.

Future intentions of the user is something that we can't know, so maybe
this should become an option in the future (not in this series, of
course).

>                                            Historically, we have always
> +     * used active commit for top nodes, so continue that practice.
> +     * (Active commit is never really wrong.)
> +     */

Changing the practice would break compatibility with clients that start
an active commit job and then attach it to a read-write device, so we
must continue the practice. I think the comment should be clearer about
this, it sounds more like "no reason, but why not".

This is even more problematic because the commit job doesn't unshare
BLK_PERM_WRITE yet, so it would lead to silent corruption rather than an
error.

> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
> +    if (top_perm & BLK_PERM_WRITE ||
> +        bdrv_skip_filters(top_bs) == bdrv_skip_filters(bs))
> +    {
>          if (has_backing_file) {
>              error_setg(errp, "'backing-file' specified,"
>                               " but 'top' is the active layer");

Hm, this error message isn't accurate any more.

In fact, the implementation isn't consistent with the QAPI documentation
any more, because backing-file is only an error for the top level.

>              goto out;
>          }
> -        commit_active_start(has_job_id ? job_id : NULL, bs, base_bs,
> -                            job_flags, speed, on_error,
> +        if (!has_job_id) {
> +            /*
> +             * Emulate here what block_job_create() does, because it
> +             * is possible that @bs != @top_bs (the block job should
> +             * be named after @bs, even if @top_bs is the actual
> +             * source)
> +             */

Should it? Oh, yes, looks like it. block-commit is weird. :-)

> +            job_id = bdrv_get_device_name(bs);
> +        }
> +        commit_active_start(job_id, top_bs, base_bs, job_flags, speed, on_error,
>                              filter_node_name, NULL, NULL, false, &local_err);
>      } else {
>          BlockDriverState *overlay_bs = bdrv_find_overlay(bs, top_bs);

Kevin


