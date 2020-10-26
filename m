Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E40C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D47E2242A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4LCpKM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D47E2242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3C5-0001sW-Ei
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX35i-0002oy-0S
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kX35e-0003bf-AH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIwPRN4YsTd2zXRwDH/Bxh7PumdUnSzyScM22M6b85U=;
 b=d4LCpKM/92xoxoRN3r/l4SZgJJM2I3y1BilOSwIdfUQ6aO3hMra6N80SvGnrzHzmgq00oi
 rQTfg/TppSXeLKg8e/ewgr4znYWHVY2hq+KU6YhrjNgZdaM3utDxN2OLQsalZT8OSYu2jX
 VZkragykTO2sRV/9JfxTo97CL4+2ITY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-IHRB3MBKNjqY7JoEPwPAkA-1; Mon, 26 Oct 2020 10:03:08 -0400
X-MC-Unique: IHRB3MBKNjqY7JoEPwPAkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DDA1019638;
 Mon, 26 Oct 2020 14:03:03 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAC25B4A4;
 Mon, 26 Oct 2020 14:02:58 +0000 (UTC)
Date: Mon, 26 Oct 2020 08:02:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v29 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201026080257.2f9d3506@w520.home>
In-Reply-To: <ce6c6864-a8a3-269e-a9c2-3fe4d2b265b8@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
 <1603704987-20977-6-git-send-email-kwankhede@nvidia.com>
 <20201026070056.42bb04de@w520.home>
 <ce6c6864-a8a3-269e-a9c2-3fe4d2b265b8@nvidia.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 19:18:51 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 10/26/2020 6:30 PM, Alex Williamson wrote:
> > On Mon, 26 Oct 2020 15:06:15 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >   
> >> VM state change handler is called on change in VM's state. Based on
> >> VM state, VFIO device state should be changed.
> >> Added read/write helper functions for migration region.
> >> Added function to set device_state.
> >>
> >> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>   hw/vfio/migration.c           | 158 ++++++++++++++++++++++++++++++++++++++++++
> >>   hw/vfio/trace-events          |   2 +
> >>   include/hw/vfio/vfio-common.h |   4 ++
> >>   3 files changed, 164 insertions(+)
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index fd7faf423cdc..65ce735d667b 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c  
> > [snip]  
> >> @@ -64,6 +216,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
> >>           ret = -EINVAL;
> >>           goto err;
> >>       }
> >> +
> >> +    migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
> >> +                                                           vbasedev);
> >>       return 0;
> >>   
> >>   err:  
> > 
> > Fails to build, @migration is not defined.  We could use
> > vbasedev->migration or pull defining and setting @migration from patch
> > 06.  Thanks,
> >   
> 
> Pulling and setting migration from patch 06 seems better option.
> Should I resend patch 5 & 6 only?

I've resolved this locally as patch 05:

@@ -38,6 +190,7 @@ static int vfio_migration_init(VFIODevice *vbasedev,
 {
     int ret;
     Object *obj;
+    VFIOMigration *migration;
 
     if (!vbasedev->ops->vfio_get_object) {
         return -EINVAL;
@@ -64,6 +217,10 @@ static int vfio_migration_init(VFIODevice *vbasedev,
         ret = -EINVAL;
         goto err;
     }
+
+    migration = vbasedev->migration;
+    migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
+                                                           vbasedev);
     return 0;
 
 err:

patch 06:

@@ -219,8 +243,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     }
 
     migration = vbasedev->migration;
+    migration->vbasedev = vbasedev;
     migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                            vbasedev);
+    migration->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&migration->migration_state);
     return 0;
 
 err:

If you're satisfied with that, no need to resend.  Thanks,

Alex


