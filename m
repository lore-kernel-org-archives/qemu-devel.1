Received: from eggs.gnu.org ([2001:4830:134:3::10]:48762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXG-0005Gf-Nw
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZCXF-00089t-Oj
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 04:19:02 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 10 Jan 2018 17:18:37 +0800
Message-Id: <20180110091846.10699-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/9] block: Add VFIO based driver for NVMe
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

v4: - Rebase, address Stefan's comments.
    - Add QAPI and doc patches.

v3: Rebase, small tweaks/fixes and add locks to provide basic thread safety
    (basic because it is not really tested).

v2:
    - Implement "split vfio addr space" appraoch. [Paolo]
    - Add back 'device reset' in nvme_close(). [Paolo]
    - Better variable namings. [Stefan]
    - "Reuse" macro definitions from NVMe emulation code.
    - Rebase onto current master which has polling by default and update
      performance results accordingly.
    - Update MAINTAINERS.
    - Specify namespace in URI.
    - The sporadical I/O error from v1 "disappeared" in this version.
    - Tests one: qemu-img bench, fio, bonnie++ and installation of
      ubuntu/fedora/rhel on QEMU emulated nvme and a Intel P3700 card.

Fam Zheng (9):
  stubs: Add stubs for ram block API
  util: Introduce vfio helpers
  block: Add VFIO based NVMe driver
  block: Introduce buf register API
  block/nvme: Implement .bdrv_(un)register_buf
  qemu-img: Map bench buffer
  block: Move NVMe constants to a separate header
  docs: Add section for NVMe VFIO driver
  qapi: Add NVMe driver options to the schema

 MAINTAINERS                    |    6 +
 block/Makefile.objs            |    1 +
 block/block-backend.c          |   10 +
 block/io.c                     |   24 +
 block/nvme.c                   | 1143 ++++++++++++++++++++++++++++++++++++++++
 block/trace-events             |   21 +
 docs/qemu-block-drivers.texi   |   32 ++
 hw/block/nvme.h                |  698 +-----------------------
 include/block/block.h          |   11 +-
 include/block/block_int.h      |    9 +
 include/block/nvme.h           |  700 ++++++++++++++++++++++++
 include/qemu/vfio-helpers.h    |   30 ++
 include/sysemu/block-backend.h |    3 +
 qapi/block-core.json           |   16 +-
 qemu-img.c                     |    9 +-
 stubs/Makefile.objs            |    1 +
 stubs/ram-block.c              |   16 +
 util/Makefile.objs             |    1 +
 util/trace-events              |   11 +
 util/vfio-helpers.c            |  723 +++++++++++++++++++++++++
 20 files changed, 2765 insertions(+), 700 deletions(-)
 create mode 100644 block/nvme.c
 create mode 100644 include/block/nvme.h
 create mode 100644 include/qemu/vfio-helpers.h
 create mode 100644 stubs/ram-block.c
 create mode 100644 util/vfio-helpers.c

-- 
2.14.3
