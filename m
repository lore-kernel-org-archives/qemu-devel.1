Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKF7-0004mA-QW
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1ejKF4-0000T6-NK
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:8241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1ejKF4-0000S5-FX
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 02:34:06 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed,  7 Feb 2018 15:33:23 +0800
Message-Id: <20180207073331.14158-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v2 0/8] nvdimm: guarantee persistence of QEMU
 writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

This v2 patch series extends v1 [1] by covering the migration path as
well.

QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
live migration. If the backend is on the persistent memory, QEMU needs
to take proper operations to ensure its writes persistent on the
persistent memory. Otherwise, a host power failure may result in the
loss the guest data on the persistent memory.

This patch series is based on Marcel's patch "mem: add share parameter
to memory-backend-ram" [2] because of the changes in patch 1.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html
[2] http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00768.html

Changes in v2:
 * (Patch 1) Use a flags parameter in file ram allocation functions.
 * (Patch 2) Add a new option 'pmem' to hostmem-file.
 * (Patch 3) Use libpmem to operate on the persistent memory, rather
   than re-implementing those operations in QEMU.
 * (Patch 5-8) Consider the write persistence in the migration path.

Haozhong Zhang (8):
 [1/8] memory, exec: switch file ram allocation functions to 'flags' parameters
 [2/8] hostmem-file: add the 'pmem' option
 [3/8] configure: add libpmem support
 [4/8] mem/nvdimm: ensure write persistence to PMEM in label emulation
 [5/8] migration/ram: ensure write persistence on loading zero pages to PMEM
 [6/8] migration/ram: ensure write persistence on loading normal pages to PMEM
 [7/8] migration/ram: ensure write persistence on loading compressed pages to PMEM
 [8/8] migration/ram: ensure write persistence on loading xbzrle pages to PMEM

 backends/hostmem-file.c             | 27 +++++++++++++-
 configure                           | 35 ++++++++++++++++++
 docs/nvdimm.txt                     | 14 ++++++++
 exec.c                              | 23 +++++++++---
 hw/mem/nvdimm.c                     |  9 ++++-
 include/exec/memory.h               | 12 +++++--
 include/exec/ram_addr.h             | 28 +++++++++++++--
 include/migration/qemu-file-types.h |  1 +
 include/qemu/pmem.h                 | 50 ++++++++++++++++++++++++++
 memory.c                            |  8 +++--
 migration/qemu-file.c               | 41 +++++++++++++++------
 migration/ram.c                     | 71 ++++++++++++++++++++++++++++---------
 migration/xbzrle.c                  | 20 +++++++++--
 migration/xbzrle.h                  |  1 +
 numa.c                              |  2 +-
 qemu-options.hx                     |  9 ++++-
 16 files changed, 308 insertions(+), 43 deletions(-)
 create mode 100644 include/qemu/pmem.h

-- 
2.14.1
