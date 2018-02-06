Received: from eggs.gnu.org ([2001:4830:134:3::10]:44483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5ZJ-0005mO-TU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5ZD-0000Bs-TU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35121)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5ZD-0000AE-NN
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:53:55 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:34 +0000
Message-Id: <20180206154936.13565-13-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 12/14] migration: Recover block devices if
 failure in device state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In e91d895 I added the new pause-before-switchover mechanism
to allow migration completion to be delayed; this changes the
last state prior to completion to MIGRATE_STATUS_DEVICE rather
than MIGRATE_STATUS_ACTIVE.

Fix the failure path in migration_completion to recover the block
devices if it fails in MIGRATE_STATUS_DEVICE, not just the
MIGRATE_STATUS_ACTIVE that it previously had.

This corresponds to rh bz:
  https://bugzilla.redhat.com/show_bug.cgi?id=1538494
whose symptom is an occasional source crash on a failed migration.

Fixes: e91d8951d59d483f085f
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 44cbfb0ddd..0fdb2e410d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2122,7 +2122,8 @@ fail_invalidate:
     /* If not doing postcopy, vm_start() will be called: let's regain
      * control on images.
      */
-    if (s->state == MIGRATION_STATUS_ACTIVE) {
+    if (s->state == MIGRATION_STATUS_ACTIVE ||
+        s->state == MIGRATION_STATUS_DEVICE) {
         Error *local_err = NULL;
 
         qemu_mutex_lock_iothread();
-- 
2.14.3
