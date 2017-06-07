Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVh-00047s-9l
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVe-0000sZ-62
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:09 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVd-0000rq-Qk
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600FH32G24780@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:02 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:20 +0300
Message-id: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170607073601eucas1p1b1897ed7d52d9edfed31971c592c2300@eucas1p1.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 00/11] calculate blocktime for postcopy
 live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

This is 7th version

(V6 -> V7)
    1. copied bitmap was placed into RAMBlock as another migration
related bitmaps.
    2. Ordering of mark_postcopy_blocktime_end call and ordering
of checking copied bitmap were changed.
    3. linewrap style defects
    4. new patch "postcopy_place_page factoring out"
    5. postcopy_ram_supported_by_host accepts
MigrationIncomingState in qmp_migrate_set_capabilities
    5. minor fixes of documentation. 
    and huge description of get_postcopy_total_blocktime was
moved. Davids comment.

This patch set is based on commit
a0d4aac7467dd02e5657b79e867f067330266a24
of git://git.qemu-project.org/qemu.git

Alexey Perevalov (11):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  migration: pass MigrationIncomingState* into migration check functions
  migration: fix hardcoded function name in error report
  migration: split ufd_version_check onto receive/request features part
  migration: introduce postcopy-blocktime capability
  migration: add postcopy blocktime ctx into MigrationIncomingState
  migration: add bitmap for copied page
  migration: postcopy_place_page factoring out
  migration: calculate vCPU blocktime on dst side
  migration: add postcopy total blocktime into query-migrate
  migration: postcopy_blocktime documentation

 docs/migration.txt                |  10 +
 hmp.c                             |  15 ++
 include/exec/ram_addr.h           |   2 +
 include/migration/migration.h     |  13 ++
 linux-headers/linux/userfaultfd.h |   4 +
 migration/migration.c             |  52 +++++-
 migration/postcopy-ram.c          | 374 ++++++++++++++++++++++++++++++++++++--
 migration/postcopy-ram.h          |   6 +-
 migration/ram.c                   |  40 +++-
 migration/ram.h                   |   4 +
 migration/savevm.c                |   2 +-
 migration/trace-events            |   6 +-
 qapi-schema.json                  |  14 +-
 13 files changed, 514 insertions(+), 28 deletions(-)

-- 
1.9.1
