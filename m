Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E21C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C9920814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 22:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dcxt6vT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C9920814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbtiV-0001zp-Ue
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 18:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbthk-0001A1-Jd
 for qemu-devel@nongnu.org; Thu, 21 May 2020 18:30:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbthj-0002q1-J0
 for qemu-devel@nongnu.org; Thu, 21 May 2020 18:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590100218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5unwk1mFsWfeHEYmZKq0TJt0BpR5dcy1xSEvQNhcPFA=;
 b=Dcxt6vT8z8bMkRPO4lzbZv1A/ENcgJgbbUAH83NjqjB1eLJQ/2yLOsA9ZQOAdW0muDboXV
 pcXqbkvsRU5MgAK07TlVXwRxxmwYXJh6q13J3m2PnjoM2GfAUvC8nX8i20ic3nagJKAogG
 NDThwX9qYe55nazbBqvGLBgj1Y8iWNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-F8vQbfDvOjKIQWA17sbVlA-1; Thu, 21 May 2020 18:30:08 -0400
X-MC-Unique: F8vQbfDvOjKIQWA17sbVlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E548C8018A7;
 Thu, 21 May 2020 22:30:05 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81C2A5C1BD;
 Thu, 21 May 2020 22:29:54 +0000 (UTC)
Subject: Re: [PATCH v3 07/17] block/io: support int64_t bytes in
 bdrv_co_do_copy_on_readv()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <918dca07-00f2-af0f-b410-54537524e5ef@redhat.com>
Date: Thu, 21 May 2020 17:29:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-8-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 14:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
> So, prepare bdrv_co_do_copy_on_readv() now.
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c         | 6 +++---
>   block/trace-events | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 8bb4ea6285..6990d8cabe 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1088,7 +1088,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
>   }
>   
>   static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
> -        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
> +        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
>           size_t qiov_offset, int flags)

Widens from 32-bit to 63-bit.  One caller:

bdrv_aligned_preadv() passes unsigned int (for now) - safe

>   {
>       BlockDriverState *bs = child->bs;
> @@ -1103,11 +1103,11 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>       BlockDriver *drv = bs->drv;
>       int64_t cluster_offset;
>       int64_t cluster_bytes;
> -    size_t skip_bytes;
> +    int64_t skip_bytes;
>       int ret;
>       int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
>                                       BDRV_REQUEST_MAX_BYTES);
> -    unsigned int progress = 0;
> +    int64_t progress = 0;
>       bool skip_write;

Use of 'bytes', 'sskip_bytes', and 'progress' within the function:
     bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, 
&cluster_bytes);
  - safe, takes int64_t. Pre-patch, cluster_bytes could be 33 bits (a 
misaligned request just under UINT_MAX can expand to > UINT_MAX when 
aligned to clusters), but only if bytes could be larger than our <2G cap 
that we use elsewhere.  But even if we relax that 2G cap in later 
patches, we should be okay even if 'bytes' starts at larger than 32 
bits, because we don't allow images that would overflow INT64_MAX when 
rounded up to cluster boundaries

     skip_bytes = offset - cluster_offset;
  - actually oversized - the difference is never going to be larger than 
a cluster (which is capped at 2M for qcow2, for example), but doesn't 
hurt that it is now a 64-bit value

     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
  - safe, tweaked in this patch

                 assert(progress >= bytes);
  - safe: progress never exceeds pnum, and both variables are same type 
pre- and post-patch

             assert(skip_bytes < pnum);
  - safe

                 qemu_iovec_from_buf(qiov, qiov_offset + progress,
                                     bounce_buffer + skip_bytes,
                                     MIN(pnum - skip_bytes, bytes - 
progress));
  - tricky - pre-patch, pnum was int64_t, post-patch, we have three more 
int64_t entities.  Either way, we're passing int64_t to a size_t 
parameter, which narrows on 64-bit.  However, we're safe: this call is 
in a loop where pnum is clamped at MAX_BOUNCE_BUFFER which is less than 
32 bits, and the MIN() here means we never overflow

             ret = bdrv_driver_preadv(bs, offset + progress,
                                      MIN(pnum - skip_bytes, bytes - 
progress),
                                      qiov, qiov_offset + progress, 0);
  - safe - takes int64_t (earlier in this series), and same analysis 
about the MIN() picking something clamped at MAX_BOUNCE_BUFFER

         progress += pnum - skip_bytes;
         skip_bytes = 0;
  - safe

Reviewed-by: Eric Blake <eblake@redhat.com>

>   
>       if (!drv) {
> diff --git a/block/trace-events b/block/trace-events
> index 29dff8881c..179b47bf63 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -14,7 +14,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>   bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
>   bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
>   bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
> -bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %u cluster_offset %"PRId64" cluster_bytes %"PRId64
> +bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
>   bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
>   bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


