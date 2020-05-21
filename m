Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F379C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000AE20814
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLwzXmZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000AE20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr4F-000651-61
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqrn-0003Kc-Hp
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:28:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jbqrk-0002lA-KP
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590089307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6wyCne8FKhV1+MJhZGsKzoiHEYw7CVVSVHp1wH0buw=;
 b=cLwzXmZ7IVfdrnh0areXvgu83VjtYF/CgKW7OPofyk82MdU8S1o+Tqaw+CiUes8oa2tlsx
 a25bq6hKmXDnLnYNiI8NE8AxZ4FhTXYD/7950lvoTj3pyXgHrAfiPmh3Fv4I25msZ0/X1n
 BEgbd2w7o3G8v863sstfDpcMg8T+KRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-meROZ-HDMxCA8qryQMgZ0w-1; Thu, 21 May 2020 15:28:25 -0400
X-MC-Unique: meROZ-HDMxCA8qryQMgZ0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB4091005510;
 Thu, 21 May 2020 19:28:23 +0000 (UTC)
Received: from work-vm (ovpn-113-115.ams2.redhat.com [10.36.113.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F27D61CA;
 Thu, 21 May 2020 19:28:12 +0000 (UTC)
Date: Thu, 21 May 2020 20:28:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v23 04/18] vfio: Add save and load functions for
 VFIO PCI devices
Message-ID: <20200521192810.GQ2752@work-vm>
References: <1589999088-31477-1-git-send-email-kwankhede@nvidia.com>
 <1589999088-31477-5-git-send-email-kwankhede@nvidia.com>
 <20200521095049.GB2752@work-vm>
 <edc6b7d1-6b85-44ac-836a-bca0fef110eb@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <edc6b7d1-6b85-44ac-836a-bca0fef110eb@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> 
> 
> On 5/21/2020 3:20 PM, Dr. David Alan Gilbert wrote:
> > * Kirti Wankhede (kwankhede@nvidia.com) wrote:
> > > These functions save and restore PCI device specific data - config
> > > space of PCI device.
> > > Tested save and restore with MSI and MSIX type.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > 
> > So I'm OK with this from the migration side, but I'd like Alex to check it from
> > the PCI side of things.
> > 
> > I still think that you'd be better:
> >    a) Using a VMStateDescription to encode the structure
> 
> Can we use VMStateDescription and SaveVMHandlers at a same time for
> migration?

Yes, one trick you can do is to call vmstate_save_state from your save
function, passing it as a vmsd; e.g. hw/virtio/virtio-pci.c virtio_pci_save_extra_state
does that.

> >    b) or at least adding a flag at the end so you can add more data later
> > 
> 
> Sure, I'm thinking of this option.

Great.

> > Experience with every other device shows you're shooting yourself in the
> > foot by hard coding the layout and not giving yourself a chance to
> > expand it.
> > 
> > but for now,
> > 
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> Thanks, this version of QEMU patches was posted without addressing comments
> on previous version so that others can test kernel interface for now. We
> need to freeze kernel interface and get those patches in v5.8 kernel.

OK, I'm more on the qemu side; and I think I've reviewed all the patches
I understand (left a few deep vfio ones for Alex).  The kernel interface
looks like it fits qemu's use here OK.

> I'll revisit all the remaining comments on v16 and v18 QEMU patches again
> and reiterate the patches. So this is not the final version.

Great.

Dave

