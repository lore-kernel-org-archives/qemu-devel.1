Received: from eggs.gnu.org ([2001:4830:134:3::10]:56913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqDvD-0002Mf-3B
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqDv9-00017f-UN
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:09:35 -0400
Received: from [59.151.112.132] (port=5000 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqDv9-00015t-8m
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:09:31 -0400
References: <1489657928-14919-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<22303218-697c-7166-406b-050888efdfd5@redhat.com>
	<cc051a40-9142-9364-8bc8-de8ec453ebe2@cn.fujitsu.com>
	<8901e058-dcda-5c4a-e43a-38fca5814eb5@redhat.com>
	<ff751bdb-95bf-4c76-b782-d2bc47746c02@cn.fujitsu.com>
	<2875d736-61ae-b8f6-bb79-40aaddf3cb9b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <af721967-8c73-1747-1428-adc390732cd1@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 15:08:35 +0800
MIME-Version: 1.0
In-Reply-To: <2875d736-61ae-b8f6-bb79-40aaddf3cb9b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 03/21/2017 02:30 PM, Jason Wang wrote:
>
>
> On 2017年03月21日 14:16, Zhang Chen wrote:
>>
>>
>> On 03/21/2017 02:10 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年03月21日 13:47, Zhang Chen wrote:
>>>>
>>>>
>>>> On 03/21/2017 11:39 AM, Jason Wang wrote:
>>>>>
>>>>>
>>>>> On 2017年03月16日 17:52, Zhang Chen wrote:
>>>>>> If user use -device virtio-net-pci, virtio-net driver will add a 
>>>>>> header
>>>>>> to raw net packet that colo-proxy can't handle it. COLO-proxy just
>>>>>> focus on the packet payload, so we skip the virtio-net header to 
>>>>>> compare
>>>>>> the sent packet that primary guest's to secondary guest's.
>>>>>>
>>>>>>
>>>>>> Zhang Chen (3):
>>>>>>    COLO-proxy: Add virtio-net packet parse function
>>>>>>    COLO-proxy: Add a tag to mark virtio-net packet
>>>>>>    COLO-compare: Add virtio-net packet compare support
>>>>>>
>>>>>>   net/colo-compare.c    | 42 
>>>>>> +++++++++++++++++++++++++++++++++---------
>>>>>>   net/colo.c            | 14 ++++++++++----
>>>>>>   net/colo.h            |  7 ++++++-
>>>>>>   net/filter-rewriter.c | 15 ++++++++++-----
>>>>>>   4 files changed, 59 insertions(+), 19 deletions(-)
>>>>>>
>>>>>
>>>>> Hi:
>>>>>
>>>>> Git grep told us virtio-net is not the only user for vnet header. 
>>>>> E1000e and vmxnet3 uses it too.
>>>>>
>>>>> So we need solve them all instead of being virtio-net specific.
>>>>>
>>>>
>>>> Yes, In this series I just try to parse vnet header, if failed I 
>>>> will try to parse normal net packet.
>>>> So, I just focus on vnet header rather than virtio-net driver.
>>>> But the patch comments really make people confused , Should I fix 
>>>> all the comments send the V2 ?
>>>
>>> Yes, please. Beside this, instead of using fixed vnet header len 
>>> macro, you should query the backend for the length of vnet header.
>>
>> I want query the backend too, but colo-compare is not a netfilter 
>> means it no need attach any netdev.
>> How can we query the backend for the length of vnet header?
>
> Filters can know this, then how about let filters add the vnet header 
> length before the real packet and send it to colo-compare?
>

I don't know whether I understand your comments...
Do you means filter send a vnet header length firstly(independent length 
packet), then send the real packet?
If yes, I think it so expensive, in colo we use filter mirror or 
redirect packet between primary and secondary
that no need to know the vnet header length.
Or do you means add a fake vnet header to real packet in same one packet?
If yes, filter-mirror and filter-redirector must touch the packet do 
some job like colo-compare.
We initial design split colo-proxy to 4 modules have make filter-mirror 
and filter-redirector not to touch
the packet content, colo-compare and filter-rewriter do the packet data 
related job.
Or you have other way to tell colo-compare the length?

Thanks
Zhang Chen



> Thanks
>
>>
>> Thanks
>> Zhang Chen
>
>
>
> .
>

-- 
Thanks
Zhang Chen
