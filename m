Received: from eggs.gnu.org ([2001:4830:134:3::10]:41349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR46-0008BS-H4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR41-0004Ja-DY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  1 Mar 2018 18:27:06 +0200
Message-Id: <cover.1519921268.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/7] Add checks for corruption in the snapshot
 table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Hey ho!

As we have already discussed in the mailing list, the offset and size
values of snapshots' L1 tables are almost never validated in the QEMU
code.

One way to deal with this is to validate them when the image is being
opened (in qcow2_read_snapshots()) and return an error if there's
anything wrong. However this would render the image unusable because
we wouldn't be able to try to recover data using the active table as
we can do now.

Another possibility is to refuse opening the image but add a way to
fix it using 'qemu-img check'. But this would be a destructive
operation, and knowing that the image is already corrupted we can't
guarantee that we wouldn't be corrupting it even more.

So although having a way to repair this kind of corruption would be
nice, we should still allow the user to try to open the image and read
data from it without requiring a potentially destructive operation
first.

So this series simply validates the snapshots' L1 tables in the places
where they are actually used. We already have a function to do this
kind of checks so we only need to call it.

Regards,

Berto

Alberto Garcia (7):
  qcow2: Generalize validate_table_offset() into qcow2_validate_table()
  qcow2: Check L1 table offset in qcow2_snapshot_load_tmp()
  qcow2: Check L1 table parameters in qcow2_expand_zero_clusters()
  qcow2: Check snapshot L1 tables in qcow2_check_metadata_overlap()
  qcow2: Check snapshot L1 table in qcow2_snapshot_goto()
  qcow2: Check snapshot L1 table in qcow2_snapshot_delete()
  qcow2: Make qemu-img check detect corrupted L1 tables in snapshots

 block/qcow2-cluster.c      | 20 +++++++-----
 block/qcow2-refcount.c     | 24 ++++++++++++++-
 block/qcow2-snapshot.c     | 21 +++++++++++--
 block/qcow2.c              | 77 ++++++++++++++++++----------------------------
 block/qcow2.h              | 10 +++---
 tests/qemu-iotests/080     | 22 ++++++++++++-
 tests/qemu-iotests/080.out | 54 ++++++++++++++++++++++++++------
 7 files changed, 155 insertions(+), 73 deletions(-)

-- 
2.11.0
