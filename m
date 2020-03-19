Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F961C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA122070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="js7IJV3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA122070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF0N6-0003ei-Ee
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 14:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jF0MT-0003Fy-B5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jF0MR-00014R-Hq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:57:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jF0MR-00013G-Ar
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:57:43 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e73c0430000>; Thu, 19 Mar 2020 11:56:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Thu, 19 Mar 2020 11:57:41 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Thu, 19 Mar 2020 11:57:41 -0700
Received: from [10.40.102.54] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 18:57:32 +0000
Subject: Re: [PATCH v14 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-5-git-send-email-kwankhede@nvidia.com>
 <20200318214500.1a0cb985@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <be22d111-123c-e1bb-a376-e66b10ebe55f@nvidia.com>
Date: Fri, 20 Mar 2020 00:27:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318214500.1a0cb985@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584644163; bh=vfV88Ij06FqO4WLmvlV/YCflIZKfz0v6Hvy6pULwZuo=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=js7IJV3SHXnODSgCqg8UiUybsPrToVSihTWkqALlgfltkrfbUtz38Z/Luc+B2LOtl
 nhj2unhILoPL8ylxCKt4T7/cx5xxsJ0TnqUJqulGfYgDHTVYXL/mfyYgBSaH53Bk9I
 Cf7KlYbENjlJ9u2xHnGlSxeNPEsjdykAAU3nX3gb7AeSQquxZnX05kRpuveFq5wNwo
 F09yhhuJ8Ld3bbCUe2qcdWdU7vN+D4FB8yVzKSHcv299nOZ9pbLcrHdYnMNg8joYWj
 AkS0OtxrQovgYRdbl9GrKOn9VyrfzoNEccn6WJAAFclQiKnffwv6rohXXxGCwoLcxt
 lO9MCHV7w473g==
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



On 3/19/2020 9:15 AM, Alex Williamson wrote:
> On Thu, 19 Mar 2020 01:11:11 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>=20
>> VFIO_IOMMU_DIRTY_PAGES ioctl performs three operations:
>> - Start dirty pages tracking while migration is active
>> - Stop dirty pages tracking.
>> - Get dirty pages bitmap. Its user space application's responsibility to
>>    copy content of dirty pages from source to destination during migrati=
on.
>>
>> To prevent DoS attack, memory for bitmap is allocated per vfio_dma
>> structure. Bitmap size is calculated considering smallest supported page
>> size. Bitmap is allocated for all vfio_dmas when dirty logging is enable=
d
>>
>> Bitmap is populated for already pinned pages when bitmap is allocated fo=
r
>> a vfio_dma with the smallest supported page size. Update bitmap from
>> pinning functions when tracking is enabled. When user application querie=
s
>> bitmap, check if requested page size is same as page size used to
>> populated bitmap. If it is equal, copy bitmap, but if not equal, return
>> error.
>>
>> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
>> Reviewed-by: Neo Jia <cjia@nvidia.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 205 ++++++++++++++++++++++++++++++++=
+++++++-
>>   1 file changed, 203 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_t=
ype1.c
>> index 70aeab921d0f..d6417fb02174 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -71,6 +71,7 @@ struct vfio_iommu {
>>   	unsigned int		dma_avail;
>>   	bool			v2;
>>   	bool			nesting;
>> +	bool			dirty_page_tracking;
>>   };
>>  =20
>>   struct vfio_domain {
>> @@ -91,6 +92,7 @@ struct vfio_dma {
>>   	bool			lock_cap;	/* capable(CAP_IPC_LOCK) */
>>   	struct task_struct	*task;
>>   	struct rb_root		pfn_list;	/* Ex-user pinned pfn list */
>> +	unsigned long		*bitmap;
>=20
> We've made the bitmap a width invariant u64 else, should be here as
> well.
>=20

Changing to u64 causes compile time warnings as below. Keeping 'unsigned=20
long *'

drivers/vfio/vfio_iommu_type1.c: In function =E2=80=98vfio_dma_bitmap_alloc=
_all=E2=80=99:
drivers/vfio/vfio_iommu_type1.c:232:8: warning: passing argument 1 of=20
=E2=80=98bitmap_set=E2=80=99 from incompatible pointer type [enabled by def=
ault]
         (vpfn->iova - dma->iova) / pgsize, 1);
         ^
In file included from ./include/linux/cpumask.h:12:0,
                  from ./arch/x86/include/asm/cpumask.h:5,
                  from ./arch/x86/include/asm/msr.h:11,
                  from ./arch/x86/include/asm/processor.h:22,
                  from ./arch/x86/include/asm/cpufeature.h:5,
                  from ./arch/x86/include/asm/thread_info.h:53,
                  from ./include/linux/thread_info.h:38,
                  from ./arch/x86/include/asm/preempt.h:7,
                  from ./include/linux/preempt.h:78,
                  from ./include/linux/spinlock.h:51,
                  from ./include/linux/seqlock.h:36,
                  from ./include/linux/time.h:6,
                  from ./include/linux/compat.h:10,
                  from drivers/vfio/vfio_iommu_type1.c:24:
./include/linux/bitmap.h:405:29: note: expected =E2=80=98long unsigned int =
*=E2=80=99=20
but argument is of type =E2=80=98u64 *=E2=80=99
  static __always_inline void bitmap_set(unsigned long *map, unsigned=20
int start,

Thanks,
Kirti

