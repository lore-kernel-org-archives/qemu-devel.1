Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9736C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9263B221EA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NyTewN8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9263B221EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTp08-0001nS-Ob
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 11:51:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTozB-00010P-VL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTozA-0005u6-As
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:50:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jToz9-0005sr-Sj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 11:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588175454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42NVZz1V2jRkN9cRCDLHNCYAQyVzPIYzwRSkPZ7C5Ls=;
 b=NyTewN8wdyD72R/177qBD6cFq+HudDNBIZWlh6p4mj8IMCldaLe+gfPxdyVD7p0bmZkbjJ
 HJPTY2JC71gOCJo8LD4xWN+f8YoWOFL4OWAH3btwbF1aDsGelwo62bs2tWjfJO2t9l8CWu
 T9E8Xpz6bKFG6bnRHN32RK/4p7wb5VE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-vl8dHog5OVGV-Rqh5xj9Uw-1; Wed, 29 Apr 2020 11:50:46 -0400
X-MC-Unique: vl8dHog5OVGV-Rqh5xj9Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E209A1005510;
 Wed, 29 Apr 2020 15:50:43 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D00C1001920;
 Wed, 29 Apr 2020 15:50:33 +0000 (UTC)
Subject: Re: [PATCH v2 02/17] block: use int64_t as bytes type in tracked
 requests
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
 <20200427082325.10414-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5450c309-feec-753d-6eb6-4411e913dfae@redhat.com>
Date: Wed, 29 Apr 2020 10:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427082325.10414-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 pavel.dovgaluk@ispras.ru, qemu-devel@nongnu.org, dillaman@redhat.com,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, stefanha@redhat.com, namei.unix@gmail.com,
 pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> We are generally moving to int64_t for both offset and bytes parameters
> on all io paths. Convert tracked requests now.

As mentioned elsewhere in the thread, this states 'what' but not 'why'; 
adding a bit more of the 'why' can be useful when revisiting this commit 
in the future.

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/block/block_int.h |  4 ++--
>   block/io.c                | 11 ++++++-----
>   2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 4c3587ea19..c8daba608b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -70,12 +70,12 @@ enum BdrvTrackedRequestType {
>   typedef struct BdrvTrackedRequest {
>       BlockDriverState *bs;
>       int64_t offset;
> -    uint64_t bytes;
> +    int64_t bytes;
>       enum BdrvTrackedRequestType type;
>   
>       bool serialising;
>       int64_t overlap_offset;
> -    uint64_t overlap_bytes;
> +    int64_t overlap_bytes;

unsigned values have defined wraparound semantics, signed values have a 
lower maximum and require careful handling to avoid undefined overflow. 
So we have to check all clients for any surprises.

block/file-posix.c:raw_do_pwrite_zeroes() -
         assert(req->offset + req->bytes >= offset + bytes);
pre-patch: assert(int64_t + uint64_t >= int64_t + int)
            assert(uint64_t >= int64_t) - unsigned compare
post-patch: assert(int64_t >= int64_t) - signed compare
Risky if adding req->bytes could ever overflow 63 bits but still fit in 
64 bits, but I couldn't find any way to trigger that.  I think we're 
safe because the block layer never calls a driver's .pwrite_zeroes with 
a bytes that would overflow 63 bits.

block/write-threshold.c:bdrv_write_threshold_exceeded() -
         if ((req->offset + req->bytes) > bs->write_threshold_offset) {
pre-patch: ((int64_t + uint64_t) > uint64_t) - unsigned compare
post-patch: (int64_t > uint64_t) - still unsigned compare

Perhaps that function should be changed to return int64_t, but probably 
as a different patch in the series (I didn't read ahead yet to see if 
you already did).

>   
>       QLIST_ENTRY(BdrvTrackedRequest) list;
>       Coroutine *co; /* owner, used for deadlock detection */
> diff --git a/block/io.c b/block/io.c
> index aba67f66b9..7cbb80bd24 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -692,10 +692,11 @@ static void tracked_request_end(BdrvTrackedRequest *req)
>   static void tracked_request_begin(BdrvTrackedRequest *req,
>                                     BlockDriverState *bs,
>                                     int64_t offset,
> -                                  uint64_t bytes,
> +                                  int64_t bytes,
>                                     enum BdrvTrackedRequestType type)
>   {
> -    assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
> +    assert(offset >= 0 && bytes >= 0 &&
> +           bytes <= INT64_MAX && offset <= INT64_MAX - bytes);

This part is nice - it makes it very easy to prove all other uses of 
BdrvTrackedRequest.bytes were already in range (both pre- and post-patch).

>   
>       *req = (BdrvTrackedRequest){
>           .bs = bs,
> @@ -716,7 +717,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
>   }
>   
>   static bool tracked_request_overlaps(BdrvTrackedRequest *req,
> -                                     int64_t offset, uint64_t bytes)
> +                                     int64_t offset, int64_t bytes)
>   {
>       /*        aaaa   bbbb */
>       if (offset >= req->overlap_offset + req->overlap_bytes) {
> @@ -773,8 +774,8 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
>   {
>       BlockDriverState *bs = req->bs;
>       int64_t overlap_offset = req->offset & ~(align - 1);

While here, should we use QEMU_ALIGN_DOWN instead of open-coding?

> -    uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
> -                               - overlap_offset;
> +    int64_t overlap_bytes =
> +            ROUND_UP(req->offset + req->bytes, align) - overlap_offset;
>       bool waited;
>   
>       qemu_co_mutex_lock(&bs->reqs_lock);
> 

Looking through uses of BdrvTrackedRequest in io.c, I couldn't find any 
other surprises (it seems everything starts with tracked_request_begin, 
and while you did switch between unsigned and signed, you did not switch 
width, so it's easier to reason about once we know things don't overflow).

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


