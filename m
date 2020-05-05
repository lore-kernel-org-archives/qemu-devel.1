Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA115C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 04:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8409E20663
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 04:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyKzjs6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8409E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVpLu-0004L7-Kc
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 00:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jVpKu-00035S-OP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 00:37:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jVpKt-0006Zx-Ia
 for qemu-devel@nongnu.org; Tue, 05 May 2020 00:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588653458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hhBdV1zsBT5oDRLHOegURY05cmxnyTc+kmPWcxkvIPU=;
 b=LyKzjs6v7UBU81vNL03up+0SGyfV0fdih2Zn/aQq7etWxa0xIzSq3Uduk7rix1AY/nBZgW
 9fM3L9Vjn01wUZB0C6ylmhWYJ2oYIy1maqY7FYVODpCTUyVP0oTjQBbarh/E2GXUA+JcXZ
 5iFQnRVv4wetDZh47+NtJcwm+cUWNsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-H78Uh3oJNXqMTmGhlZWxxQ-1; Tue, 05 May 2020 00:37:33 -0400
X-MC-Unique: H78Uh3oJNXqMTmGhlZWxxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5CD107ACCA;
 Tue,  5 May 2020 04:37:31 +0000 (UTC)
Received: from x1.home (ovpn-113-95.phx2.redhat.com [10.3.113.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 590051002387;
 Tue,  5 May 2020 04:37:29 +0000 (UTC)
Date: Mon, 4 May 2020 22:37:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v16 QEMU 08/16] vfio: Register SaveVMHandlers for VFIO
 device
Message-ID: <20200504223726.5d4bb9ce@x1.home>
In-Reply-To: <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-9-git-send-email-kwankhede@nvidia.com>
 <20200325150248.6661e1bd@w520.home>
 <a3a082a4-cc2f-b84b-60c6-a20f86528a6d@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Tue, 5 May 2020 04:49:10 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 3/26/2020 2:32 AM, Alex Williamson wrote:
> > On Wed, 25 Mar 2020 02:39:06 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Define flags to be used as delimeter in migration file stream.
> >> Added .save_setup and .save_cleanup functions. Mapped & unmapped migration
> >> region from these functions at source during saving or pre-copy phase.
> >> Set VFIO device state depending on VM's state. During live migration, VM is
> >> running when .save_setup is called, _SAVING | _RUNNING state is set for VFIO
> >> device. During save-restore, VM is paused, _SAVING state is set for VFIO device.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> ---
> >>   hw/vfio/migration.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events |  2 ++
> >>   2 files changed, 78 insertions(+)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index 22ded9d28cf3..033f76526e49 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -8,6 +8,7 @@
> >>    */
> >>   
> >>   #include "qemu/osdep.h"
> >> +#include "qemu/main-loop.h"
> >>   #include <linux/vfio.h>
> >>   
> >>   #include "sysemu/runstate.h"
> >> @@ -24,6 +25,17 @@
> >>   #include "pci.h"
> >>   #include "trace.h"
> >>   
> >> +/*
> >> + * Flags used as delimiter:
> >> + * 0xffffffff => MSB 32-bit all 1s
> >> + * 0xef10     => emulated (virtual) function IO
> >> + * 0x0000     => 16-bits reserved for flags
> >> + */
> >> +#define VFIO_MIG_FLAG_END_OF_STATE      (0xffffffffef100001ULL)
> >> +#define VFIO_MIG_FLAG_DEV_CONFIG_STATE  (0xffffffffef100002ULL)
> >> +#define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
> >> +#define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
> >> +
> >>   static void vfio_migration_region_exit(VFIODevice *vbasedev)
> >>   {
> >>       VFIOMigration *migration = vbasedev->migration;
> >> @@ -126,6 +138,69 @@ static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> >>       return 0;
> >>   }
> >>   
> >> +/* ---------------------------------------------------------------------- */
> >> +
> >> +static int vfio_save_setup(QEMUFile *f, void *opaque)
> >> +{
> >> +    VFIODevice *vbasedev = opaque;
> >> +    VFIOMigration *migration = vbasedev->migration;
> >> +    int ret;
> >> +
> >> +    qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
> >> +
> >> +    if (migration->region.mmaps) {
> >> +        qemu_mutex_lock_iothread();
> >> +        ret = vfio_region_mmap(&migration->region);
> >> +        qemu_mutex_unlock_iothread();
> >> +        if (ret) {
> >> +            error_report("%s: Failed to mmap VFIO migration region %d: %s",
> >> +                         vbasedev->name, migration->region.index,
> >> +                         strerror(-ret));
> >> +            return ret;
> >> +        }
> >> +    }
> >> +
> >> +    ret = vfio_migration_set_state(vbasedev, ~0, VFIO_DEVICE_STATE_SAVING);
> >> +    if (ret) {
> >> +        error_report("%s: Failed to set state SAVING", vbasedev->name);
> >> +        return ret;
> >> +    }
> >> +
> >> +    /*
> >> +     * Save migration region size. This is used to verify migration region size
> >> +     * is greater than or equal to migration region size at destination
> >> +     */
> >> +    qemu_put_be64(f, migration->region.size);  
> > 
> > Is this requirement supported by the uapi?    
> 
> Yes, on UAPI thread we discussed this:
> 
>   * For the user application, data is opaque. The user application 
> should write
>   * data in the same order as the data is received and the data should be of
>   * same transaction size at the source.
> 
> data should be same transaction size, so migration region size should be 
> greater than or equal to the size at source when verifying at destination.

We are that user application for which the data is opaque, therefore we
should make no assumptions about how the vendor driver makes use of
their region.  If we get a transaction that exceeds the end of the
region, I agree, that would be an error.  But we have no business
predicting that such a transaction might occur if the vendor driver
indicates it can support the migration.

> > The vendor driver operates
> > within the migration region, but it has no requirement to use the full
> > extent of the region.  Shouldn't we instead insert the version string
> > from versioning API Yan proposed?  Is this were we might choose to use
> > an interface via the vfio API rather than sysfs if we had one?
> >  
> 
> VFIO API cannot be used by libvirt or management tool stack. We need 
> sysfs as Yan proposed to be used by libvirt or management tool stack.

It's been a long time, but that doesn't seem like what I was asking.
The sysfs version checking is used to select a target that is likely to
succeed, but the migration stream is still generated by a user and the
vendor driver is still ultimately responsible for validating that
stream.  I would hope that a vendor migration stream therefore starts
with information similar to that found in the sysfs interface, allowing
the receiving vendor driver to validate the source device and vendor
software version, such that we can fail an incoming migration that the
vendor driver deems incompatible.  Ideally the vendor driver might also
include consistency and sequence checking throughout the stream to
prevent a malicious user from exploiting the internal operation of the
vendor driver.  Thanks,

Alex


