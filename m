Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFFC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 088A7206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFZPPAmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088A7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQz9-0000hq-3g
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQvJ-0002dD-3b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTQts-0002bs-CI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:09:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35911
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTQtr-0002bi-UP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588082870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IO6k4JWWMK3DBNkq8/TrGIx2i4gDIwMz1mDzYy49d9I=;
 b=eFZPPAmYB7oSUsPn5t/vo++i+sZctyHktn4TKZXH4qCfrtJbtdeKzLNL3kKLp/52a9m/jD
 JR4W386PmhmgY2LFj50LetSbaPjXS9yYhuwxXYgP5SAFu7h6SJrs+Mdr2KPps1IxKSNOGJ
 OEpy0X0XuZAmpIystOCnwSObA9iWHVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-5sYSDznROSK4-hGJGl800w-1; Tue, 28 Apr 2020 10:07:47 -0400
X-MC-Unique: 5sYSDznROSK4-hGJGl800w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CC06800D24;
 Tue, 28 Apr 2020 14:07:46 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67C7E5D750;
 Tue, 28 Apr 2020 14:07:45 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: Use blk_make_empty() after commits
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0fb5d21f-4075-8c6a-0105-01fc60acaecf@redhat.com>
Date: Tue, 28 Apr 2020 09:07:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-5-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 8:26 AM, Max Reitz wrote:
> bdrv_commit() already has a BlockBackend pointing to the BDS that we
> want to empty, it just has the wrong permissions.
> 
> qemu-img commit has no BlockBackend pointing to the old backing file
> yet, but introducing one is simple.
> 
> After this commit, bdrv_make_empty() is the only remaining caller of
> BlockDriver.bdrv_make_empty().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/commit.c |  8 +++++++-
>   qemu-img.c     | 19 ++++++++++++++-----
>   2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/block/commit.c b/block/commit.c
> index 8e672799af..24720ba67d 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -493,10 +493,16 @@ int bdrv_commit(BlockDriverState *bs)
>       }
>   
>       if (drv->bdrv_make_empty) {

This 'if' is still a bit awkward. Do all filter drivers set this 
function, or will bdrv_make_empty() automatically take care of looking 
through filters?  Should this be a check of a supported_ variable 
instead (similar to how Kevin just added supported_truncate_flags)?

> -        ret = drv->bdrv_make_empty(bs);
> +        ret = blk_set_perm(src, BLK_PERM_WRITE, BLK_PERM_ALL, NULL);
>           if (ret < 0) {
>               goto ro_cleanup;
>           }
> +
> +        ret = blk_make_empty(src, NULL);

So, if the driver lacks the callback, you miss calling blk_make_empty() 
even if it would have done something.

> +        if (ret < 0) {
> +            goto ro_cleanup;
> +        }
> +
>           blk_flush(src);
>       }
>   
> diff --git a/qemu-img.c b/qemu-img.c
> index 821cbf610e..a5e8659867 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
>           goto unref_backing;
>       }
>   
> -    if (!drop && bs->drv->bdrv_make_empty) {
> -        ret = bs->drv->bdrv_make_empty(bs);

Old code: if the driver had the callback, use it.

> -        if (ret) {
> -            error_setg_errno(&local_err, -ret, "Could not empty %s",
> -                             filename);
> +    if (!drop) {
> +        BlockBackend *old_backing_blk;
> +
> +        old_backing_blk = blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM_ALL,
> +                                          &local_err);
> +        if (!old_backing_blk) {
> +            goto unref_backing;
> +        }
> +        ret = blk_make_empty(old_backing_blk, &local_err);

New code: Call blk_make_empty() whether or not driver has the callback, 
then deal with the fallout.

> +        blk_unref(old_backing_blk);
> +        if (ret == -ENOTSUP) {
> +            error_free(local_err);
> +            local_err = NULL;
> +        } else if (ret < 0) {
>               goto unref_backing;
>           }

But this actually looks smarter than the commit case.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


