Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6438C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 630302067D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/PSTiTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 630302067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopGe-0006Rb-Ms
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jopG2-0005y9-OE
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:23:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jopFz-0008Et-4y
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593181385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ajTm2CxGiorFHKxaN8d6wTfjqF4gEnLZTq7GWgcj8Q=;
 b=P/PSTiTID4eDL6Go8gNdtKLT5e97Tb6eBV1qt06meIbIIrWWPxb0KL5D7jLGgNYoUUdiNZ
 hmYxpSHbbLpzcc9hkqdZ1a+g1Osz11Lhf0rwsJ9dFE0iprbFo+jMHq0F5rtyaXsoMSChr8
 Ia9r+zPuymJqm9t3vch05bpwsSBWjX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-l0JAmYhLMRqNvbr4Zv4sHg-1; Fri, 26 Jun 2020 10:23:02 -0400
X-MC-Unique: l0JAmYhLMRqNvbr4Zv4sHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A074B80058A;
 Fri, 26 Jun 2020 14:22:59 +0000 (UTC)
Received: from work-vm (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 562E861981;
 Fri, 26 Jun 2020 14:22:45 +0000 (UTC)
Date: Fri, 26 Jun 2020 15:22:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH QEMU v25 07/17] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200626142243.GJ3087@work-vm>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-8-git-send-email-kwankhede@nvidia.com>
 <20200622165024.5b2eb251@x1.home>
 <542ced5e-0380-19b9-91d2-5f40c5857719@nvidia.com>
 <20200623135056.0c4957a3@x1.home>
MIME-Version: 1.0
In-Reply-To: <20200623135056.0c4957a3@x1.home>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Wed, 24 Jun 2020 00:51:06 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > On 6/23/2020 4:20 AM, Alex Williamson wrote:
> > > On Sun, 21 Jun 2020 01:51:16 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >   
> > >> Define flags to be used as delimeter in migration file stream.
> > >> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> > >> region from these functions at source during saving or pre-copy phase.
> > >> Set VFIO device state depending on VM's state. During live migration, VM is
> > >> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> > >> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> > >>
> > >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> > >> ---
> > >>   hw/vfio/migration.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >>   hw/vfio/trace-events |  2 ++
> > >>   2 files changed, 94 insertions(+)
> > >>
> > >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > >> index e30bd8768701..133bb5b1b3b2 100644
> > >> --- a/hw/vfio/migration.c
> > >> +++ b/hw/vfio/migration.c
> > >> @@ -8,12 +8,15 @@
> > >>    */
> > >>   
> > >>   #include "qemu/osdep.h"
> > >> +#include "qemu/main-loop.h"
> > >> +#include "qemu/cutils.h"
> > >>   #include <linux/vfio.h>
> > >>   
> > >>   #include "sysemu/runstate.h"
> > >>   #include "hw/vfio/vfio-common.h"
> > >>   #include "cpu.h"
> > >>   #include "migration/migration.h"
> > >> +#include "migration/vmstate.h"
> > >>   #include "migration/qemu-file.h"
> > >>   #include "migration/register.h"
> > >>   #include "migration/blocker.h"
> > >> @@ -24,6 +27,17 @@
> > >>   #include "pci.h"
> > >>   #include "trace.h"
> > >>   
> > >> +/*
> > >> + * Flags used as delimiter:
> > >> + * 0xffffffff => MSB 32-bit all 1s
> > >> + * 0xef10     => emulated (virtual) function IO
> > >> + * 0x0000     => 16-bits reserved for flags
> > >> + */
> > >> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> > >> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> > >> +
> > >>   static void vfio_migration_region_exit(VFIODevice *vbasedev)
> > >>   {
> > >>       VFIOMigration *migration = vbasedev->migration;
> > >> @@ -126,6 +140,65 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> > >>       return 0;
> > >>   }
> > >>   
> > >> +/* ---------------------------------------------------------------------- */
> > >> +
> > >> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    VFIOMigration *migration = vbasedev->migration;
> > >> +    int ret;
> > >> +
> > >> +    trace_vfio_save_setup(vbasedev->name);
> > >> +
> > >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> > >> +
> > >> +    if (migration->region.mmaps) {
> > >> +        qemu_mutex_lock_iothread();
> > >> +        ret = vfio_region_mmap(&migration->region);
> > >> +        qemu_mutex_unlock_iothread();
> > >> +        if (ret) {
> > >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> > >> +                         vbasedev->name, migration->region.nr,
> > >> +                         strerror(-ret));
> > >> +            return ret;  
> > > 
> > > OTOH to my previous comments, this shouldn't be fatal, right?  mmaps
> > > are optional anyway so it should be sufficient to push an error report
> > > to explain why this might be slower than normal, but we can still
> > > proceed.
> > >   
> > 
> > Right, defining region to be sparse mmap is optional.
> > migration->region.mmaps is set if vendor driver defines sparse mmapable 
> > regions and VFIO_REGION_INFO_FLAG_MMAP flag is set. If this flag is set 
> > then error on mmap() should be fatal.
> > 
> > If there is not mmapable region, then migration will proceed.
> 
> It's both optional for the vendor to define sparse mmap support (or any
> mmap support) and optional for the user to make use of it.  The user
> can recover from an mmap failure by using read/write accesses.  The
> vendor MUST support this.  It doesn't make sense to worry about
> aborting the VM in replying to comments for 05/17, where it's not clear
> how we proceed, yet intentionally cause a fatal error here when there
> is a very clear path to proceed.
> 
> > >> +        }
> > >> +    }
> > >> +
> > >> +    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_MASK,
> > >> +                                   VFIO_DEVICE_STATE_SAVING);
> > >> +    if (ret) {
> > >> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> > >> +        return ret;
> > >> +    }  
> > > 
> > > We seem to be lacking support in the callers for detecting if the
> > > device is in an error state.  I'm not sure what our options are
> > > though, maybe only a hw_error().
> > >   
> > 
> > Returning error here fails migration process. And if device is in error 
> > state, any application running inside VM using this device would fail.
> > I think, there is no need to take any special action here by detecting 
> > device error state.
> 
> If QEMU knows a device has failed, it seems like it would make sense to
> stop the VM, otherwise we risk an essentially endless assortment of
> ways that the user might notice the guest isn't behaving normally, some
> maybe even causing the user to lose data.  Thanks,

