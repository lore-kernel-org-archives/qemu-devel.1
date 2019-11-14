Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1347FC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:02:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7862206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuZdjp4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7862206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7Ga-0003fK-BJ
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7FZ-0003Cz-J1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7FW-000850-1F
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:00:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7FS-00080q-8R
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZ68dVGmbQQMvTTPC8UlY+yMxDVDtSdIMtLPYs8modI=;
 b=BuZdjp4ThTelQfWi9KHGGGHIp8D60B3X85wyqMGzx0BC7M6piy5R2wDj9StyCBxD2aBk9C
 HcNeH/Z2O9GJxcorGgOJ4K5vKQcwTOUwcSaOIL3VlwboatCz4vpTas+52enG0vbXvZK95Z
 Nu3Wx/mFCeWAA8/vQYE+gLAXoD3sx9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-_9fvquCSOHm4rkzDSjSL7w-1; Thu, 14 Nov 2019 00:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F4DE1802CE4;
 Thu, 14 Nov 2019 05:00:39 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 606F051C3E;
 Thu, 14 Nov 2019 05:00:36 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:00:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 06/15] vfio: Add save and load functions for
 VFIO PCI devices
Message-ID: <20191113220035.7a2ede74@x1.home>
In-Reply-To: <1573578324-8389-7-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-7-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _9fvquCSOHm4rkzDSjSL7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 22:35:15 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> These functions save and restore PCI device specific data - config
> space of PCI device.
> Tested save and restore with MSI and MSIX type.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c                 | 168 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/vfio/vfio-common.h |   2 +
>  2 files changed, 170 insertions(+)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4ae02e71622a..2c22cca0c3be 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -41,6 +41,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "migration/qemu-file.h"
> =20
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -1620,6 +1621,55 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
>      }
>  }
> =20
> +static int vfio_bar_validate(VFIOPCIDevice *vdev, int nr)
> +{
> +    PCIDevice *pdev =3D &vdev->pdev;
> +    VFIOBAR *bar =3D &vdev->bars[nr];
> +    uint64_t addr;
> +    uint32_t addr_lo, addr_hi =3D 0;
> +
> +    /* Skip unimplemented BARs and the upper half of 64bit BARS. */
> +    if (!bar->size) {
> +        return 0;
> +    }
> +
> +    /* skip IO BAR */
> +    if (bar->ioport) {
> +        return 0;
> +    }

Why?

> +
> +    addr_lo =3D pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * =
4, 4);
> +
> +    addr_lo =3D addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
> +                                       PCI_BASE_ADDRESS_MEM_MASK);

And if we've skipped IO BARs above, why are we checking for them here?

> +    if (bar->type =3D=3D PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +        addr_hi =3D pci_default_read_config(pdev,
> +                                         PCI_BASE_ADDRESS_0 + (nr + 1) *=
 4, 4);
> +    }
> +
> +    addr =3D ((uint64_t)addr_hi << 32) | addr_lo;
> +
> +    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
> +        return -EINVAL;
> +    }

Why is this function even necessary?

> +
> +    return 0;
> +}
> +
> +static int vfio_bars_validate(VFIOPCIDevice *vdev)
> +{
> +    int i, ret;
> +
> +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> +        ret =3D vfio_bar_validate(vdev, i);
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
>      VFIOBAR *bar =3D &vdev->bars[nr];
> @@ -2402,11 +2452,129 @@ static Object *vfio_pci_get_object(VFIODevice *v=
basedev)
>      return OBJECT(vdev);
>  }
> =20
> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vbased=
ev);
> +    PCIDevice *pdev =3D &vdev->pdev;
> +    uint16_t pci_cmd;
> +    int i;
> +

Is the basis for what we're selecting to save and restore based
primarily on vfio_pci_write_config()?  I'm nervous about what we're
choosing to save/load and why it isn't more extensive.

