Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B3C2D0E5
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721112070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKuFgndt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721112070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHWbJ-0003xC-Jg
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 13:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHWaP-0003UI-UL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHWaN-0005a0-Jq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:46:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHWaN-0005Zk-Fc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 13:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585244790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zeDJe/iJ/ZYdTpJHJtRtcBdorarXxbKCnQDSiI0KXu8=;
 b=MKuFgndt76jm1KJltggxMf0gkokeid6RIrksoeQY47FDYHWkzRaYl0xEI/rHzth6keAhO+
 MvSlMYcpj2+Ej3YXle2HMA9LHmOitgh2Cm+wf8ySka2lTo/j0dzlm5svh4feKNjB0dMKp0
 czepMGpq870vG3C/9EkMKOge/GMSucQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-A6f2-v-sOaqSPRYU7P8qfw-1; Thu, 26 Mar 2020 13:46:28 -0400
X-MC-Unique: A6f2-v-sOaqSPRYU7P8qfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE326DB24;
 Thu, 26 Mar 2020 17:46:25 +0000 (UTC)
Received: from work-vm (ovpn-114-228.ams2.redhat.com [10.36.114.228])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE23E9128E;
 Thu, 26 Mar 2020 17:46:18 +0000 (UTC)
Date: Thu, 26 Mar 2020 17:46:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 04/16] vfio: Add save and load functions for
 VFIO PCI devices
Message-ID: <20200326174616.GG2713@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-5-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1585084154-29461-5-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> These functions save and restore PCI device specific data - config
> space of PCI device.
> Tested save and restore with MSI and MSIX type.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c                 | 163 ++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/vfio/vfio-common.h |   2 +
>  2 files changed, 165 insertions(+)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 6c77c12e44b9..8deb11e87ef7 100644
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
> @@ -1632,6 +1633,50 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
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
> +    addr_lo =3D pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * =
4, 4);
> +
> +    addr_lo =3D addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
> +                                       PCI_BASE_ADDRESS_MEM_MASK);
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
> @@ -2414,11 +2459,129 @@ static Object *vfio_pci_get_object(VFIODevice *v=
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

This isn't quite what I'd expected, since that validate is reading what
you read back; I'd have thought you'd validate the bar value before
writing it to the device.
(I'm also surprised you're only reading 32bit here?)

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

While I don't know PCI as well as Alex, I share the worry about what
happens when you decide to want to save more information about the
device; you've not got any place holders where you can add anything; and
since it's all hand-coded (rather than using vmstate) it's only going to
get hairier.

Dave

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
> --=20
> 2.7.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


