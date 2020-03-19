Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B0BC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9EF20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ceHPQzEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9EF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42631 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF1kJ-0003tw-5V
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1jF1jN-0003Cv-Tw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1jF1jK-0000Td-U6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:25:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1jF1jJ-0000GG-50
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:25:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e73d5260000>; Thu, 19 Mar 2020 13:25:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 19 Mar 2020 13:25:23 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 19 Mar 2020 13:25:23 -0700
Received: from [10.40.102.54] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 20:25:14 +0000
Subject: Re: [PATCH v14 Kernel 4/7] vfio iommu: Implementation of ioctl for
 dirty pages tracking.
To: Alex Williamson <alex.williamson@redhat.com>
References: <1584560474-19946-1-git-send-email-kwankhede@nvidia.com>
 <1584560474-19946-5-git-send-email-kwankhede@nvidia.com>
 <20200318214500.1a0cb985@w520.home>
 <e0070cf4-af58-2906-b427-0888ecb89538@nvidia.com>
 <20200319102238.77686a08@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <8e537411-b60e-cc45-498c-5e516382206e@nvidia.com>
Date: Fri, 20 Mar 2020 01:55:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319102238.77686a08@w520.home>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584649510; bh=x7i8QtLfAseF52v4fyGyBaaNiiKUfP8Yw3d6ILWuXNA=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ceHPQzEf0GB16z5/jaC/mJzemnbL0F6IBcSzY2P/hXjR7AhKY3HAJ/Vju57U7NIqR
 +F0DLxcSASh5BHLKrbj/tr9N5WunMK9/7Ey3SfW7WeAF0RmEz09eLEZPXdkhQIrRkP
 iOZ+pjJvn0WPjWSt+SC1J4thsZNFSA5iPXWe+/DiSU9d32zBJ0iB3EdTXraFObvibN
 bSGqMMHxGtSlTniJaQG8ce6/L0BSPJ6v2U3wyxI953gC2Dr/ixaqGwdPKpLiheY0d3
 n6jYRDRwxwI66ED4vj7jeS0EhzJdTqXl0slf9wS5Gd/If1XkrH/arjaQEpj/nGVJfB
 qv+X9SPuunQ8A==
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



On 3/19/2020 9:52 PM, Alex Williamson wrote:
> On Thu, 19 Mar 2020 20:22:41 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 3/19/2020 9:15 AM, Alex Williamson wrote:
>>> On Thu, 19 Mar 2020 01:11:11 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>    

<snip>

>>>> +
>>>> +static int verify_bitmap_size(uint64_t npages, uint64_t bitmap_size)
>>>> +{
>>>> +	uint64_t bsize;
>>>> +
>>>> +	if (!npages || !bitmap_size || bitmap_size > UINT_MAX)
>>>
>>> As commented previously, how do we derive this UINT_MAX limitation?
>>>    
>>
>> Sorry, I missed that earlier
>>
>>   > UINT_MAX seems arbitrary, is this specified in our API?  The size of a
>>   > vfio_dma is limited to what the user is able to pin, and therefore
>>   > their locked memory limit, but do we have an explicit limit elsewhere
>>   > that results in this limit here.  I think a 4GB bitmap would track
>>   > something like 2^47 bytes of memory, that's pretty excessive, but still
>>   > an arbitrary limit.
>>
>> There has to be some upper limit check. In core KVM, in
>> virt/kvm/kvm_main.c there is max number of pages check:
>>
>> if (new.npages > KVM_MEM_MAX_NR_PAGES)
>>
>> Where
>> /*
>>    * Some of the bitops functions do not support too long bitmaps.
>>    * This number must be determined not to exceed such limits.
>>    */
>> #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
>>
>> Though I don't know which bitops functions do not support long bitmaps.
>>
>> Something similar as above can be done or same as you also mentioned of
>> 4GB bitmap limit? that is U32_MAX instead of UINT_MAX?
> 
> Let's see, we use bitmap_set():
> 
> void bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
> 
> So we're limited to an unsigned int number of bits, but for an
> unaligned, multi-bit operation this will call __bitmap_set():
> 
> void __bitmap_set(unsigned long *map, unsigned int start, int len)
> 
> So we're down to a signed int number of bits (seems like an API bug in
> bitops there), so it makes sense that KVM is testing against MAX_INT
> number of pages, ie. number of bits.  But that still suggests a bitmap
> size of MAX_UINT is off by a factor of 16.  So we can have 2^31 bits
> divided by 2^3 bits/byte yields a maximum bitmap size of 2^28 (ie.
> 256MB), which maps 2^31 * 2^12 = 2^43 (8TB) on a 4K system.
> 
> Let's fix the limit check and put a nice comment explaining it.  Thanks,
> 

Agreed. Adding DIRTY_BITMAP_SIZE_MAX macro and comment as below.

/*
  * Input argument of number of bits to bitmap_set() is unsigned 
integer, which
  * further casts to signed integer for unaligned multi-bit operation,
  * __bitmap_set().
  * Then maximum bitmap size supported is 2^31 bits divided by 2^3 
bits/byte,
  * that is 2^28 (256 MB) which maps to 2^31 * 2^12 = 2^43 (8TB) on 4K page
  * system.
  */
#define DIRTY_BITMAP_PAGES_MAX  ((1UL << 31) - 1)
#define DIRTY_BITMAP_SIZE_MAX 	\
			DIRTY_BITMAP_BYTES(DIRTY_BITMAP_PAGES_MAX)


Thanks,
Kirti