> +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar;
> +
> +        bar =3D pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4=
, 4);
> +        qemu_put_be32(f, bar);
> +    }
> +
> +    qemu_put_be32(f, vdev->interrupt);
> +    if (vdev->interrupt =3D=3D VFIO_INT_MSI) {
> +        uint32_t msi_flags, msi_addr_lo, msi_addr_hi =3D 0, msi_data;
> +        bool msi_64bit;
> +
> +        msi_flags =3D pci_default_read_config(pdev, pdev->msi_cap + PCI_=
MSI_FLAGS,
> +                                            2);
> +        msi_64bit =3D (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        msi_addr_lo =3D pci_default_read_config(pdev,
> +                                         pdev->msi_cap + PCI_MSI_ADDRESS=
_LO, 4);
> +        qemu_put_be32(f, msi_addr_lo);
> +
> +        if (msi_64bit) {
> +            msi_addr_hi =3D pci_default_read_config(pdev,
> +                                             pdev->msi_cap + PCI_MSI_ADD=
RESS_HI,
> +                                             4);
> +        }
> +        qemu_put_be32(f, msi_addr_hi);
> +
> +        msi_data =3D pci_default_read_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_D=
ATA_32),
> +                2);
> +        qemu_put_be32(f, msi_data);
> +    } else if (vdev->interrupt =3D=3D VFIO_INT_MSIX) {
> +        uint16_t offset;
> +
> +        /* save enable bit and maskall bit */
> +        offset =3D pci_default_read_config(pdev,
> +                                       pdev->msix_cap + PCI_MSIX_FLAGS +=
 1, 2);
> +        qemu_put_be16(f, offset);
> +        msix_save(pdev, f);
> +    }
> +    pci_cmd =3D pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    qemu_put_be16(f, pci_cmd);
> +}
> +
> +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice, vbased=
ev);
> +    PCIDevice *pdev =3D &vdev->pdev;
> +    uint32_t interrupt_type;
> +    uint32_t msi_flags, msi_addr_lo, msi_addr_hi =3D 0, msi_data;
> +    uint16_t pci_cmd;
> +    bool msi_64bit;
> +    int i, ret;
> +
> +    /* retore pci bar configuration */
> +    pci_cmd =3D pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY=
)), 2);
> +    for (i =3D 0; i < PCI_ROM_SLOT; i++) {
> +        uint32_t bar =3D qemu_get_be32(f);
> +
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
> +    }
> +
> +    ret =3D vfio_bars_validate(vdev);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    interrupt_type =3D qemu_get_be32(f);
> +
> +    if (interrupt_type =3D=3D VFIO_INT_MSI) {
> +        /* restore msi configuration */
> +        msi_flags =3D pci_default_read_config(pdev,
> +                                            pdev->msi_cap + PCI_MSI_FLAG=
S, 2);
> +        msi_64bit =3D (msi_flags & PCI_MSI_FLAGS_64BIT);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
> +
> +        msi_addr_lo =3D qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
> +                              msi_addr_lo, 4);
> +
> +        msi_addr_hi =3D qemu_get_be32(f);
> +        if (msi_64bit) {
> +            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_=
HI,
> +                                  msi_addr_hi, 4);
> +        }
> +        msi_data =3D qemu_get_be32(f);
> +        vfio_pci_write_config(pdev,
> +                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_D=
ATA_32),
> +                msi_data, 2);
> +
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
> +    } else if (interrupt_type =3D=3D VFIO_INT_MSIX) {
> +        uint16_t offset =3D qemu_get_be16(f);
> +
> +        /* load enable bit and maskall bit */
> +        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
> +                              offset, 2);
> +        msix_load(pdev, f);
> +    }
> +    pci_cmd =3D qemu_get_be16(f);
> +    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
> +    return 0;
> +}
> +
>  static VFIODeviceOps vfio_pci_ops =3D {
>      .vfio_compute_needs_reset =3D vfio_pci_compute_needs_reset,
>      .vfio_hot_reset_multi =3D vfio_pci_hot_reset_multi,
>      .vfio_eoi =3D vfio_intx_eoi,
>      .vfio_get_object =3D vfio_pci_get_object,
> +    .vfio_save_config =3D vfio_pci_save_config,
> +    .vfio_load_config =3D vfio_pci_load_config,
>  };
> =20
>  int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
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
> =20
>  typedef struct VFIOGroup {