> Thanks,
> Kirti
> 
> > 
> > > ---
> > >   hw/vfio/pci.c                 | 163 ++++++++++++++++++++++++++++++++++++++++++
> > >   include/hw/vfio/vfio-common.h |   2 +
> > >   2 files changed, 165 insertions(+)
> > > 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 0514ba373d1c..94535f0e27cd 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -41,6 +41,7 @@
> > >   #include "trace.h"
> > >   #include "qapi/error.h"
> > >   #include "migration/blocker.h"
> > > +#include "migration/qemu-file.h"
> > >   #define TYPE_VFIO_PCI "vfio-pci"
> > >   #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> > > @@ -1632,6 +1633,50 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
> > >       }
> > >   }
> > > +static int vfio_bar_validate(VFIOPCIDevice *vdev, int nr)
> > > +{
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    VFIOBAR *bar = &vdev->bars[nr];
> > > +    uint64_t addr;
> > > +    uint32_t addr_lo, addr_hi = 0;
> > > +
> > > +    /* Skip unimplemented BARs and the upper half of 64bit BARS. */
> > > +    if (!bar->size) {
> > > +        return 0;
> > > +    }
> > > +
> > > +    addr_lo = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * 4, 4);
> > > +
> > > +    addr_lo &= (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
> > > +                              PCI_BASE_ADDRESS_MEM_MASK);
> > > +    if (bar->type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > > +        addr_hi = pci_default_read_config(pdev,
> > > +                                         PCI_BASE_ADDRESS_0 + (nr + 1) * 4, 4);
> > > +    }
> > > +
> > > +    addr = ((uint64_t)addr_hi << 32) | addr_lo;
> > > +
> > > +    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int vfio_bars_validate(VFIOPCIDevice *vdev)
> > > +{
> > > +    int i, ret;
> > > +
> > > +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > +        ret = vfio_bar_validate(vdev, i);
> > > +        if (ret) {
> > > +            error_report("vfio: BAR address %d validation failed", i);
> > > +            return ret;
> > > +        }
> > > +    }
> > > +    return 0;
> > > +}
> > > +
> > >   static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
> > >   {
> > >       VFIOBAR *bar = &vdev->bars[nr];
> > > @@ -2414,11 +2459,129 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
> > >       return OBJECT(vdev);
> > >   }
> > > +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> > > +{
> > > +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    uint16_t pci_cmd;
> > > +    int i;
> > > +
> > > +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > +        uint32_t bar;
> > > +
> > > +        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
> > > +        qemu_put_be32(f, bar);
> > > +    }
> > > +
> > > +    qemu_put_be32(f, vdev->interrupt);
> > > +    if (vdev->interrupt == VFIO_INT_MSI) {
> > > +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> > > +        bool msi_64bit;
> > > +
> > > +        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > > +                                            2);
> > > +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> > > +
> > > +        msi_addr_lo = pci_default_read_config(pdev,
> > > +                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> > > +        qemu_put_be32(f, msi_addr_lo);
> > > +
> > > +        if (msi_64bit) {
> > > +            msi_addr_hi = pci_default_read_config(pdev,
> > > +                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> > > +                                             4);
> > > +        }
> > > +        qemu_put_be32(f, msi_addr_hi);
> > > +
> > > +        msi_data = pci_default_read_config(pdev,
> > > +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> > > +                2);
> > > +        qemu_put_be16(f, msi_data);
> > > +    } else if (vdev->interrupt == VFIO_INT_MSIX) {
> > > +        uint16_t offset;
> > > +
> > > +        /* save enable bit and maskall bit */
> > > +        offset = pci_default_read_config(pdev,
> > > +                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
> > > +        qemu_put_be16(f, offset);
> > > +        msix_save(pdev, f);
> > > +    }
> > > +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > > +    qemu_put_be16(f, pci_cmd);
> > > +}
> > > +
> > > +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> > > +{
> > > +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
> > > +    PCIDevice *pdev = &vdev->pdev;
> > > +    uint32_t interrupt_type;
> > > +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
> > > +    uint16_t pci_cmd;
> > > +    bool msi_64bit;
> > > +    int i, ret;
> > > +
> > > +    /* retore pci bar configuration */
> > > +    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
> > > +    vfio_pci_write_config(pdev, PCI_COMMAND,
> > > +                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> > > +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> > > +        uint32_t bar = qemu_get_be32(f);
> > > +
> > > +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> > > +    }
> > > +
> > > +    ret = vfio_bars_validate(vdev);
> > > +    if (ret) {
> > > +        return ret;
> > > +    }
> > > +
> > > +    interrupt_type = qemu_get_be32(f);
> > > +
> > > +    if (interrupt_type == VFIO_INT_MSI) {
> > > +        /* restore msi configuration */
> > > +        msi_flags = pci_default_read_config(pdev,
> > > +                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
> > > +        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
> > > +
> > > +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > > +                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
> > > +
> > > +        msi_addr_lo = qemu_get_be32(f);
> > > +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> > > +                              msi_addr_lo, 4);
> > > +
> > > +        msi_addr_hi = qemu_get_be32(f);
> > > +        if (msi_64bit) {
> > > +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
> > > +                                  msi_addr_hi, 4);
> > > +        }
> > > +        msi_data = qemu_get_be16(f);
> > > +        vfio_pci_write_config(pdev,
> > > +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> > > +                msi_data, 2);
> > > +
> > > +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> > > +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
> > > +    } else if (interrupt_type == VFIO_INT_MSIX) {
> > > +        uint16_t offset = qemu_get_be16(f);
> > > +
> > > +        /* load enable bit and maskall bit */
> > > +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> > > +                              offset, 2);
> > > +        msix_load(pdev, f);
> > > +    }
> > > +    pci_cmd = qemu_get_be16(f);
> > > +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> > > +    return 0;
> > > +}
> > > +
> > >   static VFIODeviceOps vfio_pci_ops = {
> > >       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
> > >       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
> > >       .vfio_eoi = vfio_intx_eoi,
> > >       .vfio_get_object = vfio_pci_get_object,
> > > +    .vfio_save_config = vfio_pci_save_config,
> > > +    .vfio_load_config = vfio_pci_load_config,
> > >   };
> > >   int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> > > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > > index 74261feaeac9..d69a7f3ae31e 100644
> > > --- a/include/hw/vfio/vfio-common.h
> > > +++ b/include/hw/vfio/vfio-common.h
> > > @@ -120,6 +120,8 @@ struct VFIODeviceOps {
> > >       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
> > >       void (*vfio_eoi)(VFIODevice *vdev);
> > >       Object *(*vfio_get_object)(VFIODevice *vdev);
> > > +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> > > +    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
> > >   };
> > >   typedef struct VFIOGroup {
> > > -- 
> > > 2.7.0
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


