Received: from eggs.gnu.org ([2001:4830:134:3::10]:59820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLgpx-0008Du-MQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dLgpt-0002YN-Cm
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dLgpt-0002VX-3e
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 22:18:09 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
	<28122598-b6b3-9eb6-b726-bd7c22735780@cn.fujitsu.com>
	<93409ed0-7dcb-a167-9438-f5f2b1f3bef5@redhat.com>
	<5eff3578-61ac-f41a-1cab-9cc6ef40d7db@cn.fujitsu.com>
	<2b200cad-ac3a-fa86-0fa4-cc4dc39b2e09@redhat.com>
	<e11c94c0-46d9-d711-2c69-15570a6a357f@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <28f7ea9d-0b46-3719-d99a-f436ace8e5a9@redhat.com>
Date: Fri, 16 Jun 2017 10:17:59 +0800
MIME-Version: 1.0
In-Reply-To: <e11c94c0-46d9-d711-2c69-15570a6a357f@cn.fujitsu.com>
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



On 2017=E5=B9=B406=E6=9C=8815=E6=97=A5 16:10, Zhang Chen wrote:
>
>
> On 06/15/2017 12:31 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B406=E6=9C=8814=E6=97=A5 16:04, Zhang Chen wrote:
>>>
>>>
>>> On 06/13/2017 05:14 PM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B406=E6=9C=8812=E6=97=A5 17:27, Zhang Chen wrote:
>>>>>>
>>>>>>> +        if (nf->direction =3D=3D NET_FILTER_DIRECTION_RX ||
>>>>>>> +            nf->direction =3D=3D NET_FILTER_DIRECTION_ALL) {
>>>>>>> +            vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
>>>>>>
>>>>>> This can only work if e.g virtio-net set its own vnet_hdr_len.=20
>>>>>> But looks like it use guest_hdr_len instead.
>>>>>
>>>>> I see in hw/net/virtio-net.c use the=20
>>>>> "qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);" to
>>>>> set the nf->netdev->vnet_hdr_len, any case not include here?=20
>>>>
>>>> You mean:
>>>>
>>>>         if (peer_has_vnet_hdr(n) &&
>>>>             qemu_has_vnet_hdr_len(nc->peer, n->guest_hdr_len)) {
>>>>             qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);
>>>>             n->host_hdr_len =3D n->guest_hdr_len;
>>>>         }
>>>>
>>>> ?
>>>>
>>>> From the code, it only set peer's vnet header when peer supports=20
>>>> vnet_hdr up to n->guest_hdr_len. If peer can't, virtio-net will=20
>>>> strip the header.
>>>
>>> So, We should get the n->guest_hdr_len in another way? like set a=20
>>> new parameter in NetClientState?
>>> Any suggestion about it?
>>>
>>> Thanks
>>> Zhang Chen
>>
>> Rethink about this, a question is do we really care guest vnet header=20
>> len? During guest transmission, when packet reaches netfilter. The=20
>> vnet_header should have been stripped to netdev->vnet_hdr_len.
>
> But we use filter-redirector send packet to colo-compare that get the=20
> packet with the vnet header.
>
> That is colo-compare see:
>
> 1241@1497507100.108799:colo_compare_pkt_info_src src/dst:=20
> 192.168.4.144 s: seq/ack=3D2181260317/2075177759 res=3D0 flags=3D18=20
> spkt_size: 95
>
> 1241@1497507100.108803:colo_compare_pkt_info_dst src/dst: 192.168.4.88=20
> d: seq/ack=3D2181260317/2075177759 res=3D0 flags=3D18 dpkt_size: 95
>
> colo-compare ppkt: 0000:  01 00 00 00  00 00 22 00  10 00 00 00 12 14=20
> fc 1d ......".........
> colo-compare ppkt: 0010:  1a 6b 52 54  00 12 34 56  08 00 45 00 00 45=20
> 12 61 .kRT..4V..E..E.a
> colo-compare ppkt: 0020:  40 00 40 06  9e 19 c0 a8  04 90 c0 a8 04 58=20
> 04 d2 @.@..........X..
> colo-compare ppkt: 0030:  ca 98 82 03  64 1d 7b b0  b3 1f 80 18 00 e3=20
> 8a 70 ....d.{........p
> colo-compare ppkt: 0040:  00 00 01 01  08 0a 00 00  5b fa 00 4d f1 aa=20
> 73 65 ........[..M..se
> colo-compare ppkt: 0050:  72 76 65 72  20 67 65 74  20 69 74 20 34 36=20
> 38    rver get it 468
> colo-compare spkt: 0000:  01 00 00 00  00 00 22 00  10 00 00 00 12 14=20
> fc 1d ......".........
> colo-compare spkt: 0010:  1a 6b 52 54  00 12 34 56  08 00 45 00 00 45=20
> 12 61 .kRT..4V..E..E.a
> colo-compare spkt: 0020:  40 00 40 06  9e 19 c0 a8  04 90 c0 a8 04 58=20
> 04 d2 @.@..........X..
> colo-compare spkt: 0030:  ca 98 82 03  64 1d 7b b0  b3 1f 80 18 00 e3=20
> 8a 70 ....d.{........p
> colo-compare spkt: 0040:  00 00 01 01  08 0a 00 00  5c 02 00 4d f1 aa=20
> 73 65 ........\..M..se
> colo-compare spkt: 0050:  72 76 65 72  20 67 65 74  20 69 74 20 34 36=20
> 38    rver get it 468
>
> So, colo-compare need to know the vnet_hdr_len for skip this field,=20
> then colo-compare
> can parse the net packet correctly.
> Back to this patch, how should I fix it?

Let me explain a little bit more. What I mean is that we should care=20
only about the vnet header len of netdev instead of guest.

On RX direction (guest transmission). If you look at=20
virtio_net_flush_tx(), before calling qemu_sendv_packet_async() where=20
the packet can reach netfilers, virtio-net will copy only the parts that=20
host is interested. So what we can see in e.g filter-mirror is netdev's=20
vnet_hdr_len which is not guaranteed to be equal to guest hdr len.

On TX direction, the packet will reach netfilter before it reaches=20
virtio-net backend, so the vnet header is also netdev's vnet_hdr_len.

Does this explain?

Thanks

>
> Thanks
> Zhang Chen
>
>
>>
>> I still think use nf->netdev->vnet_hdr_len is sufficient.
>>
>> Thanks
>>
>>>
>>>>
>>>> Thanks
>>>>
>>>>
>>>>
>>>
>>
>>
>>
>> .
>>
>
