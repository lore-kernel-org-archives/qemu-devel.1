Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B63C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D072C2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wxd8eunY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D072C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLys-0005tR-Ra
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kNLOR-0002ZN-8l
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kNLON-0005np-8x
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:34:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601408065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H9VQbT8ap250nIQPCuR7hoymORQXtVlGWEfSVmZfmhc=;
 b=Wxd8eunYwaTWE4bxhENZdEWbRHgev1MVS/G7mx/fJCPB+Y1xddIjuuHhTVwFmkrfhyRcCb
 mO4MAN8TO751v1UBp/QL7ov+1c5dDLJelwlqJNBSnTp8VJOVRHKodYwv291rwM2Siu3MIY
 yAr50hNLBJi++7g1FOA0qOinqFYW0Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-oOHXZOB0NnavgxZILIEGeA-1; Tue, 29 Sep 2020 15:34:23 -0400
X-MC-Unique: oOHXZOB0NnavgxZILIEGeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6835164147;
 Tue, 29 Sep 2020 19:34:22 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1CFA5D9DC;
 Tue, 29 Sep 2020 19:34:14 +0000 (UTC)
Date: Tue, 29 Sep 2020 13:34:14 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Wei Huang <wei.huang2@amd.com>
Subject: Re: [PATCH V1 2/3] amd-iommu: Sync IOVA-to-GPA translation during
 page invalidation
Message-ID: <20200929133414.41982c53@x1.home>
In-Reply-To: <20200928200506.75441-3-wei.huang2@amd.com>
References: <20200928200506.75441-1-wei.huang2@amd.com>
 <20200928200506.75441-3-wei.huang2@amd.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, pbonzini@redhat.com, Suravee.Suthikulpanit@amd.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 15:05:05 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> Add support to sync the IOVA-to-GPA translation at the time of IOMMU
> page invalidation. This function is called when two IOMMU commands,
> AMDVI_CMD_INVAL_AMDVI_PAGES and AMDVI_CMD_INVAL_AMDVI_ALL, are
> intercepted. Address space notifiers are called accordingly.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> ---
>  hw/i386/amd_iommu.c | 177 ++++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/amd_iommu.h |  10 +++
>  hw/vfio/common.c    |   3 +-
>  3 files changed, 189 insertions(+), 1 deletion(-)
...
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 13471ae29436..243216499ce0 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -346,7 +346,8 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>       * the VGA ROM space.
>       */
>      if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> -        (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> +        ((errno == EEXIST || errno == EBUSY) &&
> +         vfio_dma_unmap(container, iova, size) == 0 &&
>           ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
>          return 0;
>      }


This seems like it should be a separate patch.  AFAICT the commit log
doesn't even hint at why this change is necessary.  I think the -EBUSY
error pre-dates vIOMMU as well.  Responding the same for an -EEXIST
almost suggests a coherency issue between QEMU and the kernel, or a
direct mapping replacement without an invalidation, which doesn't seem
to be what this patch is implementing.  Thanks,

Alex


