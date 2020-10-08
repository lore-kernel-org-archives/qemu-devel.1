Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89D4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 270AD2223F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FN0S6se1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270AD2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdP3-0004js-V3
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQdMu-0003xK-Be
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQdMr-0004nq-K9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602192148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foe8IvXTZgjpuNZ07X2ksFCt/nw0A/GnkEBbWA83SbU=;
 b=FN0S6se12RWfkEASOU9loHzY7XRHYnLlSFkD2ZsPbfNCXJITfnT/ITU+vtLX3X716Q+j+P
 AzEicyY8hejzd4/VLeT52Dq6E4rNEhOFItOLvkdFYZRmCYtpSoyzZpT5AJddN8/s/1y+tm
 mII9hg59dfFofb3fawA/6yXLZwjVkGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-YFt3FEODNzeHlAFjzzGRuw-1; Thu, 08 Oct 2020 17:22:24 -0400
X-MC-Unique: YFt3FEODNzeHlAFjzzGRuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F5C1019625;
 Thu,  8 Oct 2020 21:22:23 +0000 (UTC)
Received: from w520.home (ovpn-113-244.phx2.redhat.com [10.3.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F0A355797;
 Thu,  8 Oct 2020 21:22:15 +0000 (UTC)
Date: Thu, 8 Oct 2020 15:22:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 10/10] vfio: Don't issue full 2^64 unmap
Message-ID: <20201008152214.3cb1425b@w520.home>
In-Reply-To: <20201008171558.410886-11-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-11-jean-philippe@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  8 Oct 2020 19:15:58 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> IOMMUs may declare memory regions spanning from 0 to UINT64_MAX. When
> attempting to deal with such region, vfio_listener_region_del() passes a
> size of 2^64 to int128_get64() which throws an assertion failure.  Even
> ignoring this, the VFIO_IOMMU_DMA_MAP ioctl cannot handle this size
> since the size field is 64-bit. Split the request in two.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> For me this happens when memory_region_iommu_set_page_size_mask()
> returns an error because a hotplugged endpoint uses an incompatible page
> mask. vfio_connect_container() releases the memory listener which calls
> region_del() with the 2^64 IOMMU region. There are probably other ways
> to reach this.
> ---
>  hw/vfio/common.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e66054b02a7..e90a89c389e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -797,6 +797,17 @@ static void vfio_listener_region_del(MemoryListener *listener,
>      }
>  
>      if (try_unmap) {
> +        if (llsize == int128_2_64()) {
> +            /* The unmap ioctl doesn't accept a full 64-bit span. */
> +            llsize = int128_rshift(llsize, 1);
> +            ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
> +            if (ret) {
> +                error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                             "0x%"HWADDR_PRIx") = %d (%m)",
> +                             container, iova, int128_get64(llsize), ret);
> +            }
> +            iova += int128_get64(llsize);
> +        }
>          ret = vfio_dma_unmap(container, iova, int128_get64(llsize));
>          if (ret) {
>              error_report("vfio_dma_unmap(%p, 0x%"HWADDR_PRIx", "

We're still susceptible that splitting the range in two could result in
unmap calls that attempt to bisect a mapping that spans both ranges.
Both unmap calls would fail in that case.  I think we could solve this
more completely with a high water marker, but this probably good enough
for now.

Acked-by: Alex Williamson <alex.williamson@redhat.com>


