Received: from eggs.gnu.org ([2001:4830:134:3::10]:56601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi1z-0006az-Lx
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi1w-0001t3-Gw
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi1w-0001ry-4g
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18623C0AE082
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:23 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:04 +0800
Message-Id: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/13] migration: cleanup migration_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v2
- add r-bs
- the first patch: don't assert but error_report [Juan, Dave]
- remove mig_* prefix in var names [Juan]
- two more patches [Juan]:
  migration: remove notify in migrate_fd_error
  migration: remove some block_cleanup_parameters()
- rename old_vm_running to vm_was_running [Juan]
- rename vm_down_start_time to downtime_start [Juan]
- set s->downtime conditionally in migration_calculate_complete() so
  that postcopy downtime can be kept [Juan]

Firstly this series is something as a first attempt of me to cleanup
some migration code.  It may not be a good idea, but I still think it
worth a try, so I posted it.  Let me know if any of you don't like it,
so I can stop.  At least after the series the migration_thread()
function can be far shorter and much easier for first-time readers
AFAICT.

For this single function, the most complexity part is quite a lot of
local variables crossly referenced everywhere, and during the cleanup
I do think the COLO part is hacky too.

There can be some functional changes too in the future:

- cancel migration as cleanup of QEMU quit
- add migration locks to protect migration internal states
- ...

But for this single series, there is still no functional change yet.

Please have a look.  Any feedback is welcomed.  Thanks,

Peter Xu (13):
  migration: assert colo instead of check
  migration: qemu_savevm_state_cleanup() in cleanup
  migration: remove "enable_colo" var
  migration: split use of MigrationState.total_time
  migration: move vm_old_running into global state
  migration: introduce downtime_start
  migration: introduce migrate_calculate_complete
  migration: use switch at the end of migration
  migration: cleanup stats update into function
  migration: major cleanup for migrate iterations
  migration: put the finish part into a new function
  migration: remove some block_cleanup_parameters()
  migration: remove notify in fd_error

 migration/migration.c | 307 +++++++++++++++++++++++++++++---------------------
 migration/migration.h |  22 ++++
 2 files changed, 200 insertions(+), 129 deletions(-)

-- 
2.14.3
