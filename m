Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edZw2-0004jo-Rn
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edZvy-0003HZ-NQ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:06:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:5893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1edZvy-0003DJ-CF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 06:06:38 -0500
Message-ID: <5A65C652.6080307@intel.com>
Date: Mon, 22 Jan 2018 19:09:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180119130653.24044-1-stefanha@redhat.com>
In-Reply-To: <20180119130653.24044-1-stefanha@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com

On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
> These patches implement the virtio-vhost-user device design that I have
> described here:
> https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
>
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
>   hw/virtio/virtio-vhost-user.c               | 1047 +++++++++++++++++++++++++++
>   hw/virtio/trace-events                      |   22 +
>   11 files changed, 1367 insertions(+), 99 deletions(-)
>   create mode 100644 include/hw/virtio/vhost-user.h
>   create mode 100644 include/hw/virtio/virtio-vhost-user.h
>   create mode 100644 hw/virtio/virtio-vhost-user.c
>

Thanks for the quick implementation. Not sure if the following issues 
could be solved with this approach:
  - After we boot the slave VM, if we don't run the virtio-vhost-user 
driver (i.e. testpmd), then the master VM couldn't boot, because the 
booting of the virtio-net device relies on a negotiation with the 
virtio-vhost-user driver.
  - Suppose in the future there is also a kernel virtio-vhost-user 
driver as other PCI devices, can we unbind the kernel driver first, and 
then bind the device to the dpdk driver? A normal PCI device should be 
able to smoothly switch between the kernel driver and dpdk driver.

Best,
Wei
