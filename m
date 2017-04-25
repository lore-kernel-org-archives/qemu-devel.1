Received: from eggs.gnu.org ([2001:4830:134:3::10]:37251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2tmn-0006Qg-6h
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2tmi-00013N-5Z
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:17:17 -0400
Received: from [59.151.112.132] (port=5103 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d2tmh-00011d-8L
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:17:12 -0400
References: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<2010f24d-1ad0-4bab-bcd5-5e98fe21578a@redhat.com>
	<c4d3b3af-2d16-0647-9375-e6646520e027@cn.fujitsu.com>
	<2e132a33-18ea-455c-31ac-0b7fd7a54214@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ea22d757-efc5-205f-6df7-9251999e76e9@cn.fujitsu.com>
Date: Tue, 25 Apr 2017 14:17:36 +0800
MIME-Version: 1.0
In-Reply-To: <2e132a33-18ea-455c-31ac-0b7fd7a54214@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2 0/6] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 04/25/2017 11:54 AM, Jason Wang wrote:
>
>
> On 2017年04月24日 20:02, Zhang Chen wrote:
>>
>>
>> On 04/24/2017 11:48 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017年04月20日 14:39, Zhang Chen wrote:
>>>> If user use -device virtio-net-pci, virtio-net driver will add a 
>>>> header
>>>> to raw net packet that colo-proxy can't handle it. COLO-proxy just
>>>> focus on the packet payload, so we skip the virtio-net header to 
>>>> compare
>>>> the sent packet that primary guest's to secondary guest's.
>>>>
>>>> Zhang Chen (6):
>>>>    net/filter-mirror.c: Add filter-mirror and filter-redirector vnet
>>>>      support.
>>>>    net/net.c: Add vnet header length to SocketReadState
>>>>    net/colo-compare.c: Make colo-compare support vnet_hdr_len
>>>>    net/socket.c: Add vnet packet support in net_socket_receive()
>>>>    net/colo.c: Add vnet packet parse feature in colo-proxy
>>>>    net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
>>>>
>>>>   include/net/net.h     |  4 +++-
>>>>   net/colo-compare.c    | 48 
>>>> +++++++++++++++++++++++++++++++++++++++---------
>>>>   net/colo.c            |  9 +++++----
>>>>   net/colo.h            |  4 +++-
>>>>   net/filter-mirror.c   | 25 ++++++++++++++++++++-----
>>>>   net/filter-rewriter.c |  2 +-
>>>>   net/net.c             | 24 ++++++++++++++++++++++--
>>>>   net/socket.c          |  6 ++++++
>>>>   8 files changed, 99 insertions(+), 23 deletions(-)
>>>>
>>>
>>> A quick glance at the series and find two issues:
>>>
>>> - We can't assume virtio-net is the only user for vnet header, you 
>>> need query e.g NetClientState for a correct vnet header len.
>>
>> I don't know whether I understand your means.
>> I found that I can't get vnet_hdr_len from NetClientState,
>>
>> typedef struct NetClientInfo {
>> .....
>>     HasVnetHdr *has_vnet_hdr;
>>     HasVnetHdrLen *has_vnet_hdr_len;
>>     UsingVnetHdr *using_vnet_hdr;
>>     SetOffload *set_offload;
>>     SetVnetHdrLen *set_vnet_hdr_len;
>>
>> .....
>> }NetClientInfo;
>>
>> This struct haven't a function like get_vnet_hdr_len.
>> Should I add the get_vnet_hdr_len callback here and write new 
>> function in tap.c,tap-wen32.c and netmap.c ?
>>
>> Thanks
>> Zhang Chen
>
> Yes, you need add such callbacks I think.
>

OK, I got your point~

Thanks
Zhang Chen

> Thanks
>
>>
>>> - This series breaks qtest:
>>>
>>> **
>>> ERROR:tests/e1000e-test.c:296:e1000e_send_verify: assertion failed 
>>> (buffer == "TEST"): ("" == "TEST")
>>> GTester: last random seed: R02S39dd06f7f52013798111df2e4eb602c5
>>> **
>>> ERROR:tests/e1000e-test.c:365:e1000e_receive_verify: assertion 
>>> failed (le32_to_cpu(descr.wb.upper.status_error) & esta_dd == 
>>> esta_dd): (0x00000000 == 0x00000001)
>>> GTester: last random seed: R02S8c8200b8ec86358cb7addb5c6fe1303c
>>> **
>>> ERROR:tests/e1000e-test.c:296:e1000e_send_verify: assertion failed 
>>> (buffer == "TEST"): ("" == "TEST")
>>> GTester: last random seed: R02S9be86025aa7ded4902bdf644c3964a6e
>>> **
>>> ERROR:tests/libqos/virtio.c:94:qvirtio_wait_queue_isr: assertion 
>>> failed: (g_get_monotonic_time() - start_time <= timeout_us)
>>> GTester: last random seed: R02S30cac33d7a98fa56806ca59b35910ea5
>>> **
>>> ERROR:tests/libqos/virtio.c:94:qvirtio_wait_queue_isr: assertion 
>>> failed: (g_get_monotonic_time() - start_time <= timeout_us)
>>> GTester: last random seed: R02S258359836760a723622abf56cf2e61e7
>>> ^C/home/devel/git/qemu/tests/Makefile.include:815: recipe for target 
>>> 'check-qtest-x86_64' failed
>>> make: *** [check-qtest-x86_64] Interrupt
>>>
>>> Please fix them.
>>>
>>> Thanks
>>>
>>>
>>> .
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
