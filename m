Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89489C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB06206E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 05:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rm7hWeqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB06206E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV7Id-0005pm-96
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 00:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Gy-00049i-Ue
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iV7Gx-0001Q2-D0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iV7Gx-0001P3-87
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 00:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573707742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95S0bIwGEsgTcolcbAK/v8YKx2YYY7Q1cSAy22TFs0w=;
 b=Rm7hWeqkTfqtFE/K87Zyt9jd4WD99c6JkwdICS6g7wHB78rJO94LsbbrA/juKe95Mx0r1s
 6A01yGrpQsJCoN+R1gErfwadaRFlQ7SZmBKFEtac4tA2jDhcu9GIrnQapT+FOLBlzkebO2
 P/NE5WL3WLer01s/UY7vBDSYIcXJouk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-x2YfphtnNfiqdhju3kT8hw-1; Thu, 14 Nov 2019 00:02:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 141A81005502;
 Thu, 14 Nov 2019 05:02:16 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28CA6972C;
 Thu, 14 Nov 2019 05:02:14 +0000 (UTC)
Date: Wed, 13 Nov 2019 22:02:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 QEMU 08/15] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20191113220214.4fb34e07@x1.home>
In-Reply-To: <1573578324-8389-9-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
 <1573578324-8389-9-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: x2YfphtnNfiqdhju3kT8hw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Tue, 12 Nov 2019 22:35:17 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> VM state change handler gets called on change in VM's state. This is used=
 to set
> VFIO device state to _RUNNING.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 69 +++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events          |  2 ++
>  include/hw/vfio/vfio-common.h |  4 +++
>  3 files changed, 75 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index c17bd1b0b934..28981a759e6c 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include <linux/vfio.h>
> =20
> +#include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "cpu.h"
>  #include "migration/migration.h"
> @@ -74,6 +75,67 @@ err:
>      return ret;
>  }
> =20
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t set_f=
lags,
> +                                    uint32_t clear_flags)
> +{

Perhaps a mask and value interface like we have elsewhere?

> +    VFIOMigration *migration =3D vbasedev->migration;
> +    VFIORegion *region =3D &migration->region;
> +    uint32_t device_state;
> +    int ret =3D 0;
> +
> +    /* same flags should not be set or clear */
> +    assert(!(set_flags & clear_flags));

mask/value avoids this sort of thing.

> +    device_state =3D (vbasedev->device_state | set_flags) & ~clear_flags=
;

Don't we need to re-read device_state from the region?  We can't
predict what those reserved bits will be used for, they could be
volatile.  If we adopt that a reset returns to running, our cached
state may be stale.

> +
> +    switch (device_state & VFIO_DEVICE_STATE_MASK) {
> +    case VFIO_DEVICE_STATE_INVALID_CASE1:
> +    case VFIO_DEVICE_STATE_INVALID_CASE2:
> +        return -EINVAL;
> +    }

I like the VALID macro better.

> +
> +    ret =3D pwrite(vbasedev->fd, &device_state, sizeof(device_state),
> +                 region->fd_offset + offsetof(struct vfio_device_migrati=
on_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("%s: Failed to set device state %d %s",
> +                     vbasedev->name, ret, strerror(errno));
> +        return ret;
> +    }
> +
> +    vbasedev->device_state =3D device_state;

Are we opposed to re-reading device_state, here and in the error case
above?

> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> +    return 0;
> +}
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState stat=
e)
> +{
> +    VFIODevice *vbasedev =3D opaque;
> +
> +    if ((vbasedev->vm_running !=3D running)) {
> +        int ret;
> +        uint32_t set_flags =3D 0, clear_flags =3D 0;
> +
> +        if (running) {
> +            set_flags =3D VFIO_DEVICE_STATE_RUNNING;
> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> +                clear_flags =3D VFIO_DEVICE_STATE_RESUMING;
> +            }
> +        } else {
> +            clear_flags =3D VFIO_DEVICE_STATE_RUNNING;
> +        }
> +
> +        ret =3D vfio_migration_set_state(vbasedev, set_flags, clear_flag=
s);
> +        if (ret) {
> +            error_report("%s: Failed to set device state 0x%x",
> +                         vbasedev->name, set_flags & ~clear_flags);
> +        }
> +        vbasedev->vm_running =3D running;

We're effectively storing running both in vbasedev->device_state and
vbasedev->vm_running, why?

Seems like this could trivially know the initial state of the device is
running.

> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(=
state),
> +                                  set_flags & ~clear_flags);
> +    }
> +}
> +
>  static int vfio_migration_init(VFIODevice *vbasedev,
>                                 struct vfio_region_info *info)
>  {
> @@ -89,6 +151,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
> =20
> +    vbasedev->vm_state =3D qemu_add_vm_change_state_handler(vfio_vmstate=
_change,
> +                                                          vbasedev);
> +
>      return 0;
>  }
> =20
> @@ -127,6 +192,10 @@ add_blocker:
> =20
>  void vfio_migration_finalize(VFIODevice *vbasedev)
>  {
> +    if (vbasedev->vm_state) {
> +        qemu_del_vm_change_state_handler(vbasedev->vm_state);
> +    }
> +
>      if (vbasedev->migration_blocker) {
>          migrate_del_blocker(vbasedev->migration_blocker);
>          error_free(vbasedev->migration_blocker);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 191a726a1312..3d15bacd031a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -146,3 +146,5 @@ vfio_display_edid_write_error(void) ""
> =20
>  # migration.c
>  vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
> +vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> +vfio_vmstate_change(char *name, int running, const char *reason, uint32_=
t dev_state) " (%s) running %d reason %s device state %d"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index 927511897a44..6573acd6738e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -29,6 +29,7 @@
>  #ifdef CONFIG_LINUX
>  #include <linux/vfio.h>
>  #endif
> +#include "sysemu/sysemu.h"
> =20
>  #define VFIO_MSG_PREFIX "vfio %s: "
> =20
> @@ -120,6 +121,9 @@ typedef struct VFIODevice {
>      unsigned int flags;
>      VFIOMigration *migration;
>      Error *migration_blocker;
> +    uint32_t device_state;
> +    VMChangeStateEntry *vm_state;
> +    int vm_running;

Isn't this effectively a bool per our usage.

Field ordering is wasteful.

>  } VFIODevice;
> =20
>  struct VFIODeviceOps {


