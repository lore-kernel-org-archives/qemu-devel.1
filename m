Received: from eggs.gnu.org ([2001:4830:134:3::10]:53096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICUC-00079B-Ew
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICU9-0007s3-CL
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:22607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICU9-0007q2-3r
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:01 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:10 +0800
Message-Id: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 00/37] Implementation of vhost-pci for
 inter-vm commucation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

This patch series implements vhost-pci, which is a point-to-point based inter-vm
communication solution. The QEMU side implementation includes the vhost-user
extension, vhost-pci device emulation and management. The current device part
implementation is based on virtio 1.0, but it can be easily upgraded to support
the upcoming virtio 1.1. 

The current QEMU implementation supports the polling mode driver on both sides
to receive packets. More features, such as interrupt support, live migration
support, protection memory accesses will be added later.


Wei Wang (37):
  vhost-pci-net: the fundamental vhost-pci-net device emulation
  vhost-pci-net: the fundamental implementation of vhost-pci-net-pci
  vhost-user: share the vhost-user protocol related structures
  vl: add the vhost-pci-slave command line option
  vhost-pci-slave: start the implementation of vhost-pci-slave
  vhost-pci-slave: set up the fundamental handlers for the server socket
  vhost-pci-slave/msg: VHOST_USER_GET_FEATURES
  vhost-pci-slave/msg: VHOST_USER_SET_FEATURES
  vhost-pci-slave/msg: VHOST_USER_GET_PROTOCOL_FEATURES
  vhost-pci-slave/msg: VHOST_USER_SET_PROTOCOL_FEATURES
  vhost-user/msg: VHOST_USER_PROTOCOL_F_SET_DEVICE_ID
  vhost-pci-slave/msg: VHOST_USER_SET_DEVICE_ID
  vhost-pci-slave/msg: VHOST_USER_GET_QUEUE_NUM
  vhost-pci-slave/msg: VHOST_USER_SET_OWNER
  vhost-pci-slave/msg: VHOST_USER_SET_MEM_TABLE
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_NUM
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_BASE
  vhost-user: send guest physical address of virtqueues to the slave
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_ADDR
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_KICK
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_CALL
  vhost-pci-slave/msg: VHOST_USER_SET_VRING_ENABLE
  vhost-pci-slave/msg: VHOST_USER_SET_LOG_BASE
  vhost-pci-slave/msg: VHOST_USER_SET_LOG_FD
  vhost-pci-slave/msg: VHOST_USER_SEND_RARP
  vhost-pci-slave/msg: VHOST_USER_GET_VRING_BASE
  vhost-pci-net: pass the info collected by vp_slave to the device
  vhost-pci-net: pass the mem and vring info to the driver
  vhost-pci-slave/msg: VHOST_USER_SET_VHOST_PCI (start)
  vhost-pci-slave/msg: VHOST_USER_SET_VHOST_PCI (stop)
  vhost-user/msg: send VHOST_USER_SET_VHOST_PCI (start/stop)
  vhost-user: add asynchronous read for the vhost-user master
  vhost-pci-net: send the negotiated feature bits to the master
  vhost-pci-slave: add "peer_reset"
  vhost-pci-net: start the vhost-pci-net device
  vhost-user/msg: handling VHOST_USER_SET_FEATURES
  vl: enable vhost-pci-slave

 hw/net/Makefile.objs                           |   2 +-
 hw/net/vhost-pci-net.c                         | 263 ++++++++++++
 hw/net/vhost_net.c                             |  37 ++
 hw/virtio/Makefile.objs                        |   1 +
 hw/virtio/vhost-pci-slave.c                    | 552 +++++++++++++++++++++++++
 hw/virtio/vhost-user.c                         | 184 +++++----
 hw/virtio/vhost.c                              |  61 ++-
 hw/virtio/virtio-pci.c                         |  80 ++++
 hw/virtio/virtio-pci.h                         |  16 +
 include/hw/pci/pci.h                           |   1 +
 include/hw/virtio/vhost-backend.h              |   2 +
 include/hw/virtio/vhost-pci-net.h              |  45 ++
 include/hw/virtio/vhost-pci-slave.h            |  46 +++
 include/hw/virtio/vhost-user.h                 | 109 +++++
 include/hw/virtio/vhost.h                      |   3 +
 include/net/vhost-user.h                       |  22 +-
 include/net/vhost_net.h                        |   2 +
 include/standard-headers/linux/vhost_pci_net.h |  85 ++++
 include/standard-headers/linux/virtio_ids.h    |  29 +-
 net/vhost-user.c                               |  34 +-
 qemu-options.hx                                |   4 +
 vl.c                                           |  41 ++
 22 files changed, 1485 insertions(+), 134 deletions(-)
 create mode 100644 hw/net/vhost-pci-net.c
 create mode 100644 hw/virtio/vhost-pci-slave.c
 create mode 100644 include/hw/virtio/vhost-pci-net.h
 create mode 100644 include/hw/virtio/vhost-pci-slave.h
 create mode 100644 include/hw/virtio/vhost-user.h
 create mode 100644 include/standard-headers/linux/vhost_pci_net.h

-- 
2.7.4
