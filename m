Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9B020714
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfkh79ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9B020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jknqL-0002wb-Q1
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jknpe-0002P7-If
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:03:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jknpb-00060b-AL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592222594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YTsVU+wVObqC12+TLvCk7zaxY+QeeJH4tYZ3KB10sY=;
 b=bfkh79acXWsHCLluBCBcNigiBzjnFKa23bzFwatpwneyzsxJgDwUl2O3JLDNSmgN4X/Dps
 5JgOClduTWjXWcaAoYAgZ19211b0hPfS+CsiS7JUIdcQnKy8za5Ew20DqfWUYkOKrzHWAr
 hQNhjDPUfdoPKb+CWNvNxCHY+P9RoXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-gPPZe6rOPeuiTMHAzA2XGw-1; Mon, 15 Jun 2020 08:03:12 -0400
X-MC-Unique: gPPZe6rOPeuiTMHAzA2XGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4B68C9061;
 Mon, 15 Jun 2020 12:03:11 +0000 (UTC)
Received: from work-vm (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FABA5D9CC;
 Mon, 15 Jun 2020 12:03:02 +0000 (UTC)
Date: Mon, 15 Jun 2020 13:03:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 1/4] migration/savevm: respect qemu_fclose() error code
 in save_snapshot()
Message-ID: <20200615120300.GI2883@work-vm>
References: <20200611171143.21589-1-den@openvz.org>
 <20200611171143.21589-2-den@openvz.org>
MIME-Version: 1.0
In-Reply-To: <20200611171143.21589-2-den@openvz.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Denis V. Lunev (den@openvz.org) wrote:
> qemu_fclose() could return error, f.e. if bdrv_co_flush() will return
> the error.
> 
> This validation will become more important once we will start waiting of
> asynchronous IO operations, started from bdrv_write_vmstate(), which are
> coming soon.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <fam@euphon.net>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Denis Plotnikov <dplotnikov@virtuozzo.com>

We check the return value in very few other places; I think in the
migration case we do flushes and assume that if the flushes work we
were OK; then most of the closes happen on error paths or after points
we think we're done.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c00a6807d9..0ff5bb40ed 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2628,7 +2628,7 @@ int save_snapshot(const char *name, Error **errp)
>  {
>      BlockDriverState *bs, *bs1;
>      QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
> -    int ret = -1;
> +    int ret = -1, ret2;
>      QEMUFile *f;
>      int saved_vm_running;
>      uint64_t vm_state_size;
> @@ -2712,10 +2712,14 @@ int save_snapshot(const char *name, Error **errp)
>      }
>      ret = qemu_savevm_state(f, errp);
>      vm_state_size = qemu_ftell(f);
> -    qemu_fclose(f);
> +    ret2 = qemu_fclose(f);
>      if (ret < 0) {
>          goto the_end;
>      }
> +    if (ret2 < 0) {
> +        ret = ret2;
> +        goto the_end;
> +    }
>  
>      /* The bdrv_all_create_snapshot() call that follows acquires the AioContext
>       * for itself.  BDRV_POLL_WHILE() does not support nested locking because
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


