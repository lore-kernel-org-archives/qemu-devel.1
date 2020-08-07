Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28420C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E814120866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFjSzEUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E814120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k499Q-0003Ql-3k
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 16:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k498H-0002lk-6C
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:38:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k498E-0004Of-8J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:38:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077KXRBs108288;
 Fri, 7 Aug 2020 20:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=n6zMTgDwiKSj0JrUFY7KLLunQaCGDK4KZbhYvgl0HeA=;
 b=FFjSzEULV7Iev5SsipNbZzksYkf9KQrvI458DWZfGvy0+ucPGZncM9vOK3QJqrl3zOMI
 +gqbUAqfOc4TW0GrHBvcv2heaaZEAxfMfDBMKszxYtXRrYD6VmvC7ZnR5xvHeUFxVK+M
 Av9cbEOu+XUpe5rmyjd9ovX3FBU9JnQnFJDgSozjmw1i8H2ddxtE4W1K/933kAD7BYnD
 bLnRt6BoF/0aAa0mEM4tL/pLS7SN1ZHGjduneAiJiIdHPEK5SAKK30GWDtf4OrcPFdSF
 w6XYrx9cNFLNTk1tjBqLj+v6a689h0nycOfEAIHYjuiNOKxPhHoIrrV40nVKKCR3qArP NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32r6gx2j0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 07 Aug 2020 20:38:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077KXFT1115909;
 Fri, 7 Aug 2020 20:38:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32qy8rcxw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Aug 2020 20:38:16 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 077KcFSH002699;
 Fri, 7 Aug 2020 20:38:15 GMT
Received: from [10.39.221.23] (/10.39.221.23)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 07 Aug 2020 13:38:14 -0700
Subject: Re: [PATCH V1 30/32] vfio-pci: save and restore
To: Jason Zeng <jason.zeng@linux.intel.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-31-git-send-email-steven.sistare@oracle.com>
 <20200806102259.GA25634@x48>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <5d2e3c90-eb8c-569f-ef4a-5016756725c7@oracle.com>
Date: Fri, 7 Aug 2020 16:38:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806102259.GA25634@x48>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070145
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 16:38:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/2020 6:22 AM, Jason Zeng wrote:
> Hi Steve,
> 
> On Thu, Jul 30, 2020 at 08:14:34AM -0700, Steve Sistare wrote:
>> @@ -3182,6 +3207,51 @@ static Property vfio_pci_dev_properties[] = {
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>>  
>> +static int vfio_pci_post_load(void *opaque, int version_id)
>> +{
>> +    int vector;
>> +    MSIMessage msg;
>> +    Error *err = 0;
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *pdev = &vdev->pdev;
>> +
>> +    if (msix_enabled(pdev)) {
>> +        vfio_msix_enable(vdev);
>> +        pdev->msix_function_masked = false;
>> +
>> +        for (vector = 0; vector < vdev->pdev.msix_entries_nr; vector++) {
>> +            if (!msix_is_masked(pdev, vector)) {
>> +                msg = msix_get_message(pdev, vector);
>> +                vfio_msix_vector_use(pdev, vector, msg);
>> +            }
>> +        }
> 
> It looks to me MSIX re-init here may lose device IRQs and impact
> device hardware state?
> 
> The re-init will cause the kernel vfio driver to connect the device
> MSIX vectors to new eventfds and KVM instance. But before that, device
> IRQs will be routed to previous eventfd. Looks these IRQs will be lost.

Thanks Jason, that sounds like a problem.  I could try reading and saving an 
event from eventfd before shutdown, and injecting it into the eventfd after
restart, but that would be racy unless I disable interrupts.  Or, unconditionally
inject a spurious interrupt after restart to kick it, in case an interrupt 
was lost.

Do you have any other ideas?

> And the re-init will make the device go through the procedure of
> disabling MSIX, enabling INTX, and re-enabling MSIX and vectors.
> So if the device is active, its hardware state will be impacted?

Again thanks.  vfio_msix_enable() does indeed call vfio_disable_interrupts().
For a quick experiment, I deleted that call in for the post_load code path, and 
it seems to work fine, but I need to study it more.

- Steve
 
>> +
>> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
>> +        vfio_intx_enable(vdev, &err);
>> +        if (err) {
>> +            error_report_err(err);
>> +        }
>> +    }
>> +
>> +    vdev->vbasedev.group->container->reused = false;
>> +    vdev->pdev.reused = false;
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vfio_pci_vmstate = {
>> +    .name = "vfio-pci",
>> +    .unmigratable = 1,
>> +    .mode_mask = VMS_RESTART,
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .post_load = vfio_pci_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_MSIX(pdev, VFIOPCIDevice),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -3189,6 +3259,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>  
>>      dc->reset = vfio_pci_reset;
>>      device_class_set_props(dc, vfio_pci_dev_properties);
>> +    dc->vmsd = &vfio_pci_vmstate;
>>      dc->desc = "VFIO-based PCI device assignment";
>>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>      pdc->realize = vfio_realize;
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index ac2cefc..e6e1a5d 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -592,7 +592,7 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>>              return -EBUSY;
>>          }
>>      }
>> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
>> +    ret = vfio_get_device(group, vbasedev->name, vbasedev, 0, errp);
>>      if (ret) {
>>          vfio_put_group(group);
>>          return ret;
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index bd07c86..c926a24 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -358,6 +358,7 @@ struct PCIDevice {
>>  
>>      /* ID of standby device in net_failover pair */
>>      char *failover_pair_id;
>> +    bool reused;
>>  };
>>  
>>  void pci_register_bar(PCIDevice *pci_dev, int region_num,
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c78f3ff..4e2a332 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -73,6 +73,8 @@ typedef struct VFIOContainer {
>>      unsigned iommu_type;
>>      Error *error;
>>      bool initialized;
>> +    bool reused;
>> +    int cid;
>>      unsigned long pgsizes;
>>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>>      QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
>> @@ -177,7 +179,7 @@ void vfio_reset_handler(void *opaque);
>>  VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>>  void vfio_put_group(VFIOGroup *group);
>>  int vfio_get_device(VFIOGroup *group, const char *name,
>> -                    VFIODevice *vbasedev, Error **errp);
>> +                    VFIODevice *vbasedev, bool *reused, Error **errp);
>>  
>>  extern const MemoryRegionOps vfio_region_ops;
>>  typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 881dc13..2606cf0 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1568,7 +1568,7 @@ static int qemu_savevm_state(QEMUFile *f, VMStateMode mode, Error **errp)
>>          return -EINVAL;
>>      }
>>  
>> -    if (migrate_use_block()) {
>> +    if ((mode & (VMS_SNAPSHOT | VMS_MIGRATE)) && migrate_use_block()) {
>>          error_setg(errp, "Block migration and snapshots are incompatible");
>>          return -EINVAL;
>>      }
>> -- 
>> 1.8.3.1
>>
>>

