Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE9CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9620520775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzapw1gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9620520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopiF-00036j-T8
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jophU-0002d4-Cf
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:51:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jophS-00043i-DV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593183089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecHP+sHqqczB7juyGOVsXpqiJVDQ3r7rsZrl2bL8rvw=;
 b=Dzapw1gIhzxPOgsmjgWw669awX5aOm58akaKgD4GNySiZ+E+H7LHynbR6k4ZL+sklddqXD
 PvzYFqOJ3lVYtZfnzb2ru7n29xHmhXIdzsG8CzKt/1/58g+8ZwuJXd0zoSPLV/1qZqF0zo
 T1I9t8C/vZhZ8676RFF0Jn3UfuwNx5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-2pEREVxsMYahMfJDpyhcJQ-1; Fri, 26 Jun 2020 10:51:27 -0400
X-MC-Unique: 2pEREVxsMYahMfJDpyhcJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 514021940921;
 Fri, 26 Jun 2020 14:51:24 +0000 (UTC)
Received: from work-vm (ovpn-113-27.ams2.redhat.com [10.36.113.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC8E10013D2;
 Fri, 26 Jun 2020 14:51:13 +0000 (UTC)
Date: Fri, 26 Jun 2020 15:51:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH QEMU v25 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20200626145111.GL3087@work-vm>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-6-git-send-email-kwankhede@nvidia.com>
 <20200622165019.27b5f395@x1.home>
 <48629aa9-f5bb-08dd-17fc-b73b1b5bf5ae@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <48629aa9-f5bb-08dd-17fc-b73b1b5bf5ae@nvidia.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:49:42
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
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, Alex Williamson <alex.williamson@redhat.com>,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Kirti Wankhede (kwankhede@nvidia.com) wrote:
> 
> 
> On 6/23/2020 4:20 AM, Alex Williamson wrote:
> > On Sun, 21 Jun 2020 01:51:14 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > 
> > > VM state change handler gets called on change in VM's state. This is used to set
> > > VFIO device state to _RUNNING.
> > > 
> > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >   hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
> > >   hw/vfio/trace-events          |  2 +
> > >   include/hw/vfio/vfio-common.h |  4 ++
> > >   3 files changed, 93 insertions(+)
> > > 
> > > diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> > > index 48ac385d80a7..fcecc0bb0874 100644
> > > --- a/hw/vfio/migration.c
> > > +++ b/hw/vfio/migration.c
> > > @@ -10,6 +10,7 @@
> > >   #include "qemu/osdep.h"
> > >   #include <linux/vfio.h>
> > > +#include "sysemu/runstate.h"
> > >   #include "hw/vfio/vfio-common.h"
> > >   #include "cpu.h"
> > >   #include "migration/migration.h"
> > > @@ -74,6 +75,85 @@ err:
> > >       return ret;
> > >   }
> > > +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> > > +                                    uint32_t value)
> > > +{
> > > +    VFIOMigration *migration = vbasedev->migration;
> > > +    VFIORegion *region = &migration->region;
> > > +    uint32_t device_state;
> > > +    int ret;
> > > +
> > > +    ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> > > +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > +                                              device_state));
> > > +    if (ret < 0) {
> > > +        error_report("%s: Failed to read device state %d %s",
> > > +                     vbasedev->name, ret, strerror(errno));
> > > +        return ret;
> > > +    }
> > > +
> > > +    device_state = (device_state & mask) | value;
> > > +
> > > +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
> > > +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > +                                              device_state));
> > > +    if (ret < 0) {
> > > +        error_report("%s: Failed to set device state %d %s",
> > > +                     vbasedev->name, ret, strerror(errno));
> > > +
> > > +        ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> > > +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> > > +                device_state));
> > > +        if (ret < 0) {
> > > +            error_report("%s: On failure, failed to read device state %d %s",
> > > +                    vbasedev->name, ret, strerror(errno));
> > > +            return ret;
> > > +        }
> > > +
> > > +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> > > +            error_report("%s: Device is in error state 0x%x",
> > > +                         vbasedev->name, device_state);
> > > +            return -EFAULT;
> > > +        }
> > > +    }
> > > +
> > > +    vbasedev->device_state = device_state;
> > > +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> > > +    return 0;
> > > +}
> > > +
> > > +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> > > +{
> > > +    VFIODevice *vbasedev = opaque;
> > > +
> > > +    if ((vbasedev->vm_running != running)) {
> > > +        int ret;
> > > +        uint32_t value = 0, mask = 0;
> > > +
> > > +        if (running) {
> > > +            value = VFIO_DEVICE_STATE_RUNNING;
> > > +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> > > +                mask = ~VFIO_DEVICE_STATE_RESUMING;
> > > +            }
> > > +        } else {
> > > +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> > > +        }
> > > +
> > > +        ret = vfio_migration_set_state(vbasedev, mask, value);
> > > +        if (ret) {
> > > +            error_report("%s: Failed to set device state 0x%x",
> > > +                         vbasedev->name, value & mask);
> > 
> > 
> > Is there nothing more we should do here?  It seems like in either the
> > case of an outbound migration where we can't stop the device or an
> > inbound migration where we can't start the device, we'd want this to
> > trigger an abort of the migration.  Should there at least be a TODO
> > comment if the reason is that QEMU migration doesn't yet support failure
> > here?  Thanks,
> > 
> 
> Checked other modules in QEMU, at some places error message is reported as
> above while at some places abort() is called (for example
> kvmclock_vm_state_change() in hw/i386/kvm/clock.c). Abort will abort QEMU
> process, that is VM crash. Should we abort here on error case? Anyways VM
> will not recover properly on migration if there is such error.

I prefer to avoid aborts on migration if possible; unless the VM is
realyl dead.
Failing the migration is preferable.

Dave

> Thanks,
> Kirti
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


