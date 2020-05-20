Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9EF207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ab971ELq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9EF207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPsU-0008V5-0D
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbPrt-000810-IB
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:38:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbPrr-0001KF-61
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589985525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4SU0WetqPbmum2RDmvGMrtIYEQl2w7sZJXKe381jlI=;
 b=ab971ELqJeEU3om4g06DA4GcaHxKM8II5LbreCeEUtsxand9eAFPKsVvKoAfaOOXPPEypb
 GZqCchYuc8U6duJZWt4QrO0l5BjWr/iRZqPc5lj1V19OrAdewdm0/s/BgHhR3zeslO81j7
 Ry2QcVOjFo3hNgN5EzjN1cm8NnbDPfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-BISD0DqaOiSfTVUOYPKB0w-1; Wed, 20 May 2020 10:38:36 -0400
X-MC-Unique: BISD0DqaOiSfTVUOYPKB0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 375AC107ACF9;
 Wed, 20 May 2020 14:38:35 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83F5F1057FD8;
 Wed, 20 May 2020 14:38:31 +0000 (UTC)
Subject: Re: [PATCH v3 1/5] block/io: fix bdrv_co_block_status_above
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200520083520.25793-1-vsementsov@virtuozzo.com>
 <20200520083520.25793-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1dfda9f1-48cf-236c-65eb-7afc5daaa77c@redhat.com>
Date: Wed, 20 May 2020 09:38:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520083520.25793-2-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
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

On 5/20/20 3:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_co_block_status_above has several design problems with handling
> short backing files:
> 
> 1. With want_zeros=true, it may return ret with BDRV_BLOCK_ZERO but
> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> which produces these after-EOF zeros is inside requested backing
> sequence.
> 
> 2. With want_zero=false, it may return pnum=0 prior to actual EOF,
> because of EOF of short backing file.
> 
> Fix these things, making logic about short backing files clearer.
> 
> With fixed bdrv_block_status_above we also have to improve is_zero in
> qcow2 code, otherwise iotest 154 will fail, because with this patch we
> stop to merge zeros of different types (produced by fully unallocated
> in the whole backing chain regions vs produced by short backing files).
> 
> Note also, that this patch leaves for another day the general problem
> around block-status: misuse of BDRV_BLOCK_ALLOCATED as is-fs-allocated
> vs go-to-backing.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/io.c    | 39 ++++++++++++++++++++++++++++++---------
>   block/qcow2.c | 16 ++++++++++++++--
>   2 files changed, 44 insertions(+), 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/block/qcow2.c
> @@ -3827,8 +3827,20 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
>       if (!bytes) {
>           return true;
>       }
> -    res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
> -    return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
> +
> +    /*
> +     * bdrv_block_status_above doesn't merge different types of zeros, for
> +     * example, zeros which comes from the region which is unallocated in

s/comes/come/

> +     * the whole backing chain, and zeros which comes because of short backing

and again, also s/of/of a/

> +     * file. So, we need a loop.
> +     */
> +    do {
> +        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
> +        offset += nr;
> +        bytes -= nr;
> +    } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
> +
> +    return res >= 0 && (res & BDRV_BLOCK_ZERO) && bytes == 0;
>   }
>   
>   static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


