Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD43C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3795D217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 20:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THRlETlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3795D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itdZW-0006l7-EA
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 15:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1itdXZ-0005b1-Ty
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1itdXT-00071t-02
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:20:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1itdXS-0006x5-Fb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 15:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579551644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJSQl454dGGU6+9we2MrV8oN2dvy5Ubcw/m0hjRSk4U=;
 b=THRlETlhrhiPuor+YGrxihq+mKE/oyUjIiBButVFb3lrCIyLaAPr0Dvjwd0ypvpx1SO1AU
 vBoQ24DRQ0Nn6tuaDUfAFOk7NfYrpuKMBJrLizoRie/8nBXud7TwryFT5HprgXphK1j59b
 GPQIIUm9NmwfT3HYRMF/8tPArMCmpsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-cnyY9kmgNQuey0JAT7sAOA-1; Mon, 20 Jan 2020 15:20:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 816941854333;
 Mon, 20 Jan 2020 20:20:41 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1677C3D9;
 Mon, 20 Jan 2020 20:20:38 +0000 (UTC)
Subject: Re: [PATCH v3 08/10] nbd/server: introduce NBDExtentArray
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1f55c9d0-9d53-89d4-18a2-02703aada893@redhat.com>
Date: Mon, 20 Jan 2020 14:20:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219100348.24827-9-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: cnyY9kmgNQuey0JAT7sAOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 4:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce NBDExtentArray class, to handle extents list creation in more
> controlled way and with less OUT parameters in functions.

s/less/fewer/

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 201 ++++++++++++++++++++++++++++-----------------------
>   1 file changed, 109 insertions(+), 92 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index a4b348eb32..cc722adc31 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -1909,27 +1909,89 @@ static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client,
>       return ret;
>   }
>   
> +typedef struct NBDExtentArray {
> +    NBDExtent *extents;
> +    unsigned int nb_alloc;
> +    unsigned int count;
> +    uint64_t total_length;
> +    bool converted; /* extents are converted to BE, no more changes allowed */
> +} NBDExtentArray;
> +

Looks good.

> +static NBDExtentArray *nbd_extent_array_new(unsigned int nb_alloc)
> +{
> +    NBDExtentArray *ea = g_new0(NBDExtentArray, 1);
> +
> +    ea->nb_alloc = nb_alloc;
> +    ea->extents = g_new(NBDExtent, nb_alloc);

I guess g_new() is okay rather tahn g_new0, as long as we are careful 
not to read that uninitialized memory.

> +
> +    return ea;
> +}
> +
> +static void nbd_extent_array_free(NBDExtentArray *ea)
> +{
> +    g_free(ea->extents);
> +    g_free(ea);
> +}
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
> +
> +/* Further modifications of the array after conversion are abandoned */
> +static void nbd_extent_array_convert_to_be(NBDExtentArray *ea)
> +{
> +    int i;
> +
> +    if (ea->converted) {
> +        return;
> +    }

Would this be better as assert(!ea->converted), to ensure we aren't 
buggy in our usage? ...

> +    ea->converted = true;
> +
> +    for (i = 0; i < ea->count; i++) {
> +        ea->extents[i].flags = cpu_to_be32(ea->extents[i].flags);
> +        ea->extents[i].length = cpu_to_be32(ea->extents[i].length);
> +    }
> +}
> +
>   /*
> - * Populate @extents from block status. Update @bytes to be the actual
> - * length encoded (which may be smaller than the original), and update
> - * @nb_extents to the number of extents used.
> - *
> - * Returns zero on success and -errno on bdrv_block_status_above failure.
> + * Add extent to NBDExtentArray. If extent can't be added (no available space),
> + * return -1.
> + * For safety, when returning -1 for the first time, the array is converted
> + * to BE and further modifications are abandoned.
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
> +    assert(!ea->converted);

...especially since you assert here.

> +
> +    if (!length) {
> +        return 0;
> +    }
> +
> +    /* Extend previous extent if flags are the same */
> +    if (ea->count > 0 && flags == ea->extents[ea->count - 1].flags) {
> +        ea->extents[ea->count - 1].length += length;
> +        ea->total_length += length;
> +        return 0;
> +    }

The NBD spec states that NBD_CMD_BLOCK_STATUS with flag 
NBD_CMD_FLAG_REQ_ONE must not exceed the original length of the client's 
request, but that when the flag is not present, the final extent may 
indeed go beyond the client's request.  I see two potential problems here:

1) I don't see any check that extending .length does not exceed the 
client's request if NBD_CMD_FLAG_REQ_ONE was set (we can sort of tell if 
that is the case based on whether nb_alloc is 1 or greater than 1, but 
not directly here, and it seems like this is a better place to do a 
common check than to make each caller repeat it).

2) I don't see any check that extending .length does not exceed 32 bits. 
  If the client requested status of 3.5G, but the caller divides that 
into two extent additions of 3G each and with the same flags, we could 
end up overflowing the 32-bit reply field (not necessarily fatal except 
when the overflow is exactly at 4G, because as long as the server is 
making progress, the client will eventually get all data; it is only 
when the overflow wraps to exactly 0 that we quit making progress). 
32-bit overflow is one case where the server HAS to return back-to-back 
extents with the same flags (if it is going to return information on 
that many bytes, rather than truncating its reply to just the first 
extent < 4G).

> +
> +    if (ea->count >= ea->nb_alloc) {
> +        nbd_extent_array_convert_to_be(ea);
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
> +
> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
> +                                  uint64_t bytes, NBDExtentArray *ea)
> +{
> +    while (bytes) {
>           uint32_t flags;
>           int64_t num;
> -        int ret = bdrv_block_status_above(bs, NULL, offset, remaining_bytes,
> -                                          &num, NULL, NULL);
> +        int ret = bdrv_block_status_above(bs, NULL, offset, bytes, &num,
> +                                          NULL, NULL);
>   
>           if (ret < 0) {
>               return ret;
> @@ -1938,60 +2000,37 @@ static int blockstatus_to_extents(BlockDriverState *bs, uint64_t offset,
>           flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
>                   (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
>   
> -        if (first_extent) {
> -            extent->flags = flags;
> -            extent->length = num;
> -            first_extent = false;
> -        } else if (flags == extent->flags) {
> -            /* extend current extent */
> -            extent->length += num;
> -        } else {
> -            if (extent + 1 == extents_end) {
> -                break;
> -            }
> -
> -            /* start new extent */
> -            extent++;
> -            extent->flags = flags;
> -            extent->length = num;
> +        if (nbd_extent_array_add(ea, num, flags) < 0) {
> +            return 0;
>           }
> -        offset += num;
> -        remaining_bytes -= num;
> -    }

However, I _do_ like the refactoring on making the rest of the code 
easier to read.

> -
> -    extents_end = extent + 1;
>   
> -    for (extent = extents; extent < extents_end; extent++) {
> -        extent->flags = cpu_to_be32(extent->flags);
> -        extent->length = cpu_to_be32(extent->length);
> +        offset += num;
> +        bytes -= num;
>       }
>   
> -    *bytes -= remaining_bytes;
> -    *nb_extents = extents_end - extents;
> -
>       return 0;
>   }
>   

I think this needs v4 to fix the boundary cases, but I like where it is 
headed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


