Received: from eggs.gnu.org ([2001:4830:134:3::10]:55163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMRd-00061e-1x
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLMRW-0005oh-Vl
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:31:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dLMRW-0005oZ-QF
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 00:31:38 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
	<28122598-b6b3-9eb6-b726-bd7c22735780@cn.fujitsu.com>
	<93409ed0-7dcb-a167-9438-f5f2b1f3bef5@redhat.com>
	<5eff3578-61ac-f41a-1cab-9cc6ef40d7db@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2b200cad-ac3a-fa86-0fa4-cc4dc39b2e09@redhat.com>
Date: Thu, 15 Jun 2017 12:31:30 +0800
MIME-Version: 1.0
In-Reply-To: <5eff3578-61ac-f41a-1cab-9cc6ef40d7db@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 02/10] net/filter-mirror.c: Make filter
 mirror support vnet support.
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



On 2017=E5=B9=B406=E6=9C=8814=E6=97=A5 16:04, Zhang Chen wrote:
>
>
> On 06/13/2017 05:14 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B406=E6=9C=8812=E6=97=A5 17:27, Zhang Chen wrote:
>>>>
>>>>> +        if (nf->direction =3D=3D NET_FILTER_DIRECTION_RX ||
>>>>> +            nf->direction =3D=3D NET_FILTER_DIRECTION_ALL) {
>>>>> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
>>>>
>>>> This can only work if e.g virtio-net set its own vnet_hdr_len. But=20
>>>> looks like it use guest_hdr_len instead.
>>>
>>> I see in hw/net/virtio-net.c use the=20
>>> "qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);" to
>>> set the nf->netdev->vnet_hdr_len, any case not include here?=20
>>
>> You mean:
>>
>>         if (peer_has_vnet_hdr(n) &&
>>             qemu_has_vnet_hdr_len(nc->peer, n->guest_hdr_len)) {
>>             qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);
>>             n->host_hdr_len =3D n->guest_hdr_len;
>>         }
>>
>> ?
>>
>> From the code, it only set peer's vnet header when peer supports=20
>> vnet_hdr up to n->guest_hdr_len. If peer can't, virtio-net will strip=20
>> the header.
>
> So, We should get the n->guest_hdr_len in another way? like set a new=20
> parameter in NetClientState?
> Any suggestion about it?
>
> Thanks
> Zhang Chen

Rethink about this, a question is do we really care guest vnet header=20
len? During guest transmission, when packet reaches netfilter. The=20
vnet_header should have been stripped to netdev->vnet_hdr_len.

I still think use nf->netdev->vnet_hdr_len is sufficient.

Thanks

>
>>
>> Thanks
>>
>>
>>
>