With GPUs especially though we can get into messy states where only the
GPU is toast;  for example you might get this if your GUI
starts/exits/crashes during a migration - that's a bit too common to
kill a VM that might have useful data on it.

Dave

> Alex
>  
> > >> +
> > >> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > >> +
> > >> +    ret = qemu_file_get_error(f);
> > >> +    if (ret) {
> > >> +        return ret;
> > >> +    }
> > >> +
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static void vfio_save_cleanup(void *opaque)
> > >> +{
> > >> +    VFIODevice *vbasedev = opaque;
> > >> +    VFIOMigration *migration = vbasedev->migration;
> > >> +
> > >> +    if (migration->region.mmaps) {
> > >> +        vfio_region_unmap(&migration->region);
> > >> +    }
> > >> +    trace_vfio_save_cleanup(vbasedev->name);
> > >> +}
> > >> +
> > >> +static SaveVMHandlers savevm_vfio_handlers = {
> > >> +    .save_setup = vfio_save_setup,
> > >> +    .save_cleanup = vfio_save_cleanup,
> > >> +};
> > >> +
> > >> +/* ---------------------------------------------------------------------- */
> > >> +
> > >>   static void vfio_vmstate_change(void *opaque, int running, RunState state)
> > >>   {
> > >>       VFIODevice *vbasedev = opaque;
> > >> @@ -180,6 +253,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> > >>                                  struct vfio_region_info *info)
> > >>   {
> > >>       int ret;
> > >> +    char id[256] = "";
> > >>   
> > >>       vbasedev->migration = g_new0(VFIOMigration, 1);
> > >>   
> > >> @@ -192,6 +266,24 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> > >>           return ret;
> > >>       }
> > >>   
> > >> +    if (vbasedev->ops->vfio_get_object) {  
> > > 
> > > Nit, vfio_migration_region_init() would have failed already if this were
> > > not available.  Perhaps do the test once at the start of this function
> > > instead?  Thanks,
> > >   
> > 
> > Ok, will do that.
> > 
> > Thanks,
> > Kirti
> > 
> > 
> > > Alex
> > >   
> > >> +        Object *obj = vbasedev->ops->vfio_get_object(vbasedev);
> > >> +
> > >> +        if (obj) {
> > >> +            DeviceState *dev = DEVICE(obj);
> > >> +            char *oid = vmstate_if_get_id(VMSTATE_IF(dev));
> > >> +
> > >> +            if (oid) {
> > >> +                pstrcpy(id, sizeof(id), oid);
> > >> +                pstrcat(id, sizeof(id), "/");
> > >> +                g_free(oid);
> > >> +            }
> > >> +        }
> > >> +    }
> > >> +    pstrcat(id, sizeof(id), "vfio");
> > >> +
> > >> +    register_savevm_live(id, VMSTATE_INSTANCE_ID_ANY, 1, &savevm_vfio_handlers,
> > >> +                         vbasedev);
> > >>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> > >>                                                             vbasedev);
> > >>       vbasedev->migration_state.notify = vfio_migration_state_notifier;
> > >> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> > >> index bd3d47b005cb..86c18def016e 100644
> > >> --- a/hw/vfio/trace-events
> > >> +++ b/hw/vfio/trace-events
> > >> @@ -149,3 +149,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> > >>   vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
> > >>   vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> > >>   vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> > >> +vfio_save_setup(const char *name) " (%s)"
> > >> +vfio_save_cleanup(const char *name) " (%s)"  
> > >   
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


