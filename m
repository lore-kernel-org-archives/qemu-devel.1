Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw83-0004Zd-Cf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqw80-0000Bw-NK
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:31760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqw80-00009u-CE
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:26:16 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Wed, 28 Feb 2018 15:25:50 +0800
Message-Id: <20180228072558.7434-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [PATCH v4 0/8] nvdimm: guarantee persistence of QEMU
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

QEMU writes to vNVDIMM backends in the vNVDIMM label emulation and
live migration. If the backend is on the persistent memory, QEMU needs
to take proper operations to ensure its writes persistent on the
persistent memory. Otherwise, a host power failure may result in the
loss the guest data on the persistent memory.

This v3 patch series is based on Marcel's patch "mem: add share
parameter to memory-backend-ram" [1] because of the changes in patch 1.

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03858.html

Previous versions can be found at
v3: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04365.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg01579.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg05040.html

Changes in v4:
 * (Patch 2) Fix compilation errors found by patchew.

Changes in v3:
 * (Patch 5) Add a is_pmem flag to ram_handle_compressed() and handle
   PMEM writes in it, so we don't need the _common function.
 * (Patch 6) Expose qemu_get_buffer_common so we can remove the
   unnecessary qemu_get_buffer_to_pmem wrapper.
 * (Patch 8) Add a is_pmem flag to xbzrle_decode_buffer() and handle
   PMEM writes in it, so we can remove the unnecessary
   xbzrle_decode_buffer_{common, to_pmem}.
 * Move libpmem stubs to stubs/pmem.c and fix the compilation failures
   of test-{xbzrle,vmstate}.c.

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

 backends/hostmem-file.c             | 27 +++++++++++++++++++-
 configure                           | 35 ++++++++++++++++++++++++++
 docs/nvdimm.txt                     | 14 +++++++++++
 exec.c                              | 20 ++++++++++++---
 hw/mem/nvdimm.c                     |  9 ++++++-
 include/exec/memory.h               | 12 +++++++--
 include/exec/ram_addr.h             | 28 +++++++++++++++++++--
 include/migration/qemu-file-types.h |  2 ++
 include/qemu/pmem.h                 | 27 ++++++++++++++++++++
 memory.c                            |  8 +++---
 migration/qemu-file.c               | 29 ++++++++++++++--------
 migration/ram.c                     | 49 +++++++++++++++++++++++++++----------
 migration/ram.h                     |  2 +-
 migration/rdma.c                    |  2 +-
 migration/xbzrle.c                  |  8 ++++--
 migration/xbzrle.h                  |  3 ++-
 numa.c                              |  2 +-
 qemu-options.hx                     |  9 ++++++-
 stubs/Makefile.objs                 |  1 +
 stubs/pmem.c                        | 37 ++++++++++++++++++++++++++++
 tests/Makefile.include              |  4 +--
 tests/test-xbzrle.c                 |  4 +--
 22 files changed, 285 insertions(+), 47 deletions(-)
 create mode 100644 include/qemu/pmem.h
 create mode 100644 stubs/pmem.c

-- 
2.14.1
