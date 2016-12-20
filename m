Received: from eggs.gnu.org ([2001:4830:134:3::10]:41091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJNKX-0001IG-KG
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJNKW-0007H8-IT
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 11:31:57 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 21 Dec 2016 00:31:35 +0800
Message-Id: <20161220163139.12016-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] RFC: A VFIO based block driver for NVMe
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Karl Rister <krister@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>

This series adds a new protocol driver that is intended to achieve about 20%
better performance for latency bound workloads (i.e. synchronous I/O) than
linux-aio when guest is exclusively accessing a NVMe device, by talking to the
device directly instead of through kernel file system layers and its NVMe
driver.

This applies on top of Stefan's block-next tree which has the busy polling
patches - the new driver also supports it.

A git branch is also available as:

    https://github.com/famz/qemu nvme

See patch 4 for benchmark numbers.

Tests are done on QEMU's NVMe emulation and a real Intel P3700 SSD NVMe card.
Most of dd/fio/mkfs/kernel build and OS installation testings work well, but an
weird write fault looking similar to [1] is consistently seen when installing
RHEL 7.3 guest, which is still under investigation.

[1]: http://lists.infradead.org/pipermail/linux-nvme/2015-May/001840.html

Also, the ram notifier is not enough for hot plugged block device because in
that case the notifier is installed _after_ ram blocks are added so it won't
get the events.

Fam Zheng (3):
  util: Add a notifier list for qemu_vfree()
  util: Add VFIO helper library
  block: Add VFIO based NVMe driver

Paolo Bonzini (1):
  ramblock-notifier: new

 block/Makefile.objs         |    1 +
 block/nvme.c                | 1026 +++++++++++++++++++++++++++++++++++++++++++
 exec.c                      |    5 +
 include/exec/memory.h       |    6 +-
 include/exec/ram_addr.h     |   46 +-
 include/exec/ramlist.h      |   72 +++
 include/qemu/notify.h       |    1 +
 include/qemu/vfio-helpers.h |   29 ++
 numa.c                      |   29 ++
 stubs/Makefile.objs         |    1 +
 stubs/ram.c                 |   10 +
 util/Makefile.objs          |    1 +
 util/oslib-posix.c          |    9 +
 util/vfio-helpers.c         |  713 ++++++++++++++++++++++++++++++
 xen-mapcache.c              |    3 +
 15 files changed, 1903 insertions(+), 49 deletions(-)
 create mode 100644 block/nvme.c
 create mode 100644 include/exec/ramlist.h
 create mode 100644 include/qemu/vfio-helpers.h
 create mode 100644 stubs/ram.c
 create mode 100644 util/vfio-helpers.c

-- 
2.9.3
