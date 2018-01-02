Received: from eggs.gnu.org ([2001:4830:134:3::10]:59393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eWDbi-0003fO-VV
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1eWDbf-0008Qs-Tu
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:54621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1eWDbf-0008Pj-Kw
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 22:51:15 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Tue,  2 Jan 2018 11:55:25 +0800
Message-Id: <1514865329-29258-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v8 0/4] Introduce a new vhost-user-blk host
 device to QEMU
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
there are still many users using virtio_blk. QEMU 2.9 introduced a new device
vhost user scsi which can process I/O in user space for virtio_scsi, this commit
introduces a new vhost user block host device, which can support virtio_blk in
Guest OS, and I/O processing in another I/O target.

Due to the limitation for virtio_blk specification, virtio_blk device cannot get
block information such as capacity, block size etc via the specification, several
new vhost user messages were added to deliver virtio config space
information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG
messages used for get/set config space from/to I/O target, VHOST_USER_SLAVE_CONFIG_CHANGE_MSG
slave message was added for the event notifier in case the change of virtio config space. Also,
those messages can be used for vhost device live migration as well.

CHANGES:
v7-v8: Instead using an event file descriptor for event notifier in case of virtio configuration
space changed, while here used a new vhost-user slave message to deliver such event. Several small
optimizations to address the comments from v7.
v6-v7: change the parameter of set configuration function let it only contain valid data buffer.
v5-v6: add header flags for vhost-user master so that the slave can know the purpose for
set config, also vhost-user get/set messages' payload doesn't contain invalid data buffers.
v4-v5: add header offset and size for virtio config space.
v3-v4: refactoring the vhost user block example patch based on new libvhost-user library.
v2-v3: add new vhost user message to get/set virtio config space.

Changpeng Liu (4):
  vhost-user: add new vhost user messages to support virtio config space
  vhost-user-blk: introduce a new vhost-user-blk host device
  contrib/libvhost-user: enable virtio config space messages
  contrib/vhost-user-blk: introduce a vhost-user-blk sample application

 .gitignore                              |   1 +
 Makefile                                |   3 +
 Makefile.objs                           |   1 +
 contrib/libvhost-user/libvhost-user.c   |  54 ++++
 contrib/libvhost-user/libvhost-user.h   |  34 +-
 contrib/vhost-user-blk/Makefile.objs    |   1 +
 contrib/vhost-user-blk/vhost-user-blk.c | 543 ++++++++++++++++++++++++++++++++
 default-configs/pci.mak                 |   1 +
 docs/interop/vhost-user.txt             |  53 ++++
 hw/block/Makefile.objs                  |   3 +
 hw/block/vhost-user-blk.c               | 359 +++++++++++++++++++++
 hw/virtio/vhost-user.c                  | 118 +++++++
 hw/virtio/vhost.c                       |  32 ++
 hw/virtio/virtio-pci.c                  |  55 ++++
 hw/virtio/virtio-pci.h                  |  18 ++
 include/hw/virtio/vhost-backend.h       |  12 +
 include/hw/virtio/vhost-user-blk.h      |  41 +++
 include/hw/virtio/vhost.h               |  15 +
 18 files changed, 1343 insertions(+), 1 deletion(-)
 create mode 100644 contrib/vhost-user-blk/Makefile.objs
 create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
 create mode 100644 hw/block/vhost-user-blk.c
 create mode 100644 include/hw/virtio/vhost-user-blk.h

-- 
1.9.3
