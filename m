Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBEAC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 157A321D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157A321D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKyRC-0004dQ-0V
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 02:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kKyQb-0004E6-O3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:38:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4766 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuzenghui@huawei.com>)
 id 1kKyQY-00084y-Rg
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:38:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2D97DBB6E5A5ABAF67DA;
 Wed, 23 Sep 2020 14:38:38 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 23 Sep 2020 14:38:28 +0800
Subject: Re: [PATCH v26 03/17] vfio: Add save and load functions for VFIO PCI
 devices
To: Kirti Wankhede <kwankhede@nvidia.com>, <alex.williamson@redhat.com>,
 <cjia@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <75d17b56-e59e-8d70-de3e-2395635fa119@huawei.com>
Date: Wed, 23 Sep 2020 14:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=yuzenghui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 02:38:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, eskultet@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, wanghaibin.wang@huawei.com,
 Ken.Xue@amd.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 zhi.a.wang@intel.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kirti,

A few trivial comments from the first read through.

On 2020/9/23 7:24, Kirti Wankhede wrote:
> These functions save and restore PCI device specific data - config
> space of PCI device.
> Used VMStateDescription to save and restore interrupt state.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>   hw/vfio/pci.c                 | 134 ++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h                 |   1 +
>   include/hw/vfio/vfio-common.h |   2 +
>   3 files changed, 137 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bffd5bfe3b78..9968cc553391 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -41,6 +41,7 @@
>   #include "trace.h"
>   #include "qapi/error.h"
>   #include "migration/blocker.h"
> +#include "migration/qemu-file.h"
>   
>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>   
> @@ -2401,11 +2402,142 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>       return OBJECT(vdev);
>   }
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
> +    } else if (interrupt_type == VFIO_INT_MSIX) {
> +        uint16_t offset;

Maybe rename it to 'control' to match the PCI term?

> +
> +        msix_load(pdev, f);
> +        offset = pci_default_read_config(pdev,
> +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> +        /* load enable bit and maskall bit */
> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> +                              offset, 2);
> +    }
> +    return 0;
> +}
> +
> +static int vfio_put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
> +                             const VMStateField *field, QJSON *vmdesc)
> +{
> +    VFIOPCIDevice *vdev = container_of(pv, VFIOPCIDevice, vbasedev);
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    qemu_put_be32(f, vdev->interrupt);
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

Two blank lines.

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
> +
> +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vbasedev,
> +                             vdev->version_id);
> +
> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> +    return ret;
> +}
> +
>   static VFIODeviceOps vfio_pci_ops = {
>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
>       .vfio_eoi = vfio_intx_eoi,
>       .vfio_get_object = vfio_pci_get_object,
> +    .vfio_save_config = vfio_pci_save_config,
> +    .vfio_load_config = vfio_pci_load_config,
>   };
>   
>   int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> @@ -2755,6 +2887,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       vdev->vbasedev.ops = &vfio_pci_ops;
>       vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
>       vdev->vbasedev.dev = DEVICE(vdev);
> +    vdev->vbasedev.device_state = 0;

This shouldn't belong to this patch.


Thanks,
Zenghui

