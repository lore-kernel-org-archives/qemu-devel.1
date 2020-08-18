Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:28:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239AE20674
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 10:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1HMDvV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239AE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yrK-0005Ej-Ae
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 06:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7yqG-00046l-KG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:27:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7yqE-000198-OZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 06:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597746461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NTAOE18gh52n4jCO6wejcIsvupqh3SYDO9mNwrkP3y8=;
 b=F1HMDvV51o2es1ovlOgh7DITTWxb5F8mvm4BsqNh3auvHuProBHK4MDQn8YTWs/VhPp9Rz
 QEeJKHicSAXoGXqH/bHn6/YpC+Y6L14uRSQQKUARF3cegFVP/2VB2eFGulvFiS3hg18ceA
 P2SCkAQDESTS/lG2gaXDdNpKCltFzgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-WRpleXwyOYWBfqhFSYLHew-1; Tue, 18 Aug 2020 06:27:37 -0400
X-MC-Unique: WRpleXwyOYWBfqhFSYLHew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01E118686E4;
 Tue, 18 Aug 2020 10:27:36 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2FC27A1F5;
 Tue, 18 Aug 2020 10:27:35 +0000 (UTC)
Date: Tue, 18 Aug 2020 12:27:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 10/47] mirror-top: Support compressed writes
Message-ID: <20200818102734.GC6865@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-11-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625152215.941773-11-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: none client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/mirror.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/block/mirror.c b/block/mirror.c
> index e8e8844afc..469acf4600 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1480,6 +1480,15 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
>                                      NULL, 0);
>  }
>  
> +static int coroutine_fn bdrv_mirror_top_pwritev_compressed(BlockDriverState *bs,
> +                                                           uint64_t offset,
> +                                                           uint64_t bytes,
> +                                                           QEMUIOVector *qiov)
> +{
> +    return bdrv_mirror_top_pwritev(bs, offset, bytes, qiov,
> +                                   BDRV_REQ_WRITE_COMPRESSED);
> +}

Hm, not sure if it's a problem, but bdrv_supports_compressed_writes()
will now return true for mirror-top. However, with an active mirror to a
target that doesn't support compression, trying to actually do a
compressed write will always return -ENOTSUP.

So I guess the set of nodes patch 7 looks at still isn't quite complete.
However, it's not obvious how to make it more complete without
delegating to the driver.

Maybe we need to use bs->supported_write_flags, which is set by the
driver, instead of looking at the presence of callbacks.

Of course, in the general case, we also should make sure that graph
changes will be reflected in bs->supported_write_flags, but we already
fail to do this in raw-format, so I guess ignoring it for now is good
enough here, too...

Kevin


