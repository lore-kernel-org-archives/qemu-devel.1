Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CADC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F122222B9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VNB6koIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F122222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBmU-0005MO-CQ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBl2-0003nh-RX; Tue, 15 Sep 2020 10:16:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBl0-00006d-Gs; Tue, 15 Sep 2020 10:16:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FECmwA098889; Tue, 15 Sep 2020 10:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gI+EoU+LEvvKVQnp21Ju3VnHtP8NRl9GpW1vDE2O8l0=;
 b=VNB6koIKWHlTbNVHwjP8bJ0xuX96LeFnh3EgbbafZyMg0PQypFFCbGrjx483Pd/vZnBr
 vqors0ILCxa94/zNhrNEcOUSEDBsEJDxgVzQ8v4V510JV5dTOw9dmrEVXfRXQKHL1T4Z
 pcDL/bdZfU08zPQaotajv5aWD7nczAnTQRHbEOHnXTcTZltVHMkEViDr9iLXCk3vm3hd
 iKfz+E8a1cbIplgDkPJM7OPUqGIRIE2uZxkLYA7sMHmwl6MINew3STL42CpEKaJyfOhv
 dfnahvQYxD1MK6XZS2pQaVgIpS2uZgM5cWxmqHmjRt5PIDy/JJf0I0y1e3CDQbnDxOE+ Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jy63r43c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:16:28 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FEDsmt101969;
 Tue, 15 Sep 2020 10:16:27 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jy63r42v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 10:16:27 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FE8WSC008432;
 Tue, 15 Sep 2020 14:16:27 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 33gny9dx09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 14:16:26 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FEGPjP60686784
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 14:16:25 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56679136055;
 Tue, 15 Sep 2020 14:16:25 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F13113604F;
 Tue, 15 Sep 2020 14:16:24 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 14:16:24 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] s390x/pci: Honor DMA limits set by vfio
To: Cornelia Huck <cohuck@redhat.com>
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-3-git-send-email-mjrosato@linux.ibm.com>
 <20200915132849.5e166b3e.cohuck@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <2913a3f4-0c4e-14d2-9d8e-fda75e5defb4@linux.ibm.com>
Date: Tue, 15 Sep 2020 10:16:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915132849.5e166b3e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_08:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150114
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 schnelle@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, alex.williamson@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 7:28 AM, Cornelia Huck wrote:
> On Mon, 14 Sep 2020 18:29:29 -0400
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
>>   hw/s390x/s390-pci-bus.c  | 99 +++++++++++++++++++++++++++++++++++++++++++++---
>>   hw/s390x/s390-pci-bus.h  |  9 +++++
>>   hw/s390x/s390-pci-inst.c | 29 +++++++++++---
>>   hw/s390x/s390-pci-inst.h |  3 ++
>>   4 files changed, 129 insertions(+), 11 deletions(-)
>>
> 
> (...)
> 
>> @@ -737,6 +742,82 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
>>       object_unref(OBJECT(iommu));
>>   }
>>   
>> +static bool s390_sync_dma_avail(int fd, unsigned int *avail)
> 
> Not sure I like the name. It sounds like the function checks whether
> "sync dma" is available. Maybe s390_update_dma_avail()?
> 

Sounds fine to me.

>> +{
>> +    struct vfio_iommu_type1_info *info;
>> +    uint32_t argsz;
>> +    bool rval = false;
>> +    int ret;
>> +
>> +    if (avail == NULL) {
>> +        return false;
>> +    }
>> +
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
> 
> Adding vfio specific things into the generic s390 pci emulation code
> looks a bit ugly... I'd prefer to factor that out into a separate file,
> especially if you plan to add more vfio-specific things in the future.
> 

Fair.   hw/s390x/s390-pci-vfio.* ?

>> +
>> +out:
>> +    g_free(info);
>> +    return rval;
>> +}
>> +
> 
> (...)
> 
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 2f7a7d7..6af9af4 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -32,6 +32,9 @@
>>           }                                                          \
>>       } while (0)
>>   
>> +#define INC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail++;
>> +#define DEC_DMA_AVAIL(iommu) if (iommu->dma_limit) iommu->dma_limit->avail--;
> 
> Hm... maybe lowercase inline functions might be better here?
> 

OK

>> +
>>   static void s390_set_status_code(CPUS390XState *env,
>>                                    uint8_t r, uint64_t status_code)
>>   {
> 
> (...)
> 
>> @@ -620,6 +629,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>>       S390PCIIOMMU *iommu;
>>       S390IOTLBEntry entry;
>>       hwaddr start, end;
>> +    uint32_t dma_avail;
>>   
>>       if (env->psw.mask & PSW_MASK_PSTATE) {
>>           s390_program_interrupt(env, PGM_PRIVILEGED, ra);
>> @@ -675,8 +685,9 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>>           }
>>   
>>           start += entry.len;
>> -        while (entry.iova < start && entry.iova < end) {
>> -            s390_pci_update_iotlb(iommu, &entry);
>> +        dma_avail = 1; /* Assume non-zero dma_avail to start */
>> +        while (entry.iova < start && entry.iova < end && dma_avail > 0) {
>> +            dma_avail = s390_pci_update_iotlb(iommu, &entry);
>>               entry.iova += PAGE_SIZE;
>>               entry.translated_addr += PAGE_SIZE;
>>           }
>> @@ -689,7 +700,13 @@ err:
>>           s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, start, 0);
>>       } else {
>>           pbdev->fmb.counter[ZPCI_FMB_CNT_RPCIT]++;
>> -        setcc(cpu, ZPCI_PCI_LS_OK);
>> +        if (dma_avail > 0) {
> 
> When I compile this (with a headers update), the compiler moans here
> about an uninitialized variable.
> 

D'oh.  Obviously dma_avail needs to be initialized outside of the 
if/else -- I'll double-check the logic here and fix.

>> +            setcc(cpu, ZPCI_PCI_LS_OK);
>> +        } else {
>> +            /* vfio DMA mappings are exhausted, trigger a RPCIT */
>> +            setcc(cpu, ZPCI_PCI_LS_ERR);
>> +            s390_set_status_code(env, r1, ZPCI_RPCIT_ST_INSUFF_RES);
>> +        }
>>       }
>>       return 0;
>>   }
> 
> (...)
> 


