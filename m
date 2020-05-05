Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33E6C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994F7206CC
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyZ7lFju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994F7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVufG-0002zk-P2
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVuYE-0006rd-Ig
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:11:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVuYD-0002Vu-LY
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588673504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qYP5hei+9dAbu2tuMU3HQ8iEsG+EM8TI+IlS3ed1D4=;
 b=XyZ7lFjugHGNJaWsvlezFu5vrWw2lucUn/1xMcjbzyyxipQDUSEZdzUTVEgdyAjQN+tEMb
 HxY4/DbgktkgLTafe9wXGGgTw54Kx6OQpivraiqvk/kKfpnS184qo6VuCD/tKyOAkLwAB1
 fJ5Uw2nYQL1pfo8YqpTdmWzygjC7j8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-frAgqNjsO9CPVTogwMk7Gg-1; Tue, 05 May 2020 06:11:41 -0400
X-MC-Unique: frAgqNjsO9CPVTogwMk7Gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E91C64AE8;
 Tue,  5 May 2020 10:11:36 +0000 (UTC)
Received: from gondolin (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8CFA5D9D3;
 Tue,  5 May 2020 10:11:04 +0000 (UTC)
Date: Tue, 5 May 2020 12:11:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v18 QEMU 06/18] vfio: Add VM state change handler to
 know state of VM
Message-ID: <20200505120459.62bd0b16.cohuck@redhat.com>
In-Reply-To: <1588632293-18932-7-git-send-email-kwankhede@nvidia.com>
References: <1588632293-18932-1-git-send-email-kwankhede@nvidia.com>
 <1588632293-18932-7-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 04:14:41 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> VM state change handler gets called on change in VM's state. This is used to set
> VFIO device state to _RUNNING.
> 
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/trace-events          |  2 +
>  include/hw/vfio/vfio-common.h |  4 ++
>  3 files changed, 93 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index bf9384907ec0..e79b34003079 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include <linux/vfio.h>
>  
> +#include "sysemu/runstate.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "cpu.h"
>  #include "migration/migration.h"
> @@ -74,6 +75,85 @@ err:
>      return ret;
>  }
>  
> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> +                                    uint32_t value)

I find 'mask' and 'value' a bit confusing. 'mask' seems to be all the
bits you want to keep, and 'value' the bits you want to add?

> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIORegion *region = &migration->region;
> +    uint32_t device_state;
> +    int ret;
> +
> +    ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("%s: Failed to read device state %d %s",
> +                     vbasedev->name, ret, strerror(errno));
> +        return ret;
> +    }
> +
> +    device_state = (device_state & mask) | value;
> +
> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                                              device_state));
> +    if (ret < 0) {
> +        error_report("%s: Failed to set device state %d %s",
> +                     vbasedev->name, ret, strerror(errno));
> +
> +        ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
> +                device_state));
> +        if (ret < 0) {
> +            error_report("%s: On failure, failed to read device state %d %s",
> +                    vbasedev->name, ret, strerror(errno));
> +            return ret;
> +        }
> +
> +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> +            error_report("%s: Device is in error state 0x%x",
> +                         vbasedev->name, device_state);
> +            return -EFAULT;

Why -EFAULT?

Also, if the device is in an error state, don't you want to propagate
that state into the vbasedev as well? It does not look usable in that
state, but that information is only available in the migration region.

> +        }
> +    }
> +
> +    vbasedev->device_state = device_state;
> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> +    return 0;
> +}
> +
> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    if ((vbasedev->vm_running != running)) {
> +        int ret;
> +        uint32_t value = 0, mask = 0;
> +
> +        if (running) {
> +            value = VFIO_DEVICE_STATE_RUNNING;
> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> +                mask = ~VFIO_DEVICE_STATE_RESUMING;
> +            }
> +        } else {
> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> +        }

I think the issue might be that you are starting to fiddle with the
target state before you know what the actual device state is (you only
know the state in the vbasedev, which might be out of sync.) But you do
know what the transition is supposed to look like depending on the
vmstate change, so what about the following:

- read the state from the region
- figure out the transition that is supposed to be happening
- write the target state

> +
> +        ret = vfio_migration_set_state(vbasedev, mask, value);
> +        if (ret) {
> +            error_report("%s: Failed to set device state 0x%x",
> +                         vbasedev->name, value & mask);

If the transition failed, what does that mean? I assume that the device
might actually be in an unusable state (like the error state referenced
above)? Does it make sense to continue, or should the device rather be
flagged broken in some way?

> +        }
> +        vbasedev->vm_running = running;
> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> +                                  value & mask);
> +    }
> +}


