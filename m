Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1759C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E49520719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQ5frEW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E49520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWTq-0002Nw-He
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHWT6-0001wJ-3b
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHWT1-0001Sj-HM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:38:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHWT1-0001SV-Cf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585244335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib8ARNXcZuOkbHbXoUzNdH8ECgEp0CvvEhc9xmSdnoo=;
 b=BQ5frEW1p/DNufrzoOPnongDVl5Ou6n3weF/8OhFbGvyXZkcb4njrRDfIh9HfEg8FQyoZ6
 uTWGTItDqfXFq5gYwpO9t56XUwpdwnA6prh7sMMSchFHLuiKjiCGrfacdeXugTuHqKZ3oi
 id/7ssJeWiSdOHITJ/OuSe+7HjzCmG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-MXdthiSpOtWmYX2hYfsnvg-1; Thu, 26 Mar 2020 13:38:53 -0400
X-MC-Unique: MXdthiSpOtWmYX2hYfsnvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0722A1005510;
 Thu, 26 Mar 2020 17:38:51 +0000 (UTC)
Received: from x1.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BDB619C70;
 Thu, 26 Mar 2020 17:38:49 +0000 (UTC)
Date: Thu, 26 Mar 2020 11:38:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v16 QEMU 04/16] vfio: Add save and load functions for
 VFIO PCI devices
Message-ID: <20200326113848.39b6e2f4@x1.home>
In-Reply-To: <20200326172926.GF2713@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-5-git-send-email-kwankhede@nvidia.com>
 <20200325135638.32421bf9@w520.home> <20200326172926.GF2713@work-vm>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Mar 2020 17:29:26 +0000
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Wed, 25 Mar 2020 02:39:02 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> > > These functions save and restore PCI device specific data - config
> > > space of PCI device.
> > > Tested save and restore with MSI and MSIX type.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > ---
> > >  hw/vfio/pci.c                 | 163 ++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/vfio/vfio-common.h |   2 +
> > >  2 files changed, 165 insertions(+)
> > > 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index 6c77c12e44b9..8deb11e87ef7 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -41,6 +41,7 @@
> > >  #include "trace.h"
> > >  #include "qapi/error.h"
> > >  #include "migration/blocker.h"
> > > +#include "migration/qemu-file.h"
> > >  
> > >  #define TYPE_VFIO_PCI "vfio-pci"
> > >  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> > > @@ -1632,6 +1633,50 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
> > >      }
> > >  }
> > >  
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
> > > +    addr_lo = addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
> > > +                                       PCI_BASE_ADDRESS_MEM_MASK);  
> > 
> > Nit, &= or combine with previous set.
> >   
> > > +    if (bar->type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > > +        addr_hi = pci_default_read_config(pdev,
> > > +                                         PCI_BASE_ADDRESS_0 + (nr + 1) * 4, 4);
> > > +    }
> > > +
> > > +    addr = ((uint64_t)addr_hi << 32) | addr_lo;  
> > 
> > Could we use a union?
> >   
> > > +
> > > +    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
> > > +        return -EINVAL;
> > > +    }  
> > 
> > What specifically are we validating here?  This should be true no
> > matter what we wrote to the BAR or else BAR emulation is broken.  The
> > bits that could make this unaligned are not implemented in the BAR.  
> 
> That I think is based on a comment I asked a few versions back.
> Remember the value being checked here is a value loaded from the
> migration stream; it could be garbage, so it's good to do whatever
> checks you can.

It's not the migration stream though, we're reading it from config
space emulation.  The migration stream could have written absolutely
anything to the device BAR and this test should still be ok.  PCI BARs
are naturally aligned by definition.  The address bits that could make
the value unaligned are not implemented.  This is why we can determine
the size of the BAR by writing -1 to it.  Thanks,

Alex

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
> > >  static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
> > >  {
> > >      VFIOBAR *bar = &vdev->bars[nr];
> > > @@ -2414,11 +2459,129 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
> > >      return OBJECT(vdev);
> > >  }
> > >  
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
> > > +        qemu_put_be32(f, msi_data);  
> > 
> > Isn't the data field only a u16?
> >   
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
> > > +        msi_data = qemu_get_be32(f);
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
> > 
> > It always seems like there should be a lot more state than this, and I
> > probably sound like a broken record because I ask every time, but maybe
> > that's a good indication that we (or at least I) need a comment
> > explaining why we only care about these.  For example, what if we
> > migrate a device in the D3 power state, don't we need to account for
> > the state stored in the PM capability or does the device wake up into
> > D0 auto-magically after migration?  I think we could repeat that
> > question for every capability that can be modified.  Even for the MSI/X
> > cases, the interrupt may not be active, but there could be state in
> > virtual config space that would be different on the target.  For
> > example, if we migrate with a device in INTx mode where the guest had
> > written vector fields on the source, but only writes the enable bit on
> > the target, can we seamlessly figure out the rest?  For other
> > capabilities, that state may represent config space changes written
> > through to the physical device and represent a functional difference on
> > the target.  Thanks,
> > 
> > Alex
> >   
> > > +
> > >  static VFIODeviceOps vfio_pci_ops = {
> > >      .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
> > >      .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
> > >      .vfio_eoi = vfio_intx_eoi,
> > >      .vfio_get_object = vfio_pci_get_object,
> > > +    .vfio_save_config = vfio_pci_save_config,
> > > +    .vfio_load_config = vfio_pci_load_config,
> > >  };
> > >  
> > >  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> > > diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> > > index 74261feaeac9..d69a7f3ae31e 100644
> > > --- a/include/hw/vfio/vfio-common.h
> > > +++ b/include/hw/vfio/vfio-common.h
> > > @@ -120,6 +120,8 @@ struct VFIODeviceOps {
> > >      int (*vfio_hot_reset_multi)(VFIODevice *vdev);
> > >      void (*vfio_eoi)(VFIODevice *vdev);
> > >      Object *(*vfio_get_object)(VFIODevice *vdev);
> > > +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
> > > +    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
> > >  };
> > >  
> > >  typedef struct VFIOGroup {  
> >   
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


