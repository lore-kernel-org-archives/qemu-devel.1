Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13116C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB4F207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0Ex2m1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB4F207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93yt-0001cB-3p
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k93xM-0008Ec-Fs
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:07:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k93xL-0007v2-0D
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598004450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9NSb5tE0m7PmlF1tlP39mORpP7XxP573bqYJHmLqcM=;
 b=e0Ex2m1LiLsQUnXUYDmSPifad2/eL8qBFTrK9f3lKj6b1TV010pjwXYbJJPK7A+asgWzTK
 fUUm+G2nPTXvGnMXNFGaXbqA8U/zPeYkCwpenxxrjMeIVnCOrA33V9ZDYNSyxWC8zxrgbZ
 Q1u+RUr3zL5M4i09yzp5D4rASSiGOuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-XuE0L9XmNHqwLLULMt2tPg-1; Fri, 21 Aug 2020 06:07:28 -0400
X-MC-Unique: XuE0L9XmNHqwLLULMt2tPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A023D186A590;
 Fri, 21 Aug 2020 10:07:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79A687C533;
 Fri, 21 Aug 2020 10:07:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F0539AE2; Fri, 21 Aug 2020 12:07:23 +0200 (CEST)
Date: Fri, 21 Aug 2020 12:07:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH] virtio-gpu: fix unmap the already mapped items
Message-ID: <20200821100723.vbyo5bpxwrmjqdyp@sirius.home.kraxel.org>
References: <20200821084945.5264-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200821084945.5264-1-lizhijian@cn.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 04:49:45PM +0800, Li Zhijian wrote:
> we go here either (!(*iov)[i].iov_base) or (len != l), so we need to consider
> to unmap the 'i'th item as well when the 'i'th item is not nil
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/display/virtio-gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c150..1f777e43ff 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -656,7 +656,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMIO memory for"
>                            " resource %d element %d\n",
>                            __func__, ab->resource_id, i);
> -            virtio_gpu_cleanup_mapping_iov(g, *iov, i);
> +            virtio_gpu_cleanup_mapping_iov(g, *iov, i + !!(*iov)[i].iov_base);

Cute trick, but the code should be readable without having to dig out
the commit message which explains it.  Can we have something simpler
along the lines of "if (iov_base) { i++; /* cleanup partial map */ }"
please?

thanks,
  Gerd


