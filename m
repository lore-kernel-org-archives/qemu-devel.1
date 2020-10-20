Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B78C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E40C223C6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deG8qb4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E40C223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpFl-0007YL-Eu
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUpEm-0006fE-Tr
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kUpEk-0005Br-QM
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603191085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cDw3VRKRbMAkFlFs/0zt4rwR+MHUvK2Ir2xgJ56UGA=;
 b=deG8qb4OpWty10ndPyx1kKxKNZsOKGLnX7Q+iE5e1fnP0vmkzaud0OdP+4FTSc4b+8L/L+
 rz5weIkJThvdO5LuywIVkes2raRXg/5vrEwwohbS7AxW//yAcMuf3WxgfE/MlD0iQG0yYr
 4q4B8Eh8tK4+CHr7PNZFkJS/rqZBECQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-EQxDtG0QO0Kv_Kh0IBu_Yw-1; Tue, 20 Oct 2020 06:51:24 -0400
X-MC-Unique: EQxDtG0QO0Kv_Kh0IBu_Yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46122107AD65;
 Tue, 20 Oct 2020 10:51:21 +0000 (UTC)
Received: from gondolin (ovpn-114-95.ams2.redhat.com [10.36.114.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A17F12C31E;
 Tue, 20 Oct 2020 10:51:08 +0000 (UTC)
Date: Tue, 20 Oct 2020 12:51:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v26 05/17] vfio: Add VM state change handler to know
 state of VM
Message-ID: <20201020125105.5cd790df.cohuck@redhat.com>
In-Reply-To: <3dd3fe95-c81a-de40-47b0-24f0772974d4@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-6-git-send-email-kwankhede@nvidia.com>
 <20200924170220.0a9836fe.cohuck@redhat.com>
 <20200929110312.GF2826@work-vm>
 <3dd3fe95-c81a-de40-47b0-24f0772974d4@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: cjia@nvidia.com, aik@ozlabs.ru, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eauger@redhat.com, yi.l.liu@intel.com, quintela@redhat.com,
 ziye.yang@intel.com, armbru@redhat.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, zhi.a.wang@intel.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, alex.williamson@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 01:54:56 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 9/29/2020 4:33 PM, Dr. David Alan Gilbert wrote:
> > * Cornelia Huck (cohuck@redhat.com) wrote:  
> >> On Wed, 23 Sep 2020 04:54:07 +0530
> >> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >>  
> >>> VM state change handler gets called on change in VM's state. This is used to set
> >>> VFIO device state to _RUNNING.
> >>>
> >>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> >>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> >>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >>> ---
> >>>   hw/vfio/migration.c           | 136 ++++++++++++++++++++++++++++++++++++++++++
> >>>   hw/vfio/trace-events          |   3 +-
> >>>   include/hw/vfio/vfio-common.h |   4 ++
> >>>   3 files changed, 142 insertions(+), 1 deletion(-)
> >>>  
> >>
> >> (...)
> >>  
> >>> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
> >>> +                                    uint32_t value)  
> >>
> >> I think I've mentioned that before, but this function could really
> >> benefit from a comment what mask and value mean.
> >>  
> 
> Adding a comment as:
> 
> /*
>   *  Write device_state field to inform the vendor driver about the 
> device state
>   *  to be transitioned to.
>   *  vbasedev: VFIO device
>   *  mask : bits set in the mask are preserved in device_state
>   *  value: bits set in the value are set in device_state
>   *  Remaining bits in device_state are cleared.
>   */

Maybe:

"Change the device_state register for device @vbasedev. Bits set in
@mask are preserved, bits set in @value are set, and bits not set in
either @mask or @value are cleared in device_state. If the register
cannot be accessed, the resulting state would be invalid, or the device
enters an error state, an error is returned." ?

