Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33F120772
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vuj2Jr3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33F120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9HG-0000XU-55
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg9Fe-00076i-TV
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:54:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49773
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg9Fd-0000wB-GQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591113291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oK4Mk8YymMKrSR8JDeD4k7TnUKm+J2m4/LYtZZRYVS0=;
 b=Vuj2Jr3UAoIAtNvB/Mn4guSmWjEDMgIHb7691PUVJVfBcF6Wq89veS0u+oqPmrw/CBNtfN
 LZF5jAHJqM70V0XsPk+7T4eeTMrguwzirF1Teyq0rvjsiLYBWOJoaANPbEQ+uEhDknQMeN
 vedfT8LjkRC8JxwUfwm0BHIgazp0XIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-xiZ0bQGNOaW1o6e6BwXZPw-1; Tue, 02 Jun 2020 11:54:44 -0400
X-MC-Unique: xiZ0bQGNOaW1o6e6BwXZPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 369DD1054F90;
 Tue,  2 Jun 2020 15:54:43 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 851827E7E6;
 Tue,  2 Jun 2020 15:54:41 +0000 (UTC)
Date: Tue, 2 Jun 2020 17:54:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2] icount: make dma reads deterministic
Message-ID: <20200602155440.GK5940@linux.fritz.box>
References: <158823737122.27545.13132967751052120169.stgit@pasha-ThinkPad-X280>
MIME-Version: 1.0
In-Reply-To: <158823737122.27545.13132967751052120169.stgit@pasha-ThinkPad-X280>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 11:02 hat Pavel Dovgalyuk geschrieben:
> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
> 
> Windows guest sometimes makes DMA requests with overlapping
> target addresses. This leads to the following structure of iov for
> the block driver:
> 
> addr size1
> addr size2
> addr size3
> 
> It means that three adjacent disk blocks should be read into the same
> memory buffer. Windows does not expects anything from these bytes
> (should it be data from the first block, or the last one, or some mix),
> but uses them somehow. It leads to non-determinism of the guest execution,
> because block driver does not preserve any order of reading.
> 
> This situation was discusses in the mailing list at least twice:
> https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html
> 
> This patch makes such disk reads deterministic in icount mode.
> It splits the whole request into several parts. Parts may overlap,
> but SGs inside one part do not overlap.
> Parts that are processed later overwrite the prior ones in case
> of overlapping.
> 
> Examples for different SG part sequences:
> 
> 1)
> A1 1000
> A2 1000
> A1 1000
> A3 1000
> ->
> One request is split into two.
> A1 1000
> A2 1000
> --
> A1 1000
> A3 1000
> 
> 2)
> A1 800
> A2 1000
> A1 1000
> ->
> A1 800
> A2 1000
> --
> A1 1000
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>  - Rewritten the loop to split the request instead of skipping the parts
>    (suggested by Kevin Wolf)
> ---
>  dma-helpers.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/dma-helpers.c b/dma-helpers.c
> index e8a26e81e1..a49f9a0e34 100644
> --- a/dma-helpers.c
> +++ b/dma-helpers.c
> @@ -13,6 +13,8 @@
>  #include "trace-root.h"
>  #include "qemu/thread.h"
>  #include "qemu/main-loop.h"
> +#include "sysemu/cpus.h"
> +#include "qemu/range.h"
>  
>  /* #define DEBUG_IOMMU */
>  
> @@ -142,6 +144,24 @@ static void dma_blk_cb(void *opaque, int ret)
>          cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
>          cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
>          mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir);
> +        /*
> +         * Make reads deterministic in icount mode. Windows sometimes issues
> +         * disk read requests with overlapping SGs. It leads
> +         * to non-determinism, because resulting buffer contents may be mixed
> +         * from several sectors. This code splits all SGs into several
> +         * groups. SGs in every group do not overlap.
> +         */
> +        if (use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
> +            int i;
> +            for (i = 0 ; i < dbs->iov.niov ; ++i) {
> +                if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
> +                                   dbs->iov.iov[i].iov_len, (intptr_t)mem,
> +                                   cur_len)) {
> +                    mem = NULL;

Doesn't this leak mem, i.e. should we call dma_memory_unmap()?

Did you verify that it is guaranteed that mapping the same guest memory
twice results in the same host address? v1 compared the SG list (which
has guest addresses) rather than the resulting QEMUIOVector (which has
host addresses).

> +                    break;
> +                }
> +            }
> +        }
>          if (!mem)
>              break;
>          qemu_iovec_add(&dbs->iov, mem, cur_len);

Kevin


