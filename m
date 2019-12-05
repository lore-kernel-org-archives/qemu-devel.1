Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 23:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70A1724659
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 23:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9v7iOAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1724659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id0z3-0000YH-FF
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 18:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1id0y1-0008Hl-Fq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1id0xy-0000k8-MF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31111
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1id0xx-0000hS-UP
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 18:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575590123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3JjvtBETMSq5X8ccPeP+yWghLInl+q64B1bKihIixk=;
 b=N9v7iOAsGUh2t9w1mu5ocue9Kp0MapR4zL8v0KW0LU4+6C0uFGbQdBMvSG0dJDLlQAYAm6
 ApMs1zZMmYMqaFyyMRURGmN4+y6vpn2/HgpSlLwIx6aJkeNsS2cWKb58O69sL0VfPI4tjH
 D1q+LJPInnF3cQE9zPzo6uOJyUQBKWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-0we2EaDoMcuog2U-Xez0fg-1; Thu, 05 Dec 2019 18:55:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10B5E19057A2;
 Thu,  5 Dec 2019 23:55:19 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0A1E5C1C3;
 Thu,  5 Dec 2019 23:55:15 +0000 (UTC)
Date: Thu, 5 Dec 2019 16:55:15 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [RFC PATCH 3/9] vfio/pci: register a default migration region
Message-ID: <20191205165515.3a9ac7b6@x1.home>
In-Reply-To: <20191205032638.29747-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
 <20191205032638.29747-1-yan.y.zhao@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0we2EaDoMcuog2U-Xez0fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, libvir-list@redhat.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
 qemu-devel@nongnu.org, shaopeng.he@intel.com, zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  4 Dec 2019 22:26:38 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> Vendor driver specifies when to support a migration region through cap
> VFIO_PCI_DEVICE_CAP_MIGRATION in vfio_pci_mediate_ops->open().
> 
> If vfio-pci detects this cap, it creates a default migration region on
> behalf of vendor driver with region len=0 and region->ops=null.
> Vendor driver should override this region's len, flags, rw, mmap in
> its vfio_pci_mediate_ops.
> 
> This migration region definition is aligned to QEMU vfio migration code v8:
> (https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05542.html)
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |  15 ++++
>  include/linux/vfio.h        |   1 +
>  include/uapi/linux/vfio.h   | 149 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index f3730252ee82..059660328be2 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -115,6 +115,18 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
>  }
>  
> +/**
> + * init a region to hold migration ctl & data
> + */
> +void init_migration_region(struct vfio_pci_device *vdev)
> +{
> +	vfio_pci_register_dev_region(vdev, VFIO_REGION_TYPE_MIGRATION,
> +		VFIO_REGION_SUBTYPE_MIGRATION,
> +		NULL, 0,
> +		VFIO_REGION_INFO_FLAG_READ | VFIO_REGION_INFO_FLAG_WRITE,
> +		NULL);
> +}
> +
>  static void vfio_pci_probe_mmaps(struct vfio_pci_device *vdev)
>  {
>  	struct resource *res;
> @@ -523,6 +535,9 @@ static int vfio_pci_open(void *device_data)
>  				vdev->mediate_ops = mentry->ops;
>  				vdev->mediate_handle = handle;
>  
> +				if (caps & VFIO_PCI_DEVICE_CAP_MIGRATION)
> +					init_migration_region(vdev);

No.  We're not going to add a cap flag for every region the mediation
driver wants to add.  The mediation driver should have the ability to
add regions and irqs to the device itself.  Thanks,

Alex

> +
>  				pr_info("vfio pci found mediate_ops %s, caps=%llx, handle=%x for %x:%x\n",
>  						vdev->mediate_ops->name, caps,
>  						handle, vdev->pdev->vendor,


