Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7348AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F41520707
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 19:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0d6RQLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F41520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixc8a-0003gK-Fg
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 14:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixc7r-0002oI-Tf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixc7p-0007hO-VP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:38:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixc7p-0007g4-Ql
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 14:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580499524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikuUOY4epyWLZu9C8ux8bDRtuHMFcZx9vMbrU8ZScZ4=;
 b=c0d6RQLjTtIoV0IZTd7iPbvqEWLRE4xg6lMMVZfSDkN9G0i65+RY3PB6GkBvTsjpf1BRTb
 7hrnd6lkmZDIz5U2xgQ98dVcQMi1rXAhgWbMO1punYQBWmQOsMtU9to9ThWM8E3AlLkAI9
 /ug8nAHjbG2MXPqp3lI9KqfV4WkH8xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-C37RDovrMfujhQNwoJMahg-1; Fri, 31 Jan 2020 14:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C351518FE860;
 Fri, 31 Jan 2020 19:38:40 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C03E5DA81;
 Fri, 31 Jan 2020 19:38:40 +0000 (UTC)
Subject: Re: [PATCH] block/backup-top: fix flags handling
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200131184805.7033-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f442ed27-044e-f293-8955-74798b581ab4@redhat.com>
Date: Fri, 31 Jan 2020 13:38:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131184805.7033-1-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: C37RDovrMfujhQNwoJMahg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 12:48 PM, Vladimir Sementsov-Ogievskiy wrote:
> backup-top "supports" write-unchanged, by skipping CBW operation in
> backup_top_co_pwritev. But it forgets to do the same in
> backup_top_co_pwrite_zeroes, as well as declare support for
> BDRV_REQ_WRITE_UNCHANGED.
> 
> Fix this, and, while being here, declare also support for flags
> supported by source child.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/backup-top.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)


> @@ -197,6 +201,10 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
>   
>       top->total_sectors = source->total_sectors;
>       state = top->opaque;
> +    top->supported_write_flags =
> +        BDRV_REQ_WRITE_UNCHANGED | source->supported_write_flags;
> +    top->supported_zero_flags =
> +        BDRV_REQ_WRITE_UNCHANGED | source->supported_zero_flags;

Elsewhere, in block/filter-compress.c we do:

     bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
         (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);

     bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
         ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
             bs->file->bs->supported_zero_flags);

That's slightly more robust (if the block layer adds new BDRV_REQ_ bits, 
we don't have to revisit filter-compress.c to decide if blindly exposing 
those bits breaks for some reason, but rahter DO have to amend the line 
to opt-in to supporting the new bits).  Whereas your code does NOT need 
editing if passing on the new bit is safe, but risks a subtle breakage 
if we forget to filter out the new bit when passing it on would be 
unsafe.  I tend to lean towards safety and opt-in over blind 
pass-through that works with the current set of defined bits, but not 
enough to withhold:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


