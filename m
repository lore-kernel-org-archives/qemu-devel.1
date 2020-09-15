Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D9C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CAEA21D24
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZKndPyqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAEA21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBLe-00012W-28
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBFL-00016F-0Z; Tue, 15 Sep 2020 09:43:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8982
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBFI-0004As-Jr; Tue, 15 Sep 2020 09:43:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FDWK0o134981; Tue, 15 Sep 2020 09:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H7obk8BSKYBoaGCSJgeiKdRunw0D91xsXsXZkeRMM88=;
 b=ZKndPyqQS6QX+fgAFaCnn5/uvkY+5Oyf0eT2KRzQNCX5JTcudbMcX03aalJBC/Jr/YgY
 NRVGGmgbFxaF3hoxEiQj5TQ+VnxPwnhHT/TpTQ+qn4uox6W0yZNvq3/Rfj1F3dnUA6K0
 tC2NxMPLfEMWHEXH2KEeH61EdAgJ0ulpiwyH6q2dnEqlmKqYK4+Nrpc/iYdXdLH/mXo6
 miGvkFiyA3IqL6Ro8KNCr+Y3i0FrJX06dCZ7fwZYMvBKvshzO+U/kkIcIatVN/VnKLFo
 b5QsaikO0sB08HepYT6IfHpMbsMOG34z6JredAJ0RebG9Wr01POLJSLokkZWrM2yhDhU Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jwuya1qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 09:43:42 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FDX9HU138275;
 Tue, 15 Sep 2020 09:43:41 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33jwuya1q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 09:43:41 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FDgjrb003409;
 Tue, 15 Sep 2020 13:43:40 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma03dal.us.ibm.com with ESMTP id 33gny9dnmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 13:43:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FDhXhG37618076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 13:43:33 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38304136051;
 Tue, 15 Sep 2020 13:43:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3234A136053;
 Tue, 15 Sep 2020 13:43:38 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 13:43:38 +0000 (GMT)
Subject: Re: [PATCH v2 3/3] vfio: Create shared routine for scanning info
 capabilities
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.williamson@redhat.com, cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-4-git-send-email-mjrosato@linux.ibm.com>
 <942e216a-f431-9eb2-c20b-e3733615601e@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <e5835446-0aaa-70dd-ee50-9411451fa21f@linux.ibm.com>
Date: Tue, 15 Sep 2020 09:43:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <942e216a-f431-9eb2-c20b-e3733615601e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_08:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150109
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:43:42
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, schnelle@linux.ibm.com,
 david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 2:16 AM, Philippe Mathieu-Daudé wrote:
> On 9/15/20 12:29 AM, Matthew Rosato wrote:
>> Rather than duplicating the same loop in multiple locations,
>> create a static function to do the work.
> 
> Why not do that first in your series?
> 

Fair question.  I did originally do this collapsing first, but I wasn't 
sure if Alex would want it so I split it out and tacked it on the end so 
it could be dropped if desired.

I'd be just fine re-arranging and putting this patch first.

>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/vfio/common.c | 33 +++++++++++++++------------------
>>   1 file changed, 15 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 7f4a338..bfbbfe4 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -825,17 +825,12 @@ static void vfio_listener_release(VFIOContainer *container)
>>       }
>>   }
>>   
>> -struct vfio_info_cap_header *
>> -vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>> +static struct vfio_info_cap_header *
>> +vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id)
>>   {
>>       struct vfio_info_cap_header *hdr;
>> -    void *ptr = info;
>> -
>> -    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
>> -        return NULL;
>> -    }
>>   
>> -    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>> +    for (hdr = ptr + cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>>           if (hdr->id == id) {
>>               return hdr;
>>           }
>> @@ -844,23 +839,25 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>>       return NULL;
>>   }
>>   
>> +
>> +struct vfio_info_cap_header *
>> +vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>> +{
>> +    if (!(info->flags & VFIO_REGION_INFO_FLAG_CAPS)) {
>> +        return NULL;
>> +    }
>> +
>> +    return vfio_get_cap((void *)info, info->cap_offset, id);
>> +}
>> +
>>   static struct vfio_info_cap_header *
>>   vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
>>   {
>> -    struct vfio_info_cap_header *hdr;
>> -    void *ptr = info;
>> -
>>       if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
>>           return NULL;
>>       }
>>   
>> -    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>> -        if (hdr->id == id) {
>> -            return hdr;
>> -        }
>> -    }
>> -
>> -    return NULL;
>> +    return vfio_get_cap((void *)info, info->cap_offset, id);
>>   }
>>   
>>   bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>
> 


