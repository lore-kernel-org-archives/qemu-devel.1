Received: from eggs.gnu.org ([2001:4830:134:3::10]:58116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiWD-0003Bn-Nv
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiWA-0004KM-Lz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:53:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiWA-0004KA-Gz
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:53:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FCBF285C1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:53:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:53:33 +0200
Message-Id: <20170613095338.11560-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Create setup/cleanup methods for
 migration incoming side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

Hi

Changes from v1:
- Kevin detected that I didn't  called load_cleanup(), fix it.
- Be consistent and change the naming of the functions so they are all:
  qemu_savevm_state_* or qemu_loadvm_state*
- the traces still used the all names of _begin, instead of _setup,
  fix that.

Please, review.

Later, Juan.

PD: Yes, now that the includes are internal, we coauld rename
    "qemu_savevm_state_" to something shorter, like `savevm_".  The
    same for the loadvm counterparts.  But I am not doing any such
    changes soon, too much churn for so little gain.

[v1]
This series make:
- use of cleanup/save methods generic, not only for save_live methods
- create the equivalent methods for the load side (load_setup/cleanup)
- Make ram use this methods to see how/when they are used.

Stefan, Kevin, this were the methods that you asked for the block.c
migration, right?  Please, comment if they are enough for you.

Juan Quintela (5):
  migration: Rename save_live_setup() to save_setup()
  migration: Rename cleanup() to save_cleanup()
  migration: Create load_setup()/cleanup() methods
  migration: Convert ram to use new load_setup()/load_cleanup()
  migration: Make compression_threads use save/load_setup/cleanup()

 hw/ppc/spapr.c               |  4 +--
 include/migration/register.h |  6 ++--
 migration/block.c            |  4 +--
 migration/colo.c             |  2 +-
 migration/migration.c        | 10 +------
 migration/ram.c              | 66 ++++++++++++++++++++++++++++++--------------
 migration/ram.h              |  6 ----
 migration/savevm.c           | 60 ++++++++++++++++++++++++++++++++++------
 migration/savevm.h           |  2 +-
 migration/trace-events       |  4 ++-
 10 files changed, 111 insertions(+), 53 deletions(-)

-- 
2.9.4
