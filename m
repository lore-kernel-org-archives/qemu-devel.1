Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1487C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974EF21775
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pf568fRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974EF21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX9mk-0007rA-Qe
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 16:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX9lu-0007Ld-Df
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:39:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jX9ls-0004pT-Ht
 for qemu-devel@nongnu.org; Fri, 08 May 2020 16:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588970339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFMXv4pCcHeJP55wXbcEtrhqtDeY19wrD6QnT0yh8r4=;
 b=Pf568fRh/+Ys4oq+UAX93r1g/Fwwo72yQW11saHhdDDb5QHekRJJl7FJ0C/iJZebgts7bo
 AmeHhEEpT1hBDRiBGROE6Gk69wBGsMpHLndG7FxjGwCMeL2m1pxabfK6+PmF/XYO63tcyY
 RD8yspXAJAUT+Ban2Y6GC41AeLlRp0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-cM-E3QeUM0OPefJ9_ziqQw-1; Fri, 08 May 2020 16:38:52 -0400
X-MC-Unique: cM-E3QeUM0OPefJ9_ziqQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C154218A0760;
 Fri,  8 May 2020 20:38:49 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 780025C3FD;
 Fri,  8 May 2020 20:38:41 +0000 (UTC)
Subject: Re: [PATCH v3 06/17] block/io: support int64_t bytes in
 bdrv_aligned_pwritev()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
 <20200430111033.29980-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1b585d4f-69d3-b475-d763-b252f7317d0e@redhat.com>
Date: Fri, 8 May 2020 15:38:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430111033.29980-7-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
> So, prepare bdrv_aligned_pwritev() now and convert the dependencies:
> bdrv_co_write_req_prepare() and bdrv_co_write_req_finish() to signed
> type bytes.
> 
> Series: 64bit-block-status
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/block/io.c b/block/io.c
> index b83749cc50..8bb4ea6285 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1686,12 +1686,11 @@ fail:
>   }
>   
>   static inline int coroutine_fn
> -bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
> +bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
>                             BdrvTrackedRequest *req, int flags)

Changes from unsigned to signed.  Audit of callers:

bdrv_aligned_pwritev() - adjusted this patch, safe
bdrv_do_pdiscard() - passes int64_t, safe
bdrv_co_copy_range_internal() - passes int64_t, safe
bdrv_do_truncate() - passes int64_t, safe

Internal usage:

>   {
>       BlockDriverState *bs = child->bs;
>       bool waited;
> -    int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);

Drops an old sector calculation, and replaces it with:

>   
>       if (bs->read_only) {
>           return -EPERM;
> @@ -1716,8 +1715,10 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>       }
>   
>       assert(req->overlap_offset <= offset);
> +    assert(offset <= INT64_MAX - bytes);
>       assert(offset + bytes <= req->overlap_offset + req->overlap_bytes);
> -    assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
> +    assert(offset + bytes <= bs->total_sectors * BDRV_SECTOR_SIZE ||
> +           child->perm & BLK_PERM_RESIZE);

assertions that things fit within 63 bits.  Safe

[The req->overlap_offset+ req->overlap_bytes calculation used to be 
unsigned, but was changed to be signed earlier in this series]

>   
>       switch (req->type) {
>       case BDRV_TRACKED_WRITE:
> @@ -1738,7 +1739,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
>   }
>   
>   static inline void coroutine_fn
> -bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
> +bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
>                            BdrvTrackedRequest *req, int ret)
>   {

Similar to the above; same four callers, all pass int64_t.


>       int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);

This computation needs analysis.  Previously, we had:

DIV_ROUND_UP(int64_t + uint64_t, unsigned long long)
which expands to:
(((uint64_t) + (ull) - int) / (ull))
which simplifies to uint64_t.

Now we have:
DIV_ROUND_UP(int64_t + int64_t, ull)
Okay, in spite of our argument changing type, the macro still results in 
a 64-bit unsigned answer.  Either way, that answer fits within 63 bits, 
so it is safe when assigned to int64_t.

