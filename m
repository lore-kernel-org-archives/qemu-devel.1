Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F21C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706B82074B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKt6z057"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706B82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIBCf-0006Y0-Hr
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBBB-0005e9-Q0; Tue, 15 Sep 2020 09:39:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1kIBB9-0003br-Os; Tue, 15 Sep 2020 09:39:29 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08FDV8mc012401; Tue, 15 Sep 2020 09:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5H5fdr6S7enjKHGlcngleBikSOE+EZB5qySSDWJEOm4=;
 b=QKt6z057lt0Nya3sic3igCD+1Ce5MoPitVkcJP3crW+DffXiVfolG7DMgU7VyARs3K63
 2tpW8fmM1+B8jBVxoZxK7qj7h/pxa6TQ6OokD2Y8ot4IT8thFOBkwAXETY/Q8NT/pYbo
 6S/4//aPOQTZe4NryFrfKsVM0Tad2UqWM68lVMk45n9RYMpzrbeVbl15j5c6RxZQWDiT
 PxxbETDrb6VYb3N/Tgcdy7hOlM0XEH9tSSugOF23yqsWC/XUUBV/H5CufJWiDLGIhWr8
 7YBVl5lrKZrs/vOCobCLz7dHWWZVNvBURc+cXsHbMQ1qeuHHY4TOZJHoHFT4L1YFmWp2 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jxjkr7my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 09:39:25 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08FDVL7Y013505;
 Tue, 15 Sep 2020 09:39:25 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33jxjkr7m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 09:39:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08FDVgE7030232;
 Tue, 15 Sep 2020 13:39:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma05wdc.us.ibm.com with ESMTP id 33gny8ypaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 13:39:23 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 08FDdII216581224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 13:39:19 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C636136051;
 Tue, 15 Sep 2020 13:39:22 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 730CD136053;
 Tue, 15 Sep 2020 13:39:21 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.163.85.51])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 15 Sep 2020 13:39:21 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] vfio: Find DMA available capability
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 alex.williamson@redhat.com, cohuck@redhat.com
References: <1600122570-12941-1-git-send-email-mjrosato@linux.ibm.com>
 <1600122570-12941-2-git-send-email-mjrosato@linux.ibm.com>
 <fbd1df4e-8d51-87c8-2b07-5b65666342d0@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <433aee24-84eb-527b-189e-f312054cb214@linux.ibm.com>
Date: Tue, 15 Sep 2020 09:39:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fbd1df4e-8d51-87c8-2b07-5b65666342d0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_08:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150109
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, schnelle@linux.ibm.com,
 david@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 2:14 AM, Philippe Mathieu-Daudé wrote:
> Hi Matthew,
> 
> On 9/15/20 12:29 AM, Matthew Rosato wrote:
>> The underlying host may be limiting the number of outstanding DMA
>> requests for type 1 IOMMU.  Add helper functions to check for the
>> DMA available capability and retrieve the current number of DMA
>> mappings allowed.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/vfio/common.c              | 37 +++++++++++++++++++++++++++++++++++++
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 3335714..7f4a338 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -844,6 +844,43 @@ vfio_get_region_info_cap(struct vfio_region_info *info, uint16_t id)
>>       return NULL;
>>   }
>>   
>> +static struct vfio_info_cap_header *
>> +vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
>> +{
>> +    struct vfio_info_cap_header *hdr;
>> +    void *ptr = info;
>> +
>> +    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
>> +        return NULL;
>> +    }
>> +
>> +    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
>> +        if (hdr->id == id) {
>> +            return hdr;
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>> +                             unsigned int *avail)
>> +{
>> +    struct vfio_info_cap_header *hdr;
>> +    struct vfio_iommu_type1_info_dma_avail *cap;
>> +
>> +    /* If the capability cannot be found, assume no DMA limiting */
>> +    hdr = vfio_get_iommu_type1_info_cap(info,
>> +                                        VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
>> +    if (hdr == NULL || avail == NULL) {
> 
> If you expect the caller to use avail=NULL, then why
> return false when there is available information?

I was not expecting the caller to use avail=NULL as there would be 
nowhere to stash the dma_avail count.  But you're right, we can at least 
still know that the capability is enabled/disabled when avail=NULL.

I can change this by returning true/false solely based upon the 
existence of the capability (whether or not hdr==NULL) while only 
updating the caller's *avail value when avail!=NULL.

If that's no good, then the alternative would be an assert()

> 
>> +        return false;
>> +    }
>> +
>> +    cap = (void *) hdr;
>> +    *avail = cap->avail;
>> +    return true;
>> +}
>> +
>>   static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>>                                             struct vfio_region_info *info)
>>   {
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c78f3ff..661a380 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -178,6 +178,8 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>>   void vfio_put_group(VFIOGroup *group);
>>   int vfio_get_device(VFIOGroup *group, const char *name,
>>                       VFIODevice *vbasedev, Error **errp);
>> +bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>> +                             unsigned int *avail);
>>   
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>>
> 


