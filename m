Received: from eggs.gnu.org ([2001:4830:134:3::10]:50369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQI-0000ZS-46
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsjQE-0007MY-7V
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 01:44:18 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 15 Sep 2017 13:44:01 +0800
Message-Id: <20170915054404.19914-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] migration: Fix crash by cleaning up before
 quit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, peterx@redhat.com

Quit command causes asssertion failure in block layer due to op blockers added
by BMDS, if there is an active block migration.

Fixing this by calling migration cleaning up functions at the end of main()
before bdrv_close_all() is called.

Fam Zheng (3):
  migration: Allow ram_save_cleanup to be called with empty state
  migration: Cancel migration at exit
  iotests: Add "quit during block migration" case 195

 include/migration/misc.h   |  1 +
 migration/migration.c      |  7 +++-
 migration/ram.c            |  3 ++
 tests/qemu-iotests/195     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/195.out | 19 +++++++++
 tests/qemu-iotests/group   |  1 +
 vl.c                       |  3 ++
 7 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/195
 create mode 100644 tests/qemu-iotests/195.out

-- 
2.13.5
