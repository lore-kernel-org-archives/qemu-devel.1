Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC74C2D0D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD9E24683
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aDdE9X7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD9E24683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0lz-0004l7-2L
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1ii0l6-00045v-MW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1ii0l4-000863-IM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:42:47 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2037)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1ii0l4-0007xB-7j
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:42:46 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dfbc4990000>; Thu, 19 Dec 2019 10:42:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 19 Dec 2019 10:42:44 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 19 Dec 2019 10:42:44 -0800
Received: from [10.40.100.125] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Dec
 2019 18:42:34 +0000
Subject: Re: [PATCH v10 Kernel 4/5] vfio iommu: Implementation of ioctl to for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1576527700-21805-1-git-send-email-kwankhede@nvidia.com>
 <1576527700-21805-5-git-send-email-kwankhede@nvidia.com>
 <20191217051513.GE21868@joy-OptiPlex-7040>
 <17ac4c3b-5f7c-0e52-2c2b-d847d4d4e3b1@nvidia.com>
 <20191218143902.3c9b06df@x1.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <6667e0b4-f3da-6283-3f27-c1cba3d13117@nvidia.com>
Date: Fri, 20 Dec 2019 00:12:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191218143902.3c9b06df@x1.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1576780954; bh=yc7GPjS2kHBED4VdPZXolDx+lH4rl8plLC7emiHQM9Y=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=aDdE9X7hlKg0NJn0sJaTZNo0MTuiG4d64RSe4TPiXRIALTAxP18ZR5cYNcoZHzzvn
 OtP6OzpMX0GqyYezSK1FGttePQ80pS8M8cnHw3BfPH5mxZ4sbjZhEECbOLzFOHbiye
 /se+vcJ3rvXPYqiTJSZMTER4gm/q6YSViRZYIhAtH5HDJmTQfkrokCY1vWmaz3KIXD
 XwpKSX6J4MnX3t9bYV6a4bk3TeNVyBRGqWA1C8MYMagB6a4axgFJsI2qQAtJ0c2krZ
 Lj55MC2S5oMhGFfPxDAFZAo2n+5nMjjeQ2B1G4784UBMfSC8BxLIPnqmyqiUIuUAoF
 tGRjvXrylk5Rw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Yan Zhao <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 12/19/2019 3:09 AM, Alex Williamson wrote:
> On Tue, 17 Dec 2019 14:54:14 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 12/17/2019 10:45 AM, Yan Zhao wrote:
>>> On Tue, Dec 17, 2019 at 04:21:39AM +0800, Kirti Wankhede wrote:
>>>> +		} else if (range.flags &
>>>> +				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
>>>> +			uint64_t iommu_pgmask;
>>>> +			unsigned long pgshift = __ffs(range.pgsize);
>>>> +			unsigned long *bitmap;
>>>> +			long bsize;
>>>> +
>>>> +			iommu_pgmask =
>>>> +			 ((uint64_t)1 << __ffs(vfio_pgsize_bitmap(iommu))) - 1;
>>>> +
>>>> +			if (((range.pgsize - 1) & iommu_pgmask) !=
>>>> +			    (range.pgsize - 1))
>>>> +				return -EINVAL;
>>>> +
>>>> +			if (range.iova & iommu_pgmask)
>>>> +				return -EINVAL;
>>>> +			if (!range.size || range.size > SIZE_MAX)
>>>> +				return -EINVAL;
>>>> +			if (range.iova + range.size < range.iova)
>>>> +				return -EINVAL;
>>>> +
>>>> +			bsize = verify_bitmap_size(range.size >> pgshift,
>>>> +						   range.bitmap_size);
>>>> +			if (bsize)
>>>> +				return ret;
>>>> +
>>>> +			bitmap = kmalloc(bsize, GFP_KERNEL);
>>>> +			if (!bitmap)
>>>> +				return -ENOMEM;
>>>> +
>>>> +			ret = copy_from_user(bitmap,
>>>> +			     (void __user *)range.bitmap, bsize) ? -EFAULT : 0;
>>>> +			if (ret)
>>>> +				goto bitmap_exit;
>>>> +
>>>> +			iommu->dirty_page_tracking = false;
>>> why iommu->dirty_page_tracking is false here?
>>> suppose this ioctl can be called several times.
>>>    
>>
>> This ioctl can be called several times, but once this ioctl is called
>> that means vCPUs are stopped and VFIO devices are stopped (i.e. in
>> stop-and-copy phase) and dirty pages bitmap are being queried by user.
> 
> Do not assume how userspace works or its intent.  If dirty tracking is
> on, it should remain on until the user turns it off.  We cannot assume
> userspace uses a one-shot approach.  Thanks,
> 

Dirty tracking should be on until user turns it off or user reads 
bitmap, right? This ioctl is used to read bitmap.


Thanks,
Kirti




