Received: from eggs.gnu.org ([2001:4830:134:3::10]:43356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1drJGV-0001DT-Es
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1drJGS-0007dd-6m
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:18824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1drJGR-0007cA-TV
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:36:16 -0400
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue, 12 Sep 2017 15:56:12 +0800
Message-Id: <1505202976-1784-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v3 0/4] *** Introduce a new vhost-user-blk host
 device to Qemu ***
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: changpeng.liu@intel.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

Although virtio scsi specification was designed as a replacement for virtio_blk,
there are still many users using virtio_blk. Qemu 2.9 introduced a new device
vhost user scsi which can process I/O in user space for virtio_scsi, this commit
introduces a new vhost user block host device, which can support virtio_blk in
Guest OS, and I/O processing in another I/O target.

Due to the limitation for virtio_blk specification, virtio_blk device cannot get
block information such as capacity, block size etc via the specification, several
new vhost user messages were added to support deliver virtio config space
information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG
messages used for get/set config space from/to I/O target, VHOST_USER_SET_CONFIG_FD
was added for event notifier in case the change of virtio config space. Also, those
messages can be used for vhost device live migration as well.

Changpeng Liu (4):
  vhost-user: add new vhost user messages to support virtio config space
  vhost-user-blk: introduce a new vhost-user-blk host device
  contrib/libvhost-user: enable virtio config space messages
  contrib/vhost-user-blk: introduce a vhost-user-blk sample application

 .gitignore                              |   1 +
 Makefile                                |   3 +
 Makefile.objs                           |   2 +
 configure                               |  11 +
 contrib/libvhost-user/libvhost-user.c   |  74 ++++
 contrib/libvhost-user/libvhost-user.h   |  15 +
 contrib/vhost-user-blk/Makefile.objs    |   1 +
 contrib/vhost-user-blk/vhost-user-blk.c | 735 ++++++++++++++++++++++++++++++++
 docs/interop/vhost-user.txt             |  32 ++
 hw/block/Makefile.objs                  |   3 +
 hw/block/vhost-user-blk.c               | 360 ++++++++++++++++
 hw/virtio/vhost-user.c                  |  97 +++++
 hw/virtio/vhost.c                       |  63 +++
 hw/virtio/virtio-pci.c                  |  55 +++
 hw/virtio/virtio-pci.h                  |  18 +
 include/hw/virtio/vhost-backend.h       |   8 +
 include/hw/virtio/vhost-user-blk.h      |  40 ++
 include/hw/virtio/vhost.h               |  16 +
 18 files changed, 1534 insertions(+)
 create mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
 create mode 100644 hw/block/vhost-user-blk.c
 create mode 100644 include/hw/virtio/vhost-user-blk.h

-- 
1.9.3
