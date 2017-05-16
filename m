Received: from eggs.gnu.org ([2001:4830:134:3::10]:37904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWG3-00032m-AW
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAWG2-0007CT-BH
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:46:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAWG2-0007CA-1p
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:46:58 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
Date: Tue, 16 May 2017 14:46:49 +0800
MIME-Version: 1.0
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 16:35, Wei Wang wrote:
> This patch series implements vhost-pci, which is a point-to-point based
> inter-vm communication solution. The QEMU side implementation includes =
the
> vhost-user extension, vhost-pci device emulation and management, and in=
ter-VM
> notification.
>
> v1->v2 changes:
> 1) inter-VM notification support;
> 2) vhost-pci-net ctrlq message format change;
> 3) patch re-org and code cleanup.
>
> Wei Wang (16):
>    vhost-user: share the vhost-user protocol related structures
>    vl: add the vhost-pci-slave command line option
>    vhost-pci-slave: create a vhost-user slave to support vhost-pci
>    vhost-pci-net: add vhost-pci-net
>    vhost-pci-net-pci: add vhost-pci-net-pci
>    virtio: add inter-vm notification support
>    vhost-user: send device id to the slave
>    vhost-user: send guest physical address of virtqueues to the slave
>    vhost-user: send VHOST_USER_SET_VHOST_PCI_START/STOP
>    vhost-pci-net: send the negotiated feature bits to the master
>    vhost-user: add asynchronous read for the vhost-user master
>    vhost-user: handling VHOST_USER_SET_FEATURES
>    vhost-pci-slave: add "reset_virtio"
>    vhost-pci-slave: add support to delete a vhost-pci device
>    vhost-pci-net: tell the driver that it is ready to send packets
>    vl: enable vhost-pci-slave
>
>   hw/net/Makefile.objs                           |   2 +-
>   hw/net/vhost-pci-net.c                         | 364 +++++++++++++
>   hw/net/vhost_net.c                             |  39 ++
>   hw/virtio/Makefile.objs                        |   7 +-
>   hw/virtio/vhost-pci-slave.c                    | 676 ++++++++++++++++=
+++++++++
>   hw/virtio/vhost-stub.c                         |  22 +
>   hw/virtio/vhost-user.c                         | 192 +++----
>   hw/virtio/vhost.c                              |  63 ++-
>   hw/virtio/virtio-bus.c                         |  19 +-
>   hw/virtio/virtio-pci.c                         |  96 +++-
>   hw/virtio/virtio-pci.h                         |  16 +
>   hw/virtio/virtio.c                             |  32 +-
>   include/hw/pci/pci.h                           |   1 +
>   include/hw/virtio/vhost-backend.h              |   2 +
>   include/hw/virtio/vhost-pci-net.h              |  40 ++
>   include/hw/virtio/vhost-pci-slave.h            |  64 +++
>   include/hw/virtio/vhost-user.h                 | 110 ++++
>   include/hw/virtio/vhost.h                      |   3 +
>   include/hw/virtio/virtio.h                     |   2 +
>   include/net/vhost-user.h                       |  22 +-
>   include/net/vhost_net.h                        |   2 +
>   include/standard-headers/linux/vhost_pci_net.h |  74 +++
>   include/standard-headers/linux/virtio_ids.h    |   1 +
>   net/vhost-user.c                               |  37 +-
>   qemu-options.hx                                |   4 +
>   vl.c                                           |  46 ++
>   26 files changed, 1796 insertions(+), 140 deletions(-)
>   create mode 100644 hw/net/vhost-pci-net.c
>   create mode 100644 hw/virtio/vhost-pci-slave.c
>   create mode 100644 include/hw/virtio/vhost-pci-net.h
>   create mode 100644 include/hw/virtio/vhost-pci-slave.h
>   create mode 100644 include/hw/virtio/vhost-user.h
>   create mode 100644 include/standard-headers/linux/vhost_pci_net.h
>

Hi:

Care to post the driver codes too?

Thanks
