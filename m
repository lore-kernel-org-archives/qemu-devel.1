Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4E2C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135292082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGTuvHMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135292082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2d0h-0001Co-8M
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 10:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1j2d04-0000bX-Tx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1j2d03-00078E-Ln
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:35:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1j2d03-000786-HX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 10:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581694527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7CVJ0sJI1pSRv/OIudov9/ZM9/R5TudR53FuZlrlqQ=;
 b=VGTuvHMgvAaIHEdyTGys295BSegoAqU+FpaE6q0rtJpo4BwSecnQqXwuWAbU+LM/87V+A5
 EFQ9OeOegX0MatG+roCyKGbLp6i4uuQt5Kvmb9RWY3L+ZqxO+7fekrUUF1BU1yvtHONymH
 V0S9v9j7uMvujWlunCqM+DLUmzrx7qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-VfzCd4qYNt-s-tzfgkoGIQ-1; Fri, 14 Feb 2020 10:35:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B934A8010E6;
 Fri, 14 Feb 2020 15:35:16 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33CF65C126;
 Fri, 14 Feb 2020 15:35:16 +0000 (UTC)
Date: Fri, 14 Feb 2020 08:35:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2] Report stringified errno in VFIO related errors
Message-ID: <20200214083515.15b94be8@x1.home>
In-Reply-To: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
References: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VfzCd4qYNt-s-tzfgkoGIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:55:19 +0100
Michal Privoznik <mprivozn@redhat.com> wrote:

> In a few places we report errno formatted as a negative integer.
> This is not as user friendly as it can be. Use strerror() and/or
> error_setg_errno() instead.
> 
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
> 
> v1 posted here:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg03623.html
> 
> diff to v1:
>  - Change error reporting in vfio_dma_unmap() too as I missed it in v1.
> 
>  hw/vfio/common.c    | 4 ++--
>  util/vfio-helpers.c | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5ca11488d6..0b3593b3c0 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -319,7 +319,7 @@ static int vfio_dma_unmap(VFIOContainer *container,
>              unmap.size -= 1ULL << ctz64(container->pgsizes);
>              continue;
>          }
> -        error_report("VFIO_UNMAP_DMA: %d", -errno);
> +        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>          return -errno;
>      }
>  
> @@ -352,7 +352,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>          return 0;
>      }
>  
> -    error_report("VFIO_MAP_DMA: %d", -errno);
> +    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>      return -errno;
>  }
>  
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 813f7ec564..ddd9a96e76 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -545,7 +545,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
>      trace_qemu_vfio_do_mapping(s, host, size, iova);
>  
>      if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
> -        error_report("VFIO_MAP_DMA: %d", -errno);
> +        error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>          return -errno;
>      }
>      return 0;
> @@ -570,7 +570,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
>      assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
>      assert(index >= 0 && index < s->nr_mappings);
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
> +        error_setg_errno(errp, errno, "VFIO_UNMAP_DMA failed");
>      }
>      memmove(mapping, &s->mappings[index + 1],
>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
> @@ -669,7 +669,7 @@ int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
>      trace_qemu_vfio_dma_reset_temporary(s);
>      qemu_mutex_lock(&s->lock);
>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
> -        error_report("VFIO_UNMAP_DMA: %d", -errno);
> +        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>          qemu_mutex_unlock(&s->lock);
>          return -errno;
>      }

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

(hoping this gets grabbed by trivial)


