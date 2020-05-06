Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD66AC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93187208D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6ptrbln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93187208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLNY-0000fs-NK
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWLMf-0008CN-FF
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:49:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWLMd-0002ie-I4
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588776574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOg70KcRYQn9BoJx1el52BAcVUCnAdJ3kVXPFLgevxA=;
 b=C6ptrblnIP7cDRY451v48MX/TbURQZ22zfhV9HeLdtM/yLq/YNeR86fafAnW/kv2RDLB1Y
 P5N9T7ZFImVOzj7QzQEXUWzblEGmPt1Ha6VPTw7tNHdD6oqFIqAqH2fLX7qHhnPWdSMrRy
 Anb+D6jy14TSaxU+SlvBygI6mHs9yqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-XHvRBJ1LONe4P1xEXA6q-Q-1; Wed, 06 May 2020 10:49:32 -0400
X-MC-Unique: XHvRBJ1LONe4P1xEXA6q-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35FA81895A28;
 Wed,  6 May 2020 14:49:30 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 307CB19C4F;
 Wed,  6 May 2020 14:49:26 +0000 (UTC)
Subject: Re: [PATCH 7/8] qemu-img: convert: don't use
 unallocated_blocks_are_zero
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
 <20200506092513.20904-8-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6e430529-5fe1-65de-6e07-6176d0d9a201@redhat.com>
Date: Wed, 6 May 2020 09:49:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506092513.20904-8-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
> qemu-img convert wants to distinguish ZERO which comes from short
> backing files. unallocated_blocks_are_zero field of bdi is unrelated:
> space after EOF is always considered to be zero anyway. So, just make
> post_backing_zero true in case of short backing file.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qemu-img.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

This patch should come first in the series.  It would have saved me a 
lot of time in reviewing 1/8.

> 
> diff --git a/qemu-img.c b/qemu-img.c
> index 6a4327aaba..4fe751878b 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1632,7 +1632,6 @@ typedef struct ImgConvertState {
>       BlockBackend *target;
>       bool has_zero_init;
>       bool compressed;
> -    bool unallocated_blocks_are_zero;
>       bool target_is_new;
>       bool target_has_backing;
>       int64_t target_backing_sectors; /* negative if unknown */
> @@ -1677,7 +1676,7 @@ static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
>   
>       if (s->target_backing_sectors >= 0) {
>           if (sector_num >= s->target_backing_sectors) {
> -            post_backing_zero = s->unallocated_blocks_are_zero;
> +            post_backing_zero = true;
>           } else if (sector_num + n > s->target_backing_sectors) {
>               /* Split requests around target_backing_sectors (because
>                * starting from there, zeros are handled differently) */
> @@ -2580,7 +2579,6 @@ static int img_convert(int argc, char **argv)
>       } else {
>           s.compressed = s.compressed || bdi.needs_compressed_writes;
>           s.cluster_sectors = bdi.cluster_size / BDRV_SECTOR_SIZE;
> -        s.unallocated_blocks_are_zero = bdi.unallocated_blocks_are_zero;
>       }

My question in 1/8 about whether we have iotest coverage of this 
optimization remains, but I concur that the block layer takes care of 
reading zero when encountering unallocated blocks beyond EOF of a short 
backing file, and therefore performing this optimization always rather 
than just when the driver claims that unallocated blocks read as zero 
should be safe.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


