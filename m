Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EECC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E682247F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r33nEWaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E682247F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBo9-0007ap-8c
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBnT-0006hI-KK; Tue, 15 Sep 2020 10:19:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBnR-0000T6-MI; Tue, 15 Sep 2020 10:19:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FEAdUf059177; Tue, 15 Sep 2020 10:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=owUG/g5l+ZuLt6rJVFUg0uiZ7t4uIEV0AgZvr2W4Uu0=;
 b=r33nEWaUnyw+y5mo9L52g1L/gwmqgtlz6X+3PnyA+ZoPy7Cd8g5ytlpMzeWpN30fuw1h
 lkcSQBt36bsC0vmPk2d7Q9Sf6xaIRQXYsAHuqQEXHJBy0lncoh5d2I+Sb6Jt0nw2Gnw6
 EvUD++hyq/aKggyU3/plgm/fxkIGUj+RumAglRwaVXSoizvfoo9xrF7pOwBT6bQ5jES9
 KTIr8geC+3BKtWUDNzXnT5cq9Zj/7vMH/dV4NTNOjHFqxc+TI0oiSLn8s1x+GBXZQ6dt
 TwFeQFsGYt2+06bXE3qJ5x3IVsuYRxSS/zlRQRE7acgbFO8rlQS91/XgGHE2RQln95Pp iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jxx90v2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:18:59 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FEBSRb064295;
 Tue, 15 Sep 2020 10:18:59 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jxx90v1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:18:59 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FEHulc030454;
 Tue, 15 Sep 2020 14:18:58 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01wdc.us.ibm.com with ESMTP id 33jaxxqbea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 14:18:58 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FEIpl366126094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 14:18:51 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21441136051;
 Tue, 15 Sep 2020 14:18:57 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29DEA13604F;
 Tue, 15 Sep 2020 14:18:56 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 14:18:56 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
To: Thomas Huth <thuth@redhat.com>, alex.williamson@redhat.com,
 cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
 <6d835b47-5935-8eb7-f0f7-d81f0cec4028@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <bb684ffd-1f12-f6a1-ea5b-3973faaa2037@linux.ibm.com>
Date: Tue, 15 Sep 2020 10:18:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6d835b47-5935-8eb7-f0f7-d81f0cec4028@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_08:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150114
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:39:26
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: pmorel@linux.ibm.com, schnelle@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 8:54 AM, Thomas Huth wrote:
> On 15/09/2020 00.29, Matthew Rosato wrote:
>> When an s390 guest is using lazy unmapping, it can result in a very
>> large number of oustanding DMA requests, far beyond the default
>> limit configured for vfio.  Let's track DMA usage similar to vfio
>> in the host, and trigger the guest to flush their DMA mappings
>> before vfio runs out.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++---
>>   hw/s390x/s390-pci-bus.h  |  9 +++++
>>   hw/s390x/s390-pci-inst.c | 29 +++++++++++---
>>   hw/s390x/s390-pci-inst.h |  3 ++
>>   4 files changed, 129 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 92146a2..23474cd 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -11,6 +11,8 @@
>>    * directory.
>>    */
>>   
>> +#include <sys/ioctl.h>
>> +
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>>   #include "qapi/visitor.h"
>> @@ -24,6 +26,9 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/module.h"
>>   
>> +#include "hw/vfio/pci.h"
>> +#include "hw/vfio/vfio-common.h"
>> +
>>   #ifndef DEBUG_S390PCI_BUS
>>   #define DEBUG_S390PCI_BUS  0
>>   #endif
>> @@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>>       object_unref(OBJECT(iommu));
>>   }
>>   
>> +static bool s390_sync_dma_avail(int fd, unsigned int *avail)
>> +{
>> +    struct vfio_iommu_type1_info *info;
> 
> You could use g_autofree to get rid of the g_free() at the end.
> 

OK

>> +    uint32_t argsz;
>> +    bool rval = false;
>> +    int ret;
>> +
>> +    if (avail == NULL) {
>> +        return false;
>> +    }
> 
> Since this is a "static" local function, and calling it with avail ==
> NULL does not make too much sense, I think I'd rather turn this into an
> assert() instead. >

Sure, sounds good.


>> +    argsz = sizeof(struct vfio_iommu_type1_info);
>> +    info = g_malloc0(argsz);
>> +    info->argsz = argsz;
>> +    /*
>> +     * If the specified argsz is not large enough to contain all
>> +     * capabilities it will be updated upon return.  In this case
>> +     * use the updated value to get the entire capability chain.
>> +     */
>> +    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
>> +    if (argsz != info->argsz) {
>> +        argsz = info->argsz;
>> +        info = g_realloc(info, argsz);
>> +        info->argsz = argsz;
>> +        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
>> +    }
>> +
>> +    if (ret) {
>> +        goto out;
>> +    }
>> +
>> +    /* If the capability exists, update with the current value */
>> +    rval = vfio_get_info_dma_avail(info, avail);
>> +
>> +out:
>> +    g_free(info);
>> +    return rval;
>> +}
>> +
>> +static S390PCIDMACount *s390_start_dma_count(S390pciState *s, VFIODevice *vdev)
>> +{
>> +    int id = vdev->group->container->fd;
>> +    S390PCIDMACount *cnt;
>> +    uint32_t avail;
>> +
>> +    if (!s390_sync_dma_avail(id, &avail)) {
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
>> +    if (cnt == NULL) {
>> +        return;
>> +    }
> 
> Either use assert() or drop this completely (since you're checking it at
> the caller site already).
> 

Fair - I'll assert() here.  Thanks!

