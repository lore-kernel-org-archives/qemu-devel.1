Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9320AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 492062068D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwVCTR9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 492062068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDRz-0003DW-HS
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jcDRJ-0002Q3-FJ
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:34:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49228
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jcDRH-00025V-Rm
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590176077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdZciMLdiFXhQ/AZi14CkRXKAi15DYpBz+YoeH83t1U=;
 b=cwVCTR9ryzBCZw4nHzf6tNgmHpmEtdEW8fwknxeaM9MLUhFlNMdU4n7IVQdiFAuK8Fxqj1
 JaUIjMtjEBysta3MqCyM9CckXN+t6WgbDr2EpdfKn7x/Ek0Dig7BbIrEYBLVs6C9+1Q6B2
 fM0BzbFdZPMeSSZo9bVX07JS+WIisP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-9VBgICPWOJC6MWjshQik6w-1; Fri, 22 May 2020 15:34:33 -0400
X-MC-Unique: 9VBgICPWOJC6MWjshQik6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523CB18B6423;
 Fri, 22 May 2020 19:34:31 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16A1678B3B;
 Fri, 22 May 2020 19:34:23 +0000 (UTC)
Subject: Re: [PATCH v3 09/17] block/io: support int64_t bytes in
 bdrv_co_p{read,write}v_part()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-10-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9b0727d3-3142-ad18-f073-d567e7667e20@redhat.com>
Date: Fri, 22 May 2020 14:34:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-10-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> So, prepare bdrv_co_preadv_part() and bdrv_co_pwritev_part() and their
> remaining dependencies now.
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block_int.h |  4 ++--
>   block/io.c                | 16 ++++++++--------
>   block/trace-events        |  4 ++--
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index c8daba608b..3c2a1d741a 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -975,13 +975,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
>       int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
>       BdrvRequestFlags flags);
>   int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes,
> +    int64_t offset, int64_t bytes,
>       QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
>   int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>       int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
>       BdrvRequestFlags flags);
>   int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes,
> +    int64_t offset, int64_t bytes,
>       QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);

Callers for these two functions:

block-backend.c:blk_do_pwritev_part() - currently passes unsigned int

filter-compress.c:compress_co_preadv_part() - passes uint64_t from 
.bdrv_co_preadv_part, which in turn is called from:
  - io.c:bdrv_driver_preadv() - callers analyzed earlier this series, 
where we know we are currently capped at <2G
  - qcow2-cluster.c:do_perform_cow_read() - passes size_t qiov->size, 
but we further know qcow2 cow is limited to cluster size of 2M
  - qcow2.c:qcow2_load_vmstate() - passes size_t qiov->size, tracing 
whether that ever exceeds 32 bits (on 64-bit platforms) is harder

filter-compress.c:compress_co_pwritev_part() - ditto, but for 
.bdrv_co_pwritev_part, which in turn is called from:
  - io.c:bdrv_driver_pwritev() - callers analyzed earlier this series, 
where we know we are currently capped at <2G
  - qcow2.c:qcow2_save_vmstate() - passes size_t qiov->size, tracing 
whether that ever exceeds 32 bits (on 64-bit platforms) is harder

io.c:bdrv_co_preadv() - currently passes unsigned int

io.c:bdrv_co_pwritev() - currently passes unsigned int

qcow2.c:qcow2_co_preadv_task() - passes uint64_t from 
qcow2_co_preadv_part(), which in turn is called from:
  - .bdrv_co_preadv_part - analyzed above

qcow2.c:qcow2_co_pwritev_task() - passes uint64_t from 
qcow2_co_pwritev_part(), which in turn is called from:
  - .bdrv_co_pwritev_part - analyzed above
  - qcow2_co_truncate() - passes uint64_t but it is clamped to 1 
cluster, at most 2M

In summary, it looks like even with our new 64-bit bytes parameter, most 
(all?) callers are still clamped to 32 bits.  But if we later relax 
callers, we want to see how bytes is used within these functions.

