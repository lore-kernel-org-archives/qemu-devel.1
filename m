Received: from eggs.gnu.org ([2001:4830:134:3::10]:53459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Jx-00079B-6b
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1co9Js-0003Cm-BN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1co9Js-0003C7-1u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 09:50:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1530B4E4D3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 13:50:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 15 Mar 2017 14:49:50 +0100
Message-Id: <20170315135021.6978-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/31] Creating RAMState for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

Hi

Currently, we have several places where we store informaticon about
ram for migration pruposes:
- global variables on migration/ram.c
- inside the accounting_info struct in migration/ram.c
  notice that not all the accounting vars are inside there
- some stuff is in MigrationState, althought it belongs to migrate/ram.c

So, this series does:
- move everything related to ram.c to RAMState struct
- make all the statistics consistent, exporting them with an accessor
  function

Why now?

Because I am trying to do some more optimizations about how we send
data around and it is basically impossible to do with current code, we
still need to add more variables.  Notice that there are things like that:
- accounting info was only reset if we had xbzrle enabled
- How/where to initialize variables are completely inconsistent.



To Do:

- There are still places that access directly the global struct.
  Mainly postcopy.  We could finfd a way to make a pointer to the
  current migration.  If people like the approach, I will search where
  to put it.
- I haven't posted any real change here, this is just the move of
  variables to the struct and pass the struct around.  Optimizations
  will came after.

- Consolidate XBZRLE, Compression params, etc in its own structs
  (inside or not RAMState, to be able to allocate ones, others, or
  ...)

Comments, please.


Juan Quintela (31):
  ram: move more fields into RAMState
  ram: Add dirty_rate_high_cnt to RAMState
  ram: move bitmap_sync_count into RAMState
  ram: Move start time into RAMState
  ram: Move bytes_xfer_prev into RAMState
  ram: Move num_dirty_pages_period into RAMState
  ram: Move xbzrle_cache_miss_prev into RAMState
  ram: Move iterations_prev into RAMState
  ram: Move dup_pages into RAMState
  ram: Remove unused dump_mig_dbytes_transferred()
  ram: Remove unused pages_skiped variable
  ram: Move norm_pages to RAMState
  ram: Remove norm_mig_bytes_transferred
  ram: Move iterations into RAMState
  ram: Move xbzrle_bytes into RAMState
  ram: Move xbzrle_pages into RAMState
  ram: Move xbzrle_cache_miss into RAMState
  ram: move xbzrle_cache_miss_rate into RAMState
  ram: move xbzrle_overflows into RAMState
  ram: move migration_dirty_pages to RAMState
  ram: Everything was init to zero, so use memset
  ram: move migration_bitmap_mutex into RAMState
  ram: Move migration_bitmap_rcu into RAMState
  ram: Move bytes_transferred into RAMState
  ram: Use the RAMState bytes_transferred parameter
  ram: Remove ram_save_remaining
  ram: Move last_req_rb to RAMState
  ram: Create ram_dirty_sync_count()
  ram: Remove dirty_bytes_rate
  ram: move dirty_pages_rate to RAMState
  ram: move postcopy_requests into RAMState

 include/migration/migration.h |  14 +-
 migration/migration.c         |  21 +-
 migration/ram.c               | 594 +++++++++++++++++++++---------------------
 3 files changed, 303 insertions(+), 326 deletions(-)

-- 
2.9.3
