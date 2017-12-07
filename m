Received: from eggs.gnu.org ([2001:4830:134:3::10]:52489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMonn-0001wO-UI
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:32:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMonk-0003BT-Qg
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:32:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:62233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMonk-0003Al-Gh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:32:52 -0500
Message-ID: <5A28D2FA.2070006@intel.com>
Date: Thu, 07 Dec 2017 13:34:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<20171207070947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171207070947-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 12/07/2017 01:11 PM, Michael S. Tsirkin wrote:
> On Thu, Dec 07, 2017 at 11:57:33AM +0800, Wei Wang wrote:
>> On 12/07/2017 12:27 AM, Stefan Hajnoczi wrote:
>>> On Wed, Dec 6, 2017 at 4:09 PM, Wang, Wei W <wei.w.wang@intel.com> wrote:
>>>> On Wednesday, December 6, 2017 9:50 PM, Stefan Hajnoczi wrote:
>>>>> On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
>>>>>> Vhost-pci is a point-to-point based inter-VM communication solution.
>>>>>> This patch series implements the vhost-pci-net device setup and
>>>>>> emulation. The device is implemented as a virtio device, and it is set
>>>>>> up via the vhost-user protocol to get the neessary info (e.g the
>>>>>> memory info of the remote VM, vring info).
>>>>>>
>>>>>> Currently, only the fundamental functions are implemented. More
>>>>>> features, such as MQ and live migration, will be updated in the future.
>>>>>>
>>>>>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>>>>>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>>>> I have asked questions about the scope of this feature.  In particular, I think
>>>>> it's best to support all device types rather than just virtio-net.  Here is a
>>>>> design document that shows how this can be achieved.
>>>>>
>>>>> What I'm proposing is different from the current approach:
>>>>> 1. It's a PCI adapter (see below for justification) 2. The vhost-user protocol is
>>>>> exposed by the device (not handled 100% in
>>>>>      QEMU).  Ultimately I think your approach would also need to do this.
>>>>>
>>>>> I'm not implementing this and not asking you to implement it.  Let's just use
>>>>> this for discussion so we can figure out what the final vhost-pci will look like.
>>>>>
>>>>> Please let me know what you think, Wei, Michael, and others.
>>>>>
>>>> Thanks for sharing the thoughts. If I understand it correctly, the key difference is that this approach tries to relay every vhost-user msg to the guest. I'm not sure about the benefits of doing this.
>>>> To make data plane (i.e. driver to send/receive packets) work, I think, mostly, the memory info and vring info are enough. Other things like callfd, kickfd don't need to be sent to the guest, they are needed by QEMU only for the eventfd and irqfd setup.
>>> Handling the vhost-user protocol inside QEMU and exposing a different
>>> interface to the guest makes the interface device-specific.  This will
>>> cause extra work to support new devices (vhost-user-scsi,
>>> vhost-user-blk).  It also makes development harder because you might
>>> have to learn 3 separate specifications to debug the system (virtio,
>>> vhost-user, vhost-pci-net).
>>>
>>> If vhost-user is mapped to a PCI device then these issues are solved.
>> I intend to have a different opinion about this:
>>
>> 1) Even relaying the msgs to the guest, QEMU still need to handle the msg
>> first, for example, it needs to decode the msg to see if it is the ones
>> (e.g. SET_MEM_TABLE, SET_VRING_KICK, SET_VRING_CALL) that should be used for
>> the device setup (e.g. mmap the memory given via SET_MEM_TABLE). In this
>> case, we will be likely to have 2 slave handlers - one in the guest, another
>> in QEMU device.
>>
>> 2) If people already understand the vhost-user protocol, it would be natural
>> for them to understand the vhost-pci metadata - just the obtained memory and
>> vring info are put to the metadata area (no new things).
> I see a bigger problem with passthrough. If qemu can't fully decode all
> messages, it can not operate in a disconected mode - guest will have to
> stop on disconnect until we re-connect a backend.
>

What do you mean by "passthrough" in this case? Why qemu can't fully 
decode all the messages (probably I haven't got the point)

Best,
Wei
