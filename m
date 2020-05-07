Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1D9C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1763F208DB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR1ml13S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1763F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhDh-00047n-7f
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhD0-0003LX-7A
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:09:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jWhCy-0005Nn-T8
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588860543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw6pjzx/6d7FhYxhki23pTY5frsNEZFMJZbo3r5X854=;
 b=IR1ml13Se7WiVwKAKONzAHSn3R8atuwukg9SU/F2fr2WHlhjv4uLQHHuctg9HyaJyANWxo
 wpqrRhivq03fZEsIH9zNfVNRVrcEeRfpQGsNsiuwugcH6lbO5sflQ/cMCB9ujrQB3SOHyF
 6opNDx/Kkj/wNPIgHRwvkkCADCr+26g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-oBZg08xaNfyoa88kTzP0yw-1; Thu, 07 May 2020 10:08:52 -0400
X-MC-Unique: oBZg08xaNfyoa88kTzP0yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3359C8BF622;
 Thu,  7 May 2020 14:08:50 +0000 (UTC)
Received: from [10.3.114.73] (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD30F62952;
 Thu,  7 May 2020 14:08:44 +0000 (UTC)
Subject: Re: [PATCH v2 2/9] block: inline bdrv_unallocated_blocks_are_zero()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
 <20200507084800.20596-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <066235a9-72ee-f9bc-7d5b-1f664a7d36b7@redhat.com>
Date: Thu, 7 May 2020 09:08:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507084800.20596-3-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, ronniesahlberg@gmail.com,
 codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/20 3:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function has the only user: bdrv_co_block_status(). Inline it to

s/the only/only one/

> simplify reviewing of the following patches, which will finally drop
> unallocated_blocks_are_zero field too.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   include/block/block.h |  1 -
>   block.c               | 15 ---------------
>   block/io.c            | 11 ++++++++---
>   3 files changed, 8 insertions(+), 19 deletions(-)
> 

> +++ b/block/io.c
> @@ -2386,15 +2386,20 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
>       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
>           ret |= BDRV_BLOCK_ALLOCATED;
>       } else if (want_zero) {
> -        if (bdrv_unallocated_blocks_are_zero(bs)) {
> -            ret |= BDRV_BLOCK_ZERO;
> -        } else if (bs->backing) {
> +        if (bs->backing) {
>               BlockDriverState *bs2 = bs->backing->bs;
>               int64_t size2 = bdrv_getlength(bs2);
>   
>               if (size2 >= 0 && offset >= size2) {
>                   ret |= BDRV_BLOCK_ZERO;
>               }
> +        } else {
> +            BlockDriverInfo bdi;
> +            int ret2 = bdrv_get_info(bs, &bdi);
> +
> +            if (ret2 == 0 && bdi.unallocated_blocks_are_zero) {

Could perhaps condense to:

else {
     BlockDriverInfo bdi;

     if (bdrv_get_info(bs, &bd) == 0 &&
         bdi.unallocated_blocks_are_zero) {

but that's cosmetic.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