Also in this function:
             stat64_max(&bs->wr_highest_offset, offset + bytes);
in include/qemu/stats64.h, takes uint64_t parameter, but we're passing a 
positive 63-bit number - safe
             bdrv_set_dirty(bs, offset, bytes);
in block/dirty-bitmap.c, takes int64_t parameter - safe

> @@ -1780,14 +1781,14 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
>    * after possibly fragmenting it.
>    */
>   static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
> -    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
> +    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
>       int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
>   {

changes signature from unsigned 32-bit to signed 64-bit.  callers:

bdrv_co_do_zero_pwritev() - passes int64_t, but that was clamped to 
either pad.buf_len [BdrvRequestPadding uses 'size_t buf_len', but 
initializes it in bdrv_init_padding() to at most 2*align] or align set 
from BlockLimits.request_alignment (naturally uint32_t, but documented 
as 'a power of 2 less than INT_MAX' which is at most 1G), so the old 
code never overflowed, and the new code introduces no change

Perhaps we should separately fix BdrvRequestPadding to use a saner type 
than size_t for continuity between 32- and 64-bit platforms (perhaps 
uint32_t rather than int64_t, since we know our padding is bounded by 
request_alignment), but it doesn't impact this patch

bdrv_do_pwritev_part() - still passes unsigned int at this point in the 
series, safe

Usage within the function:

>       BlockDriverState *bs = child->bs;
>       BlockDriver *drv = bs->drv;
>       int ret;
>   
> -    uint64_t bytes_remaining = bytes;
> +    int64_t bytes_remaining = bytes;

Previously we widened unsigned 32-bit into unsigned 64-bit; now we use 
signed 64-bit unchanged.

>       int max_transfer;
>   
>       if (!drv) {
> @@ -1799,6 +1800,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
>       }
>   
>       assert(is_power_of_2(align));
> +    assert(offset >= 0);
> +    assert(bytes >= 0);
>       assert((offset & (align - 1)) == 0);
>       assert((bytes & (align - 1)) == 0);
>       assert(!qiov || qiov_offset + bytes <= qiov->size);

qiov->size is only size_t, while 'qiov_offset + bytes' changed from 
'size_t + unsigned int' to 'size_t + int64_t'.  The resulting type of 
the computation changes for some platforms, but the assertion is proving 
that things still fit (including in 32 bits, when size_t is constrained).

     ret = bdrv_co_write_req_prepare(child, offset, bytes, req, flags);
also touched in this patch, safe

         qemu_iovec_is_zero(qiov, qiov_offset, bytes)) {
Passes an 'int64_t' to a 'size_t' parameter, which is possibly 
narrowing.  Fortunately, the assertions just above prove that by this 
point, we are constrained by qiov->size, which is also size_t. Safe.

         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
Passes to int64_t, safe

         ret = bdrv_driver_pwritev_compressed(bs, offset, bytes,
Passes to int64_t, safe

         ret = bdrv_driver_pwritev(bs, offset, bytes, qiov, qiov_offset, 
flags);
Passes to int64_t, safe

             ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
                                       num, qiov, bytes - bytes_remaining,
Passes int64_t to size_t parameter, but the previous assertion proved we 
did not overflow qiov->size which is size_t. Safe

     bdrv_co_write_req_finish(child, offset, bytes, req, ret);
also touched in this patch, safe

> @@ -1899,7 +1902,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
>       assert(!bytes || (offset & (align - 1)) == 0);
>       if (bytes >= align) {
>           /* Write the aligned part in the middle. */
> -        uint64_t aligned_bytes = bytes & ~(align - 1);
> +        int64_t aligned_bytes = bytes & ~(align - 1);
>           ret = bdrv_aligned_pwritev(child, req, offset, aligned_bytes, align,
>                                      NULL, 0, flags);
>           if (ret < 0) {
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


