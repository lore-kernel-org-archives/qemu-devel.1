Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10806C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FCD207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 22:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw/rmBcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FCD207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLa4U-0003Rf-QO
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 18:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLa3L-0002x6-4J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kLa3I-0005Qz-6m
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 18:49:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600987758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOuzFwbVuMGZBOVSOWYMmP538Cal+9D/Dxpe2NCkwQE=;
 b=Rw/rmBclkL2JnshhrCdSp29DfotJ0wkgKgNsh7VKNqvsNnxAm8koBDnewPCUoUuTEIOLzG
 Qo7b7HFYZQr0j298P0KQug9zxMmM3Fi7Mp9Q40pvs7/hHi+C6AxH+JQ88krv69vLmX4BR/
 qF/HSRBcj6Xdw/MiWXadiRDAT31eCOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ttIGnICdPOeN8oDMZLqTOA-1; Thu, 24 Sep 2020 18:49:15 -0400
X-MC-Unique: ttIGnICdPOeN8oDMZLqTOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B955780732A;
 Thu, 24 Sep 2020 22:49:12 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F3D173693;
 Thu, 24 Sep 2020 22:49:05 +0000 (UTC)
Date: Thu, 24 Sep 2020 16:49:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 03/17] vfio: Add save and load functions for VFIO
 PCI devices
Message-ID: <20200924164905.1a2f1384@x1.home>
In-Reply-To: <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 04:54:05 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> These functions save and restore PCI device specific data - config
> space of PCI device.
> Used VMStateDescription to save and restore interrupt state.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c                 | 134 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.h                 |   1 +
>  include/hw/vfio/vfio-common.h |   2 +
>  3 files changed, 137 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bffd5bfe3b78..9968cc553391 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -41,6 +41,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "migration/qemu-file.h"
>  
>  #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>  
> @@ -2401,11 +2402,142 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>      return OBJECT(vdev);
>  }
>  
> +static int vfio_get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
> +                             const VMStateField *field)
> +{
> +    VFIOPCIDevice *vdev = container_of(pv, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint32_t interrupt_type;
> +
> +    interrupt_type = qemu_get_be32(f);
> +
> +    if (interrupt_type == VFIO_INT_MSI) {
> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +        bool msi_64bit;
> +
> +        /* restore msi configuration */
> +        msi_flags = pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags & ~PCI_MSI_FLAGS_ENABLE, 2);
> +
> +        msi_addr_lo = pci_default_read_config(pdev,
> +                                        pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> +                              msi_addr_lo, 4);
> +
> +        if (msi_64bit) {
> +            msi_addr_hi = pci_default_read_config(pdev,
> +                                        pdev->msi_cap + PCI_MSI_ADDRESS_HI, 4);
> +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                  msi_addr_hi, 4);
> +        }
> +
> +        msi_data = pci_default_read_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                2);
> +
> +        vfio_pci_write_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                msi_data, 2);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);

Aside from the flags register which includes the enable bit, is there
any purpose to reading the other registers from emulated config space
and writing them back through vfio?

> +    } else if (interrupt_type == VFIO_INT_MSIX) {
> +        uint16_t offset;
> +
> +        msix_load(pdev, f);
> +        offset = pci_default_read_config(pdev,
> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> +        /* load enable bit and maskall bit */
> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> +                              offset, 2);
> +    }
> +    return 0;


It seems this could be simplified down to:

if (msi_enabled(pdev)) {
    vfio_msi_enable(vdev);
} else if (msix_enabled(pdev)) {
    msix_load(pdev, f);
    vfio_msix_enable(vdev);
}

But that sort of begs the question whether both MSI and MSI-X should be
handled via subsections, where MSI-X could make use of VMSTATE_MSIX and
a post_load callback for each would test to see if the capability is
enabled and call the appropriate vfio_msi{x}_enable() function.  That
would also make it a lot more clear how additional capabilities with
QEMU emulation state would be handled in the future.

> +}
> +
> +static int vfio_put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
> +                             const VMStateField *field, QJSON *vmdesc)
> +{
> +    VFIOPCIDevice *vdev = container_of(pv, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    qemu_put_be32(f, vdev->interrupt);

As above, it seems that vdev->interrupt can be inferred by looking at
config space.

> +    if (vdev->interrupt == VFIO_INT_MSIX) {
> +        msix_save(pdev, f);
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_info_vfio_pci_irq_state = {
> +    .name = "VFIO PCI irq state",
> +    .get  = vfio_get_pci_irq_state,
> +    .put  = vfio_put_pci_irq_state,
> +};
> +
> +const VMStateDescription vmstate_vfio_pci_config = {
> +    .name = "VFIOPCIDevice",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_INT32_POSITIVE_LE(version_id, VFIOPCIDevice),
> +        VMSTATE_BUFFER_UNSAFE_INFO(interrupt, VFIOPCIDevice, 1,
> +                                   vmstate_info_vfio_pci_irq_state,
> +                                   sizeof(int32_t)),

Seems like we're copying vmstate_pci_device here rather than using
VMSTATE_PCI_DEVICE, shouldn't we be using the latter instead?

> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +
> +    pci_device_save(pdev, f);
> +    vmstate_save_state(f, &vmstate_vfio_pci_config, vbasedev, NULL);
> +}
> +
> +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint16_t pci_cmd;
> +    int ret, i;
> +
> +    ret = pci_device_load(pdev, f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /* retore pci bar configuration */
> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                        pci_cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY), 2);
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar = pci_default_read_config(pdev,
> +                                               PCI_BASE_ADDRESS_0 + i * 4, 4);
> +
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> +    }

Is the intention here to trigger the sub-page support?  If so we should
have a comment because otherwise there's no reason to write it back,
right?  Another option might be to simply call the sub-page update
directly.

> +
> +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vbasedev,
> +                             vdev->version_id);
> +
> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> +    return ret;
> +}
> +
>  static VFIODeviceOps vfio_pci_ops = {
>      .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>      .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
>      .vfio_eoi = vfio_intx_eoi,
>      .vfio_get_object = vfio_pci_get_object,
> +    .vfio_save_config = vfio_pci_save_config,
> +    .vfio_load_config = vfio_pci_load_config,
>  };
>  
>  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> @@ -2755,6 +2887,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vdev->vbasedev.ops = &vfio_pci_ops;
>      vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
>      vdev->vbasedev.dev = DEVICE(vdev);
> +    vdev->vbasedev.device_state = 0;

Why is this here?

> +    vdev->version_id = 1;

I'm not sure how this is meant to work or if it's even necessary if we
use VMSTATE_PCI_DEVICE and infer the interrupt configuration from
config space.

>  
>      tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
>      len = readlink(tmp, group_path, sizeof(group_path));
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index bce71a9ac93f..9f46af7e153f 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
>      uint32_t display_yres;
>      int32_t bootindex;
>      uint32_t igd_gms;
> +    int32_t version_id;     /* Version id needed for VMState */
>      OffAutoPCIBAR msix_relo;
>      uint8_t pm_cap;
>      uint8_t nv_gpudirect_clique;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fe99c36a693a..ba6169cd926e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -120,6 +120,8 @@ struct VFIODeviceOps {
>      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>      void (*vfio_eoi)(VFIODevice *vdev);
>      Object *(*vfio_get_object)(VFIODevice *vdev);
> +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> +    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>  };
>  
>  typedef struct VFIOGroup {


