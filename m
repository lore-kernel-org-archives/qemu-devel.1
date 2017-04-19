Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whI-0003Pm-Ef
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0whF-0006lf-Bf
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0whF-0006kf-2O
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 16:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEAECC05678F
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 20:59:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:58:24 +0200
Message-Id: <20170419205923.8808-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/59] RAMState + qdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

Hi

This is just v3 rebased, with review-by, and the small changes suggested.
I added the removal of hotmplug because they are already reviewed.

I plan to send this as migration/next for when 2.0 open.



- put all reviews
- rebase
- small changes on compression-switch
- add all the hotplug removal comments/typos/fixes

Please, comment.

Thanks, Juan.

[v3]
Contination of the previous series, addressed comments from Peter and Dav=
e.

- All docs suggestions changed
- rename flush_page_queue to migration_page_queue()
- rebase on top of latest
- move the compression-switch logic
- change parameters to page_abs everywhere (notice that we end dropping t=
hem)


[v2]
Continuation of previous series, all review comments addressed. New thing=
s:
- Consolidate all function comments in the same style (yes, docs)
- Be much more careful with maintaining comments correct
- Move all postcopy fields to RAMState
- Move QEMUFile to RAMState
- rename qemu_target_page_bits() to qemu_target_page_size() to reflect us=
e
- Remove MigrationState from functions that don't need it
- reorganize last_sent_block to the place where it is used/needed
- Move several places from offsets to pages
- Rename last_ram_offset() to last_ram_page() to refect use

Please comment.


[v1]
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
still need to add more variables.  Notice that there are things like that=
:
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


[v2 no-hotplug]
This updates patches with all the comments received.
I move qdev_unplug() to make linux-user compile.

Please, review.


[RFC - v1 no-hotplug]
This series disable hotplug/unplug during migration.  Thank to Markus
for explaining where I had to put the checks.  Why?  Because during
migration we will fail if there are changes.  For instance, in
postcopy, if we add a memory region, we would failing.  Same for other
devices if they are not setup exactly the same on destination.

Iidea would be to disable it, andthen enable for the thing that we know t=
hat work.

This series are on top of my previous RAMState v2 serie.

Commets, please?

Thanks, Juan.


Comments, please.


Chao Fan (1):
  ram: Add page-size to output in 'info migrate'

Juan Quintela (58):
  ram: Update all functions comments
  ram: Rename flush_page_queue() to migration_page_queue_free()
  ram: Rename block_name to rbname
  ram: Create RAMState
  ram: Add dirty_rate_high_cnt to RAMState
  ram: Move bitmap_sync_count into RAMState
  ram: Move start time into RAMState
  ram: Move bytes_xfer_prev into RAMState
  ram: Change byte_xfer_{prev,now} type to uint64_t
  ram: Move num_dirty_pages_period into RAMState
  ram: Change num_dirty_pages_period type to uint64_t
  ram: Move xbzrle_cache_miss_prev into RAMState
  ram: Move iterations_prev into RAMState
  ram: Move dup_pages into RAMState
  ram: Remove unused dup_mig_bytes_transferred()
  ram: Remove unused pages_skipped variable
  ram: Move norm_pages to RAMState
  ram: Remove norm_mig_bytes_transferred
  ram: Move iterations into RAMState
  ram: Move xbzrle_bytes into RAMState
  ram: Move xbzrle_pages into RAMState
  ram: Move xbzrle_cache_miss into RAMState
  ram: Move xbzrle_cache_miss_rate into RAMState
  ram: Move xbzrle_overflows into RAMState
  ram: Move migration_dirty_pages to RAMState
  ram: Everything was init to zero, so use memset
  ram: Move migration_bitmap_mutex into RAMState
  ram: Move migration_bitmap_rcu into RAMState
  ram: Move bytes_transferred into RAMState
  ram: Use the RAMState bytes_transferred parameter
  ram: Remove ram_save_remaining
  ram: Move last_req_rb to RAMState
  ram: Move src_page_req* to RAMState
  ram: Create ram_dirty_sync_count()
  ram: Remove dirty_bytes_rate
  ram: Move dirty_pages_rate to RAMState
  ram: Move postcopy_requests into RAMState
  ram: Add QEMUFile to RAMState
  ram: Move QEMUFile into RAMState
  ram: Remove compression_switch and inline its logic
  migration: Remove MigrationState from migration_in_postcopy
  ram: We don't need MigrationState parameter anymore
  ram: Rename qemu_target_page_bits() to qemu_target_page_size()
  ram: Pass RAMBlock to bitmap_sync
  ram: ram_discard_range() don't use the mis parameter
  ram: reorganize last_sent_block
  ram: Use page number instead of an address for the bitmap operations
  ram: Remember last_page instead of last_offset
  ram: Change offset field in PageSearchStatus to page
  ram: Use ramblock and page offset instead of absolute offset
  ram: rename last_ram_offset() last_ram_pages()
  ram: Use RAMBitmap type for coherence
  migration: Remove MigrationState parameter from migration_is_idle()
  qdev: qdev_hotplug is really a bool
  qdev: Export qdev_hot_removed
  qdev: Move qdev_unplug() to qdev-monitor.c
  migration: Disable hotplug/unplug during migration
  ram: Remove migration_bitmap_extend()

 exec.c                        |   11 +-
 hmp.c                         |    3 +
 hw/core/qdev.c                |   40 +-
 include/exec/ram_addr.h       |    8 +-
 include/hw/qdev-core.h        |    3 +-
 include/migration/migration.h |   41 +-
 include/sysemu/sysemu.h       |    2 +-
 migration/migration.c         |   44 +-
 migration/postcopy-ram.c      |   14 +-
 migration/ram.c               | 1210 +++++++++++++++++++++--------------=
------
 migration/savevm.c            |   15 +-
 migration/trace-events        |    4 +-
 qapi-schema.json              |    5 +-
 qdev-monitor.c                |   45 ++
 14 files changed, 741 insertions(+), 704 deletions(-)

--=20
2.9.3
