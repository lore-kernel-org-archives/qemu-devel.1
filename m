Received: from eggs.gnu.org ([2001:4830:134:3::10]:38732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eWzr7-0007ve-BF
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eWzr3-0006Ev-7o
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:22:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eWzr2-0006Ea-Uj
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 02:22:21 -0500
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
	<20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <aca10596-f8d4-417e-26b6-ed09ef766552@redhat.com>
Date: Thu, 4 Jan 2018 15:21:55 +0800
MIME-Version: 1.0
In-Reply-To: <20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [RFC 0/3] Extend vhost-user to
 support VFIO based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jianfeng.tan@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, cunming.liang@intel.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com, pbonzini@redhat.com, dan.daly@intel.com



On 2018=E5=B9=B401=E6=9C=8804=E6=97=A5 14:18, Tiwei Bie wrote:
> On Wed, Jan 03, 2018 at 10:34:36PM +0800, Jason Wang wrote:
>> On 2017=E5=B9=B412=E6=9C=8822=E6=97=A5 14:41, Tiwei Bie wrote:
>>> This RFC patch set does some small extensions to vhost-user protocol
>>> to support VFIO based accelerators, and makes it possible to get the
>>> similar performance of VFIO passthru while keeping the virtio device
>>> emulation in QEMU.
>>>
>>> When we have virtio ring compatible devices, it's possible to setup
>>> the device (DMA mapping, PCI config, etc) based on the existing info
>>> (memory-table, features, vring info, etc) which is available on the
>>> vhost-backend (e.g. DPDK vhost library). Then, we will be able to
>>> use such devices to accelerate the emulated device for the VM. And
>>> we call it vDPA: vhost DataPath Acceleration. The key difference
>>> between VFIO passthru and vDPA is that, in vDPA only the data path
>>> (e.g. ring, notify and queue interrupt) is pass-throughed, the device
>>> control path (e.g. PCI configuration space and MMIO regions) is still
>>> defined and emulated by QEMU.
>>>
>>> The benefits of keeping virtio device emulation in QEMU compared
>>> with virtio device VFIO passthru include (but not limit to):
>>>
>>> - consistent device interface from guest OS;
>>> - max flexibility on control path and hardware design;
>>> - leveraging the existing virtio live-migration framework;
>>>
>>> But the critical issue in vDPA is that the data path performance is
>>> relatively low and some host threads are needed for the data path,
>>> because some necessary mechanisms are missing to support:
>>>
>>> 1) guest driver notifies the device directly;
>>> 2) device interrupts the guest directly;
>>>
>>> So this patch set does some small extensions to vhost-user protocol
>>> to make both of them possible. It leverages the same mechanisms (e.g.
>>> EPT and Posted-Interrupt on Intel platform) as the VFIO passthru to
>>> achieve the data path pass through.
>>>
>>> A new protocol feature bit is added to negotiate the accelerator feat=
ure
>>> support. Two new slave message types are added to enable the notify a=
nd
>>> interrupt passthru for each queue. From the view of vhost-user protoc=
ol
>>> design, it's very flexible. The passthru can be enabled/disabled for
>>> each queue individually, and it's possible to accelerate each queue b=
y
>>> different devices. More design and implementation details can be foun=
d
>>> from the last patch.
>>>
>>> There are some rough edges in this patch set (so this is a RFC patch
>>> set for now), but it's never too early to hear the thoughts from the
>>> community! So any comments and suggestions would be really appreciate=
d!
>>>
>>> Tiwei Bie (3):
>>>     vhost-user: support receiving file descriptors in slave_read
>>>     vhost-user: introduce shared vhost-user state
>>>     vhost-user: add VFIO based accelerators support
>>>
>>>    docs/interop/vhost-user.txt     |  57 ++++++
>>>    hw/scsi/vhost-user-scsi.c       |   6 +-
>>>    hw/vfio/common.c                |   2 +-
>>>    hw/virtio/vhost-user.c          | 430 ++++++++++++++++++++++++++++=
+++++++++++-
>>>    hw/virtio/vhost.c               |   3 +-
>>>    hw/virtio/virtio-pci.c          |   8 -
>>>    hw/virtio/virtio-pci.h          |   8 +
>>>    include/hw/vfio/vfio.h          |   2 +
>>>    include/hw/virtio/vhost-user.h  |  43 ++++
>>>    include/hw/virtio/virtio-scsi.h |   6 +-
>>>    net/vhost-user.c                |  30 +--
>>>    11 files changed, 561 insertions(+), 34 deletions(-)
>>>    create mode 100644 include/hw/virtio/vhost-user.h
>>>
>> I may miss something, but may I ask why you must implement them throug=
h
>> vhost-use/dpdk. It looks to me you could put all of them in qemu which=
 could
>> simplify a lots of things (just like userspace NVME driver wrote by Fa=
m).
>>
> Thanks for your comments! :-)
>
> Yeah, you're right. We can also implement everything in QEMU
> like the userspace NVME driver by Fam. It was also described
> by Cunming on the KVM Forum 2017. Below is the link to the
> slides:
>
> https://events.static.linuxfound.org/sites/events/files/slides/KVM17%27=
-vDPA.pdf

Thanks for the pointer. Looks rather interesting.

>
> We're also working on it (including defining a standard device
> for vhost data path acceleration based on mdev to hide vendor
> specific details).

This is exactly what I mean. Form my point of view, there's no need for=20
any extension for vhost protocol, we just need to reuse qemu iothread to=20
implement a userspace vhost dataplane and do the mdev inside that thread.

>
> And IMO it's also not a bad idea to extend vhost-user protocol
> to support the accelerators if possible. And it could be more
> flexible because it could support (for example) below things
> easily without introducing any complex command line options or
> monitor commands to QEMU:

Maybe I was wrong but I don't think we care about the complexity of=20
command line or monitor command in this case.

>
> - the switching among different accelerators and software version
>    can be done at runtime in vhost process;
> - use different accelerators to accelerate different queue pairs
>    or just accelerate some (instead of all) queue pairs;

Well, technically, if we want, these could be implemented in qemu too.

And here's some more advantages if you implement it in qemu:

1) Avoid extra dependency like dpdk
2) More flexible, mdev could even choose to not use VFIO or not depend=20
on vDPA
3) More efficient guest IOMMU integration especially for dynamic=20
mappings (device IOTLB transactions could be done by function calls=20
instead of slow UDP messages)
4) Zerocopy (for non intel vDPA) is more easier to be implemented
5) Compare to vhost-user, tightly coupled with device emulation can=20
simplify lots of things (an example is programmable flow director/RSS=20
implementation). And any future enhancement to virtio does not need to=20
introduce new type of vhost-user messages.

I don't object vhost-user/dpdk method but I second for implementing all=20
the stuffs in qemu.

Thanks

>
> Best regards,
> Tiwei Bie
>
