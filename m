Received: from eggs.gnu.org ([2001:4830:134:3::10]:39077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fBeOp-00010A-P0
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fBeOl-0000SJ-Q6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:45:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:13329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fBeOl-0000Rt-Fj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:45:11 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 26 Apr 2018 18:45:51 +0800
Message-Id: <20180426104553.31034-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH 0/2] Support host notifier in libvhost-user and
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com, tiwei.bie@intel.com

This patch set extends libvhost-user and vhost-user-bridge
to support the host notifier [1] feature in vhost user.

A new API is added for libvhost-user to support setting
host notifier for each queue:

/**
 * vu_set_queue_host_notifier:
 * @dev: a VuDev context
 * @vq: a VuVirtq queue
 * @fd: a file descriptor
 * @size: host page size
 * @offset: notifier offset in @fd file
 *
 * Set queue's host notifier. This function may be called several
 * times for the same queue. If called with -1 @fd, the notifier
 * is removed.
 */
bool vu_set_queue_host_notifier(VuDev *dev, VuVirtq *vq, int fd,
                                int size, int offset);

A new option (-H) is added for vhost-user-bridge to enable
the host notifier. It's pretty simple to test:

# Launch vhost-user-bridge with host notifier enabled
$ make tests/vhost-user-bridge
$ ./tests/vhost-user-bridge -H

# Launch QEMU on another terminal
$ ./x86_64-softmmu/qemu-system-x86_64 \
        -smp 4 -m 1024M -cpu host -enable-kvm \
        -hda "$DISK" \
        -object memory-backend-file,id=mem,size=1024M,mem-path=/dev/shm,share=on \
        -numa node,memdev=mem -mem-prealloc \
        -chardev socket,id=char0,path=/tmp/vubr.sock \
        -netdev type=vhost-user,id=net0,chardev=char0 \
        -device virtio-net-pci,netdev=net0,page-per-vq=on

More details can be found from the patches.

Thanks!

[1] http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg01779.html

Tiwei Bie (2):
  libvhost-user: support host notifier
  vhost-user-bridge: support host notifier

 contrib/libvhost-user/libvhost-user.c | 76 ++++++++++++++++++++++++---
 contrib/libvhost-user/libvhost-user.h | 31 +++++++++++
 tests/vhost-user-bridge.c             | 98 +++++++++++++++++++++++++++++++++--
 3 files changed, 194 insertions(+), 11 deletions(-)

-- 
2.11.0
