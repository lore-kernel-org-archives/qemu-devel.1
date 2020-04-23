Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB874C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E162075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGlREDK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E162075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRduc-00026o-SX
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRdtx-0001gY-6C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRdtw-0007Ru-7B
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:36:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRdtu-0007LQ-NS
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587656189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iizc3MEBI1kFVhveD5Vny+dqyQrqDqh2G/5yCYHmFVg=;
 b=gGlREDK6mVwH75PN6YlkvaslEem8hlrvA/k5VtHZtKFMcD4iJEyp/P1HtmNxFxGnV/eHS6
 vtk9sFwsW2TDlfuJfMPk85c5qLnuqVMONwFgJLBarmW8IIp1VnD2sbjMjfm4KRStMd3ILD
 d30tDzn+iXpeyeoxwyhRhsTIbtHIUQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-N2LhN3WLM5O_FSCk2y8euQ-1; Thu, 23 Apr 2020 11:36:25 -0400
X-MC-Unique: N2LhN3WLM5O_FSCk2y8euQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A874460;
 Thu, 23 Apr 2020 15:36:24 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10D885D9CC;
 Thu, 23 Apr 2020 15:36:22 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] qcow2: Forward ZERO_WRITE flag for full
 preallocation
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-11-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <fca340c2-5bee-b287-e43e-28dc679ea372@redhat.com>
Date: Thu, 23 Apr 2020 10:36:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423150127.142609-11-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/23/20 10:01 AM, Kevin Wolf wrote:
> The BDRV_REQ_ZERO_WRITE is currently implemented in a way that first the
> image is possibly preallocated and then the zero flag is added to all
> clusters. This means that a copy-on-write operation may be needed when
> writing to these clusters, despite having used preallocation, negating
> one of the major benefits of preallocation.
> 
> Instead, try to forward the BDRV_REQ_ZERO_WRITE to the protocol driver,
> and if the protocol driver can ensure that the new area reads as zeros,
> we can skip setting the zero flag in the qcow2 layer.

Hmm.  When we get block status, it is very easy to tell that something 
reads as zero when the qcow2 file has the zero bit set, but when the 
qcow2 file does not have the zero bit set, we have to then query the 
format layer whether it reads as zeros (which is expensive enough for 
some format layers that we no longer report things as reading as zero). 
I'm worried that optimizing this case could penalize later block status.

We already can tell the difference between a cluster that has the zero 
bit set but is not preallocated, vs. has the zero bit set and is 
preallocated.  Are we really forcing a copy-on-write to a cluster that 
is marked zero but preallocated?  Is the problem that we don't have a 
way to distinguish between 'reads as zeroes, allocated, but we don't 
know state of format layer' and 'reads as zeroes, allocated, and we know 
format layer reads as zeroes'?

> 
> Unfortunately, the same approach doesn't work for metadata
> preallocation, so we'll still set the zero flag there.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/qcow2.c              | 22 +++++++++++++++++++---
>   tests/qemu-iotests/274.out |  4 ++--
>   2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ad621fe404..b28e588942 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4170,9 +4170,25 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
>           /* Allocate the data area */
>           new_file_size = allocation_start +
>                           nb_new_data_clusters * s->cluster_size;
> -        /* Image file grows, so @exact does not matter */
> -        ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, 0,
> -                               errp);
> +        /*
> +         * Image file grows, so @exact does not matter.
> +         *
> +         * If we need to zero out the new area, try first whether the protocol
> +         * driver can already take care of this.
> +         */
> +        if (flags & BDRV_REQ_ZERO_WRITE) {
> +            ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc,
> +                                   BDRV_REQ_ZERO_WRITE, errp);
> +            if (ret >= 0) {
> +                flags &= ~BDRV_REQ_ZERO_WRITE;
> +            }

Hmm - just noticing things: how does this series interplay with the 
existing bdrv_has_zero_init_truncate?  Should this series automatically 
handle BDRV_REQ_ZERO_WRITE on a bdrv_co_truncate(PREALLOC_NONE) request 
for all drivers that report true, even if that driver does not advertise 
support for the BDRV_REQ_ZERO_WRITE flag?

> +        } else {
> +            ret = -1;
> +        }

Here, ret == -1 does not imply whether errp is set - but annoyingly, 
errp CAN be set if bdrv_co_truncate() failed.

> +        if (ret < 0) {
> +            ret = bdrv_co_truncate(bs->file, new_file_size, false, prealloc, 0,
> +                                   errp);

And here, you are passing a possibly-set errp back to 
bdrv_co_truncate().  That is a bug that can abort.  You need to pass 
NULL to the first bdrv_co_truncate() call or else clear errp prior to 
trying a fallback to this second bdrv_co_truncate() call.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


