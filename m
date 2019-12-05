Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB74C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AB2206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLSzXHio"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB2206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxT5-0004x5-JC
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1icxRa-00047u-3y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1icxRW-0006JT-N2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:09:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1icxRW-0006ET-Fd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575576581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6VczvkEy9bYoSdDeIZ9npbUnXHQmobH+C9YSDb91bM=;
 b=gLSzXHiogZEwG0baOWw+TiBwC2Pgm8wcozUZLoEs9us7mSE3kS2LwsnyN4MZbSHryGfx5Q
 hFgVbZThEop5V5WuTwSeiPuWfSFKyMnLfYD1GIh8WGb4erCD6MUyPTniKEB5RMF5o+YxOJ
 Bjf7PbbsNs4mBkKm7ED+2Uey9aO1PBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-YokNhkKhNtyO7b0ypWEt7g-1; Thu, 05 Dec 2019 15:09:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E30107ACC7;
 Thu,  5 Dec 2019 20:09:39 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2DFA10013D9;
 Thu,  5 Dec 2019 20:09:33 +0000 (UTC)
Subject: Re: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191205193049.30666-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <22af83d1-91e2-ab71-2dc4-349b5b24d1d8@redhat.com>
Date: Thu, 5 Dec 2019 14:09:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205193049.30666-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: YokNhkKhNtyO7b0ypWEt7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 libvirt-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 1:30 PM, Vladimir Sementsov-Ogievskiy wrote:
> Here is double bug:
> 
> First, return error but not set errp. This may lead to:
> qmp block-dirty-bitmap-remove may report success when actually failed
> 
> block-dirty-bitmap-remove used in a transaction will crash, as
> qmp_transaction will think that it returned success and will cal

call

> block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
> NULL
> 
> Second (like in anecdote), this case is not an error at all. As it is
> documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
> definition, absence of bitmap is not an error, and similar case handled
> at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
> there is no bitmaps at all..

double .

> 
> But when there are some bitmaps, but not the requested one, it return
> error with errp unset.
> 
> Fix that.
> 
> Fixes: b56a1e31759b750
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi all!
> 
> Ohm, suddenly we faced this bug. It's a regression in 4.2. I'm very
> sorry for introducing it, and it sad that it's found so late..
> 
> Personally, I think that this one worth rc5, as it makes new bitmap
> interfaces unusable. But the decision is yours.
> 
> Last minute edit: hmm, actually, transaction action introduced in
> 4.2, so crash is not a regression, only broken block-dirty-bitmap-remove
> command is a regression... Maybe it's OK for stable.

Libvirt REALLY wants to use transaction bitmap management (and require 
qemu 4.2) for its incremental backup patches that Peter is almost ready 
to merge in.  I'm trying to ascertain:

When exactly can this bug hit?  Can you give a sequence of QMP commands 
that will trigger it for easy reproduction?  Are there workarounds (such 
as checking that a bitmap exists prior to attempting to remove it)?  If 
it does NOT get fixed in rc5, how will libvirt be able to probe whether 
the fix is in place?

> 
>   block/qcow2-bitmap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 8abaf632fc..c6c8ebbe89 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1469,8 +1469,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>       Qcow2BitmapList *bm_list;
>   
>       if (s->nb_bitmaps == 0) {
> -        /* Absence of the bitmap is not an error: see explanation above
> -         * bdrv_remove_persistent_dirty_bitmap() definition. */
> +        /*
> +         * Absence of the bitmap is not an error: see explanation above
> +         * bdrv_co_remove_persistent_dirty_bitmap() definition.
> +         */
>           return 0;
>       }
>   
> @@ -1485,7 +1487,8 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>   
>       bm = find_bitmap_by_name(bm_list, name);
>       if (bm == NULL) {
> -        ret = -EINVAL;
> +        /* Absence of the bitmap is not an error, see above. */
> +        ret = 0;
>           goto out;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


