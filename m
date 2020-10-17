Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBAC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05EE207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KDmzEy3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05EE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTswS-0001OT-I1
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTsvF-0000RT-6L
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:35:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kTsvD-0004SP-5K
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 16:35:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8b557c0000>; Sat, 17 Oct 2020 13:35:09 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 17 Oct
 2020 20:35:06 +0000
Subject: Re: [PATCH v26 06/17] vfio: Add migration state change notifier
To: Alex Williamson <alex.williamson@redhat.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
 <1600817059-26721-7-git-send-email-kwankhede@nvidia.com>
 <20200925142032.524c1a79@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <048540b5-9e03-e6ec-64e5-a78b99a78c08@nvidia.com>
Date: Sun, 18 Oct 2020 02:05:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925142032.524c1a79@x1.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1602966909; bh=/WvZ2LNgvUjkysh21eM6xBifzWOCZKJ51hEZJeGKJlY=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=KDmzEy3Nca0ILgiCRg8z9xdochv5wKJ082e429d+2hzU2FJX39l6O2DtfkNanN2BN
 YQf72T8+uERb5H2Vd9NUuO6GfJpr003cOK0uG+sZpBY6zcKTxqN8C614CXdokN6J10
 CjPlRvADzA4afmOcB7SbcPm2KIWJ7x4BNJ2zib08tzZyRuGmvp2Fc0+yqfZGDodJey
 v6fKEdadMnkXWKbuJpd43PzoxBgucJQV4pVrVNYKYd2CjvS6/CLAgy6DdwvPOrPI3n
 NYYQH2n8RyagxoSyEFm9/xPl10WjKx/guSXVQCBk4140KSiZ0/mtWL9sl9Bu/itF9f
 ungv1t6h5PSUg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 16:15:05
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.247, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/26/2020 1:50 AM, Alex Williamson wrote:
> On Wed, 23 Sep 2020 04:54:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added migration state change notifier to get notification on migration state
>> change. These states are translated to VFIO device state and conveyed to vendor
>> driver.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   hw/vfio/migration.c           | 29 +++++++++++++++++++++++++++++
>>   hw/vfio/trace-events          |  5 +++--
>>   include/hw/vfio/vfio-common.h |  1 +
>>   3 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index a30d628ba963..f650fe9fc3c8 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -199,6 +199,28 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
>>       }
>>   }
>>   
>> +static void vfio_migration_state_notifier(Notifier *notifier, void *data)
>> +{
>> +    MigrationState *s = data;
>> +    VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);
>> +    int ret;
>> +
>> +    trace_vfio_migration_state_notifier(vbasedev->name,
>> +                                        MigrationStatus_str(s->state));
>> +
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
> Here again the caller assumes success means the device has entered the
> desired state, but as implemented it only means the device is in some
> non-error state.
> 
>> +    }
>> +}
>> +
>>   static int vfio_migration_init(VFIODevice *vbasedev,
>>                                  struct vfio_region_info *info)
>>   {
>> @@ -221,6 +243,8 @@ static int vfio_migration_init(VFIODevice *vbasedev,
>>   
>>       vbasedev->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
>>                                                             vbasedev);
>> +    vbasedev->migration_state.notify = vfio_migration_state_notifier;
>> +    add_migration_state_change_notifier(&vbasedev->migration_state);
>>       return ret;
>>   }
>>   
>> @@ -263,6 +287,11 @@ add_blocker:
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
>> index 6524734bf7b4..bcb3fa7314d7 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -149,5 +149,6 @@ vfio_display_edid_write_error(void) ""
>>   
>>   # migration.c
>>   vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
>> -vfio_migration_set_state(char *name, uint32_t state) " (%s) state %d"
>> -vfio_vmstate_change(char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>> +vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
>> +vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
>> +vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 25e3b1a3b90a..49c7c7a0e29a 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -123,6 +123,7 @@ typedef struct VFIODevice {
>>       VMChangeStateEntry *vm_state;
>>       uint32_t device_state;
>>       int vm_running;
>> +    Notifier migration_state;
> 
> Can this live in VFIOMigration?  Thanks,
> 

No, callback vfio_migration_state_notifier() has notifier argument and 
to reach its corresponding device structure as below, its should be in 
VFIODevice.

VFIODevice *vbasedev = container_of(notifier, VFIODevice, migration_state);

Thanks,
Kirti

> Alex
> 
>>   } VFIODevice;
>>   
>>   struct VFIODeviceOps {
> 

