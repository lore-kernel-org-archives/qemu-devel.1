Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C18C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D238520714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gbO5Pwjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D238520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpLG-0005io-2M
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jGpKL-0004nt-Ur
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jGpKK-0007Le-SZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:35:05 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jGpKK-0007KO-MS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:35:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7a608c0000>; Tue, 24 Mar 2020 12:33:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 24 Mar 2020 12:35:03 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 24 Mar 2020 12:35:03 -0700
Received: from [10.40.103.72] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Mar
 2020 19:34:54 +0000
Subject: Re: [PATCH v15 Kernel 2/7] vfio iommu: Remove atomicity of ref_count
 of pinned pages
To: Auger Eric <eric.auger@redhat.com>, <alex.williamson@redhat.com>,
 <cjia@nvidia.com>
References: <1584649004-8285-1-git-send-email-kwankhede@nvidia.com>
 <1584649004-8285-3-git-send-email-kwankhede@nvidia.com>
 <b2e791ee-e55a-3142-119c-c2f4300fabd5@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <ae258072-89db-8c88-ad6a-8084781a0205@nvidia.com>
Date: Wed, 25 Mar 2020 01:04:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b2e791ee-e55a-3142-119c-c2f4300fabd5@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585078412; bh=40wVc0Yor8YTosJnEQ2TGgBM6wIvNiRWDsFVZ7Q/Fjg=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=gbO5PwjkX/gKB+EUSCsbtRqYcPexTnIjStcBsnRgvqlKBBhAReRViuGL9KGrip2k0
 alwsjRbBM3RM08beJomQv/L1sQqapeflSlKBP2U+VkH9scY8iV7pdV6urcQ4Go+bww
 MW62nZnfwjKBCykW750YUNfwjjAl3bVvAQvxYERWtHJhJzidFA2u49f4x/DRHET9sx
 Cb6MFYQRuZA+XurNLS8nB5k5kbhTNXqsADBAQ4nHW8jRIm24QmAKjYKmD7VUJsYDtb
 vdd5yOFWZSRBADJA/J85Z9VxOpuJ/6GHI4uaOEzp6BBGykCT7ekkE0uXNqYw3AsezB
 WmNRW9IEqjy8w==
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
 yan.y.zhao@intel.com, kvm@vger.kernel.org, eskultet@redhat.com,
 ziye.yang@intel.com, qemu-devel@nongnu.org, cohuck@redhat.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com,
 felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/24/2020 2:00 AM, Auger Eric wrote:
> Hi Kirti,
> 
> On 3/19/20 9:16 PM, Kirti Wankhede wrote:
>> vfio_pfn.ref_count is always updated by holding iommu->lock, using atomic
>> variable is overkill.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Thanks.

Kirti.

> Thanks
> 
> Eric
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 9fdfae1cb17a..70aeab921d0f 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -112,7 +112,7 @@ struct vfio_pfn {
>>   	struct rb_node		node;
>>   	dma_addr_t		iova;		/* Device address */
>>   	unsigned long		pfn;		/* Host pfn */
>> -	atomic_t		ref_count;
>> +	unsigned int		ref_count;
>>   };
>>   
>>   struct vfio_regions {
>> @@ -233,7 +233,7 @@ static int vfio_add_to_pfn_list(struct vfio_dma *dma, dma_addr_t iova,
>>   
>>   	vpfn->iova = iova;
>>   	vpfn->pfn = pfn;
>> -	atomic_set(&vpfn->ref_count, 1);
>> +	vpfn->ref_count = 1;
>>   	vfio_link_pfn(dma, vpfn);
>>   	return 0;
>>   }
>> @@ -251,7 +251,7 @@ static struct vfio_pfn *vfio_iova_get_vfio_pfn(struct vfio_dma *dma,
>>   	struct vfio_pfn *vpfn = vfio_find_vpfn(dma, iova);
>>   
>>   	if (vpfn)
>> -		atomic_inc(&vpfn->ref_count);
>> +		vpfn->ref_count++;
>>   	return vpfn;
>>   }
>>   
>> @@ -259,7 +259,8 @@ static int vfio_iova_put_vfio_pfn(struct vfio_dma *dma, struct vfio_pfn *vpfn)
>>   {
>>   	int ret = 0;
>>   
>> -	if (atomic_dec_and_test(&vpfn->ref_count)) {
>> +	vpfn->ref_count--;
>> +	if (!vpfn->ref_count) {
>>   		ret = put_pfn(vpfn->pfn, dma->prot);
>>   		vfio_remove_from_pfn_list(dma, vpfn);
>>   	}
>>
> 

