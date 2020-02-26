Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261DC4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3902467D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 15:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFIejOn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3902467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6yHE-0002aK-VZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 10:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j6yGQ-0001w3-9q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j6yGL-0003yB-Sa
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:06:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j6yGL-0003uZ-Lh
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582729573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgGwY1TqIwLu2NgJ5S7yM7RldBiARW9grt3W193Lur8=;
 b=JFIejOn8CKQepXTAE7TZ/VifePrNBlPSg3h55UuG67GC0zLOp1mWSAZVHu27CawoGhs6Ag
 TEuKQk5/oFdmTVgd6jlvxFDFsQwtrZ2utA5w7yBnv0FlEJ3M9Wk1kLoiwT905oWVDgnLmc
 yrTCGh8DmxqSdew3mlRlkFV5sQ8rCUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-itwzGa9EPta8Sv5kglaIhg-1; Wed, 26 Feb 2020 10:06:07 -0500
X-MC-Unique: itwzGa9EPta8Sv5kglaIhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E81931005516;
 Wed, 26 Feb 2020 15:06:05 +0000 (UTC)
Received: from [10.3.116.57] (ovpn-116-57.phx2.redhat.com [10.3.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 065E89079B;
 Wed, 26 Feb 2020 15:06:04 +0000 (UTC)
Subject: Re: [PATCH v4 08/10] nbd/server: introduce NBDExtentArray
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <20200205112041.6003-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6396ff32-16a3-62fe-1001-fde8b5a4f431@redhat.com>
Date: Wed, 26 Feb 2020 09:06:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200205112041.6003-9-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce NBDExtentArray class, to handle extents list creation in more
> controlled way and with fewer OUT parameters in functions.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 210 +++++++++++++++++++++++++++++----------------------
>   1 file changed, 118 insertions(+), 92 deletions(-)
> 

> +
> +/* Further modifications of the array after conversion are abandoned */
> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
> +{
> +    int i;
> +
> +    assert(!ea->converted_to_be);

Comment is stale - further modifications after conversion are a bug that 
aborts the program, not abandoned.


>   /*
> - * Populate @extents from block status. Update @bytes to be the actual
> - * length encoded (which may be smaller than the original), and update
> - * @nb_extents to the number of extents used.
> - *
> - * Returns zero on success and -errno on bdrv_block_status_above failure.
> + * Add extent to NBDExtentArray. If extent can't be added (no available space),
> + * return -1.
> + * For safety, when returning -1 for the first time, .can_add is set to false,
> + * further call to nbd_extent_array_add() will crash.

s/further call/so further calls/

> + * (to avoid the situation, when after failing to add an extent (returned -1),
> + * user miss this failure and add another extent, which is successfully added
> + * (array is full, but new extent may be squashed into the last one), then we
> + * have invalid array with skipped extent)

Long comment with nested ().  I'm not sure it adds much value, I think 
it can safely be dropped.  But if it is kept, I suggest:

(this ensures that after a failure, no further extents can accidentally 
change the bounds of the last extent in the array)

>    */
> -static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
> -                                  uint64_t *bytes, NBDExtent *extents,
> -                                  unsigned int *nb_extents)
> +static int nbd_extent_array_add(NBDExtentArray *ea,
> +                                uint32_t length, uint32_t flags)
>   {
> -    uint64_t remaining_bytes = *bytes;
> -    NBDExtent *extent = extents, *extents_end = extents + *nb_extents;
> -    bool first_extent = true;
> +    assert(ea->can_add);
> +
> +    if (!length) {
> +        return 0;
> +    }
> +
> +    /* Extend previous extent if flags are the same */
> +    if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
> +        uint64_t sum = (uint64_t)length + ea->extents[ea->count - 1].length;
> +
> +        if (sum <= UINT32_MAX) {
> +            ea->extents[ea->count - 1].length = sum;
> +            ea->total_length += length;
> +            return 0;
> +        }
> +    }
> +
> +    if (ea->count >= ea->nb_alloc) {
> +        ea->can_add = false;
> +        return -1;
> +    }
> +
> +    ea->total_length += length;
> +    ea->extents[ea->count] = (NBDExtent) {.length = length, .flags = flags};
> +    ea->count++;
>   
> -    assert(*nb_extents);
> -    while (remaining_bytes) {
> +    return 0;
> +}

Looks like you properly addressed my concerns from v3.

Comment changes are trivial, so you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


