Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE1AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1C920719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hUfGSDjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1C920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaLU-0005EL-KU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaKM-0003xW-QW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jHaKL-0002Ly-Fm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:14 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jHaKL-0002Jn-84
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:46:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e7d22930000>; Thu, 26 Mar 2020 14:45:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 26 Mar 2020 14:46:08 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 26 Mar 2020 14:46:08 -0700
Received: from [10.40.103.35] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 21:45:47 +0000
Subject: Re: [PATCH v16 Kernel 2/7] vfio iommu: Remove atomicity of ref_count
 of pinned pages
To: Cornelia Huck <cohuck@redhat.com>
References: <1585078359-20124-1-git-send-email-kwankhede@nvidia.com>
 <1585078359-20124-3-git-send-email-kwankhede@nvidia.com>
 <20200326114935.4e729fba.cohuck@redhat.com>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <257a0b2e-129d-f606-99b8-09a24dc9f648@nvidia.com>
Date: Fri, 27 Mar 2020 03:15:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326114935.4e729fba.cohuck@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1585259155; bh=dUDTJr9BkEIVgCIMHumoa3TnFE5OADEV1EFCEb6yiwY=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=hUfGSDjTb40vS+CFjtSoQaXk4qInEsw5DtPB+P7YRx6JTR+znWooqLzZ4lqQaWFkA
 1Q99IPVkDLh0pXBG4ePB80lOc7LxfObT7JtCcCr8ho8Bhpu4gCskj1dlTglgwWRVXj
 H1IvV2VhI9JI7FWuOkiXhDtPW6CzMj1VIbJ8HMG7kcW/ENkeq+7btRJOVj5WZWCJ3R
 sSw4N2YNkNiSIW2cWS5Fx5UUOVFUfjVxqh2JKF6qEdT4shaLV0VbnblHZ7R4+eHKU8
 zuULbXJ7k7KTZX08XDrL0QrdTj9EQ2ziEypVBm9lrEnglN83VHpB4FhpZ9QXoEtd8b
 kz4vi/9j3e6nQ==
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



On 3/26/2020 4:19 PM, Cornelia Huck wrote:
> On Wed, 25 Mar 2020 01:02:34 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> vfio_pfn.ref_count is always updated by holding iommu->lock, using atomic
> 
> s/by/while/
> 

Ok.

>> variable is overkill.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,
Kirti

