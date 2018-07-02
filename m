Received: from eggs.gnu.org ([2001:4830:134:3::10]:56795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fa62k-0007j6-E5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fa62j-0002OY-GY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 17:07:30 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  2 Jul 2018 23:07:19 +0200
Message-Id: <20180702210721.4847-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vmdk: Fix possible segfault with non-VMDK
 backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

The VMDK driver assumes that its backing file is always a VMDK file,
too, because it verifies that when creating the overlay.  However, that
verification means nothing at runtime, and consequently you can assign
non-VMDK backing files to a VMDK node.  This then breaks because the
driver accesses the backing node as a VMDK node to read its supposed CID
to compare it with the overlay's parentCID entry -- which usually fails,
either in a benign way (we read from a garbage offset, and then we read
garbage or get a read error straight away), or we get a segfault
(because the backing node does not have a respective file child).

Anyway, we just shouldn't do it and instead check whether the backing
file is a VMDK node before treating it like one.


(This fixes
 http://lists.nongnu.org/archive/html/qemu-block/2018-06/msg01268.html)


Max Reitz (2):
  vmdk: Fix possible segfault with non-VMDK backing
  iotests: Add VMDK backing file correlation test

 block/vmdk.c               |   6 ++
 tests/qemu-iotests/225     | 132 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/225.out |  24 +++++++
 tests/qemu-iotests/group   |   1 +
 4 files changed, 163 insertions(+)
 create mode 100755 tests/qemu-iotests/225
 create mode 100644 tests/qemu-iotests/225.out

-- 
2.17.1
