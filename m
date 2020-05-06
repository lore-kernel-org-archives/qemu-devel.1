Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506EDC4725B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1222620836
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 15:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix6snfsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1222620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLlB-0005JN-5W
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 11:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWLkV-0004oy-5M
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:14:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37584
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWLkT-0007gL-8J
 for qemu-devel@nongnu.org; Wed, 06 May 2020 11:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588778052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYVMI1TiOkiUJmKaM89uxSRms9LLT1RCGqmG5RR7eME=;
 b=ix6snfsQa30Qcd8tibzo6kBgVV+82POxLPRt/eZnYFrX4JEYyFtrljaX/1ju3vtOF9qJ/Y
 7XNPtUQA56mWZxJDL8h7npzZD8ICP3+0VqLTVMvskc+twmQsFihaMqgUneswsbXO/M4+8c
 NJ7poSmGp1GvoyX/gkhQU9pgC063viw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-hwqDaHH8P8SIWneq3I1XqQ-1; Wed, 06 May 2020 11:14:07 -0400
X-MC-Unique: hwqDaHH8P8SIWneq3I1XqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFC6D835B40;
 Wed,  6 May 2020 15:14:05 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3965D9C5;
 Wed,  6 May 2020 15:14:02 +0000 (UTC)
Subject: Re: [PATCH 8/8] block: drop unallocated_blocks_are_zero
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-9-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ad581d23-d79d-bf78-3cd5-848eb29a90f5@redhat.com>
Date: Wed, 6 May 2020 10:14:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506092513.20904-9-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/20 4:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> Currently this field only set by qed and qcow2.

Well, only after patches 1-6 (prior to then, it was also set in protocol 
drivers).  I think you might be able to hoist part of this patch earlier 
in the series, to make the changes to the protocol drivers easier to 
review, by rewording this sentence:

Currently, the only format drivers that set this field are qed and qcow2.

> But in fact, all
> backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
> this semantics: on unallocated blocks, if there is no backing file they

s/this/these/

> just memset the buffer with zeroes.
> 
> So, document this behavior for .supports_backing and drop
> .unallocated_blocks_are_zero
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block.h     |  6 ------
>   include/block/block_int.h | 13 ++++++++++++-
>   block.c                   | 15 ---------------
>   block/io.c                |  8 ++++----
>   block/qcow2.c             |  1 -
>   block/qed.c               |  1 -
>   6 files changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/include/block/block.h b/include/block/block.h
> index 8b62429aa4..db1cb503ec 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
>       /* offset at which the VM state can be saved (0 if not possible) */
>       int64_t vm_state_offset;
>       bool is_dirty;
> -    /*
> -     * True if unallocated blocks read back as zeroes. This is equivalent
> -     * to the LBPRZ flag in the SCSI logical block provisioning page.
> -     */
> -    bool unallocated_blocks_are_zero;

You can't delete this field until all protocol drivers are cleaned up, 
so deferring this part of the change to the end of the series makes sense.

>       /*
>        * True if this block driver only supports compressed writes
>        */
> @@ -431,7 +426,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
>   int bdrv_has_zero_init_1(BlockDriverState *bs);
>   int bdrv_has_zero_init(BlockDriverState *bs);
>   int bdrv_has_zero_init_truncate(BlockDriverState *bs);
> -bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);

Doing this cleanup makes sense: there is only one caller of this 
function pre-patch, and 0 callers post-patch - but whether the cleanup 
should be at the same time as you fix the one caller, or deferred to 
when you also clean up the field, is less important.

If I were writing the series:

1 - fix qemu-img.c to not use the field
2 - fix block_status to not use the function
3-n - fix protocol drivers that set the field to also return _ZERO
  during block status (but not delete the field at that time)
n+1 - delete unused function and field (from ALL drivers)

>   bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
>   int bdrv_block_status(BlockDriverState *bs, int64_t offset,
>                         int64_t bytes, int64_t *pnum, int64_t *map,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 92335f33c7..c156b22c6b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -115,7 +115,18 @@ struct BlockDriver {
>        */
>       bool bdrv_needs_filename;
>   
> -    /* Set if a driver can support backing files */
> +    /*
> +     * Set if a driver can support backing files. This also implies the
> +     * following semantics:
> +     *
> +     *  - Return status 0 of .bdrv_co_block_status means that corresponding
> +     *    blocks are not allocated in this layer of backing-chain
> +     *  - For such (unallocated) blocks, read will:
> +     *    - read from backing file if there is one and big enough

s/and/and it is/

> +     *    - fill buffer with zeroes if there is no backing file
> +     *    - space after EOF of the backing file considered as zero
> +     *      (corresponding part of read-buffer must be zeroed by driver)

Does the driver actually have to do the zeroing?  Looking at qcow2.c, I see:
static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
...

     case QCOW2_CLUSTER_UNALLOCATED:
         assert(bs->backing); /* otherwise handled in 
qcow2_co_preadv_part */

         BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
         return bdrv_co_preadv_part(bs->backing, offset, bytes,
                                    qiov, qiov_offset, 0);

which just defers to the block layer to handle read-beyond-EOF, rather 
than an explicit memset in the driver.

So maybe you can simplify to:
- For such (unallocated) blocks, read will:
   - fill buffer with zeros if there is no backing file
   - read from the backing file otherwise, where the block layer
     takes care of reading zeros beyond EOF if backing file is short

But the effect is the same.

> +++ b/block/io.c
> @@ -2385,16 +2385,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>   
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |= BDRV_BLOCK_ALLOCATED;
> -    } else if (want_zero) {
> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
> -            ret |= BDRV_BLOCK_ZERO;
> -        } else if (bs->backing) {
> +    } else if (want_zero && bs->drv->supports_backing) {
> +        if (bs->backing) {
>               BlockDriverState *bs2 = bs->backing->bs;
>               int64_t size2 = bdrv_getlength(bs2);
>   
>               if (size2 >= 0 && offset >= size2) {
>                   ret |= BDRV_BLOCK_ZERO;
>               }
> +        } else {
> +            ret |= BDRV_BLOCK_ZERO;
>           }

I like this part of the change.  But if it is done first in the series, 
it _does_ have a semantic impact on protocol drivers (previously, 
protocol drivers that return 0 but set the field 
.unallocated_blocks_are_zero will be changed to report _ZERO; after this 
patch, protocol drivers do not do that, because they don't support 
backing files, and it is now only backing files that do the _ZERO 
magic).  So doing _just_ this change, along with a better analysis of 
how it changes the semantics of 'qemu-io -c map' on protocol drivers 
while mentioning why that is okay, would make a better start to the 
series, rather than here at the end.  Of course, if you defer it to the 
end, then none of the protocol drivers set .unallocated_blocks_are_zero 
anyway, but that cost more review work on each altered protocol driver.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


