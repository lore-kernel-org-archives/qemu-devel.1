Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A7F206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7UWH5QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A7F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb7Vo-0006K3-2M
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jb7V1-0005tB-Vw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31642
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jb7V0-0001FQ-Bs
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589914917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=exv3/npEKA07jD4yZqfeHfgHSlSydWFPWo7lIusSh5o=;
 b=B7UWH5QTUMGJ1L25OCybKu39I3jB1u4wHfFVLCTJYCE9AVHIVPJeIQKgxmrn+lpd4lwAPZ
 KLH3eOu/20FYwDmi63JQy7rvcm+hrefCzFsKkyhcbfrAPvmDpb/WQMFBDvpPRmJCG9T+ss
 AwMFZl5LUkBXbLOlwy+1luq/ZE984iY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-tuNNNbpXP5OAQSfgCwFo-w-1; Tue, 19 May 2020 15:01:52 -0400
X-MC-Unique: tuNNNbpXP5OAQSfgCwFo-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5AB2835B41;
 Tue, 19 May 2020 19:01:49 +0000 (UTC)
Received: from work-vm (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14BBD6297D;
 Tue, 19 May 2020 19:01:38 +0000 (UTC)
Date: Tue, 19 May 2020 20:01:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v22 08/18] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200519190136.GL2798@work-vm>
References: <1589782398-24406-1-git-send-email-kwankhede@nvidia.com>
 <1589782398-24406-9-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1589782398-24406-9-git-send-email-kwankhede@nvidia.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, alex.williamson@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
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
>  hw/vfio/migration.c  | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events |  2 ++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index c2f5564b51c3..773c8d16b1c1 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -8,12 +8,14 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include <linux/vfio.h>
>  
>  #include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "cpu.h"
>  #include "migration/migration.h"
> +#include "migration/vmstate.h"
>  #include "migration/qemu-file.h"
>  #include "migration/register.h"
>  #include "migration/blocker.h"
> @@ -24,6 +26,17 @@
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
> @@ -126,6 +139,64 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
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
> +    trace_vfio_save_setup(vbasedev->name);
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
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +
> +    ret = qemu_file_get_error(f);
> +    if (ret) {
> +        return ret;
> +    }
> +
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
> @@ -192,6 +263,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>          return ret;
>      }
>  
> +    register_savevm_live("vfio", VMSTATE_INSTANCE_ID_ANY, 1,
> +                         &savevm_vfio_handlers, vbasedev);

I see you changed the -1 to VMSTATE_INSTANCE_ID_ANY which is soemthing
I'd asked for in my review last month of v16.
But I also asked what happens with multiple devices and whether this was
working OK because I was worried about using the fixed name and multiple
instances of a register_savevm_live being rare.  Did you check that out?

Dave

>      vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>                                                            vbasedev);
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index bd3d47b005cb..86c18def016e 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,3 +149,5 @@ vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>  vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
>  vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>  vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> +vfio_save_setup(const char *name) " (%s)"
> +vfio_save_cleanup(const char *name) " (%s)"
> -- 
> 2.7.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


