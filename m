Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7v59-0003we-2U
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d7v55-0003T5-V1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:40:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d7v55-0003Ry-IO
	for qemu-devel@nongnu.org; Mon, 08 May 2017 22:40:55 -0400
References: <1493372840-24551-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1493372840-24551-6-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7bde3681-280c-764a-71df-f4a1cc4b7011@redhat.com>
	<4cc14276-55bc-2981-cbdd-4d66ae6be59e@cn.fujitsu.com>
	<fbb4b2b1-4af2-c948-406f-e63398f4c749@redhat.com>
	<d960c269-b68a-ffd9-5df1-b507eb4fe24d@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f80bed9a-598e-bb89-3a01-123bdc40e526@redhat.com>
Date: Tue, 9 May 2017 10:40:45 +0800
MIME-Version: 1.0
In-Reply-To: <d960c269-b68a-ffd9-5df1-b507eb4fe24d@cn.fujitsu.com>
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



On 2017=E5=B9=B405=E6=9C=8808=E6=97=A5 11:47, Zhang Chen wrote:
>
>
> On 05/03/2017 06:42 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8803=E6=97=A5 11:43, Zhang Chen wrote:
>>>
>>>
>>> On 05/02/2017 12:53 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B404=E6=9C=8828=E6=97=A5 17:47, Zhang Chen wrote:
>>>>> Address Jason Wang's comments add vnet header length to=20
>>>>> SocketReadState.
>>>>
>>>> Instead of saying this, you can add "Suggested-by: Jason Wang=20
>>>> <jasowang@redhat.com>" above your sign-off.
>>>
>>> OK.
>>>
>>>>
>>>>> So we change net_fill_rstate() to read
>>>>> struct  {int size; int vnet_hdr_len; const uint8_t buf[];}.
>>>>
>>>> This makes me thinking about the backward compatibility. I think=20
>>>> we'd better try to keep it as much as possible. E.g how about pack=20
>>>> vnet_hdr_len into higher bits of size?
>>>>
>>>
>>> Do you means split uint32_t size to uint16_t size and uint16_t=20
>>> vnet_hdr_len ?
>>> If yes, we also can't keep compatibility with old version.
>>> Old code send a uint32_t size, we read it as uint16_t size is always=20
>>> wrong.
>>>
>>> Thanks
>>> Zhang Chen
>>
>> Consider it's unlikely to send or receive packet >=3D 64K, we can reus=
e=20
>> higher bits (e.g highest 8 bits). Then we can still read uint32_t and=20
>> then check its highest 8 bits. If it was zero, we know vnet header is=20
>> zero, if not it could be read as vnet header length.
>
> I got your point, but in this way, packet size must < 64K, if size=20
> >=3D64K we still can't maintain the backward compatibility,
> For the packet sender that didn't know the potential packet size=20
> limit, I think we should make code explicitly declared like
> currently code. Otherwise we will make other people confused and make=20
> code difficult to maintain.
>
> Thanks
> Zhang Chen
>

Yes, this is an possible issue in the future. Rethink about this, what=20
if we just compare vnet header? Is there any issue of doing this?=20
(Sorry, I remember this is a reason, but forget now).

Thanks
