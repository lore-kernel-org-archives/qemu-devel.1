Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7F1C47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6C421D43
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6WE9450"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6C421D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDUx-0002RD-6U
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNDQ1-0005FK-9D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kNDPz-0002rf-BG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:03:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601377414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iVaPevfbtqr+4yOyxmAPVmCMQ7qa9hFmw6lRqdlNYw=;
 b=Z6WE945045Zvg89ezP89y/VlpJ8EevRFnVCNCOU/b3S1GonXoveR2K5vvDzMxfXvOy9/9c
 9loS+/xkeehjCgW+znFj2Au1uPQbPEGKlOIgqzmeJTNBYjs6rP5VMMQJRxiqm7YQs8XIZW
 dxVhbEsWKNQ+5j/uMoeGs/TyfXs/WTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-bM_UNyZ-Ok226yUSle0OSQ-1; Tue, 29 Sep 2020 07:03:30 -0400
X-MC-Unique: bM_UNyZ-Ok226yUSle0OSQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62520186842D;
 Tue, 29 Sep 2020 11:03:28 +0000 (UTC)
Received: from work-vm (ovpn-114-253.ams2.redhat.com [10.36.114.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA6E85D9CA;
 Tue, 29 Sep 2020 11:03:14 +0000 (UTC)
Date: Tue, 29 Sep 2020 12:03:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20200929110312.GF2826@work-vm>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200924170220.0a9836fe.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200924170220.0a9836fe.cohuck@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Wed, 23 Sep 2020 04:54:07 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
> > VM state change handler gets called on change in VM's state. This is used to set
> > VFIO device state to _RUNNING.
> > 
> > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  hw/vfio/migration.c           | 136 ++++++++++++++++++++++++++++++++++++++++++
> >  hw/vfio/trace-events          |   3 +-
> >  include/hw/vfio/vfio-common.h |   4 ++
> >  3 files changed, 142 insertions(+), 1 deletion(-)
> > 
> 
> (...)
> 
> > +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> > +                                    uint32_t value)
> 
> I think I've mentioned that before, but this function could really
> benefit from a comment what mask and value mean. 
> 
> > +{
> > +    VFIOMigration *migration = vbasedev->migration;
> > +    VFIORegion *region = &migration->region;
> > +    off_t dev_state_off = region->fd_offset +
> > +                      offsetof(struct vfio_device_migration_info, device_state);
> > +    uint32_t device_state;
> > +    int ret;
> > +
> > +    ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> > +                        dev_state_off);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    device_state = (device_state & mask) | value;
> > +
> > +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    ret = vfio_mig_write(vbasedev, &device_state, sizeof(device_state),
> > +                         dev_state_off);
> > +    if (ret < 0) {
> > +        ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> > +                          dev_state_off);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +
> > +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> > +            hw_error("%s: Device is in error state 0x%x",
> > +                     vbasedev->name, device_state);
> > +            return -EFAULT;
> 
> Is -EFAULT a good return value here? Maybe -EIO?
> 
> > +        }
> > +    }
> > +
> > +    vbasedev->device_state = device_state;
> > +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> > +    return 0;
> > +}
> > +
> > +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> > +{
> > +    VFIODevice *vbasedev = opaque;
> > +
> > +    if ((vbasedev->vm_running != running)) {
> > +        int ret;
> > +        uint32_t value = 0, mask = 0;
> > +
> > +        if (running) {
> > +            value = VFIO_DEVICE_STATE_RUNNING;
> > +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> > +                mask = ~VFIO_DEVICE_STATE_RESUMING;
> 
> I've been staring at this for some time and I think that the desired
> result is
> - set _RUNNING
> - if _RESUMING was set, clear it, but leave the other bits intact
> - if _RESUMING was not set, clear everything previously set
> This would really benefit from a comment (or am I the only one
> struggling here?)
> 
> > +            }
> > +        } else {
> > +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> > +        }
> > +
> > +        ret = vfio_migration_set_state(vbasedev, mask, value);
> > +        if (ret) {
> > +            /*
> > +             * vm_state_notify() doesn't support reporting failure. If such
> > +             * error reporting support added in furure, migration should be
> > +             * aborted.
> 
> 
> "We should abort the migration in this case, but vm_state_notify()
> currently does not support reporting failures."
> 
> ?
> 
> Can/should we mark the failing device in some way?

I think you can call qemu_file_set_error on the migration stream to
force an error.

Dave

> > +             */
> > +            error_report("%s: Failed to set device state 0x%x",
> > +                         vbasedev->name, value & mask);
> > +        }
> > +        vbasedev->vm_running = running;
> > +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> > +                                  value & mask);
> > +    }
> > +}
> > +
> >  static int vfio_migration_init(VFIODevice *vbasedev,
> >                                 struct vfio_region_info *info)
> >  {
> 
> (...)
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


