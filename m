Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4D2C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145092071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb5bEyr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145092071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHvC-0002fM-8f
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jJHuU-00028Z-RT
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jJHuT-0006wv-MN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:30:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jJHuT-0006wU-HW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585665032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3JQzDu41M8o39GXgIAVsohawRfa23jPDPNH2E+Xc14=;
 b=Lb5bEyr9R56OcTrLxQsZjBi9gHvlD1pVSbv0vYU8G1qf04fpPOCxcBdRXChi9fgvbbF8tB
 9xSFCx7y8bd2YpBGwqeEJKRWqYeeSnspBpgZLlX9zuW7DZT3h7vhlYyamw54GMquS5F6nS
 4BKmU1/uhx+DxLOAH3Sp5TH62LV5ruE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-JEk-THX6NiWcPUo3QNy1vQ-1; Tue, 31 Mar 2020 10:30:29 -0400
X-MC-Unique: JEk-THX6NiWcPUo3QNy1vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C51191084433;
 Tue, 31 Mar 2020 14:30:26 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CC9B100EBD4;
 Tue, 31 Mar 2020 14:30:07 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: set host iommu context to vIOMMU
To: Liu Yi L <yi.l.liu@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, peterx@redhat.com
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-11-git-send-email-yi.l.liu@intel.com>
Message-ID: <564d1a55-04df-a3bd-5241-e30f958a4e89@redhat.com>
Date: Tue, 31 Mar 2020 16:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-11-git-send-email-yi.l.liu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
 pbonzini@redhat.com, hao.wu@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yi,

On 3/30/20 6:24 AM, Liu Yi L wrote:
> For vfio-pci devices, it could use pci_device_set/unset_iommu() to
> expose host iommu context to vIOMMU emulators. vIOMMU emulators
> could make use the methods provided by host iommu context. e.g.
> propagate requests to host iommu.
I think I would squash this patch into the previous one.

> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/vfio/pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5e75a95..c140c88 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2717,6 +2717,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      VFIODevice *vbasedev_iter;
>      VFIOGroup *group;
> +    VFIOContainer *container;
>      char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>      Error *err = NULL;
>      ssize_t len;
> @@ -3028,6 +3029,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
>  
> +    container = vdev->vbasedev.group->container;
> +    if (container->iommu_ctx.initialized) {
Sin't it possible to dynamically allocate the iommu_ctx so that you can
simply check container->iommu_ctx and discard the initialized field?
> +        pci_device_set_iommu_context(pdev, &container->iommu_ctx);
> +    }
> +
>      return;
>  
>  out_deregister:
> @@ -3072,9 +3078,16 @@ static void vfio_instance_finalize(Object *obj)
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
>      VFIOPCIDevice *vdev = PCI_VFIO(pdev);
> +    VFIOContainer *container;
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> +
> +    container = vdev->vbasedev.group->container;
> +    if (container->iommu_ctx.initialized) {
> +        pci_device_unset_iommu_context(pdev);
> +    }
> +
>      pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
>      if (vdev->irqchip_change_notifier.notify) {
>          kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> 
Thanks

Eric


