Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0ECDC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3D3206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FU0yh8nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3D3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7NC-00024F-J9
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7L7-0000T2-Mn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7L4-00072b-O4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7L4-00071K-A2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6W+rf8RoQ2EcnMzgPdSIi/pM2kNrjvyHY3+XKyeqIZw=;
 b=FU0yh8ndCSFEh4xnbq0EljocHJadTT38qUQ10Aa+JsbtkrJw0nCT9zz5gb3iNZ8SJrhkxw
 fxhcL160OWUsEH3oHusCyMwtXv+lmxc0VluYJ4iHg0eu9Xq8/qlgXWxSF+pk5vs1cEiYb/
 pNk8gj7qgU60ZyccTPD116z6ZfEy7G8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-kXXMTkR6NuSUe05C_mpt3g-1; Thu, 14 Nov 2019 00:06:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABE7B1802CE1;
 Thu, 14 Nov 2019 05:06:31 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57A385F787;
 Thu, 14 Nov 2019 05:06:30 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:06:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 15/15] vfio: Make vfio-pci device migration
 capable.
Message-ID: <20191113220629.2be2d0e1@x1.home>
In-Reply-To: <1573578324-8389-16-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-16-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kXXMTkR6NuSUe05C_mpt3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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

On Tue, 12 Nov 2019 22:35:24 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> If device is not failover primary device call vfio_migration_probe()
> and vfio_migration_finalize() functions for vfio-pci device to enable
> migration for vfio PCI device which support migration.
> Removed vfio_pci_vmstate structure.
> Removed migration blocker from VFIO PCI device specific structure and use
> migration blocker from generic structure of  VFIO device.
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/pci.c | 30 +++++++++++-------------------
>  hw/vfio/pci.h |  1 -
>  2 files changed, 11 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2c22cca0c3be..3d2ebc7abfdc 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2909,21 +2909,11 @@ static void vfio_realize(PCIDevice *pdev, Error *=
*errp)
>          return;
>      }
> =20
> -    if (!pdev->failover_pair_id) {
> -        error_setg(&vdev->migration_blocker,
> -                "VFIO device doesn't support migration");
> -        ret =3D migrate_add_blocker(vdev->migration_blocker, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            error_free(vdev->migration_blocker);
> -            return;
> -        }
> -    }
> -
>      vdev->vbasedev.name =3D g_path_get_basename(vdev->vbasedev.sysfsdev)=
;
>      vdev->vbasedev.ops =3D &vfio_pci_ops;
>      vdev->vbasedev.type =3D VFIO_DEVICE_TYPE_PCI;
>      vdev->vbasedev.dev =3D DEVICE(vdev);
> +    vdev->vbasedev.device_state =3D 0;

But it's not.

> =20
>      tmp =3D g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
>      len =3D readlink(tmp, group_path, sizeof(group_path));
> @@ -3184,6 +3174,14 @@ static void vfio_realize(PCIDevice *pdev, Error **=
errp)
>          }
>      }
> =20
> +    if (!pdev->failover_pair_id) {
> +        ret =3D vfio_migration_probe(&vdev->vbasedev, errp);

Hmm, I suppose this prevents us from breaking failover previously, but
does it make more sense to enable it earlier in the series, even before
it's feature complete so that we can iteratively debug?

> +        if (ret) {
> +                error_report("%s: Failed to setup for migration",
> +                             vdev->vbasedev.name);
> +        }
> +    }
> +
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> @@ -3196,10 +3194,6 @@ out_teardown:
>      vfio_bars_exit(vdev);
>  error:
>      error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> -    if (vdev->migration_blocker) {
> -        migrate_del_blocker(vdev->migration_blocker);
> -        error_free(vdev->migration_blocker);
> -    }
>  }
> =20
>  static void vfio_instance_finalize(Object *obj)
> @@ -3207,14 +3201,11 @@ static void vfio_instance_finalize(Object *obj)
>      VFIOPCIDevice *vdev =3D PCI_VFIO(obj);
>      VFIOGroup *group =3D vdev->vbasedev.group;
> =20
> +    vdev->vbasedev.device_state =3D 0;

Nor is this accurate or meaningful unless we do actually stop the
device.

>      vfio_display_finalize(vdev);
>      vfio_bars_finalize(vdev);
>      g_free(vdev->emulated_config_bits);
>      g_free(vdev->rom);
> -    if (vdev->migration_blocker) {
> -        migrate_del_blocker(vdev->migration_blocker);
> -        error_free(vdev->migration_blocker);
> -    }
>      /*
>       * XXX Leaking igd_opregion is not an oversight, we can't remove the
>       * fw_cfg entry therefore leaking this allocation seems like the saf=
est
> @@ -3239,6 +3230,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>      }
>      vfio_teardown_msi(vdev);
>      vfio_bars_exit(vdev);
> +    vfio_migration_finalize(&vdev->vbasedev);
>  }
> =20
>  static void vfio_pci_reset(DeviceState *dev)
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index b329d50338b5..834a90d64686 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -168,7 +168,6 @@ typedef struct VFIOPCIDevice {
>      bool no_vfio_ioeventfd;
>      bool enable_ramfb;
>      VFIODisplay *dpy;
> -    Error *migration_blocker;
>  } VFIOPCIDevice;
> =20
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);


