Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3080C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB7120737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/3WleTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB7120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQKP-000675-Qj
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQIs-0004LC-4i
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQIq-0002Y1-7y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:40:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57678
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQIp-0002Ts-Uk
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5/kTKGJX3uO+7MY4P3ky5JxeSu04jmYgyMg5lRYaE1k=;
 b=B/3WleTxW/X6SKSlrShbTTbN+RR3Ubcp6YrzgiGdwzmDRmWQBtWVlI0Zsyyxzjd4tqF+D7
 0PcHW8ugiVlaE9uYlVmaYGP0kDGfxhvFp3YHxVRzVjbGBdXIWxF6jiZBsHgPjoEg2MT6dc
 JDxbk1K/TuwdtYK8pM84k23ghQDKDqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-0AmLnwLsP0-GVmNEqJ0KbA-1; Fri, 03 Apr 2020 13:40:13 -0400
X-MC-Unique: 0AmLnwLsP0-GVmNEqJ0KbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E762A802567;
 Fri,  3 Apr 2020 17:40:11 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 209B69A255;
 Fri,  3 Apr 2020 17:40:11 +0000 (UTC)
Subject: Re: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200403165752.18009-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a8434c66-7c80-2632-b8fd-404e7a0e6c69@redhat.com>
Date: Fri, 3 Apr 2020 12:40:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403165752.18009-1-berto@igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 11:57 AM, Alberto Garcia wrote:
> When issuing a compressed write request the number of bytes must be a
> multiple of the cluster size.
> 
> With the current code such requests are allowed and we hit an
> assertion:
> 
>     $ qemu-img create -f qcow2 img.qcow2 1M
>     $ qemu-io -c 'write -c 0 32k' img.qcow2
> 
>     qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:
>     Assertion `bytes == s->cluster_size || (bytes < s->cluster_size &&
>                (offset + bytes == bs->total_sectors << BDRV_SECTOR_BITS))' failed.
>     Aborted
> 
> This patch fixes a regression introduced in 0d483dce38
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/qcow2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2bb536b014..923ad428f0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4345,7 +4345,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
>           return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
>       }
>   
> -    if (offset_into_cluster(s, offset)) {
> +    if (offset_into_cluster(s, offset | bytes)) {
>           return -EINVAL;
>       }
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


