Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CC6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E470205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcPpL6ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E470205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc9Oz-00044g-G0
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 11:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jc9Nx-0003H0-R9
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:14:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58148
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jc9Nw-00022U-SI
 for qemu-devel@nongnu.org; Fri, 22 May 2020 11:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590160496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pygucWuFaQBD7sZN54bwwioIVktyp3oelb8TGfMdeXs=;
 b=RcPpL6yeDIGLCKCYFKcUuJYZEPg4Tgb1IxyPrBFWfMhbv2OdBA/uTVWlmFswDpz0AD7lUh
 c9vTUdN1c+CaKKteDEtiG+rQrQqQlurdCSlesUgA1qwsZWq7osVEy/vWyb99H/qURjkOX5
 QJ5eJys8tbHTDQ4NUl93SImnCAMKgxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-RsGcVkwuOC2ZCZl_ZOa1uA-1; Fri, 22 May 2020 11:14:47 -0400
X-MC-Unique: RsGcVkwuOC2ZCZl_ZOa1uA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA7D1100CCC2;
 Fri, 22 May 2020 15:14:45 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDB65C1D3;
 Fri, 22 May 2020 15:14:37 +0000 (UTC)
Subject: Re: [PATCH v3 08/17] block/io: support int64_t bytes in
 bdrv_aligned_preadv()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9143ff10-cba2-bcc2-c48c-eac73446b159@redhat.com>
Date: Fri, 22 May 2020 10:14:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-9-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 6:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths.
> 
> Main motivation is realization of 64-bit write_zeroes operation for
> fast zeroing large disk chunks, up to the whole disk.
> 
> We chose signed type, to be consistent with off_t (which is signed) and
> with possibility for signed return type (where negative value means
> error).
> 
> So, prepare bdrv_aligned_preadv() now.
> 
> Make byte variable in bdrv_padding_rmw_read() int64_t, as it defined
> only to be passed to bdrv_aligned_preadv().
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 6990d8cabe..d336e4e691 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1250,16 +1250,17 @@ err:
>    * reads; any other features must be implemented by the caller.
>    */
>   static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
> -    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
> +    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
>       int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
>   {

Callers:

bdrv_padding_rmw_read() - passes int64_t (uint64_t before this patch), 
which in turn is bounded by request_alignment (still 32-bit) or 
BdrvRequestPadding.buf_len (size_t, but also constrained by creation to 
32-bit) - safe

bdrv_do_preadv_part() - passes unsigned int - safe


>       BlockDriverState *bs = child->bs;
>       int64_t total_bytes, max_bytes;
>       int ret = 0;
> -    uint64_t bytes_remaining = bytes;
> +    int64_t bytes_remaining = bytes;
>       int max_transfer;
>   
>       assert(is_power_of_2(align));
> +    assert(offset >= 0 && bytes >= 0);

Use within the function:

the new assertion added here does not check for whether offset+bytes is 
positive; I would suggest we strengthen it to instead be:
assert(offset >= 0 && (uint64_t) bytes <= INT64_MAX - offset);

         ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
  - takes int64_t, safe

         if (!ret || pnum != bytes) {
             ret = bdrv_co_do_copy_on_readv(child, offset, bytes,
                                            qiov, qiov_offset, flags);
  - takes int64_t, safe

     if (bytes <= max_bytes && bytes <= max_transfer) {
         ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
  - takes int64_t, safe

>       assert((offset & (align - 1)) == 0);
>       assert((bytes & (align - 1)) == 0);
>       assert((bs->open_flags & BDRV_O_NO_IO) == 0);
> @@ -1315,7 +1316,7 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
>       }
>   
>       while (bytes_remaining) {
> -        int num;
> +        int64_t num;
>   
>           if (max_bytes) {
>               num = MIN(bytes_remaining, MIN(max_bytes, max_transfer));

  - safe, bounded by max_transfer which is <= INT_MAX earlier in the 
function

             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
                                      num, qiov, bytes - 
bytes_remaining, 0);
  - takes int64_t, and num is capped by max_transfer - safe

             ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
                                     bytes_remaining);
  - takes size_t, risky for 32-bit platforms.  Works because we checked 
that all our callers are still bounded by 32-bits, but we should 
consider adding an assertion that bytes <= SIZE_MAX so that even when 
our callers are updated in later patches, we know that we are still 
fragmenting requests appropriately on 32-bit platforms

> @@ -1416,7 +1417,7 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
>       assert(req->serialising && pad->buf);
>   
>       if (pad->head || pad->merge_reads) {
> -        uint64_t bytes = pad->merge_reads ? pad->buf_len : align;
> +        int64_t bytes = pad->merge_reads ? pad->buf_len : align;
>   
>           qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
>   
> 

Preferably with the suggested assertions added,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


