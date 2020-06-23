Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3E5207F9
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Agdt9C7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3E5207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jno6K-00008t-6P
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jno5j-00089s-GM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:56:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jno5h-00072b-7z
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 14:56:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef250200000>; Tue, 23 Jun 2020 11:55:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 23 Jun 2020 11:56:14 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 23 Jun 2020 11:56:14 -0700
Received: from [10.40.100.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 18:55:58 +0000
Subject: Re: [PATCH QEMU v25 05/17] vfio: Add VM state change handler to know
 state of VM
To: Alex Williamson <alex.williamson@redhat.com>
References: <1592684486-18511-1-git-send-email-kwankhede@nvidia.com>
 <1592684486-18511-6-git-send-email-kwankhede@nvidia.com>
 <20200622165019.27b5f395@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <48629aa9-f5bb-08dd-17fc-b73b1b5bf5ae@nvidia.com>
Date: Wed, 24 Jun 2020 00:25:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200622165019.27b5f395@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592938528; bh=VmdDDz2NRAyAzGEMIRFSMDwxVnn70WLquxy/JsncS6M=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Agdt9C7op6IasyfO4h1drQkMNe4Ze5xHzoRlsSLQCyVTuo4KmbFndO+gj4c12g5Ld
 TZbWxmKESBXKdUsfuLjpB0oEoackhQW5bJrJLQHPtPq5B+QxfJYxbk1qY6WyBOJpnX
 giMmKLjD5yWHzJyJYhZPyetaNEDd++vmtbAq1U6WC3r4n6JZ6bqfPfQ/cXLyoYsBlX
 p3MFVSwkj5rzEGKMfFjKXeIg/OtPTeUjTMX82Ts7ZFQdNMSMZuiHoX9UH4vL4peqj/
 0vzqfShn65/W5HSciM/PsJ16bALLp7Bb7j0YLp6XDFCPEtrSy+R8AK0d6OZIA50Xh/
 0rIf4DuqLdg9w==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 14:56:14
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 6/23/2020 4:20 AM, Alex Williamson wrote:
> On Sun, 21 Jun 2020 01:51:14 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> VM state change handler gets called on change in VM's state. This is used to set
>> VFIO device state to _RUNNING.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/migration.c           | 87 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |  2 +
>>   include/hw/vfio/vfio-common.h |  4 ++
>>   3 files changed, 93 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 48ac385d80a7..fcecc0bb0874 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -10,6 +10,7 @@
>>   #include "qemu/osdep.h"
>>   #include <linux/vfio.h>
>>   
>> +#include "sysemu/runstate.h"
>>   #include "hw/vfio/vfio-common.h"
>>   #include "cpu.h"
>>   #include "migration/migration.h"
>> @@ -74,6 +75,85 @@ err:
>>       return ret;
>>   }
>>   
>> +static int vfio_migration_set_state(VFIODevice *vbasedev, uint32_t mask,
>> +                                    uint32_t value)
>> +{
>> +    VFIOMigration *migration = vbasedev->migration;
>> +    VFIORegion *region = &migration->region;
>> +    uint32_t device_state;
>> +    int ret;
>> +
>> +    ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              device_state));
>> +    if (ret < 0) {
>> +        error_report("%s: Failed to read device state %d %s",
>> +                     vbasedev->name, ret, strerror(errno));
>> +        return ret;
>> +    }
>> +
>> +    device_state = (device_state & mask) | value;
>> +
>> +    if (!VFIO_DEVICE_STATE_VALID(device_state)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = pwrite(vbasedev->fd, &device_state, sizeof(device_state),
>> +                 region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                                              device_state));
>> +    if (ret < 0) {
>> +        error_report("%s: Failed to set device state %d %s",
>> +                     vbasedev->name, ret, strerror(errno));
>> +
>> +        ret = pread(vbasedev->fd, &device_state, sizeof(device_state),
>> +                region->fd_offset + offsetof(struct vfio_device_migration_info,
>> +                device_state));
>> +        if (ret < 0) {
>> +            error_report("%s: On failure, failed to read device state %d %s",
>> +                    vbasedev->name, ret, strerror(errno));
>> +            return ret;
>> +        }
>> +
>> +        if (VFIO_DEVICE_STATE_IS_ERROR(device_state)) {
>> +            error_report("%s: Device is in error state 0x%x",
>> +                         vbasedev->name, device_state);
>> +            return -EFAULT;
>> +        }
>> +    }
>> +
>> +    vbasedev->device_state = device_state;
>> +    trace_vfio_migration_set_state(vbasedev->name, device_state);
>> +    return 0;
>> +}
>> +
>> +static void vfio_vmstate_change(void *opaque, int running, RunState state)
>> +{
>> +    VFIODevice *vbasedev = opaque;
>> +
>> +    if ((vbasedev->vm_running != running)) {
>> +        int ret;
>> +        uint32_t value = 0, mask = 0;
>> +
>> +        if (running) {
>> +            value = VFIO_DEVICE_STATE_RUNNING;
>> +            if (vbasedev->device_state & VFIO_DEVICE_STATE_RESUMING) {
>> +                mask = ~VFIO_DEVICE_STATE_RESUMING;
>> +            }
>> +        } else {
>> +            mask = ~VFIO_DEVICE_STATE_RUNNING;
>> +        }
>> +
>> +        ret = vfio_migration_set_state(vbasedev, mask, value);
>> +        if (ret) {
>> +            error_report("%s: Failed to set device state 0x%x",
>> +                         vbasedev->name, value & mask);
> 
> 
> Is there nothing more we should do here?  It seems like in either the
> case of an outbound migration where we can't stop the device or an
> inbound migration where we can't start the device, we'd want this to
> trigger an abort of the migration.  Should there at least be a TODO
> comment if the reason is that QEMU migration doesn't yet support failure
> here?  Thanks,
> 

Checked other modules in QEMU, at some places error message is reported 
as above while at some places abort() is called (for example 
kvmclock_vm_state_change() in hw/i386/kvm/clock.c). Abort will abort 
QEMU process, that is VM crash. Should we abort here on error case? 
Anyways VM will not recover properly on migration if there is such error.

Thanks,
Kirti


