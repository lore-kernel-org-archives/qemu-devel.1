Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9CAC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24632076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN4n4Yrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24632076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNClE-0001oM-QS
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNCjm-0001H8-2f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNCjj-0004Qf-T3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:19:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601374795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR4e+p0ujdMpNVwEpmTDBIWgVQ02dP/3c2lC9YNWJWA=;
 b=ZN4n4YrffzOlKoWaBdIcvAhHryCvWIOpmH1WSitLZmEjraWG2xRy+ZfCW0PVAtj8AiTEVC
 w4Z5YS0yOJL2b19Y7dL3UiOYmEp8N3HDInRzMIExqPVnT/efg6FG6mhwcYhLdcMlbYqX6V
 u45+FzE22rcJAVgpFv5AQoJ8MO5VJr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-wy4zDLsuPrSizyIFOcGTrA-1; Tue, 29 Sep 2020 06:19:52 -0400
X-MC-Unique: wy4zDLsuPrSizyIFOcGTrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D8FE801F95;
 Tue, 29 Sep 2020 10:19:49 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C89C10013C0;
 Tue, 29 Sep 2020 10:19:38 +0000 (UTC)
Date: Tue, 29 Sep 2020 11:19:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v26 07/17] vfio: Register SaveVMHandlers for VFIO device
Message-ID: <20200929101935.GD2826@work-vm>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-8-git-send-email-kwankhede@nvidia.com>
 <bffa8dc8-917f-047c-d71a-d9ec5770bfbe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bffa8dc8-917f-047c-d71a-d9ec5770bfbe@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, quintela@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> On 9/23/20 1:24 AM, Kirti Wankhede wrote:
> > Define flags to be used as delimeter in migration file stream.
> 
> Typo "delimiter".
> 
> > Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> > region from these functions at source during saving or pre-copy phase.
> > Set VFIO device state depending on VM's state. During live migration, VM is
> > running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> > device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> > 
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > ---
> >  hw/vfio/migration.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/vfio/trace-events |  2 ++
> >  2 files changed, 93 insertions(+)
> > 
> > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > index f650fe9fc3c8..8e8adaa25779 100644
> > --- a/hw/vfio/migration.c
> > +++ b/hw/vfio/migration.c
> > @@ -8,12 +8,15 @@
> >   */
> >  
> >  #include "qemu/osdep.h"
> > +#include "qemu/main-loop.h"
> > +#include "qemu/cutils.h"
> >  #include <linux/vfio.h>
> >  
> >  #include "sysemu/runstate.h"
> >  #include "hw/vfio/vfio-common.h"
> >  #include "cpu.h"
> >  #include "migration/migration.h"
> > +#include "migration/vmstate.h"
> >  #include "migration/qemu-file.h"
> >  #include "migration/register.h"
> >  #include "migration/blocker.h"
> > @@ -25,6 +28,17 @@
> >  #include "trace.h"
> >  #include "hw/hw.h"
> >  
> > +/*
> > + * Flags used as delimiter:
> > + * 0xffffffff => MSB 32-bit all 1s
> > + * 0xef10     => emulated (virtual) function IO
> > + * 0x0000     => 16-bits reserved for flags
> > + */
> > +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> > +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> > +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> > +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> > +
> >  static inline int vfio_mig_access(VFIODevice *vbasedev, void *val, int count,
> >                                    off_t off, bool iswrite)
> >  {
> > @@ -166,6 +180,65 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> >      return 0;
> >  }
> >  
> > +/* ---------------------------------------------------------------------- */
> > +
> > +static int vfio_save_setup(QEMUFile *f, void *opaque)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +    VFIOMigration *migration = vbasedev->migration;
> > +    int ret;
> > +
> > +    trace_vfio_save_setup(vbasedev->name);
> > +
> > +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> > +
> > +    if (migration->region.mmaps) {
> > +        qemu_mutex_lock_iothread();
> > +        ret = vfio_region_mmap(&migration->region);
> > +        qemu_mutex_unlock_iothread();
> > +        if (ret) {
> > +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > +                         vbasedev->name, migration->region.nr,
> > +                         strerror(-ret));
> > +            error_report("%s: Falling back to slow path", vbasedev->name);
> > +        }
> > +    }
> > +
> > +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
> > +                                   VFIO_DEVICE_STATE_SAVING);
> > +    if (ret) {
> > +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> > +        return ret;
> > +    }
> > +
> > +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > +
> > +    ret = qemu_file_get_error(f);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void vfio_save_cleanup(void *opaque)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +    VFIOMigration *migration = vbasedev->migration;
> > +
> > +    if (migration->region.mmaps) {
> > +        vfio_region_unmap(&migration->region);
> > +    }
> > +    trace_vfio_save_cleanup(vbasedev->name);
> > +}
> > +
> > +static SaveVMHandlers savevm_vfio_handlers = {
> > +    .save_setup = vfio_save_setup,
> > +    .save_cleanup = vfio_save_cleanup,
> > +};
> > +
> > +/* ---------------------------------------------------------------------- */
> > +
> >  static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >  {
> >      VFIODevice *vbasedev = opaque;
> > @@ -225,6 +298,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >                                 struct vfio_region_info *info)
> >  {
> >      int ret = -EINVAL;
> > +    char id[256] = "";
> > +    Object *obj;
> >  
> >      if (!vbasedev->ops->vfio_get_object) {
> >          return ret;
> > @@ -241,6 +316,22 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >          return ret;
> >      }
> >  
> > +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> > +
> > +    if (obj) {
> > +        DeviceState *dev = DEVICE(obj);
> > +        char *oid = vmstate_if_get_id(VMSTATE_IF(dev));
> > +
> > +        if (oid) {
> > +            pstrcpy(id, sizeof(id), oid);
> > +            pstrcat(id, sizeof(id), "/");
> > +            g_free(oid);
> > +        }
> > +    }
> > +    pstrcat(id, sizeof(id), "vfio");
> 
> Alternatively (easier to review, matter of taste):
> 
>  g_autofree char *path = NULL;
> 
>  if (oid) {
>    path = g_strdup_printf("%s/vfio",
>                           vmstate_if_get_id(VMSTATE_IF(obj)););
>  } else {
>    path = g_strdup("vfio");
>  }
>  strpadcpy(id, sizeof(id), path, '\0');

Maybe, although it's a straight copy of the magic in unregister_savevm.

Dave

> > +
> > +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
> > +                         vbasedev);
> >      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> >                                                            vbasedev);
> >      vbasedev->migration_state.notify = vfio_migration_state_notifier;
> > diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > index bcb3fa7314d7..982d8dccb219 100644
> > --- a/hw/vfio/trace-events
> > +++ b/hw/vfio/trace-events
> > @@ -152,3 +152,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> >  vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
> >  vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> > +vfio_save_setup(const char *name) " (%s)"
> > +vfio_save_cleanup(const char *name) " (%s)"
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


