Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48A0C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84FE2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8+0LkH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84FE2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZR6-0002O0-Oa
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUZPz-0001Y4-Jk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:57:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kUZPx-0000Sp-Ni
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603130276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moXn6JpMxqIjyBnsPXL9nhlh4+Cc20bGprUXjVwLQ/A=;
 b=C8+0LkH9ZOYzXW2wJ2NlmXDaiQ57wIPjDu3a1qnIxLF3qiTM74wpkfc9pp4WKl9fxA3dFC
 ud+N6o5gxUpDo/Xi1ygbkV9Jwp4V8C866JtSmLor6zn7px+YRpKnsdSI0wjioNFz5JnHlj
 oS8Y3kGzgjnh26MWd2mRmqapMUDWD0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-X3EdGHSkNqmo_Ia2oXFfdA-1; Mon, 19 Oct 2020 13:57:54 -0400
X-MC-Unique: X3EdGHSkNqmo_Ia2oXFfdA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35CFD1006C9B;
 Mon, 19 Oct 2020 17:57:52 +0000 (UTC)
Received: from w520.home (ovpn-112-77.phx2.redhat.com [10.3.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 833215C26A;
 Mon, 19 Oct 2020 17:57:47 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:57:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 06/17] vfio: Add migration state change notifier
Message-ID: <20201019115747.15846824@w520.home>
In-Reply-To: <048540b5-9e03-e6ec-64e5-a78b99a78c08@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-7-git-send-email-kwankhede@nvidia.com>
 <20200925142032.524c1a79@x1.home>
 <048540b5-9e03-e6ec-64e5-a78b99a78c08@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, changpeng.liu@intel.com,
 eskultet@redhat.com, Ken.Xue@amd.com, jonathan.davies@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 02:05:03 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 9/26/2020 1:50 AM, Alex Williamson wrote:
> > On Wed, 23 Sep 2020 04:54:08 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> Added migration state change notifier to get notification on migration state
> >> change. These states are translated to VFIO device state and conveyed to vendor
> >> driver.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> ---
> >>   hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events          |  5 +++--
> >>   include/hw/vfio/vfio-common.h |  1 +
> >>   3 files changed, 33 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index a30d628ba963..f650fe9fc3c8 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -199,6 +199,28 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >>       }
> >>   }
> >>   
> >> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
> >> +{
> >> +    MigrationState *s = data;
> >> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
> >> +    int ret;
> >> +
> >> +    trace_vfio_migration_state_notifier(vbasedev->name,
> >> +                                        MigrationStatus_str(s->state));
> >> +
> >> +    switch (s->state) {
> >> +    case MIGRATION_STATUS_CANCELLING:
> >> +    case MIGRATION_STATUS_CANCELLED:
> >> +    case MIGRATION_STATUS_FAILED:
> >> +        ret = vfio_migration_set_state(vbasedev,
> >> +                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
> >> +                      VFIO_DEVICE_STATE_RUNNING);
> >> +        if (ret) {
> >> +            error_report("%s: Failed to set state RUNNING", vbasedev->name);
> >> +        }  
> > 
> > Here again the caller assumes success means the device has entered the
> > desired state, but as implemented it only means the device is in some
> > non-error state.
> >   
> >> +    }
> >> +}
> >> +
> >>   static int vfio_migration_init(VFIODevice *vbasedev,
> >>                                  struct vfio_region_info *info)
> >>   {
> >> @@ -221,6 +243,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >>   
> >>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> >>                                                             vbasedev);
> >> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
> >> +    add_migration_state_change_notifier(&vbasedev->migration_state);
> >>       return ret;
> >>   }
> >>   
> >> @@ -263,6 +287,11 @@ add_blocker:
> >>   
> >>   void vfio_migration_finalize(VFIODevice *vbasedev)
> >>   {
> >> +
> >> +    if (vbasedev->migration_state.notify) {
> >> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
> >> +    }
> >> +
> >>       if (vbasedev->vm_state) {
> >>           qemu_del_vm_change_state_handler(vbasedev->vm_state);
> >>       }
> >> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> >> index 6524734bf7b4..bcb3fa7314d7 100644
> >> --- a/hw/vfio/trace-events
> >> +++ b/hw/vfio/trace-events
> >> @@ -149,5 +149,6 @@ vfio_display_edid_write_error(void) ""
> >>   
> >>   # migration.c
> >>   vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
> >> -vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
> >> -vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >> +vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
> >> +vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
> >> +vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >> index 25e3b1a3b90a..49c7c7a0e29a 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
> >>       VMChangeStateEntry *vm_state;
> >>       uint32_t device_state;
> >>       int vm_running;
> >> +    Notifier migration_state;  
> > 
> > Can this live in VFIOMigration?  Thanks,
> >   
> 
> No, callback vfio_migration_state_notifier() has notifier argument and 
> to reach its corresponding device structure as below, its should be in 
> VFIODevice.
> 
> VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);

An alternative would be to place migration_state within VFIOMigration,
along with a pointer back to vbasedev (like we do in VFIORegion) then
the notifier could use container_of to get the VFIOMigration structure,
from which we could get to the VFIODevice via the vbasedev pointer.
This would better compartmentalize the migration related data into a
single structure.  Thanks,

Alex


