Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD98C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CF9206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0r54HKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CF9206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7Jy-0007DS-3b
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7HT-0004bn-Iu
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7HS-00025h-43
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7HR-000252-Vq
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7PZ1ieRftmMbGYh3EnSEuv5kWXkj8e6Hz54JuVQi5A=;
 b=J0r54HKpO/pwae1QJd70LMJXdZ+AMoZ2B9DsI+GpZGqw35Y7EbMCjc9NmVkCFm0c2WD34z
 J6xrRyUmYXCIk0y/IOZPJ/KVGa1hDLfslPXs+gA5nDa8AhCtaFNPyMESqF/D2BCBNn4PP/
 iXQpXtRIeEijdOKiARkx3RntrspLMgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-y38Z9JIaNtKanEux4iSL8g-1; Thu, 14 Nov 2019 00:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C29CB107ACC5;
 Thu, 14 Nov 2019 05:02:49 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 716F78176A;
 Thu, 14 Nov 2019 05:02:48 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:02:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 10/15] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20191113220248.37bebca7@x1.home>
In-Reply-To: <1573578324-8389-11-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-11-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: y38Z9JIaNtKanEux4iSL8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Tue, 12 Nov 2019 22:35:19 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Define flags to be used as delimeter in migration file stream.
> Added .save_setup and .save_cleanup functions. Mapped & unmapped migratio=
n
> region from these functions at source during saving or pre-copy phase.
> Set VFIO device state depending on VM's state. During live migration, VM =
is
> running when .save_setup is called, _SAVING | _RUNNING state is set for V=
FIO
> device. During save-restore, VM is paused, _SAVING state is set for VFIO =
device.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events |  2 ++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 7e7aeb58647e..48aac6d29876 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -8,6 +8,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include <linux/vfio.h>
> =20
>  #include "sysemu/runstate.h"
> @@ -24,6 +25,17 @@
>  #include "pci.h"
>  #include "trace.h"
> =20
> +/*
> + * Flags used as delimiter:
> + * 0xffffffff =3D> MSB 32-bit all 1s
> + * 0xef10     =3D> emulated (virtual) function IO
> + * 0x0000     =3D> 16-bits reserved for flags
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +
>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration =3D vbasedev->migration;
> @@ -108,6 +120,63 @@ static int vfio_migration_set_state(VFIODevice *vbas=
edev, uint32_t set_flags,
>      return 0;
>  }
> =20
> +/* ---------------------------------------------------------------------=
- */
> +
> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> +
> +    if (migration->region.mmaps) {
> +        qemu_mutex_lock_iothread();
> +        ret =3D vfio_region_mmap(&migration->region);
> +        qemu_mutex_unlock_iothread();

Please add comment indicating why the iothread mutex handling is
necessary.

> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %=
s",
> +                         vbasedev->name, migration->region.index,
> +                         strerror(-ret));
> +            return ret;

mmaps are optional for the user, right?  This seems like a continue'able er=
ror.

> +        }
> +    }
> +
> +    ret =3D vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_SAVING,=
 0);
> +    if (ret) {
> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> +        return ret;
> +    }
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

Why have we bothered to write anything into the migration stream yet?

> +
> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_setup(vbasedev->name);
> +    return 0;
> +}
> +
> +static void vfio_save_cleanup(void *opaque)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +    VFIOMigration *migration =3D vbasedev->migration;
> +
> +    if (migration->region.mmaps) {
> +        vfio_region_unmap(&migration->region);
> +    }
> +    trace_vfio_save_cleanup(vbasedev->name);

We don't need to touch device_state here?

> +}
> +
> +static SaveVMHandlers savevm_vfio_handlers =3D {
> +    .save_setup =3D vfio_save_setup,
> +    .save_cleanup =3D vfio_save_cleanup,
> +};
> +
> +/* ---------------------------------------------------------------------=
- */
> +
>  static void vfio_vmstate_change(void *opaque, int running, RunState stat=
e)
>  {
>      VFIODevice *vbasedev =3D opaque;
> @@ -171,6 +240,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
> =20
> +    register_savevm_live("vfio", -1, 1, &savevm_vfio_handlers, vbasedev)=
;
>      vbasedev->vm_state =3D qemu_add_vm_change_state_handler(vfio_vmstate=
_change,
>                                                            vbasedev);
> =20
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 69503228f20e..4bb43f18f315 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,3 +149,5 @@ vfio_migration_probe(char *name, uint32_t index) " (%=
s) Region %d"
>  vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(char *name, int running, const char *reason, uint32_=
t dev_state) " (%s) running %d reason %s device state %d"
>  vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
> +vfio_save_setup(char *name) " (%s)"
> +vfio_save_cleanup(char *name) " (%s)"


