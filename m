Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42975C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1434D206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1434D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIIDj-0005XX-Gd
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIFM0-0004Kn-K3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIFLz-0000gg-7V
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:02:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIFLv-0000fe-3p; Wed, 09 Oct 2019 13:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A96AC806A7F;
 Wed,  9 Oct 2019 17:02:17 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0393E5D9D6;
 Wed,  9 Oct 2019 17:02:13 +0000 (UTC)
Subject: Re: [PATCH 08/10] nbd/server: introduce NBDExtentArray
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190930151502.7829-1-vsementsov@virtuozzo.com>
 <20190930151502.7829-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c56a7e0c-50df-1ad7-6c6e-d4c3fe52132f@redhat.com>
Date: Wed, 9 Oct 2019 12:02:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190930151502.7829-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 09 Oct 2019 17:02:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/19 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> Introduce NBDExtentArray class, to handle extents list creation in more
> controlled way and with less OUT parameters in functions.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   nbd/server.c | 184 +++++++++++++++++++++++++--------------------------
>   1 file changed, 90 insertions(+), 94 deletions(-)
> 

> +static void nbd_extent_array_free(NBDExtentArray *ea)
> +{
> +    g_free(ea->extents);
> +    g_free(ea);
> +}
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);

Nice to see this getting more popular :)

> +
> +static int nbd_extent_array_add(NBDExtentArray *ea,
> +                                uint32_t length, uint32_t flags)
>   {

> -    assert(*nb_extents);
> -    while (remaining_bytes) {
> +    if (ea->count >= ea->nb_alloc) {
> +        return -1;
> +    }

Returning -1 is not a failure in the protocol, just failure to add any 
more information to the reply.  A function comment might help, but this 
looks like a good helper function.

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

> +        if (nbd_extent_array_add(ea, num, flags) < 0) {
> +            return 0;
>           }
> -        offset += num;
> -        remaining_bytes -= num;
> -    }
>   
> -    extents_end = extent + 1;
> -
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

Also looks good (return 0 if we populated until we either ran out of 
reply space or out of bytes to report on).

>   static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
> -                               NBDExtent *extents, unsigned int nb_extents,
> -                               uint64_t length, bool last,
> -                               uint32_t context_id, Error **errp)
> +                               NBDExtentArray *ea,
> +                               bool last, uint32_t context_id, Error **errp)
>   {
>       NBDStructuredMeta chunk;
> -
> +    size_t len = ea->count * sizeof(ea->extents[0]);
> +    g_autofree NBDExtent *extents = g_memdup(ea->extents, len);

Why do we need memdup here?  What's wrong with modifying ea->extents in 
place?...

> +    NBDExtent *extent, *extents_end = extents + ea->count;
>       struct iovec iov[] = {
>           {.iov_base = &chunk, .iov_len = sizeof(chunk)},
> -        {.iov_base = extents, .iov_len = nb_extents * sizeof(extents[0])}
> +        {.iov_base = extents, .iov_len = len}
>       };
>   
> -    trace_nbd_co_send_extents(handle, nb_extents, context_id, length, last);
> +    for (extent = extents; extent < extents_end; extent++) {
> +        extent->flags = cpu_to_be32(extent->flags);
> +        extent->length = cpu_to_be32(extent->length);
> +    }
> +
> +    trace_nbd_co_send_extents(handle, ea->count, context_id, ea->total_length,
> +                              last);
>       set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
>                    NBD_REPLY_TYPE_BLOCK_STATUS,
>                    handle, sizeof(chunk) - sizeof(chunk.h) + iov[1].iov_len);
> @@ -1994,39 +2012,27 @@ static int nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>   {
>       int ret;
>       unsigned int nb_extents = dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_EXTENTS;
> -    NBDExtent *extents = g_new(NBDExtent, nb_extents);
> -    uint64_t final_length = length;
> +    g_autoptr(NBDExtentArray) ea = nbd_extent_array_new(nb_extents);
>   
> -    ret = blockstatus_to_extents(bs, offset, &final_length, extents,
> -                                 &nb_extents);
> +    ret = blockstatus_to_extents(bs, offset, length, ea);
>       if (ret < 0) {
> -        g_free(extents);
>           return nbd_co_send_structured_error(
>                   client, handle, -ret, "can't get block status", errp);
>       }
>   
> -    ret = nbd_co_send_extents(client, handle, extents, nb_extents,
> -                              final_length, last, context_id, errp);
> -
> -    g_free(extents);
> -
> -    return ret;
> +    return nbd_co_send_extents(client, handle, ea, last, context_id, errp);

...especially since ea goes out of scope right after the helper function 
finishes?

Overall looks like a nice refactoring.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

