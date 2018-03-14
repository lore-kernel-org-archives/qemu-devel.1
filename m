Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5g-0000Li-Qd
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <junyan.he@hotmail.com>) id 1evv5b-0006Jo-Ud
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:28906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <junyan.he@hotmail.com>)
	id 1evv5b-0006Hx-Ls
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 21:20:23 -0400
From: junyan.he@hotmail.com
Date: Wed, 14 Mar 2018 09:20:08 +0800
Message-Id: <1520990418-28258-1-git-send-email-junyan.he@hotmail.com>
Subject: [Qemu-devel] [PATCH 00/10] RFC: Optimize nvdimm kind memory for
 snapshot.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, quintela@redhat.com, rth@twiddle.net, dgilbert@redhat.com, famz@redhat.com, Junyan He <junyan.he@intel.com>

From: Junyan He <junyan.he@intel.com>

The nvdimm size is huge, sometimes it is more than 256G or even more.
This is a huge burden for snapshot saving. One snapshot point with
nvdimm may occupy more than 50G disk space even with compression
enabled.
We need to introduce dependent snapshot manner to solve this problem.
The first snapshot point should always be saved completely, and enable
dirty log trace after saving for nvdimm memory region. The later snapshot
point should add the reference to previous snapshot's nvdimm data and
just saving dirty pages. This can save a lot of disk and time if the
snapshot operations are triggered frequently.
We add save_snapshot_dependency functions to QCOW2 file system firstly, the
later snapshot will add reference to previous dependent snapshot's data
cluster. There is an alignment problem here, the dependent data should
always be cluster aligned. We need to add some padding data when saving
the snapshot to make it always cluster aligned.
The logic between nvdimm and ram for snapshot saving is a little confused
now, we need to exclude nvdimm kind memory region from ram list and the
dirty log tracing setting is also not very clear. Maybe we can separate the
snapshot saving from the migration logic later to make code clean.
In theory, this kind of manner can apply to any kind of memory. But because
it need to turn dirty log trace on, the performance may decline. So we just
enable it for nvdimm kind memory firstly.

Signed-off-by: Junyan He <junyan.he@intel.com>
---
Makefile.target              |    1 +
block/qcow2-snapshot.c       |  154 ++++++++++++++++++++++
block/qcow2.c                |    2 +
block/qcow2.h                |    7 +
block/snapshot.c             |   45 +++++++
exec.c                       |    7 +
hw/ppc/spapr.c               |    2 +-
hw/s390x/s390-stattrib.c     |    2 +-
include/block/block_int.h    |    9 ++
include/block/snapshot.h     |    7 +
include/exec/memory.h        |    9 ++
include/exec/ram_addr.h      |    2 +
include/migration/misc.h     |    4 +
include/migration/register.h |    2 +-
include/migration/snapshot.h |    3 +
memory.c                     |   18 ++-
migration/block.c            |    2 +-
migration/nvdimm.c           | 1033 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
migration/qemu-file.c        |   61 +++++++++
migration/qemu-file.h        |   14 ++
migration/ram.c              |   19 ++-
migration/savevm.c           |   62 ++++++++-
vl.c                         |    1 +
23 files changed, 1452 insertions(+), 14 deletions(-)
