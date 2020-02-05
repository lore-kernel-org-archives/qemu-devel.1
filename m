Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7FFC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A9E20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 16:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwecxbsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A9E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izNLR-0000Oe-Hd
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 11:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izNKY-0008Fu-3W
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izNKW-0001RM-8I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:15:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izNKW-0001PD-00
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 11:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580919307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rClP3fYC6SIvgCpKvv/E23KOuYJWWcXaJgCO0JlJkow=;
 b=RwecxbsAqMXpjCYUdFLYgjAdECAnm2fybFQFdKnKCucFZzsiXYMuZHmbno2e8E7FYsTwIw
 Hj2xRg7CBNm447ApYapHQGb0/oyjKWTVJQjpvxkvF3H10t9cLzkHjkGrQMIugcT5Nd8YUt
 4RN/tKP0O0KVrwrWwWhuahmxsDpqzYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-xTmCd07fO3W1V57hVDR4nA-1; Wed, 05 Feb 2020 11:14:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418331088382;
 Wed,  5 Feb 2020 16:14:41 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2F8810027A5;
 Wed,  5 Feb 2020 16:14:40 +0000 (UTC)
Subject: Re: [PATCH v2 05/33] block: Pass BdrvChildRole to bdrv_child_perm()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <114a8308-a7d0-0591-abe3-397d164c6740@redhat.com>
Date: Wed, 5 Feb 2020 10:14:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-6-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xTmCd07fO3W1V57hVDR4nA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Sparse commit message - is the intent that this is no semantic change 
and just adding a parameter?

> ---
>   block.c                     | 22 ++++++++++++----------
>   block/backup-top.c          |  3 ++-
>   block/blkdebug.c            |  5 +++--
>   block/blklogwrites.c        |  9 +++++----
>   block/commit.c              |  1 +
>   block/copy-on-read.c        |  1 +
>   block/mirror.c              |  1 +
>   block/quorum.c              |  1 +
>   block/replication.c         |  1 +
>   block/vvfat.c               |  1 +
>   include/block/block_int.h   |  5 ++++-
>   tests/test-bdrv-drain.c     |  5 +++--
>   tests/test-bdrv-graph-mod.c |  1 +
>   13 files changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/block.c b/block.c
> index c576377650..7fa7830428 100644
> --- a/block.c
> +++ b/block.c
> @@ -1764,12 +1764,12 @@ bool bdrv_is_writable(BlockDriverState *bs)
>   
>   static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
>                               BdrvChild *c, const BdrvChildClass *child_class,
> -                            BlockReopenQueue *reopen_queue,
> +                            BdrvChildRole role, BlockReopenQueue *reopen_queue,

Again, using an enum name where a bitmask of non-enum values is 
self-documenting, but somewhat abusive of C's loose type system.  Is an 
unsigned int any better?

Looks mechanical enough. I'd like a better commit message, but:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


