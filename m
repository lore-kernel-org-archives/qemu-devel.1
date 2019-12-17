Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8590C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E1A2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BZK2QEOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E1A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6bl-0007Z1-4e
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ih6PN-0008Mq-0q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ih6PL-0003ka-Ik
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:36 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ih6PL-0003b3-AB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:32:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5df876660000>; Mon, 16 Dec 2019 22:32:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 16 Dec 2019 22:32:33 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 16 Dec 2019 22:32:33 -0800
Received: from [10.40.102.133] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 06:32:22 +0000
Subject: Re: [PATCH v10 Kernel 2/5] vfio iommu: Adds flag to indicate dirty
 pages tracking capability support
To: Alex Williamson <alex.williamson@redhat.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-3-git-send-email-kwankhede@nvidia.com>
 <20191216161652.30681b05@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <c235ab32-0343-9ef9-a08b-ca46f6d59a99@nvidia.com>
Date: Tue, 17 Dec 2019 12:02:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191216161652.30681b05@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576564326; bh=A5QjnAkDzWKyT82IOaf5AQpyfjWRFLeindcNAQorwSU=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=BZK2QEOneDhLAWCupNOc+G//i2LMgl7QvFpqRHncVpFrFrEN3k5j5HX3BiJOUCKgn
 fwNZogb10y409UGrVsvzOQHa9F7saTZcifw5b3OvmGc2kQbimcorlomzwd+sSwZK0j
 JlNlN/lw3XzgRblxIvVSpN76Mc0ieWEoJMoERCwyGF9kglIu1yhQlocKhin/KM0Z47
 ZuHO75BbdVo56oPpe2S23bFegW9r2YdnkHWTT+68yg04re8++p+ApEtL8fJVfQFzSp
 pchjLfuftWqywqxlMpdFhc+QgvHY3SAwkcAtJtehIwklc4kQGWGvsk7rphf7KqOG3O
 f1rEXhQqGNlGw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.143
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/17/2019 4:46 AM, Alex Williamson wrote:
> On Tue, 17 Dec 2019 01:51:37 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Flag VFIO_IOMMU_INFO_DIRTY_PGS in VFIO_IOMMU_GET_INFO indicates that driver
>> support dirty pages tracking.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 3 ++-
>>   include/uapi/linux/vfio.h       | 5 +++--
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 2ada8e6cdb88..3f6b04f2334f 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -2234,7 +2234,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>   			info.cap_offset = 0; /* output, no-recopy necessary */
>>   		}
>>   
>> -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
>> +		info.flags = VFIO_IOMMU_INFO_PGSIZES |
>> +			     VFIO_IOMMU_INFO_DIRTY_PGS;
> 
> Type1 shouldn't advertise it until it's supported though, right?
> Thanks,
> 

Should this be merged with last patch where VFIO_IOMMU_UNMAP_DMA ioctl 
is updated?

Thanks,
Kirti

> Alex
> 
>>   
>>   		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
>>   
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index a0817ba267c1..81847ed54eb7 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -900,8 +900,9 @@ struct vfio_device_ioeventfd {
>>   struct vfio_iommu_type1_info {
>>   	__u32	argsz;
>>   	__u32	flags;
>> -#define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
>> -#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
>> +#define VFIO_IOMMU_INFO_PGSIZES   (1 << 0) /* supported page sizes info */
>> +#define VFIO_IOMMU_INFO_CAPS      (1 << 1) /* Info supports caps */
>> +#define VFIO_IOMMU_INFO_DIRTY_PGS (1 << 2) /* supports dirty page tracking */
>>   	__u64	iova_pgsizes;	/* Bitmap of supported page sizes */
>>   	__u32   cap_offset;	/* Offset within info struct of first cap */
>>   };
> 

