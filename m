Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2657207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="V9H/ib1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2657207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ0A-00021Z-Vv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbPzN-0000mW-9M
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:46:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1jbPzL-0002wk-8v
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:46:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ec542760001>; Wed, 20 May 2020 07:45:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 May 2020 07:46:29 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 May 2020 07:46:29 -0700
Received: from [10.40.103.233] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 May
 2020 14:46:21 +0000
Subject: Re: [PATCH Kernel v22 3/8] vfio iommu: Cache pgsize_bitmap in struct
 vfio_iommu
To: Cornelia Huck <cohuck@redhat.com>
References: <1589781397-28368-1-git-send-email-kwankhede@nvidia.com>
 <1589781397-28368-4-git-send-email-kwankhede@nvidia.com>
 <20200520120825.7d8144ba.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <b43ac210-56da-26ea-7235-0416c7b7ff84@nvidia.com>
Date: Wed, 20 May 2020 20:16:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520120825.7d8144ba.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1589985910; bh=FPbxFOmi6KNOFTvuFioGxQQrtp4OZVgphsmww96nZ8E=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=V9H/ib1Au1lVVa1VZ5Z0T34YbYRV9fAjEKGJSp1HKcefK8zmpgi8JyqstyjV/OABY
 CRFaMlP8PsvHpnDYtLkNcnBho6zjHsbzG5uaQKtvjkrpyl2+mdcojlzmGg3MtIY76G
 BADbAkU2APNe7Kcsu3s6Di8LDGN+9B+91eZwvO9+YXPsTr5aKBv6Vt4kzlPVzEmyQ0
 jLrtup9Xt8E+wIejSykJaPrlFJQa2iUKk3M+tzdIrWdEwt866lF06JtIRBxbINO8oU
 V01N4Of+xk8um+rvx2brsYmor7hYOdNV4+/ziFuyqFeLQQFrvT+pyj3UtT2X5JOjJb
 FBDYFMNtnMhmQ==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 09:40:22
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/20/2020 3:38 PM, Cornelia Huck wrote:
> On Mon, 18 May 2020 11:26:32 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> Calculate and cache pgsize_bitmap when iommu->domain_list is updated
>> and iommu->external_domain is set for mdev device.
>> Add iommu->lock protection when cached pgsize_bitmap is accessed.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 88 +++++++++++++++++++++++------------------
>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>
> 
> (...)
> 
>> @@ -805,15 +806,14 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>>   	iommu->dma_avail++;
>>   }
>>   
>> -static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
>> +static void vfio_pgsize_bitmap(struct vfio_iommu *iommu)
> 
> Minor nit: I'd have renamed this function to
> vfio_update_pgsize_bitmap().
> 

Done.

>>   {
>>   	struct vfio_domain *domain;
>> -	unsigned long bitmap = ULONG_MAX;
>>   
>> -	mutex_lock(&iommu->lock);
>> +	iommu->pgsize_bitmap = ULONG_MAX;
>> +
>>   	list_for_each_entry(domain, &iommu->domain_list, next)
>> -		bitmap &= domain->domain->pgsize_bitmap;
>> -	mutex_unlock(&iommu->lock);
>> +		iommu->pgsize_bitmap &= domain->domain->pgsize_bitmap;
>>   
>>   	/*
>>   	 * In case the IOMMU supports page sizes smaller than PAGE_SIZE
> 
> (...)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks.

Kirti

