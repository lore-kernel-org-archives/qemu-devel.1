Received: from eggs.gnu.org ([2001:4830:134:3::10]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dLPqV-0005Fj-1h
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dLPqR-0007dR-2P
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:09:39 -0400
Received: from [59.151.112.132] (port=62181 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dLPqQ-0007cy-2q
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 04:09:35 -0400
References: <1496829322-17099-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1496829322-17099-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<4d998686-136d-1b6d-a641-9332930dcc93@redhat.com>
	<28122598-b6b3-9eb6-b726-bd7c22735780@cn.fujitsu.com>
	<93409ed0-7dcb-a167-9438-f5f2b1f3bef5@redhat.com>
	<5eff3578-61ac-f41a-1cab-9cc6ef40d7db@cn.fujitsu.com>
	<2b200cad-ac3a-fa86-0fa4-cc4dc39b2e09@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e11c94c0-46d9-d711-2c69-15570a6a357f@cn.fujitsu.com>
Date: Thu, 15 Jun 2017 16:10:48 +0800
MIME-Version: 1.0
In-Reply-To: <2b200cad-ac3a-fa86-0fa4-cc4dc39b2e09@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>



On 06/15/2017 12:31 PM, Jason Wang wrote:
>
>
> On 2017年06月14日 16:04, Zhang Chen wrote:
>>
>>
>> On 06/13/2017 05:14 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年06月12日 17:27, Zhang Chen wrote:
>>>>>
>>>>>> +        if (nf->direction == NET_FILTER_DIRECTION_RX ||
>>>>>> +            nf->direction == NET_FILTER_DIRECTION_ALL) {
>>>>>> +            vnet_hdr_len = nf->netdev->vnet_hdr_len;
>>>>>
>>>>> This can only work if e.g virtio-net set its own vnet_hdr_len. But 
>>>>> looks like it use guest_hdr_len instead.
>>>>
>>>> I see in hw/net/virtio-net.c use the 
>>>> "qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);" to
>>>> set the nf->netdev->vnet_hdr_len, any case not include here? 
>>>
>>> You mean:
>>>
>>>         if (peer_has_vnet_hdr(n) &&
>>>             qemu_has_vnet_hdr_len(nc->peer, n->guest_hdr_len)) {
>>>             qemu_set_vnet_hdr_len(nc->peer, n->guest_hdr_len);
>>>             n->host_hdr_len = n->guest_hdr_len;
>>>         }
>>>
>>> ?
>>>
>>> From the code, it only set peer's vnet header when peer supports 
>>> vnet_hdr up to n->guest_hdr_len. If peer can't, virtio-net will 
>>> strip the header.
>>
>> So, We should get the n->guest_hdr_len in another way? like set a new 
>> parameter in NetClientState?
>> Any suggestion about it?
>>
>> Thanks
>> Zhang Chen
>
> Rethink about this, a question is do we really care guest vnet header 
> len? During guest transmission, when packet reaches netfilter. The 
> vnet_header should have been stripped to netdev->vnet_hdr_len.

But we use filter-redirector send packet to colo-compare that get the 
packet with the vnet header.

That is colo-compare see:

1241@1497507100.108799:colo_compare_pkt_info_src src/dst: 192.168.4.144 
s: seq/ack=2181260317/2075177759 res=0 flags=18 spkt_size: 95

1241@1497507100.108803:colo_compare_pkt_info_dst src/dst: 192.168.4.88 
d: seq/ack=2181260317/2075177759 res=0 flags=18 dpkt_size: 95

colo-compare ppkt: 0000:  01 00 00 00  00 00 22 00  10 00 00 00  12 14 
fc 1d ......".........
colo-compare ppkt: 0010:  1a 6b 52 54  00 12 34 56  08 00 45 00  00 45 
12 61 .kRT..4V..E..E.a
colo-compare ppkt: 0020:  40 00 40 06  9e 19 c0 a8  04 90 c0 a8  04 58 
04 d2 @.@..........X..
colo-compare ppkt: 0030:  ca 98 82 03  64 1d 7b b0  b3 1f 80 18  00 e3 
8a 70 ....d.{........p
colo-compare ppkt: 0040:  00 00 01 01  08 0a 00 00  5b fa 00 4d  f1 aa 
73 65 ........[..M..se
colo-compare ppkt: 0050:  72 76 65 72  20 67 65 74  20 69 74 20  34 36 
38    rver get it 468
colo-compare spkt: 0000:  01 00 00 00  00 00 22 00  10 00 00 00  12 14 
fc 1d ......".........
colo-compare spkt: 0010:  1a 6b 52 54  00 12 34 56  08 00 45 00  00 45 
12 61 .kRT..4V..E..E.a
colo-compare spkt: 0020:  40 00 40 06  9e 19 c0 a8  04 90 c0 a8  04 58 
04 d2 @.@..........X..
colo-compare spkt: 0030:  ca 98 82 03  64 1d 7b b0  b3 1f 80 18  00 e3 
8a 70 ....d.{........p
colo-compare spkt: 0040:  00 00 01 01  08 0a 00 00  5c 02 00 4d  f1 aa 
73 65 ........\..M..se
colo-compare spkt: 0050:  72 76 65 72  20 67 65 74  20 69 74 20  34 36 
38    rver get it 468

So, colo-compare need to know the vnet_hdr_len for skip this field, then 
colo-compare
can parse the net packet correctly.
Back to this patch, how should I fix it?

Thanks
Zhang Chen


>
> I still think use nf->netdev->vnet_hdr_len is sufficient.
>
> Thanks
>
>>
>>>
>>> Thanks
>>>
>>>
>>>
>>
>
>
>
> .
>

-- 
Thanks
Zhang Chen
