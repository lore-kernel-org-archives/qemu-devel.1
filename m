Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38B7206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 23:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aAUYroSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38B7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVkgf-00045s-TP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 19:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOQ-0004AV-3T
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:20:58 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jVkOM-0001TH-Ug
 for qemu-devel@nongnu.org; Mon, 04 May 2020 19:20:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5eb0a2d50001>; Mon, 04 May 2020 16:18:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 04 May 2020 16:20:53 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 04 May 2020 16:20:53 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 23:20:53 +0000
Received: from [10.40.101.152] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 23:20:44 +0000
Subject: Re: [PATCH v16 QEMU 07/16] vfio: Add migration state change notifier
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1585084154-29461-1-git-send-email-kwankhede@nvidia.com>
 <1585084154-29461-8-git-send-email-kwankhede@nvidia.com>
 <20200401112720.GB3258@work-vm>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <42407b19-4e1a-5fc5-2066-8c4e1bee14aa@nvidia.com>
Date: Tue, 5 May 2020 04:50:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401112720.GB3258@work-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1588634325; bh=kd/HAkfyJHnVQFgdHNJ8EUM8rOHU5ijlV+iZB5EU2SY=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=aAUYroSirUzXiQMkCuCY6CRpD6Ag3Pl38YyXSO2DBgVAKvknp8IHfT3pxJYYvd+HV
 Rk2u21+qXNFDOLArswIXcDCDwoa6IKas+uclMnxL4NhNSjb292614BhGNPqmss+OEe
 yNzBD+r1zan4LReZW/ShaCgWtk7qXQCopg8V9pq2nK+I+snsA+EWTMG10pTmRfLhUW
 Qjth7hVWdM+5XEeHIKE9LXROaHJLMwmThhIDWRPvFsOOMFI69WNC93cNgG5rBuBTUo
 PxAYFrQj8gDBEeu+68urTUwUlr63DkEYLutGbKF1XoZ3rxrRXp7UQXoW1LrQXSn0Be
 3+svrLeJYKunA==
Received-SPF: pass client-ip=216.228.121.143;
 envelope-from=kwankhede@nvidia.com; helo=hqnvemgate24.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 19:18:10
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Zhengxiao.zx@alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/1/2020 4:57 PM, Dr. David Alan Gilbert wrote:
> * Kirti Wankhede (kwankhede@nvidia.com) wrote:
>> Added migration state change notifier to get notification on migration state
>> change. These states are translated to VFIO device state and conveyed to vendor
>> driver.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |  1 +
>>   include/hw/vfio/vfio-common.h |  1 +
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index af9443c275fb..22ded9d28cf3 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -154,6 +154,27 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>       }
>>   }
>>   
>> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>> +{
>> +    MigrationState *s = data;
>> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
>> +    int ret;
>> +
>> +    trace_vfio_migration_state_notifier(vbasedev->name, s->state);
> 
> You might want to use MigrationStatus_str(s->status) to make that
> readable.
> 

Yes.

>> +    switch (s->state) {
>> +    case MIGRATION_STATUS_CANCELLING:
>> +    case MIGRATION_STATUS_CANCELLED:
>> +    case MIGRATION_STATUS_FAILED:
>> +        ret = vfio_migration_set_state(vbasedev,
>> +                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
>> +                      VFIO_DEVICE_STATE_RUNNING);
>> +        if (ret) {
>> +            error_report("%s: Failed to set state RUNNING", vbasedev->name);
>> +        }
> 
> In the migration code we check to see if the VM was running prior to the
> start of the migration before we start the CPUs going again (see
> migration_iteration_finish):
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          if (s->vm_was_running) {
>              vm_start();
>          } else {
>              if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
>                  runstate_set(RUN_STATE_POSTMIGRATE);
>              }
> 
> so if the guest was paused before a migration we don't falsely restart
> it.  Maybe you need something similar?
> 

Guest paused means vCPUs are paused, but that doesn't pause device. Init 
state of VFIO device is also RUNNING and device will not get any 
instructions until vCPUs are running. So I think putting device in 
RUNNING is still fine.

Thanks,
Kirti

> Dave
> 
>> +    }
>> +}
>> +
>>   static int vfio_migration_init(VFIODevice *vbasedev,
>>                                  struct vfio_region_info *info)
>>   {
>> @@ -173,6 +194,9 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                             vbasedev);
>>   
>> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
>> +    add_migration_state_change_notifier(&vbasedev->migration_state);
>> +
>>       return 0;
>>   }
>>   
>> @@ -211,6 +235,11 @@ add_blocker:
>>   
>>   void vfio_migration_finalize(VFIODevice *vbasedev)
>>   {
>> +
>> +    if (vbasedev->migration_state.notify) {
>> +        remove_migration_state_change_notifier(&vbasedev->migration_state);
>> +    }
>> +
>>       if (vbasedev->vm_state) {
>>           qemu_del_vm_change_state_handler(vbasedev->vm_state);
>>       }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 3d15bacd031a..69503228f20e 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -148,3 +148,4 @@ vfio_display_edid_write_error(void) ""
>>   vfio_migration_probe(char *name, uint32_t index) " (%s) Region %d"
>>   vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>>   vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>> +vfio_migration_state_notifier(char *name, int state) " (%s) state %d"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 3d18eb146b33..28f55f66d019 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
>>       VMChangeStateEntry *vm_state;
>>       uint32_t device_state;
>>       int vm_running;
>> +    Notifier migration_state;
>>   } VFIODevice;
>>   
>>   struct VFIODeviceOps {
>> -- 
>> 2.7.0
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

