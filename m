Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B7AC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727292071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 17:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DETgfTQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727292071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJhJJ-0003re-Gg
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 13:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jJhIU-0003Dw-7J
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jJhIS-00046O-2u
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:37:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jJhIR-00045U-TX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 13:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585762617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mySTwchgWclqsFBpqS0xjdnzZM7ffCcI4YtJosaQ55Q=;
 b=DETgfTQ7a7u8vvo4tqX/mUACusHrodkErZ+IENcDF/TnSlInxODWI3B2KK1wS9v41PmqOP
 JvZF3sj40QTL85eFWRvMXfFXKB/LNWJFPVWaSHvwT0pO1hNcTsTBNDYY0hWZg+m06ueeNR
 2BCaeRBPOS+MEBfmSYiR6WgPXZAxpew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-KfYdxjWTNwOw-aq5lzCewQ-1; Wed, 01 Apr 2020 13:36:54 -0400
X-MC-Unique: KfYdxjWTNwOw-aq5lzCewQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C38149C2;
 Wed,  1 Apr 2020 17:36:50 +0000 (UTC)
Received: from work-vm (ovpn-115-201.ams2.redhat.com [10.36.115.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 313665C3F8;
 Wed,  1 Apr 2020 17:36:43 +0000 (UTC)
Date: Wed, 1 Apr 2020 18:36:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200401173640.GG52559@work-vm>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
>  hw/vfio/migration.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/vfio/trace-events |  2 ++
>  2 files changed, 78 insertions(+)
>=20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 22ded9d28cf3..033f76526e49 100644
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
> @@ -126,6 +138,69 @@ static int vfio_migration_set_state(VFIODevice *vbas=
edev, uint32_t mask,
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
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %=
s",
> +                         vbasedev->name, migration->region.index,
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    ret =3D vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAV=
ING);
> +    if (ret) {
> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> +        return ret;
> +    }
> +
> +    /*
> +     * Save migration region size. This is used to verify migration regi=
on size
> +     * is greater than or equal to migration region size at destination
> +     */
> +    qemu_put_be64(f, migration->region.size);
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);

OK, good, so now we can change that to something else if you want to
migrate something extra in the future.

> +    ret =3D qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    trace_vfio_save_setup(vbasedev->name);

I'd put that trace at the start of the function.

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
> @@ -191,6 +266,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
> =20
> +    register_savevm_live("vfio", -1, 1, &savevm_vfio_handlers, vbasedev)=
;

That doesn't look right to me;  firstly the -1 should now be
VMSTATE_INSTANCE_ID_ANY - after the recent change in commit 1df2c9a

Have you tried this with two vfio devices?
This is quite rare - it's an iterative device that can have
multiple instances;  if you look at 'ram' for example, all the RAM
instances are handled inside the save_setup/save for the one instance of
'ram'.  I think here you're trying to register an individual vfio
device, so if you had multiple devices you'd see this called twice.

So either you need to make vfio_save_* do all of the devices in a loop -
which feels like a bad idea;  or replace "vfio" in that call by a unique
device name;  as long as your device has a bus path then you should be
able to use the same trick vmstate_register_with_alias_id does, and use
I think,  vmstate_if_get_id(VMSTAETE_IF(vbasedev)).

but it might take some experimentation since this is an odd use.

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
> --=20
> 2.7.0
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


