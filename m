Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF1FC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD042072C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 15:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eiuzde9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD042072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVcuz-0007NB-K8
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 11:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVctd-0006Ro-Sh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:52:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kVctb-0008Hn-IX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 11:52:57 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f91aac50000>; Thu, 22 Oct 2020 08:52:37 -0700
Received: from [10.40.101.194] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 22 Oct
 2020 15:52:35 +0000
Subject: Re: [PATCH v27 03/17] vfio: Add save and load functions for VFIO PCI
 devices
To: Alex Williamson <alex.williamson@redhat.com>
References: <1603365127-14202-1-git-send-email-kwankhede@nvidia.com>
 <1603365127-14202-4-git-send-email-kwankhede@nvidia.com>
 <20201022080648.1af7b85c@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <973d4252-37ef-6682-0559-49c6fd438ead@nvidia.com>
Date: Thu, 22 Oct 2020 21:22:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201022080648.1af7b85c@w520.home>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603381957; bh=5nT+UYJXunRUBQhJs28jBOAEV5uu3BXOedmFDZsBdRU=;
 h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
 b=eiuzde9Vnr1roGCz7BM/VZHZ6Sh5YSaI2HbNg2XsZrW0wJr4abDnT+NKbYVTE/MBr
 IHQBV8I9K727JQ58UI+yE2CnmWod3vzza5GLrPUp5Od+n2tNvmW7xe/xnc1igkU1Oc
 zoXSV4xWuDGOAxbfjf2ZVdz3TNuUh1WIlLU8HFV64Ijz+94GKimYLsJ0ddvYUAjp+d
 amF/1tXRQJydZF8WfpUlW7ps9dRHoIEhaQtY1MQD2ImS4iDfI9QN0WRifOISAkGBNT
 4tbvWpuq8YBl6tRngtvATn8M9uhFLU9Bg/Qm8QcL84sbt40oXQYNJnqQn9FMjBjhbd
 lLCsJWOj6cjLg==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 11:52:49
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, cjia@nvidia.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com, eauger@redhat.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/22/2020 7:36 PM, Alex Williamson wrote:
> On Thu, 22 Oct 2020 16:41:53 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Added functions to save and restore PCI device specific data,
>> specifically config space of PCI device.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   hw/vfio/pci.c                 | 48 +++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index bffd5bfe3b78..1036a5332772 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -41,6 +41,7 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "migration/blocker.h"
>> +#include "migration/qemu-file.h"
>>   
>>   #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
>>   
>> @@ -2401,11 +2402,58 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
>>       return OBJECT(vdev);
>>   }
>>   
>> +static bool vfio_msix_enabled(void *opaque, int version_id)
>> +{
>> +    PCIDevice *pdev = opaque;
>> +
>> +    return msix_enabled(pdev);
> 
> Why msix_enabled() rather than msix_present()?  It seems that even if
> MSI-X is not enabled at the point in time where this is called, there's
> still emulated state in the vector table.  For example if the guest has
> written the vectors but has not yet enabled the capability at the point
> where we start a migration, this test might cause the guest on the
> target to enable MSI-X with uninitialized data in the vector table.
> 

You're correct. Changing it to check if present.

>> +}
>> +
>> +const VMStateDescription vmstate_vfio_pci_config = {
>> +    .name = "VFIOPCIDevice",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
>> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_enabled),
> 
> MSI (not-X) state is entirely in config space, so doesn't need a
> separate field, correct?
> 

Yes.

> Otherwise this looks quite a bit cleaner than previous version, I hope
> VMState experts can confirm this is sufficiently extensible within the
> migration framework.  Thanks,
> 

Thanks,
Kirti

> Alex
> 
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +
>> +    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
>> +}
>> +
>> +static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
>> +{
>> +    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    int ret;
>> +
>> +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
>> +    if (ret) {
>> +        return ret;
>> +    }
>> +
>> +    if (msi_enabled(pdev)) {
>> +        vfio_msi_enable(vdev);
>> +    } else if (msix_enabled(pdev)) {
>> +        vfio_msix_enable(vdev);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static VFIODeviceOps vfio_pci_ops = {
>>       .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
>>       .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
>>       .vfio_eoi = vfio_intx_eoi,
>>       .vfio_get_object = vfio_pci_get_object,
>> +    .vfio_save_config = vfio_pci_save_config,
>> +    .vfio_load_config = vfio_pci_load_config,
>>   };
>>   
>>   int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index fe99c36a693a..ba6169cd926e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -120,6 +120,8 @@ struct VFIODeviceOps {
>>       int (*vfio_hot_reset_multi)(VFIODevice *vdev);
>>       void (*vfio_eoi)(VFIODevice *vdev);
>>       Object *(*vfio_get_object)(VFIODevice *vdev);
>> +    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
>> +    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
>>   };
>>   
>>   typedef struct VFIOGroup {
> 

