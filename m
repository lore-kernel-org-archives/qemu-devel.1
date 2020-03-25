Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CEEC2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4005A20737
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmCg5kUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4005A20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHDEP-0002s8-FW
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 17:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1jHDAz-000716-Jo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1jHDAx-0001fs-MC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:03:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1jHDAx-0001fN-Fi
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 17:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585170178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MNoLllsJ1Qi7H58h7uCANDJscHJdoXMmlXwPlE5gIaQ=;
 b=WmCg5kUNXJEvSCFOvum0BuCDZ1WwXRjUHYeYT1x2uizm6hpY9hVfFssxAZkhVHGZu2y25u
 zHQ8SZsWuvcknUpnJ3KRFzWHfoqK9GZjvNrCGgkj3hPT2bpNE1EwYwu9mpt0DqYwuusJXD
 I1+p9MM60zbpFpU1nibLbEI9GuTBK0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-oOGirRakP2SuRhIBCHMPrQ-1; Wed, 25 Mar 2020 17:02:54 -0400
X-MC-Unique: oOGirRakP2SuRhIBCHMPrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878DA8017CC;
 Wed, 25 Mar 2020 21:02:51 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1742ABBBDD;
 Wed, 25 Mar 2020 21:02:49 +0000 (UTC)
Date: Wed, 25 Mar 2020 15:02:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200325150248.6661e1bd@w520.home>
In-Reply-To: <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

On Wed, 25 Mar 2020 02:39:06 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Define flags to be used as delimeter in migration file stream.
> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> region from these functions at source during saving or pre-copy phase.
> Set VFIO device state depending on VM's state. During live migration, VM is
> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |  2 ++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 22ded9d28cf3..033f76526e49 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include <linux/vfio.h>
>  
>  #include "sysemu/runstate.h"
> @@ -24,6 +25,17 @@
>  #include "pci.h"
>  #include "trace.h"
>  
> +/*
> + * Flags used as delimiter:
> + * 0xffffffff => MSB 32-bit all 1s
> + * 0xef10     => emulated (virtual) function IO
> + * 0x0000     => 16-bits reserved for flags
> + */
> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> +
>  static void vfio_migration_region_exit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;
> @@ -126,6 +138,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>      return 0;
>  }
>  
> +/* ---------------------------------------------------------------------- */
> +
> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> +{
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    int ret;
> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> +
> +    if (migration->region.mmaps) {
> +        qemu_mutex_lock_iothread();
> +        ret = vfio_region_mmap(&migration->region);
> +        qemu_mutex_unlock_iothread();
> +        if (ret) {
> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> +                         vbasedev->name, migration->region.index,
> +                         strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAVING);
> +    if (ret) {
> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> +        return ret;
> +    }
> +
> +    /*
> +     * Save migration region size. This is used to verify migration region size
> +     * is greater than or equal to migration region size at destination
> +     */
> +    qemu_put_be64(f, migration->region.size);

Is this requirement supported by the uapi?  The vendor driver operates
within the migration region, but it has no requirement to use the full
extent of the region.  Shouldn't we instead insert the version string
from versioning API Yan proposed?  Is this were we might choose to use
an interface via the vfio API rather than sysfs if we had one?

> +
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
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
> +    VFIODevice *vbasedev = opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +
> +    if (migration->region.mmaps) {
> +        vfio_region_unmap(&migration->region);
> +    }
> +    trace_vfio_save_cleanup(vbasedev->name);
> +}
> +
> +static SaveVMHandlers savevm_vfio_handlers = {
> +    .save_setup = vfio_save_setup,
> +    .save_cleanup = vfio_save_cleanup,
> +};
> +
> +/* ---------------------------------------------------------------------- */
> +
>  static void vfio_vmstate_change(void *opaque, int running, RunState state)
>  {
>      VFIODevice *vbasedev = opaque;
> @@ -191,6 +266,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    register_savevm_live("vfio", -1, 1, &savevm_vfio_handlers, vbasedev);
>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 69503228f20e..4bb43f18f315 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,3 +149,5 @@ vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>  vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>  vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
> +vfio_save_setup(char *name) " (%s)"
> +vfio_save_cleanup(char *name) " (%s)"


