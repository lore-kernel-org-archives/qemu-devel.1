Received: from eggs.gnu.org ([2001:4830:134:3::10]:60577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aR-00071d-Pi
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aN-0003bm-QR
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:51 -0400
Received: from m12-15.163.com ([220.181.12.15]:51265)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aN-0003a6-0M
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:47 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:10 -0700
Message-Id: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 0/8] Add missed read callback for some memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

This patch set try to add the missed read callback for memory region.
Without this patchset, when the guest reads the IO port/memory, it will
cause an NULL-dereference issue. For example, add 
"-device isa-debug-exit" to command, then read the 0x501 port, it causes a 
SIGSEGV.

The only exception is 'readonly_mem_ops' as its read is directly 
access the underlying host ram as the comments says.

These missed read callback is mostly pointed by Laszlo Ersek.



Li Qiang (8):
  fw_cfg_mem: add read memory region callback
  hw: debugexit: add read callback
  hw: hyperv_testdev: add read callback
  hw: pc-testdev: add read memory region callback
  hw: designware: add read memory region callback
  hw: pvrdma: add read memory region callback
  hw: sun4c: add read memory region callback
  exec: add read callback for notdirty memory region

 exec.c                    |  7 +++++++
 hw/misc/debugexit.c       |  6 ++++++
 hw/misc/hyperv_testdev.c  | 10 ++++++++--
 hw/misc/pc-testdev.c      | 20 ++++++++++++++++----
 hw/nvram/fw_cfg.c         |  6 ++++++
 hw/pci-host/designware.c  |  7 +++++++
 hw/rdma/vmw/pvrdma_main.c |  6 ++++++
 hw/sparc64/sun4u.c        |  6 ++++++
 8 files changed, 62 insertions(+), 6 deletions(-)

-- 
2.17.1
