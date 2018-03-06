Received: from eggs.gnu.org ([2001:4830:134:3::10]:60846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFEq-0007Km-R1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFEo-00080i-1B
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:52 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue,  6 Mar 2018 18:14:05 +0200
Message-Id: <cover.1520352600.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 0/7] Add checks for corruption in the
 snapshot table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

Hey,

here's the new version of this series. It fixes a leak reported by
Kevin and adds a couple of error_report_err() to make use of the
message returned by qcow2_validate_table().

Regards,

Berto

Changes:

v2:
- Patch 3: Don't leak l1_table and report the error returned by
  qcow2_validate_table()
- Patch 5: Report the error returned by qcow2_validate_table().

v1: https://lists.gnu.org/archive/html/qemu-block/2018-03/msg00030.html
- Initial version

Output of backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[----] [-C] 'qcow2: Generalize validate_table_offset() into qcow2_validate_table()'
002/7:[----] [--] 'qcow2: Check L1 table offset in qcow2_snapshot_load_tmp()'
003/7:[0010] [FC] 'qcow2: Check L1 table parameters in qcow2_expand_zero_clusters()'
004/7:[----] [-C] 'qcow2: Check snapshot L1 tables in qcow2_check_metadata_overlap()'
005/7:[0007] [FC] 'qcow2: Check snapshot L1 table in qcow2_snapshot_goto()'
006/7:[----] [-C] 'qcow2: Check snapshot L1 table in qcow2_snapshot_delete()'
007/7:[----] [-C] 'qcow2: Make qemu-img check detect corrupted L1 tables in snapshots'

Alberto Garcia (7):
  qcow2: Generalize validate_table_offset() into qcow2_validate_table()
  qcow2: Check L1 table offset in qcow2_snapshot_load_tmp()
  qcow2: Check L1 table parameters in qcow2_expand_zero_clusters()
  qcow2: Check snapshot L1 tables in qcow2_check_metadata_overlap()
  qcow2: Check snapshot L1 table in qcow2_snapshot_goto()
  qcow2: Check snapshot L1 table in qcow2_snapshot_delete()
  qcow2: Make qemu-img check detect corrupted L1 tables in snapshots

 block/qcow2-cluster.c      | 24 ++++++++++-----
 block/qcow2-refcount.c     | 24 ++++++++++++++-
 block/qcow2-snapshot.c     | 24 +++++++++++++--
 block/qcow2.c              | 77 ++++++++++++++++++----------------------------
 block/qcow2.h              | 10 +++---
 tests/qemu-iotests/080     | 22 ++++++++++++-
 tests/qemu-iotests/080.out | 58 ++++++++++++++++++++++++++++------
 7 files changed, 166 insertions(+), 73 deletions(-)

-- 
2.11.0
