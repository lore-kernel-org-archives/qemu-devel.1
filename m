Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3253ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15552084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/Y2aOs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15552084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZUx-0001to-8j
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iMZT6-0000Nl-7C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iMZT4-0004LR-T3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iMZT4-0004LL-PU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571671173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fswZIzCqGLQWPwFHQbdsSE4XbUo+SGhfJVvuhPzqMFE=;
 b=f/Y2aOs1lW5hQEJFRB+4Mv8ZjWoPpZxI8cStxLqKijtGR/71qV8u+sDBaGoJ18gHPU6PyS
 pL9EXUFns8/AtDmIVfLDTa0ipNld+zPTrvIjRgkRpECzFJv66Hb8vxhjBODkyCIviXNhQB
 SbLhJohb8CKbWfPJVGtCHIx8zcmbPPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-n6h5IikvOVqaPjAqOcgwkA-1; Mon, 21 Oct 2019 11:19:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6496347B;
 Mon, 21 Oct 2019 15:19:29 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A1295C28C;
 Mon, 21 Oct 2019 15:19:21 +0000 (UTC)
Date: Mon, 21 Oct 2019 09:19:20 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>, parav@mellanox.com
Subject: Re: [PATCH 11/11] vfio: unplug failover primary device before
 migration
Message-ID: <20191021091920.308e7454@x1.home>
In-Reply-To: <20191018202040.30349-12-jfreimann@redhat.com>
References: <20191018202040.30349-1-jfreimann@redhat.com>
 <20191018202040.30349-12-jfreimann@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: n6h5IikvOVqaPjAqOcgwkA-1
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 22:20:40 +0200
Jens Freimann <jfreimann@redhat.com> wrote:

> As usual block all vfio-pci devices from being migrated, but make an
> exception for failover primary devices. This is achieved by setting
> unmigratable to 0 but also add a migration blocker for all vfio-pci
> devices except failover primary devices. These will be unplugged before
> migration happens by the migration handler of the corresponding
> virtio-net standby device.
>=20
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> ---
>  hw/vfio/pci.c | 31 +++++++++++++++++++++++++------
>  hw/vfio/pci.h |  1 +
>  2 files changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 12fac39804..a15b83c6b6 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -40,6 +40,9 @@
>  #include "pci.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> +#include "migration/blocker.h"
> +#include "qemu/option.h"
> +#include "qemu/option_int.h"
> =20
>  #define TYPE_VFIO_PCI "vfio-pci"
>  #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> @@ -2712,12 +2715,26 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
>      int i, ret;
>      bool is_mdev;
> =20
> +    if (!pdev->net_failover_pair_id) {
> +        error_setg(&vdev->migration_blocker,
> +                "VFIO device doesn't support migration");
> +        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            goto error;
> +        }
> +    } else {
> +            pdev->qdev.allow_unplug_during_migration =3D true;

Why is this unique to vfio-pci, shouldn't any device set as the primary
for a failover allow unplug during migration, and therefore should it
be done in the core code rather than device driver?  With the
net_failover_pair_id set in PCIDevice, I should be able to test with an
e1000e NIC as primary, but this suggests they wouldn't be handled
identically elsewhere.  Thanks,

Alex

> +    }
> +
>      if (!vdev->vbasedev.sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
>                ~vdev->host.slot || ~vdev->host.function)) {
>              error_setg(errp, "No provided host device");
>              error_append_hint(errp, "Use -device vfio-pci,host=3DDDDD:BB=
:DD.F "
>                                "or -device vfio-pci,sysfsdev=3DPATH_TO_DE=
VICE\n");
> +            migrate_del_blocker(vdev->migration_blocker);
> +            error_free(vdev->migration_blocker);
>              return;
>          }
>          vdev->vbasedev.sysfsdev =3D
> @@ -2729,6 +2746,8 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>      if (stat(vdev->vbasedev.sysfsdev, &st) < 0) {
>          error_setg_errno(errp, errno, "no such host device");
>          error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.sysfsdev);
> +        migrate_del_blocker(vdev->migration_blocker);
> +        error_free(vdev->migration_blocker);
>          return;
>      }
> =20
> @@ -3008,6 +3027,8 @@ out_teardown:
>      vfio_bars_exit(vdev);
>  error:
>      error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +    migrate_del_blocker(vdev->migration_blocker);
> +    error_free(vdev->migration_blocker);
>  }
> =20
>  static void vfio_instance_finalize(Object *obj)
> @@ -3019,6 +3040,10 @@ static void vfio_instance_finalize(Object *obj)
>      vfio_bars_finalize(vdev);
>      g_free(vdev->emulated_config_bits);
>      g_free(vdev->rom);
> +    if (vdev->migration_blocker) {
> +        migrate_del_blocker(vdev->migration_blocker);
> +        error_free(vdev->migration_blocker);
> +    }
>      /*
>       * XXX Leaking igd_opregion is not an oversight, we can't remove the
>       * fw_cfg entry therefore leaking this allocation seems like the saf=
est
> @@ -3151,11 +3176,6 @@ static Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> -static const VMStateDescription vfio_pci_vmstate =3D {
> -    .name =3D "vfio-pci",
> -    .unmigratable =3D 1,
> -};
> -
>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -3163,7 +3183,6 @@ static void vfio_pci_dev_class_init(ObjectClass *kl=
ass, void *data)
> =20
>      dc->reset =3D vfio_pci_reset;
>      dc->props =3D vfio_pci_dev_properties;
> -    dc->vmsd =3D &vfio_pci_vmstate;
>      dc->desc =3D "VFIO-based PCI device assignment";
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>      pdc->realize =3D vfio_realize;
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 834a90d646..b329d50338 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -168,6 +168,7 @@ typedef struct VFIOPCIDevice {
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
>      VFIODisplay *dpy;
> +    Error *migration_blocker;
>  } VFIOPCIDevice;
> =20
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);


