Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGQoF-000575-Ds
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGQoC-00048v-7N
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:43 -0400
Received: from [59.151.112.132] (port=65475 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dGQoB-00047t-Rs
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:10:40 -0400
References: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1495549241-23380-7-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<9f0e7f5e-7da7-4d78-95d9-be544b1bd28e@redhat.com>
	<b4ad4d4a-a469-edff-ed98-06cb7d4ecc8f@cn.fujitsu.com>
	<9de12794-ee9d-4874-b6c0-c8902cbc09c7@redhat.com>
	<88049ac0-921b-303c-321d-d5e373b8d2d3@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <fab47db5-cabb-2af0-3934-22cdba98d0e8@cn.fujitsu.com>
Date: Thu, 1 Jun 2017 22:11:17 +0800
MIME-Version: 1.0
In-Reply-To: <88049ac0-921b-303c-321d-d5e373b8d2d3@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V5 6/9] net/colo-compare.c: Make
 colo-compare support vnet_hdr_len
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, bian naimeng <biannm@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>


On 05/26/2017 01:36 PM, Jason Wang wrote:
>
>
> On 2017年05月26日 13:35, Jason Wang wrote:
>>
>>
>> On 2017年05月25日 21:18, Zhang Chen wrote:
>>>>> @@ -472,7 +474,10 @@ static void colo_compare_connection(void 
>>>>> *opaque, void *user_data)
>>>>>           }
>>>>>             if (result) {
>>>>> -            ret = compare_chr_send(&s->chr_out, pkt->data, 
>>>>> pkt->size);
>>>>> +            ret = compare_chr_send(s,
>>>>> +                                   pkt->data,
>>>>> +                                   pkt->size,
>>>>> +                                   pkt->vnet_hdr_len);
>>>>
>>>> Why not check vnet_hdr support here?  And don't we need strip 
>>>> vnet_hdr here? (Since the redirector on destination does not do this)
>>>
>>> If we create a normal qemu guest that use virtio-net-pci driver, the 
>>> guest's send packet have the vnet_hdr,
>>> qemu virtio-net-pci driver will strip vnet_hdr then send to external 
>>> network. In COLO we just redirect
>>> or mirror the packet, finally the packet will back to primary qemu 
>>> virtio-net-pci driver, So we just send
>>> the packet.
>>>
>>> Thanks
>>> Zhang Chen 
>>
>> But you send vnet_hdr_len unconditionally, which mean colo-compare 
>> can not work for redirector with vnet_hdr off now?

No, we input vnet_hdr_len unconditionally but in compare_chr_send() use 
s->vnet_hdr to
decide whether send the vnet_hdr_len field. so colo-compare can work for 
all redirector.

>>
>> Thanks
>>
>
> Btw, you may consider to update the COLO example in docs for the case 
> that needs vnet hdr.

Yes, thanks to remind me.
I will add it in next version.

Thanks
Zhang Chen


>
> Thanks
>
>
>
> .
>

-- 
Thanks
Zhang Chen
