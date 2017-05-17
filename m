Received: from eggs.gnu.org ([2001:4830:134:3::10]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAtDM-000121-9e
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAtDJ-0002vi-1b
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:17:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dAtDI-0002vT-OY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:17:40 -0400
References: <1494838260-30439-1-git-send-email-peterx@redhat.com>
	<9a93009b-f909-3142-5bc5-915b9a10ed20@redhat.com>
	<f69dcf32-b6a2-fb59-2b54-61fd7b52e66e@redhat.com>
	<20170517042342.GA9921@pxdev.xzpeter.org>
	<20170517055756.GA31206@pxdev.xzpeter.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <19720c24-aa9a-50e6-2ea1-32ee86ae3591@redhat.com>
Date: Wed, 17 May 2017 09:17:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170517055756.GA31206@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: address space translation
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>



On 05/17/2017 07:57 AM, Peter Xu wrote:
> On Wed, May 17, 2017 at 12:23:42PM +0800, Peter Xu wrote:
>> On Tue, May 16, 2017 at 06:51:03PM +0200, Maxime Coquelin wrote:
>>> Hi Peter,
>>>
>>> On 05/16/2017 03:24 PM, Maxime Coquelin wrote:
>>>>
>>>>
>>>> On 05/15/2017 10:50 AM, Peter Xu wrote:
>>>>> The problem is that, address_space_get_iotlb_entry() shares a lot with
>>>>> address_space_translate(). This patch tries to abstract the
>>>>> shared elements.
>>>>>
>>>>> Originally, this work is derived from discussion from VT-d passthrough
>>>>> series discussions [1]. But for sure we can just see this series as a
>>>>> standalone cleanup. So I posted it separately here.
>>>>>
>>>>> Smoke tests are done with general VM boots, IOs, especially with vhost
>>>>> dmar configurations.
>>>>>
>>>>> I believe with current series I can throw away the old patch [1],
>>>>> which may be good. But before that, please kindly review. Thanks.
>>>>
>>>> I faced the problem the old patch fixes when declaring and attaching an
>>>> IOMMU device, but booting the kernel with intel_iommu=off.
>>>>
>>>> I tested again with patches 1 & 4 of your series, and I confirm it fixes
>>>> the issue:
>>>> Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>
>>> I did some more testing with my "vhost-user IOMMU" setup, and the series
>>> actually breaks with IOMMU device attached, and intel_iommu=on.
>>>
>>> The main difference with the previous passing test is the guest RAM
>>> size. In the working setup, it is 2G of 2M hugepages, vs. 4G of 2M
>>> hugepages in the failing one. Note that I also reproduce with vhost-kernel
>>> backend.
>>>
>>> The error happens in the first vhost_device_iotlb_miss() call:
>>> qemu-system-x86_64: Fail to lookup the translated address b5d7c000
>>>
>>> I don't have the root cause yet, I'll keep you updated.
>>
>> Maxime,
>>
>> Thanks a lot for help testing this series!
>>
>> I reproduced this problem, and this is not a problem obvious enough
>> for me. Let me investigate as well.
>>
>> -- 
>> Peter Xu
> 
> Maxime,
> 
> Could you help try adding this change upon current to see whether
> problem solved?

Hi Peter,

Yes, problem is solved with below change.

Thanks!
Maxime

> diff --git a/exec.c b/exec.c
> index 697d902..68576a2 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -521,6 +521,10 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>           goto iotlb_fail;
>       }
>   
> +    /* Convert memory region offset into address space offset */
> +    xlat += section.offset_within_address_space -
> +        section.offset_within_region;
> +
>       if (plen == (hwaddr)-1) {
>           /*
>            * We use default page size here. Logically it only happens
> 
> Thanks in advance,
> 
