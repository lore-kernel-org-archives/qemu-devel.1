Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBBgo-0007S4-Mb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 23:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dBBgl-0005ov-LH
	for qemu-devel@nongnu.org; Wed, 17 May 2017 23:01:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:4709)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dBBgl-0005od-CR
	for qemu-devel@nongnu.org; Wed, 17 May 2017 23:01:19 -0400
Message-ID: <591D0EF5.9000807@intel.com>
Date: Thu, 18 May 2017 11:03:17 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
In-Reply-To: <7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 00/16] Vhost-pci for
 inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 05/17/2017 02:22 PM, Jason Wang wrote:
>
>
> On 2017年05月17日 14:16, Jason Wang wrote:
>>
>>
>> On 2017年05月16日 15:12, Wei Wang wrote:
>>>>>
>>>>
>>>> Hi:
>>>>
>>>> Care to post the driver codes too?
>>>>
>>> OK. It may take some time to clean up the driver code before post it 
>>> out. You can first
>>> have a check of the draft at the repo here:
>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>
>>> Best,
>>> Wei
>>
>> Interesting, looks like there's one copy on tx side. We used to have 
>> zerocopy support for tun for VM2VM traffic. Could you please try to 
>> compare it with your vhost-pci-net by:
>>
We can analyze from the whole data path - from VM1's network stack to 
send packets -> VM2's
network stack to receive packets. The number of copies are actually the 
same for both.

vhost-pci: 1-copy happen in VM1's driver xmit(), which copes packets 
from its network stack to VM2's
RX ring buffer. (we call it "zerocopy" because there is no intermediate 
copy between VMs)
zerocopy enabled vhost-net: 1-copy happen in tun's recvmsg, which copies 
packets from VM1's TX ring
buffer to VM2's RX ring buffer.

That being said, we compared to vhost-user, instead of vhost_net, 
because vhost-user is the one
that is used in NFV, which we think is a major use case for vhost-pci.


>> - make sure zerocopy is enabled for vhost_net
>> - comment skb_orphan_frags() in tun_net_xmit()
>>
>> Thanks
>>
>
> You can even enable tx batching for tun by ethtool -C tap0 rx-frames 
> N. This will greatly improve the performance according to my test.
>

Thanks, but would this hurt latency?

Best,
Wei
