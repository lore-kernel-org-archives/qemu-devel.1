Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGX-00077B-2m
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dGYGT-0002B8-SU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dGYGT-0002A5-N7
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:08:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C62B7F6A0
	for <qemu-devel@nongnu.org>; Thu,  1 Jun 2017 22:08:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri,  2 Jun 2017 00:08:08 +0200
Message-Id: <20170601220813.30535-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] Make RAMState dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This series make RAMState a dynamic variable.  We create it at the
beggining of migration and remove it when migration ends.

- Move ZERO_TARGET_PAGE to XBZRLE
- print the number of remaining pages not only the number of bytes
  this makes easier to use statistics.
- How to export statistics to use for "info migrate"?  It is
  complicated, right now we use accessor functions for RAMState.  But we
  already have a struct with the fields that we need.  MigrationStats.
  Use them instead of having to create a new accessor function for
  each new field that we print.  There is another reason for this: We
  want to make RAMstate dynamic. And we access states after migration
  has finished.
- We end making RAMState dynamic.

This series is on top of the "previous consistent ouput"

Please, review.

Thanks, Juan.

Juan Quintela (5):
  ram: Call migration_page_queue_free() at ram_migration_cleanup()
  ram: Move ZERO_TARGET_PAGE inside XBZRLE
  migration: Print statistics about the number of remaining target pages
  ram: Use MigrationStats for statistics
  ram: Make RAMState dynamic

 migration/migration.c |  35 ++++----
 migration/ram.c       | 243 ++++++++++++++++++--------------------------------
 migration/ram.h       |  16 +---
 qapi-schema.json      |   6 +-
 4 files changed, 113 insertions(+), 187 deletions(-)

-- 
2.9.4
