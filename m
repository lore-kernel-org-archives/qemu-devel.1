Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49BF206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWRD2y9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49BF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKYx-0005QV-24
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWKYK-0004wr-5r
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:57:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWKYI-000368-IJ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588773453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGLKBnzrNY89o9HUFgmv3KIKBu8QPj/EqQH4fHVLdm8=;
 b=JWRD2y9R1rmFnDpCR656mf1tOQBfEp627ZtQewjEqF8gJXmXIzuoa8Qhx/ZTzbKfcbVO4S
 GLntBtqty3jU/SWTTuqukNVOzarirjasLggcDnWU2kpe6H3xCC18Bd/Mc53xnfkz+dgQYy
 niCKyvvKyNZtF4G/P2R82cFCP0d38aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-94dIJ0zIOkeGkUcEo6iZvg-1; Wed, 06 May 2020 09:57:28 -0400
X-MC-Unique: 94dIJ0zIOkeGkUcEo6iZvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B6380183C;
 Wed,  6 May 2020 13:57:25 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D50910013D9;
 Wed,  6 May 2020 13:57:21 +0000 (UTC)
Subject: Re: [PATCH 1/8] block/vdi: return ZERO block-status when appropriate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <496d65c2-ae7b-7456-532a-9acc90d1f926@redhat.com>
Date: Wed, 6 May 2020 08:57:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506092513.20904-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
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
> In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
> of qiov. So, this should be reported as ZERO.

This part makes sense outright, since vdi does not allow backing files, 
so all reads of a VDI disk result in data rather than deferral to 
another layer, and we indeed read zero in this case.  However, it _is_ a 
behavior change: previously, 'qemu-io -c map' on a vdi image will show 
unallocated portions, but with this change, the entire image now shows 
as allocated.  You need to call out this fact in the commit message, 
documenting that it is intentional (it matches what we do for posix 
files: since neither files nor vdi support backing images, we guarantee 
that all read attempts will be satisfied by this layer rather than 
deferring to a backing layer, and thus can treat all data as allocated 
in this layer, regardless of whether it is sparse).

Do any existing iotests need an update to reflect change in output?  If 
not, should we have an iotest covering it?

> 
> After block-status update, it never reports 0, so setting
> unallocated_blocks_are_zero doesn't make sense. Drop it.

This is a harder claim. To prove it, we need to inspect all callers that 
use unallocated_blocks_are_zero, to see their intent.  Fortunately, the 
list is small - a mere 2 clients!

block/io.c:bdrv_co_block_status(): if .bdrv_co_block_status sets either 
_DATA or _ZERO, block status adds _ALLOCATED; but if the driver did not 
set either, we use bdrv_unallocated_blocks_are_zero() in order to set 
_ZERO but not _ALLOCATED.  This is the code that explains the behavior 
change mentioned above (now that vdi is reporting _ZERO instead of 0, 
block_status is appending _ALLOCATED instead of querying 
bdrv_unallocated_blocks_are_zero).  But you are correct that it does not 
change where _ZERO is reported.

qemu-img.c:img_convert(): calls bdrv_get_info() up front and caches what 
it learned from unallocated_blocks_are_zero about the target; later on, 
in convert_iteration_sectors(), it uses this information to optimize the 
case where the source reads as zero, but the target has a backing file 
and the range being written lies beyond the end of the backing file. 
That is, given the following scenario:

qemu-img convert input -B backing output
input:   ABCD-0E
backing: ACBD

the optimization lets us produce:
output:  -BC---E

instead of the larger:
output:  -BC--0E

Do we have any iotests that cover this particular scenario, to prove 
that our optimization does indeed result in a smaller image file without 
explicit zeros written in the tail?  Or put another way, if we were to 
disable the post_backing_zero optimization in 
convert_iteration_sectors(), would any iotests fail?  If not, we should 
really enhance our testsuite.

With that said, we could just as easily achieve the optimization of the 
conversion to the tail of a destination with short backing file by 
checking block_status to see whether the tail already reads as all 
zeroes, rather than relying on unallocated_blocks_are_zero.  Even if 
querying block_status is a slight pessimization in time, it would avoid 
regressing in the more important factor of artificially bloating the 
destination.  I would _really_ love to see a patch to qemu-img.c 
reworking the logic to avoid the use of unallocated_blocks_are_zero 
first, prior to removing the setting of that field in the various 
drivers.  Once bdrv_co_block_status() remains as the only client of the 
field, then I could accept this patch with a better commit message about 
the intentional change in block_status _ALLOCATION behavior.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/vdi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index 0c7835ae70..83471528d2 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>       logout("\n");
>       bdi->cluster_size = s->block_size;
>       bdi->vm_state_offset = 0;
> -    bdi->unallocated_blocks_are_zero = true;
>       return 0;
>   }
>   
> @@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
>       *pnum = MIN(s->block_size - index_in_block, bytes);
>       result = VDI_IS_ALLOCATED(bmap_entry);
>       if (!result) {
> -        return 0;
> +        return BDRV_BLOCK_ZERO;
>       }
>   
>       *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


