Received: from eggs.gnu.org ([2001:4830:134:3::10]:59136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1edSrz-0003Od-Jk
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1edSrv-0000D7-O8
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1edSrv-0000CG-Eg
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 22:33:59 -0500
References: <20180119130653.24044-1-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
Date: Mon, 22 Jan 2018 11:33:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180119130653.24044-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>



On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 21:06, Stefan Hajnoczi wrote:
> These patches implement the virtio-vhost-user device design that I have
> described here:
> https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007

Thanks for the patches, looks rather interesting and similar to split=20
device model used by Xen.

>
> The goal is to let the guest act as the vhost device backend for other =
guests.
> This allows virtual networking and storage appliances to run inside gue=
sts.

So the question still, what kind of protocol do you want to run on top?=20
If it was ethernet based, virtio-net work pretty well and it can even do=20
migration.

> This device is particularly interesting for poll mode drivers where exi=
tless
> VM-to-VM communication is possible, completely bypassing the hypervisor=
 in the
> data path.

It's better to clarify the reason of hypervisor bypassing. (performance,=20
security or scalability).

Probably not for the following cases:

1) kick/call
2) device IOTLB / IOMMU transaction (or any other case that backends=20
needs metadata from qemu).

>
> The DPDK driver is here:
> https://github.com/stefanha/dpdk/tree/virtio-vhost-user
>
> For more information, see
> https://wiki.qemu.org/Features/VirtioVhostUser.
>
> virtio-vhost-user is inspired by Wei Wang and Zhiyong Yang's vhost-pci =
work.
> It differs from vhost-pci in that it has:
> 1. Vhost-user protocol message tunneling, allowing existing vhost-user
>     slave software to be reused inside the guest.
> 2. Support for all vhost device types.
> 3. Disconnected operation and reconnection support.
> 4. Asynchronous vhost-user socket implementation that avoids blocking.
>
> I have written this code to demonstrate how the virtio-vhost-user appro=
ach
> works and that it is more maintainable than vhost-pci because vhost-use=
r slave
> software can use both AF_UNIX and virtio-vhost-user without significant=
 code
> changes to the vhost device backends.

Yes, this looks cleaner than vhost-pci.

>
> One of the main concerns about virtio-vhost-user was that the QEMU
> virtio-vhost-user device implementation could be complex because it nee=
ds to
> parse all messages.  I hope this patch series shows that it's actually =
very
> simple because most messages are passed through.
>
> After this patch series has been reviewed, we need to decide whether to=
 follow
> the original vhost-pci approach or to use this one.  Either way, both p=
atch
> series still require improvements before they can be merged.  Here are =
my todos
> for this series:
>
>   * Implement "Additional Device Resources over PCI" for shared memory,
>     doorbells, and notifications instead of hardcoding a BAR with magic
>     offsets into virtio-vhost-user:
>     https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2920007

Does this mean we need to standardize vhost-user protocol first?

>   * Implement the VRING_KICK eventfd - currently vhost-user slaves must=
 be poll
>     mode drivers.
>   * Optimize VRING_CALL doorbell with ioeventfd to avoid QEMU exit.

The performance implication needs to be measured. It looks to me both=20
kick and call will introduce more latency form the point of guest.

>   * vhost-user log feature
>   * UUID config field for stable device identification regardless of PC=
I
>     bus addresses.
>   * vhost-user IOMMU and SLAVE_REQ_FD feature

So an assumption is the VM that implements vhost backends should be at=20
least as secure as vhost-user backend process on host. Could we have=20
this conclusion?

>   * VhostUserMsg little-endian conversion for cross-endian support
>   * Chardev disconnect using qemu_chr_fe_set_watch() since CHR_CLOSED i=
s
>     only emitted while a read callback is registered.  We don't keep a
>     read callback registered all the time.
>   * Drain txq on reconnection to discard stale messages.
>
> Stefan Hajnoczi (1):
>    virtio-vhost-user: add virtio-vhost-user device
>
> Wei Wang (1):
>    vhost-user: share the vhost-user protocol related structures
>
>   configure                                   |   18 +
>   hw/virtio/Makefile.objs                     |    1 +
>   hw/virtio/virtio-pci.h                      |   21 +
>   include/hw/pci/pci.h                        |    1 +
>   include/hw/virtio/vhost-user.h              |  106 +++
>   include/hw/virtio/virtio-vhost-user.h       |   88 +++
>   include/standard-headers/linux/virtio_ids.h |    1 +
>   hw/virtio/vhost-user.c                      |  100 +--
>   hw/virtio/virtio-pci.c                      |   61 ++
>   hw/virtio/virtio-vhost-user.c               | 1047 ++++++++++++++++++=
+++++++++
>   hw/virtio/trace-events                      |   22 +
>   11 files changed, 1367 insertions(+), 99 deletions(-)
>   create mode 100644 include/hw/virtio/vhost-user.h
>   create mode 100644 include/hw/virtio/virtio-vhost-user.h
>   create mode 100644 hw/virtio/virtio-vhost-user.c
>

Btw, it's better to have some early numbers, e.g what testpmd reports=20
during forwarding.

Thanks