> 
> 
> >>> +{
> >>> +    VFIOMigration *migration = vbasedev->migration;
> >>> +    VFIORegion *region = &migration->region;
> >>> +    off_t dev_state_off = region->fd_offset +
> >>> +                      offsetof(struct vfio_device_migration_info, device_state);
> >>> +    uint32_t device_state;
> >>> +    int ret;
> >>> +
> >>> +    ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> >>> +                        dev_state_off);
> >>> +    if (ret < 0) {
> >>> +        return ret;
> >>> +    }
> >>> +
> >>> +    device_state = (device_state & mask) | value;
> >>> +
> >>> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
> >>> +        return -EINVAL;
> >>> +    }
> >>> +
> >>> +    ret = vfio_mig_write(vbasedev, &device_state, sizeof(device_state),
> >>> +                         dev_state_off);
> >>> +    if (ret < 0) {
> >>> +        ret = vfio_mig_read(vbasedev, &device_state, sizeof(device_state),
> >>> +                          dev_state_off);
> >>> +        if (ret < 0) {
> >>> +            return ret;
> >>> +        }
> >>> +
> >>> +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
> >>> +            hw_error("%s: Device is in error state 0x%x",
> >>> +                     vbasedev->name, device_state);
> >>> +            return -EFAULT;  
> >>
> >> Is -EFAULT a good return value here? Maybe -EIO?
> >>  
> 
> Ok. Changing to -EIO.
> 
> >>> +        }
> >>> +    }
> >>> +
> >>> +    vbasedev->device_state = device_state;
> >>> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
> >>> +{
> >>> +    VFIODevice *vbasedev = opaque;
> >>> +
> >>> +    if ((vbasedev->vm_running != running)) {
> >>> +        int ret;
> >>> +        uint32_t value = 0, mask = 0;
> >>> +
> >>> +        if (running) {
> >>> +            value = VFIO_DEVICE_STATE_RUNNING;
> >>> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
> >>> +                mask = ~VFIO_DEVICE_STATE_RESUMING;  
> >>
> >> I've been staring at this for some time and I think that the desired
> >> result is
> >> - set _RUNNING
> >> - if _RESUMING was set, clear it, but leave the other bits intact  
> 
> Upto here, you're correct.
> 
> >> - if _RESUMING was not set, clear everything previously set
> >> This would really benefit from a comment (or am I the only one
> >> struggling here?)
> >>  
> 
> Here mask should be ~0. Correcting it.

Hm, now I'm confused. With value == _RUNNING, ~_RUNNING and ~0 as mask
should be equivalent, shouldn't they?

> 
> 
> >>> +            }
> >>> +        } else {
> >>> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
> >>> +        }
> >>> +
> >>> +        ret = vfio_migration_set_state(vbasedev, mask, value);
> >>> +        if (ret) {
> >>> +            /*
> >>> +             * vm_state_notify() doesn't support reporting failure. If such
> >>> +             * error reporting support added in furure, migration should be
> >>> +             * aborted.  
> >>
> >>
> >> "We should abort the migration in this case, but vm_state_notify()
> >> currently does not support reporting failures."
> >>
> >> ?
> >>  
> 
> Ok. Updating comment as suggested here.
> 
> >> Can/should we mark the failing device in some way?  
> > 
> > I think you can call qemu_file_set_error on the migration stream to
> > force an error.
> >   
> 
> It should be as below, right?
> qemu_file_set_error(migrate_get_current()->to_dst_file, ret);

Does this indicate in any way which device was causing problems? (I'm
not sure how visible the error_report would be?)

> 
> 
> Thanks,
> Kirti
> 
> > Dave
> >   
> >>> +             */
> >>> +            error_report("%s: Failed to set device state 0x%x",
> >>> +                         vbasedev->name, value & mask);
> >>> +        }
> >>> +        vbasedev->vm_running = running;
> >>> +        trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
> >>> +                                  value & mask);
> >>> +    }
> >>> +}
> >>> +
> >>>   static int vfio_migration_init(VFIODevice *vbasedev,
> >>>                                  struct vfio_region_info *info)
> >>>   {  
> >>
> >> (...)  
> 


