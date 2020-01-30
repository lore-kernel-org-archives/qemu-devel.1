Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E18C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F614206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F614206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8K3-0007nm-4O
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8Fd-0002Hh-OD
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ix8Fc-0000l3-Cw
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:44:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ix8Fc-0000hG-3n
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:44:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00UBe2xO082502
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:44:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xueh73pk6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:44:45 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 30 Jan 2020 11:44:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 30 Jan 2020 11:44:40 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00UBieKs48627958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jan 2020 11:44:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1FEBA4054;
 Thu, 30 Jan 2020 11:44:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97C27A405F;
 Thu, 30 Jan 2020 11:44:38 +0000 (GMT)
Received: from [9.199.196.67] (unknown [9.199.196.67])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jan 2020 11:44:38 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] spapr: Add NVDIMM device support
To: David Gibson <david@gibson.dropbear.id.au>
References: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
 <157657253645.53829.168353921681383728.stgit@lep8c.aus.stglabs.ibm.com>
 <20200103012015.GP2098@umbus>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Thu, 30 Jan 2020 17:14:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200103012015.GP2098@umbus>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20013011-0008-0000-0000-0000034E2C80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013011-0009-0000-0000-00004A6EAC80
Message-Id: <f72750e4-1f70-b7d4-ac65-fd03ac56004d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-30_03:2020-01-28,
 2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300086
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 01/03/2020 06:50 AM, David Gibson wrote:
> On Tue, Dec 17, 2019 at 02:49:14AM -0600, Shivaprasad G Bhat wrote:
>> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
>> device interface in QEMU to support virtual NVDIMM devices for Power.
>> Create the required DT entries for the device (some entries have
>> dummy values right now).
>>
>> The patch creates the required DT node and sends a hotplug
>> interrupt to the guest. Guest is expected to undertake the normal
>> DR resource add path in response and start issuing PAPR SCM hcalls.
>>
>> The device support is verified based on the machine version unlike x86.
>>
>> This is how it can be used ..
>> Ex :
>> For coldplug, the device to be added in qemu command line as shown below
>> -object memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
>> -device nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0
>>
>> For hotplug, the device to be added from monitor as below
>> object_add memory-backend-file,id=memnvdimm0,prealloc=yes,mem-path=/tmp/nvdimm0,share=yes,size=1073872896
>> device_add nvdimm,label-size=128k,uuid=75a3cdd7-6a2f-4791-8d15-fe0a920e8e9e,memdev=memnvdimm0,id=nvdimm0,slot=0
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
>>                 [Early implementation]
>> ---
>>   default-configs/ppc64-softmmu.mak |    1
>>   hw/mem/Kconfig                    |    2
>>   hw/ppc/spapr.c                    |  216 ++++++++++++++++++++++++++++++++++---
>>   hw/ppc/spapr_drc.c                |   18 +++
>>   hw/ppc/spapr_events.c             |    4 +
>>   include/hw/ppc/spapr.h            |   11 ++
>>   include/hw/ppc/spapr_drc.h        |    9 ++
>>   7 files changed, 245 insertions(+), 16 deletions(-)
>>
>> diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
>> index cca52665d9..ae0841fa3a 100644
>> --- a/default-configs/ppc64-softmmu.mak
>> +++ b/default-configs/ppc64-softmmu.mak
>> @@ -8,3 +8,4 @@ CONFIG_POWERNV=y
>>   
>>   # For pSeries
>>   CONFIG_PSERIES=y
>> +CONFIG_NVDIMM=y
>> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
>> index 620fd4cb59..2ad052a536 100644
>> --- a/hw/mem/Kconfig
>> +++ b/hw/mem/Kconfig
>> @@ -8,4 +8,4 @@ config MEM_DEVICE
>>   config NVDIMM
>>       bool
>>       default y
>> -    depends on PC
>> +    depends on (PC || PSERIES)
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index 3ae7db1563..921d8d7c8e 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -80,6 +80,8 @@
>>   #include "hw/ppc/spapr_cpu_core.h"
>>   #include "hw/mem/memory-device.h"
>>   #include "hw/ppc/spapr_tpm_proxy.h"
>> +#include "hw/mem/nvdimm.h"
>> +#include "qemu/nvdimm-utils.h"
>>   
>>   #include "monitor/monitor.h"
>>   
>> @@ -685,12 +687,22 @@ static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
>>               nr_entries++;
>>           }
>>   
>> -        /* Entry for DIMM */
>> -        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
>> -        g_assert(drc);
>> -        elem = spapr_get_drconf_cell(size / lmb_size, addr,
>> -                                     spapr_drc_index(drc), node,
>> -                                     SPAPR_LMB_FLAGS_ASSIGNED);
>> +        if (info->value->type == MEMORY_DEVICE_INFO_KIND_DIMM) {
>> +            /* Entry for DIMM */
>> +            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
>> +            g_assert(drc);
>> +            elem = spapr_get_drconf_cell(size / lmb_size, addr,
>> +                                         spapr_drc_index(drc), node,
>> +                                         SPAPR_LMB_FLAGS_ASSIGNED);
>> +        } else if (info->value->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
>> +            /*
>> +             * NVDIMM sits here, let the DIMM LMBs be unusable here in the
>> +             * whole range
>> +             */
>> +            elem = spapr_get_drconf_cell(size / lmb_size, addr, 0, -1,
>> +                                         SPAPR_LMB_FLAGS_RESERVED |
>> +                                         SPAPR_LMB_FLAGS_DRC_INVALID);
>> +        }
> As discussed in reply to an earlier thread, this whole scheme
> basically breaks down in the presence of hotplug - it relies on which
> GPAs are DIMMs and which are NVDIMMs not changing.
>
> Other than that significant problem, the rest of this looks
> reasonable.

As discussed, I verified not marking the NVDIMM occupied area as reserved,
and it seems to work fine. The malicious attempts to claim
the drcs on the those areas fail as there wont be a valid dimm devices
asscociated with those drcs.

Sending the next version fixing this part.


