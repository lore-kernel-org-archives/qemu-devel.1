Received: from eggs.gnu.org ([2001:4830:134:3::10]:46458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er4vX-0001md-6I
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1er4vU-0007nX-3C
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:49:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1er4vT-0007n1-UN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:49:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86CBC402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 16:49:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Feb 2018 16:49:37 +0000
Message-Id: <20180228164937.18450-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Fix block failure cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This fixes a couple of cases where the block migration capability
doesn't get cleared when a migration failed.

1) When block migration is compiled out:
  (qemu) migrate -d -b  "exec:cat > /dev/null"
  QEMU compiled without old-style (blk/-b, inc/-i) block migration
  Use drive_mirror+NBD instead.
  (qemu) migrate_set_capability xbzrle off
  QEMU compiled without old-style (blk/-b, inc/-i) block migration
  Use drive_mirror+NBD instead.

  This corresponds to https://bugzilla.redhat.com/show_bug.cgi?id=1550022

2) When a migration with a bad protocol is tried:
  (qemu) migrate -d -b "foo:bah"
  Parameter 'uri' expects a valid migration protocol
  (qemu) info migrate_capabilities
  xbzrle: off
  rdma-pin-all: off
  auto-converge: off
  zero-blocks: off
  compress: off
  events: off
  postcopy-ram: off
  x-colo: off
  release-ram: off
  block: on   <<<<<<-----
  return-path: off
  pause-before-switchover: off
  x-multifd: off

Fixes: 2833c59b947
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b913b98803..da0e4a1f56 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1391,11 +1391,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
             return;
         }
         migrate_set_block_enabled(true, &local_err);
+        s->must_remove_block_options = true;
         if (local_err) {
             error_propagate(errp, local_err);
+            block_cleanup_parameters(s);
             return;
         }
-        s->must_remove_block_options = true;
     }
 
     if (has_inc && inc) {
@@ -1417,11 +1418,10 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-        return;
     }
 
     if (local_err) {
-- 
2.14.3
