Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E53BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C25222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C25222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUjl-0005Iw-1T
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iDUiE-0004Sa-PP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iDUiD-000806-K5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:25:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14476
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iDUiD-0007yG-GJ
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:25:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QENnaD029811
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:25:33 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8x0dkskt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:25:32 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 26 Sep 2019 15:25:31 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 26 Sep 2019 15:25:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QEPQ2v51773682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 14:25:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C2F011C04C;
 Thu, 26 Sep 2019 14:25:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B01EE11C04A;
 Thu, 26 Sep 2019 14:25:25 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.49])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 26 Sep 2019 14:25:25 +0000 (GMT)
Subject: Re: [PATCH] s390: PCI: fix IOMMU region init
To: Matthew Rosato <mjrosato@linux.ibm.com>, cohuck@redhat.com
References: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 26 Sep 2019 16:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19092614-0020-0000-0000-00000371FE6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092614-0021-0000-0000-000021C7CA77
Message-Id: <c2de2181-88ce-d4a6-bc2b-ce40e015a4b8@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260132
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: walling@linux.ibm.com, fiuczy@linux.ibm.com, david@redhat.com,
 stzi@linux.ibm.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, thuth@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yes, it is the right thing to do.

We will see if we one of these day can fix the address space size and 
get rid of the access to the lower memory.

The iommu region translation callback protect us from setting a 
translation outside of pba-pal, so that we should be safe.

reviewed-by: Pierre Morel <pmorel@linux.ibm.com>


On 9/26/19 4:10 PM, Matthew Rosato wrote:
> The fix in dbe9cf606c shrinks the IOMMU memory region to a size
> that seems reasonable on the surface, however is actually too
> small as it is based against a 0-mapped address space.  This
> causes breakage with small guests as they can overrun the IOMMU window.
>
> Let's go back to the prior method of initializing iommu for now.
>
> Fixes: dbe9cf606c ("s390x/pci: Set the iommu region size mpcifc request")
> Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Reported-by: Stefan Zimmerman <stzi@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 963a41c..2d2f4a7 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -695,10 +695,15 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
>   
>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>   {
> +    /*
> +     * The iommu region is initialized against a 0-mapped address space,
> +     * so the smallest IOMMU region we can define runs from 0 to the end
> +     * of the PCI address space.
> +     */
>       char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
>       memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
> -                             name, iommu->pal - iommu->pba + 1);
> +                             name, iommu->pal + 1);
>       iommu->enabled = true;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);

-- 
Pierre Morel
IBM Lab Boeblingen


