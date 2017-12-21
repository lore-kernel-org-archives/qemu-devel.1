Received: from eggs.gnu.org ([2001:4830:134:3::10]:43922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1my-0004ik-Sa
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1mt-0003MH-4I
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:25:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1ms-0003Lm-LS
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:25:30 -0500
Date: Thu, 21 Dec 2017 16:25:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221162459-mutt-send-email-mst@kernel.org>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com

On Tue, Nov 28, 2017 at 05:03:05PM +0800, Gonglei wrote:
> I posted the RFC verion five months ago for DPDK
> vhost-crypto implmention, and now it's time to send
> the formal version. Because we need an user space scheme
> for better performance.
> 
> The vhost user crypto server side patches had been
> sent to DPDK community, pls see
> 
> [RFC PATCH 0/6] lib/librte_vhost: introduce new	vhost_user crypto backend support
> http://dpdk.org/ml/archives/dev/2017-November/081048.html
> 
> You also can get virtio-crypto polling mode driver from:
> 
> [PATCH] virtio: add new driver for crypto devices
> http://dpdk.org/ml/archives/dev/2017-November/081985.html
> 

This makes build on mingw break:

  CC      sparc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
hw/virtio/virtio-crypto.o: In function `virtio_crypto_vhost_status':
/scm/qemu/hw/virtio/virtio-crypto.c:898: undefined reference to `cryptodev_get_vhost'
/scm/qemu/hw/virtio/virtio-crypto.c:910: undefined reference to `cryptodev_vhost_start'
/scm/qemu/hw/virtio/virtio-crypto.c:917: undefined reference to `cryptodev_vhost_stop'
hw/virtio/virtio-crypto.o: In function `virtio_crypto_guest_notifier_pending':
/scm/qemu/hw/virtio/virtio-crypto.c:947: undefined reference to `cryptodev_vhost_virtqueue_pending'
hw/virtio/virtio-crypto.o: In function `virtio_crypto_guest_notifier_mask':
/scm/qemu/hw/virtio/virtio-crypto.c:937: undefined reference to `cryptodev_vhost_virtqueue_mask'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:193: qemu-system-i386.exe] Error 1
make: *** [Makefile:383: subdir-i386-softmmu] Error 2



> Gonglei (4):
>   cryptodev: add vhost-user as a new cryptodev backend
>   cryptodev: add vhost support
>   cryptodev-vhost-user: add crypto session handler
>   cryptodev-vhost-user: set the key length
> 
>  backends/Makefile.objs                |   4 +
>  backends/cryptodev-builtin.c          |   1 +
>  backends/cryptodev-vhost-user.c       | 381 ++++++++++++++++++++++++++++++++++
>  backends/cryptodev-vhost.c            | 297 ++++++++++++++++++++++++++
>  docs/interop/vhost-user.txt           |  19 ++
>  hw/virtio/vhost-user.c                |  89 ++++++++
>  hw/virtio/virtio-crypto.c             |  70 +++++++
>  include/hw/virtio/vhost-backend.h     |   8 +
>  include/hw/virtio/virtio-crypto.h     |   1 +
>  include/sysemu/cryptodev-vhost-user.h |  47 +++++
>  include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
>  include/sysemu/cryptodev.h            |   8 +
>  qemu-options.hx                       |  21 ++
>  vl.c                                  |   4 +
>  14 files changed, 1104 insertions(+)
>  create mode 100644 backends/cryptodev-vhost-user.c
>  create mode 100644 backends/cryptodev-vhost.c
>  create mode 100644 include/sysemu/cryptodev-vhost-user.h
>  create mode 100644 include/sysemu/cryptodev-vhost.h
> 
> -- 
> 1.8.3.1
> 
