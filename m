Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92112C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA38422251
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jlnyjt0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA38422251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIX1x-00015D-Kc
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIX1O-0000Ze-J1; Wed, 16 Sep 2020 08:58:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIX1L-00014z-Qd; Wed, 16 Sep 2020 08:58:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08GCXT54150805; Wed, 16 Sep 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lbHcgx0h7RXZaWDpz/AfkS6Gkj3g9Ts9IMe9mb1Xhm4=;
 b=jlnyjt0IPXYmQ43cDhx+NzRh6mU1pjkfzVm9wu09VTdtKFK2sm9QVbMvqwmnk5nfMB92
 9xn+AGgm+QJt1wTeJFUQGvf0ApRqaA8/Jq6Z16q8qhS728nGnV8Qiez6trs++tAonZUB
 usbxXLjTJ/3q5CEpLK/PcSq6gw72YlLTA6NLiS4V8dHdZqHLO9ZNSZPDY384QoD/SMTO
 AHr8fs9y8T9SN6eZsEnKPiWdAQ1DPDKftnPhdovlIqlLsmEnu1eHeRahXqRfkXhFpiKm
 llz5YvwppGvgjg25d7f6/iSjUuP3a2CvcdYPDuBvXRxNhTkS5sckXCfD3rASkdHHOxv8 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33kj3nj3b6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 08:58:46 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08GCkcmF035757;
 Wed, 16 Sep 2020 08:58:45 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33kj3nj3am-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 08:58:45 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08GClRmA027972;
 Wed, 16 Sep 2020 12:58:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03wdc.us.ibm.com with ESMTP id 33k5wccqwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2020 12:58:44 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08GCwhWI43843940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2020 12:58:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC31B28059;
 Wed, 16 Sep 2020 12:58:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD6492805C;
 Wed, 16 Sep 2020 12:58:40 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2020 12:58:40 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] s390x/pci: Honor DMA limits set by vfio
To: Cornelia Huck <cohuck@redhat.com>
References: <1600197283-25274-1-git-send-email-mjrosato@linux.ibm.com>
 <1600197283-25274-6-git-send-email-mjrosato@linux.ibm.com>
 <20200916130524.48e11b26.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <df001856-dcb3-6d34-7934-0fb0f7c02ba7@linux.ibm.com>
Date: Wed, 16 Sep 2020 08:58:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916130524.48e11b26.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-16_07:2020-09-16,
 2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 suspectscore=2 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160092
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:55:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.062,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 7:05 AM, Cornelia Huck wrote:
> On Tue, 15 Sep 2020 15:14:43 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> When an s390 guest is using lazy unmapping, it can result in a very
>> large number of oustanding DMA requests, far beyond the default
>> limit configured for vfio.  Let's track DMA usage similar to vfio
>> in the host, and trigger the guest to flush their DMA mappings
>> before vfio runs out.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 56 +++++++++++++++++++++++++++++++++++++++++++-----
>>   hw/s390x/s390-pci-bus.h  |  9 ++++++++
>>   hw/s390x/s390-pci-inst.c | 34 +++++++++++++++++++++++------
>>   hw/s390x/s390-pci-inst.h |  3 +++
>>   4 files changed, 91 insertions(+), 11 deletions(-)
> 
> (...)
> 
>> @@ -737,6 +740,41 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>>       object_unref(OBJECT(iommu));
>>   }
>>   
>> +static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)
> 
> Should these go into the new vfio-related file?
> 
>> +{
>> +    int id = vdev->group->container->fd;
>> +    S390PCIDMACount *cnt;
>> +    uint32_t avail;
>> +
>> +    if (!s390_pci_update_dma_avail(id, &avail)) {
>> +        return NULL;
>> +    }
>> +
>> +    QTAILQ_FOREACH(cnt, &s->zpci_dma_limit, link) {
>> +        if (cnt->id  == id) {
>> +            cnt->users++;
>> +            return cnt;
>> +        }
>> +    }
>> +
>> +    cnt = g_new0(S390PCIDMACount, 1);
>> +    cnt->id = id;
>> +    cnt->users = 1;
>> +    cnt->avail = avail;
>> +    QTAILQ_INSERT_TAIL(&s->zpci_dma_limit, cnt, link);
>> +    return cnt;
>> +}
>> +
>> +static void s390_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
>> +{
>> +    assert(cnt);
>> +
>> +    cnt->users--;
>> +    if (cnt->users == 0) {
>> +        QTAILQ_REMOVE(&s->zpci_dma_limit, cnt, link);
>> +    }
>> +}
>> +
>>   static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>>   {
>>       PCIBus *b;
>> @@ -764,6 +802,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>>       s->bus_no = 0;
>>       QTAILQ_INIT(&s->pending_sei);
>>       QTAILQ_INIT(&s->zpci_devs);
>> +    QTAILQ_INIT(&s->zpci_dma_limit);
>>   
>>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>>                                S390_ADAPTER_SUPPRESSIBLE, errp);
>> @@ -902,6 +941,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>   {
>>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>       PCIDevice *pdev = NULL;
>> +    VFIOPCIDevice *vpdev = NULL;
>>       S390PCIBusDevice *pbdev = NULL;
>>   
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>> @@ -941,17 +981,20 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>               }
>>           }
>>   
>> +        pbdev->pdev = pdev;
>> +        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
>> +        pbdev->iommu->pbdev = pbdev;
>> +        pbdev->state = ZPCI_FS_DISABLED;
>> +
>>           if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>               pbdev->fh |= FH_SHM_VFIO;
>> +            vpdev = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
>> +            pbdev->iommu->dma_limit = s390_start_dma_count(s,
>> +                                                           &vpdev->vbasedev);
> 
> I think you can just pass s and pbdev to that function... that would
> move dealing with vfio specifics from this file.

I had considered this as well, should have went with my gut -- I'll move 
them.

> 
>>           } else {
>>               pbdev->fh |= FH_SHM_EMUL;
>>           }
>>   
>> -        pbdev->pdev = pdev;
>> -        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
>> -        pbdev->iommu->pbdev = pbdev;
>> -        pbdev->state = ZPCI_FS_DISABLED;
>> -
>>           if (s390_pci_msix_init(pbdev)) {
>>               error_setg(errp, "MSI-X support is mandatory "
>>                          "in the S390 architecture");
> 
> (...)
> 
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 2f7a7d7..cc34b17 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -32,6 +32,9 @@
>>           }                                                          \
>>       } while (0)
>>   
>> +#define inc_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;
> 
> I was thinking more of something like
> 
> static inline void inc_dma_avail(S390PCIIOMMU *iommu)
> {
>      if (iommu->dma_limit) {
>          iommu->dma_limit->avail++;
>      }
> }
> 

Ah, I read the 'lowercase' and missed the 'inline function' part of your 
previous comment, sorry.  Will change.

>> +#define dec_dma_avail(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;
>> +
>>   static void s390_set_status_code(CPUS390XState *env,
>>                                    uint8_t r, uint64_t status_code)
>>   {
> 
> (...)
> 


