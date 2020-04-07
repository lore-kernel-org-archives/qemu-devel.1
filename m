Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A19C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA2D206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 04:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA2D206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLfZv-0005lN-Jj
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 00:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1jLfZJ-0005LR-3O
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1jLfZH-0001Of-Hf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:10:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60176 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1jLfZG-0001M0-Uc
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 00:10:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A9C3B8CE02779775D7F2;
 Tue,  7 Apr 2020 12:10:24 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 7 Apr 2020
 12:10:15 +0800
Subject: Re: [PATCH v16 QEMU 04/16] vfio: Add save and load functions for VFIO
 PCI devices
To: Kirti Wankhede <kwankhede@nvidia.com>, <alex.williamson@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-5-git-send-email-kwankhede@nvidia.com>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <4b79c097-4a56-49df-2f2e-b9c58d6e406e@huawei.com>
Date: Tue, 7 Apr 2020 12:10:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1585084154-29461-5-git-send-email-kwankhede@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, yan.y.zhao@intel.com,
 felipe@nutanix.com, eskultet@redhat.com, ziye.yang@intel.com, Ken.Xue@amd.com,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, eauger@redhat.com,
 cohuck@redhat.com, jonathan.davies@nutanix.com, cjia@nvidia.com,
 mlevitsk@redhat.com, changpeng.liu@intel.com, zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/25 5:09, Kirti Wankhede wrote:
> These functions save and restore PCI device specific data - config
> space of PCI device.
> Tested save and restore with MSI and MSIX type.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c                 | 163 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h |   2 +
>  2 files changed, 165 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6c77c12e44b9..8deb11e87ef7 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -41,6 +41,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "migration/qemu-file.h"
>  
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -1632,6 +1633,50 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
>      }
>  }
>  
> +static int vfio_bar_validate(VFIOPCIDevice *vdev, int nr)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +    VFIOBAR *bar = &vdev->bars[nr];
> +    uint64_t addr;
> +    uint32_t addr_lo, addr_hi = 0;
> +
> +    /* Skip unimplemented BARs and the upper half of 64bit BARS. */
> +    if (!bar->size) {
> +        return 0;
> +    }
> +
> +    addr_lo = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * 4, 4);
> +
> +    addr_lo = addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
> +                                       PCI_BASE_ADDRESS_MEM_MASK);
> +    if (bar->type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +        addr_hi = pci_default_read_config(pdev,
> +                                         PCI_BASE_ADDRESS_0 + (nr + 1) * 4, 4);
> +    }
> +
> +    addr = ((uint64_t)addr_hi << 32) | addr_lo;
> +
> +    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vfio_bars_validate(VFIOPCIDevice *vdev)
> +{
> +    int i, ret;
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        ret = vfio_bar_validate(vdev, i);
> +        if (ret) {
> +            error_report("vfio: BAR address %d validation failed", i);
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
>  static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOBAR *bar = &vdev->bars[nr];
> @@ -2414,11 +2459,129 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>      return OBJECT(vdev);
>  }
>  
> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint16_t pci_cmd;
> +    int i;
> +
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar;
> +
> +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> +        qemu_put_be32(f, bar);
> +    }
> +
> +    qemu_put_be32(f, vdev->interrupt);
> +    if (vdev->interrupt == VFIO_INT_MSI) {
> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +        bool msi_64bit;
> +
> +        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                                            2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        msi_addr_lo = pci_default_read_config(pdev,
> +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +        qemu_put_be32(f, msi_addr_lo);
> +
> +        if (msi_64bit) {
> +            msi_addr_hi = pci_default_read_config(pdev,
> +                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                             4);
> +        }
> +        qemu_put_be32(f, msi_addr_hi);
> +
> +        msi_data = pci_default_read_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                2);
> +        qemu_put_be32(f, msi_data);
> +    } else if (vdev->interrupt == VFIO_INT_MSIX) {
> +        uint16_t offset;
> +
> +        /* save enable bit and maskall bit */
> +        offset = pci_default_read_config(pdev,
> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> +        qemu_put_be16(f, offset);
> +        msix_save(pdev, f);
> +    }
> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    qemu_put_be16(f, pci_cmd);
> +}
> +
> +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +    uint32_t interrupt_type;
> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> +    uint16_t pci_cmd;
> +    bool msi_64bit;
> +    int i, ret;
> +
> +    /* retore pci bar configuration */
> +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar = qemu_get_be32(f);
> +
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> +    }
> +
> +    ret = vfio_bars_validate(vdev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    interrupt_type = qemu_get_be32(f);
> +
> +    if (interrupt_type == VFIO_INT_MSI) {
> +        /* restore msi configuration */
> +        msi_flags = pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
> +
> +        msi_addr_lo = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> +                              msi_addr_lo, 4);
> +
> +        msi_addr_hi = qemu_get_be32(f);
> +        if (msi_64bit) {
> +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> +                                  msi_addr_hi, 4);
> +        }
> +        msi_data = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                msi_data, 2);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
> +    } else if (interrupt_type == VFIO_INT_MSIX) {
> +        uint16_t offset = qemu_get_be16(f);
> +
> +        /* load enable bit and maskall bit */
> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> +                              offset, 2);
> +        msix_load(pdev, f);
Hi Kirti, Alex

'msix_load' here may increases the downtime. Our migrate-cap device has 128 msix
interrupts and the guestos enables all of them, so cost a lot of time (nearly
1s) to do 'msix_load', because in 'vfio_msix_vector_do_use' we need disable all
old interuppts and then append a new one.

What's your opinions ?

> +    }
> +    pci_cmd = qemu_get_be16(f);
> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> +    return 0;
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
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 74261feaeac9..d69a7f3ae31e 100644
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
> 

-- 
---
Regards,
Longpeng(Mike)

