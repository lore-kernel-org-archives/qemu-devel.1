Received: from eggs.gnu.org ([2001:4830:134:3::10]:36879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7zhT-0007cF-VU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7zhO-00052B-5l
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:36:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d7zhN-00051t-TT
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:36:46 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7bde3681-280c-764a-71df-f4a1cc4b7011@redhat.com>
	<4cc14276-55bc-2981-cbdd-4d66ae6be59e@cn.fujitsu.com>
	<fbb4b2b1-4af2-c948-406f-e63398f4c749@redhat.com>
	<d960c269-b68a-ffd9-5df1-b507eb4fe24d@cn.fujitsu.com>
	<f80bed9a-598e-bb89-3a01-123bdc40e526@redhat.com>
	<09077119-d9bb-c367-799a-a0718664cdc7@cn.fujitsu.com>
	<97099db3-169d-178c-01ab-73194167677a@redhat.com>
	<9fd0649c-caa0-9c4c-adf0-276a0ec6801f@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a94323f-89cd-586d-3ba6-5360ec26a96e@redhat.com>
Date: Tue, 9 May 2017 15:36:35 +0800
MIME-Version: 1.0
In-Reply-To: <9fd0649c-caa0-9c4c-adf0-276a0ec6801f@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 05/10] net/net.c: Add vnet header length
 to SocketReadState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8809=E6=97=A5 14:59, Zhang Chen wrote:
>
>
> On 05/09/2017 01:36 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8809=E6=97=A5 12:03, Zhang Chen wrote:
>>>
>>>
>>> On 05/09/2017 10:40 AM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B405=E6=9C=8808=E6=97=A5 11:47, Zhang Chen wrote:
>>>>>
>>>>>
>>>>> On 05/03/2017 06:42 PM, Jason Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2017=E5=B9=B405=E6=9C=8803=E6=97=A5 11:43, Zhang Chen wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 05/02/2017 12:53 PM, Jason Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2017=E5=B9=B404=E6=9C=8828=E6=97=A5 17:47, Zhang Chen wrote:
>>>>>>>>> Address Jason Wang's comments add vnet header length to=20
>>>>>>>>> SocketReadState.
>>>>>>>>
>>>>>>>> Instead of saying this, you can add "Suggested-by: Jason Wang=20
>>>>>>>> <jasowang@redhat.com>" above your sign-off.
>>>>>>>
>>>>>>> OK.
>>>>>>>
>>>>>>>>
>>>>>>>>> So we change net_fill_rstate() to read
>>>>>>>>> struct  {int size; int vnet_hdr_len; const uint8_t buf[];}.
>>>>>>>>
>>>>>>>> This makes me thinking about the backward compatibility. I=20
>>>>>>>> think we'd better try to keep it as much as possible. E.g how=20
>>>>>>>> about pack vnet_hdr_len into higher bits of size?
>>>>>>>>
>>>>>>>
>>>>>>> Do you means split uint32_t size to uint16_t size and uint16_t=20
>>>>>>> vnet_hdr_len ?
>>>>>>> If yes, we also can't keep compatibility with old version.
>>>>>>> Old code send a uint32_t size, we read it as uint16_t size is=20
>>>>>>> always wrong.
>>>>>>>
>>>>>>> Thanks
>>>>>>> Zhang Chen
>>>>>>
>>>>>> Consider it's unlikely to send or receive packet >=3D 64K, we can=20
>>>>>> reuse higher bits (e.g highest 8 bits). Then we can still read=20
>>>>>> uint32_t and then check its highest 8 bits. If it was zero, we=20
>>>>>> know vnet header is zero, if not it could be read as vnet header=20
>>>>>> length.
>>>>>
>>>>> I got your point, but in this way, packet size must < 64K, if size=20
>>>>> >=3D64K we still can't maintain the backward compatibility,
>>>>> For the packet sender that didn't know the potential packet size=20
>>>>> limit, I think we should make code explicitly declared like
>>>>> currently code. Otherwise we will make other people confused and=20
>>>>> make code difficult to maintain.
>>>>>
>>>>> Thanks
>>>>> Zhang Chen
>>>>>
>>>>
>>>> Yes, this is an possible issue in the future. Rethink about this,=20
>>>> what if we just compare vnet header? Is there any issue of doing=20
>>>> this? (Sorry, I remember this is a reason, but forget now).
>>>
>>> Yes, we can compare all packet with vnet header, the compare=20
>>> performance is very low. but we can't parse raw packet to=20
>>> tcp/udp/icmp packet, because we didn't know the vnet_hdr_len as the=20
>>> offset.
>>>
>>> Thanks
>>> Zhang Chen
>>
>> Aha, so I think it's time to use the new format but:
>>
>> - probably need a new option to enable this support for filter
>
> Do you means we should add the new option for every filter object like=20
> that:
> Now:
> -object filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0
> Feature:
> -object=20
> filter-mirror,id=3Dm0,netdev=3Dhn0,queue=3Dtx,outdev=3Dmirror0,has_vnet=
_hdr_len=3Don
>
> And colo-compare also need this option to get the vnet_hdr_len.

Yes, and you can use make it short like "vnet_hdr".

>
>
>> - let's don't touch socket backend, and make it still can work with=20
>> filters whose vnet_hder is off
>
> OK, Maybe we can add a new variable in net_fill_rstate().

Right.

Thanks

>
> Thanks
> Zhang Chen
>
>>
>> Thanks
>>
>>>
>>>>
>>>> Thanks
>>>>
>>>>
>>>> .
>>>>
>>>
>>
>>
>>
>> .
>>
>