>   
>   static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
> diff --git a/block/io.c b/block/io.c
> index d336e4e691..d7fd429345 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1488,7 +1488,7 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
>    */
>   static bool bdrv_pad_request(BlockDriverState *bs,
>                                QEMUIOVector **qiov, size_t *qiov_offset,
> -                             int64_t *offset, unsigned int *bytes,
> +                             int64_t *offset, int64_t *bytes,
>                                BdrvRequestPadding *pad)
>   {
>       if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {

Callers:
bdrv_do_preadv_part() - adjusted to int64_t in this patch
bdrv_do_pwritev_part() - adjusted to int64_t in this patch

Usage:
     if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
  - takes int64_t, but now has to be checked for 64-bit safety below

     qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
                              *qiov, *qiov_offset, *bytes,
                              pad->buf + pad->buf_len - pad->tail, 
pad->tail);
  - takes size_t, risky on 32-bit platforms if any of our callers ever 
pass in a value larger than 32 bits.  I'd feel much better with an 
assertion that bytes <= SIZE_MAX.

     *bytes += pad->head + pad->tail;
  - corner-case risk of overflow for an image near 63-bit limits (nbdkit 
can generate such an image, but real images do not tickle this); the 
risk can be mitigated if we insist that no images are larger than 
QEMU_ALIGN_DOWN(INT64_MAX, request_alignment), as we would be unable to 
access the unaligned tail bytes of such an image


bdrv_init_padding():
     sum = pad->head + bytes + pad->tail;
  - ouch: this sets 'size_t sum' to what has always been an int64_t 
parameter, but which prior to this patch was initialized by callers 
passing 32-bit values (with this patch, callers now pass in actual 
int64_t).  But even pre-patch, there are values of bytes that fit in 32 
bits but where this sum can overflow on 32-bit platforms, with that 
potential overflow not changed here.  We need a separate patch to fix 
this (sum needs to be int64_t), preferably earlier in the series. (patch 
6/17 also mentioned bdrv_init_padding as needing a fix)


> @@ -1515,7 +1515,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
>   
>   /* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
>   static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes,
> +    int64_t offset, int64_t bytes,
>       QEMUIOVector *qiov, size_t qiov_offset,
>       BdrvRequestFlags flags)
>   {

Callers:
bdrv_co_preadv_part() - adjusted this patch
bdrv_rw_co_entry() called by bdrv_prwv_co called by:
  - bdrv_pwrite_zeroes() - int bytes
  - bdrv_pwritev() - size_t bytes from qiov
  - bdrv_preadv() - size_t bytes from qiov

This fixes a latent issue where pre-patch callers could pass size_t and 
suffer truncation on a 64-bit platform; but in practice we never tickled 
that bug because of our insistence on <2G read/write.

Usage:

> @@ -1524,7 +1524,7 @@ static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
>       BdrvRequestPadding pad;
>       int ret;
>   
> -    trace_bdrv_co_preadv(bs, offset, bytes, flags);
> +    trace_bdrv_co_preadv_part(bs, offset, bytes, flags);
>   
>       ret = bdrv_check_byte_request(bs, offset, bytes);

takes int64_t (patch 3/17 in this series), and ensures the transaction 
is <2G for the rest of the function. If we ever relax 
bdrv_check_byte_request, we also have to worry about:

     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
  - takes int64_t, audited earlier in this series

     ret = bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
                               qiov, qiov_offset, flags);
  - takes int64_t, audited earlier in this series


>       if (ret < 0) {
> @@ -1562,7 +1562,7 @@ static int coroutine_fn bdrv_do_preadv_part(BdrvChild *child,
>   }
>   
>   int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes,
> +    int64_t offset, int64_t bytes,
>       QEMUIOVector *qiov, size_t qiov_offset,
>       BdrvRequestFlags flags)
>   {

Callers analyzed above, usage within the function:

     ret = bdrv_do_preadv_part(child, offset, bytes, qiov, qiov_offset, 
flags);
  - analyzed above

> @@ -1866,7 +1866,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>   
>   static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
>                                                   int64_t offset,
> -                                                unsigned int bytes,
> +                                                int64_t bytes,
>                                                   BdrvRequestFlags flags,
>                                                   BdrvTrackedRequest *req)
>   {

Caller: bdrv_do_pwritev_part(), adjusted in this patch

Usage:
     padding = bdrv_init_padding(bs, offset, bytes, &pad);
  - analyzed above

         ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, 
align,
                                    NULL, 0, flags);
  - takes int64_t, audited earlier in the series
         assert(align == pad.tail + bytes);
  - changes from 'uint64_t == size_t + unsigned int' to 'uint64_t == 
size_t + int64_t', but does not change in semantics


> @@ -1941,7 +1941,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>   
>   /* To be called between exactly one pair of bdrv_inc/dec_in_flight() */
>   static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
> +    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
>       BdrvRequestFlags flags)
>   {
>       BlockDriverState *bs = child->bs;

Callers:
bdrv_co_pwritev_part() - adjusted this patch
bdrv_do_pwrite_zeroes() - passes 'int'
bdrv_rw_co_entry() analyzed above

Usage:

> @@ -1950,7 +1950,7 @@ static int coroutine_fn bdrv_do_pwritev_part(BdrvChild *child,
>       BdrvRequestPadding pad;
>       int ret;
>   
> -    trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
> +    trace_bdrv_co_pwritev_part(child->bs, offset, bytes, flags);
>   
>       if (!bs->drv) {
>           return -ENOMEDIUM;

     ret = bdrv_check_byte_request(bs, offset, bytes);
  - analyzed above; if we ever relax it, we must also worry about:

     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
  - analyzed above

         ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
  - analyzed above

     if (bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad)) {
  - analyzed above

     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
                                qiov, qiov_offset, flags);
  - takes int64_t, analyzed earlier this series


> @@ -2009,7 +2009,7 @@ out:
>   }
>   
>   int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
> -    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
> +    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
>       BdrvRequestFlags flags)
>   {
>       int ret;

Callers analzyed above, usage:

     ret = bdrv_do_pwritev_part(child, offset, bytes, qiov, qiov_offset, 
flags);
  - analyzed above

> diff --git a/block/trace-events b/block/trace-events
> index 179b47bf63..dd367a9b19 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -11,8 +11,8 @@ blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>   blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
>   
>   # io.c
> -bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
> -bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
> +bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
> +bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"

Interesting that the trace always took 64-bit numbers, but you are 
renaming it to match the fact that they are now called from different 
functions (since commit 1acc3466a2).  I'd feel better if 'flags' were 
kept unsigned int, even though semantically it doesn't matter.

>   bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
>   bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
>   bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
> 

I think if you fix bdrv_init_padding in a separate patch, then 
everything else here is safe.
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


