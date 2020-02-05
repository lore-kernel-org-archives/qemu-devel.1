Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1725C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2382082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1J1PiVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2382082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTRN-00030T-IW
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izTQ5-0001Md-5v
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izTQ3-0001ym-Uu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izTQ3-0001xZ-PO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580942715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ovNLWgXdJ5nuAfgDV55xIg1cjihU0RW5kw4P24bDM3g=;
 b=T1J1PiVT3T58yeA9Q2mM21BKbGjr9AjaXWde45/5KTkuDXQRxAinvXKwe7rPOQdTnT7n1a
 N+OTiIx+XPGCkZvwqF2qpV1tSyBWZk0cNJTTRp1iZEg69uLuTStYwS4OisPGJ7/TjRyJ7x
 8fZdAZXdg6O0sxQIQkSPmyI0GOr0SuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-nLxtSOW4PfyE1460NJMPBw-1; Wed, 05 Feb 2020 17:45:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56D33800D54;
 Wed,  5 Feb 2020 22:45:10 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8D68F6EE;
 Wed,  5 Feb 2020 22:45:09 +0000 (UTC)
Subject: Re: [PATCH v2 22/33] block: Make backing files child_of_bds children
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-23-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6869d2fe-197a-3bd8-516a-9ae07756a227@redhat.com>
Date: Wed, 5 Feb 2020 16:45:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-23-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nLxtSOW4PfyE1460NJMPBw-1
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

Another sparse commit message (a recurring theme of this series). The 
subject line says 'what', and the patch appears to be faithful to that, 
but if a future bisection lands here, even a one-sentence 'why' would be 
handy; maybe:

This is part of a larger series of unifying block device relationships 
via child_of_bds.

to at least hint that searching nearby commits gives a better why.

> ---
>   block.c                 | 26 ++++++++++++++++++++------
>   block/backup-top.c      |  2 +-
>   block/vvfat.c           |  3 ++-
>   tests/test-bdrv-drain.c | 13 +++++++------
>   4 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 77755f0c6c..6b705ee23a 100644
> --- a/block.c
> +++ b/block.c
> @@ -2748,6 +2748,20 @@ static bool bdrv_inherits_from_recursive(BlockDriverState *child,
>       return child != NULL;
>   }
>   
> +/*
> + * Return the BdrvChildRole for @bs's backing child.  bs->backing is
> + * mostly used for COW backing children (role = COW), but also for
> + * filtered children (role = FILTERED | PRIMARY).
> + */
> +static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
> +{
> +    if (bs->drv && bs->drv->is_filter) {
> +        return BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;

And here's the first point (that I've spotted at least) in this series 
where you are definitely returning a non-BdrvChildRole through a return 
type of BdrvChildRole, rather than me just guessing you might (the 
integer formed by bitwise-or of two enum values is not itself an enum 
value).  Repeating what I said earlier, the C language is loose enough 
to allow your usage, and your usage is somewhat better self-documenting 
than using an unsigned int; but it would not fly in other languages.

So I won't insist you change it, but at least think about it. (And the 
latter has already happened if you read my paragraph - so can we call 
that enough thought on the matter? ;)

> +    } else {
> +        return BDRV_CHILD_COW;
> +    }
> +}
> +
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


