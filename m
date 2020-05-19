Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9780C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959892072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRl4eG3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959892072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb93y-0006rw-OP
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 16:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb933-0005l1-Ix
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:41:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jb931-0004jQ-UI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 16:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589920870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyZPiJ+Ubh0KNEfjInlQzQb+A8ihsMdxamhjFH0QUbE=;
 b=HRl4eG3cdmNGXxiAxM/hMlK+86BsDw+xzzKeP6A2jWDNB8K9JDpHff4B7BgfxNooV/x2kU
 i/G9kGMaEnPu+nswVDPg8OIXkLNHufAN8EJwz9eiDdxrCYJ9uzRs+MSghzqjl9gLOsLLaJ
 pSkAieeTJ0XhiDfaaSq9CA0Dyz40sxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-McGgvQlxNYOeQ2S0w8zzXA-1; Tue, 19 May 2020 16:41:06 -0400
X-MC-Unique: McGgvQlxNYOeQ2S0w8zzXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8FC474;
 Tue, 19 May 2020 20:41:05 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230A860610;
 Tue, 19 May 2020 20:41:00 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] block/io: fix bdrv_co_block_status_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200519195501.29071-1-vsementsov@virtuozzo.com>
 <20200519195501.29071-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cd4c3996-703a-13c5-aa9c-664d2de0ca26@redhat.com>
Date: Tue, 19 May 2020 15:41:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519195501.29071-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 2:54 PM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_co_block_status_above has several problems with handling short
> backing files:
> 
> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> which produces these after-EOF zeros is inside requested backing
> sequence.

That's intentional.  That portion of the guest-visible data reads as 
zero (BDRV_BLOCK_ZERO set) but was NOT read from the top layer, but 
rather synthesized by the block layer because it derived from the 
backing file but was beyond EOF of that backing layer 
(BDRV_BLOCK_ALLOCATED is clear).

> 
> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
> because of EOF of short backing file.

Do you have a reproducer for this?  In my experience, this is not 
possible.  Generally, if you request status that overlaps EOF of the 
backing, you get a response truncated to the end of the backing, and you 
are then likely to follow up with a subsequent status request starting 
from the underlying EOF which then sees the desired unallocated zeroes:

back     xxxx
top      yy------
request    ^^^^^^
response   ^^
request      ^^^^
response     ^^^^

> 
> Fix these things, making logic about short backing files clearer.
> 
> Note that 154 output changed, because now bdrv_block_status_above don't

doesn't

> merge unallocated zeros with zeros after EOF (which are actually
> "allocated" in POV of read from backing-chain top) and is_zero() just
> don't understand that the whole head or tail is zero. We may update
> is_zero to call bdrv_block_status_above several times, or add flag to
> bdrv_block_status_above that we are not interested in ALLOCATED flag,
> so ranges with different ALLOCATED status may be merged, but actually,
> it seems that we'd better don't care about this corner case.

This actually sounds like an avoidable regression.  :(

I argue that if we did not explicitly write data/zero clusters in the 
tail of the top layer, then those clusters are not allocated from the 
POV of reading from the backing-chain top.  Yes, we know what their 
contents will be, but we also know what the contents of unallocated 
clusters will be when there is no backing file at all - basically, after 
your other patch series to drop unallocated_blocks_are_zero:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg05429.html
then we know that only format drivers that can support backing files 
even care what allocation means, and 'allocated' strictly means that the 
data comes from the top layer rather than from a backing (whether 
directly from the backing, or synthesized as zero by the block layer 
because it was beyond EOF of the backing).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c                 | 38 +++++++++++++++++++++++++++++---------
>   tests/qemu-iotests/154.out |  4 ++--
>   2 files changed, 31 insertions(+), 11 deletions(-)
> 

I'm already not a fan of this patch - it adds lines rather than removes, 
and seems to add a regression.

> diff --git a/block/io.c b/block/io.c
> index 121ce17a49..db990e812b 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2461,25 +2461,45 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
>           ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
>                                      file);
>           if (ret < 0) {
> -            break;
> +            return ret;
>           }
> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
> +        if (*pnum == 0) {
> +            if (first) {
> +                return ret;
> +            }
> +
>               /*
> -             * Reading beyond the end of the file continues to read
> -             * zeroes, but we can only widen the result to the
> -             * unallocated length we learned from an earlier
> -             * iteration.
> +             * Reads from bs for the selected region will return zeroes,
> +             * produced because the current level is short. We should consider
> +             * it as allocated.

Why?  If we replaced the backing file to something longer (qemu-img 
rebase -u), we would WANT to read from the backing file.  The only 
reason we read zero is because the block layer synthesized it _while_ 
deferring to the backing layer, not because it was directly allocated in 
the top layer.

> +             *
> +             * TODO: Should we report p as file here?

No. Reporting 'file' only makes sense if you can point to an offset 
within that file that would read the guest-visible data in question - 
but when the data is synthesized, there is no such offset.

>                */
> +            assert(ret & BDRV_BLOCK_EOF);
>               *pnum = bytes;
> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
>           }
> -        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
> -            break;
> +        if (ret & BDRV_BLOCK_ALLOCATED) {
> +            /* We've found the node and the status, we must return. */
> +
> +            if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
> +                /*
> +                 * This level is also responsible for reads after EOF inside
> +                 * the unallocated region in the previous level.
> +                 */
> +                *pnum = bytes;
> +            }
> +
> +            return ret;
>           }
> +
>           /* [offset, pnum] unallocated on this layer, which could be only
>            * the first part of [offset, bytes].  */
> -        bytes = MIN(bytes, *pnum);
> +        assert(*pnum <= bytes);
> +        bytes = *pnum;
>           first = false;
>       }
> +
>       return ret;
>   }
>   
> diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
> index fa3673317f..a203dfcadd 100644
> --- a/tests/qemu-iotests/154.out
> +++ b/tests/qemu-iotests/154.out
> @@ -310,13 +310,13 @@ wrote 512/512 bytes at offset 134217728
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]

The fact that we no longer see zeroes in the tail of the file makes me 
think this patch is wrong.

>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
>   wrote 512/512 bytes at offset 134219264
>   512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   2048/2048 bytes allocated at offset 128 MiB
>   [{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": false},
> -{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data": false}]
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
>   Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134219776 backing_file=TEST_DIR/t.IMGFMT.base
>   wrote 1024/1024 bytes at offset 134218240
>   1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


