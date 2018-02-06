Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Zl-0006BP-01
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Zk-0000ja-0t
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5Zj-0000it-On
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:54:27 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:36 +0000
Message-Id: <20180206154936.13565-15-dgilbert@redhat.com>
In-Reply-To: <20180206154936.13565-1-dgilbert@redhat.com>
References: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 14/14] migration: incoming postcopy advise
 sanity checks
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

From: Greg Kurz <groug@kaod.org>

If postcopy-ram was set on the source but not on the destination,
migration doesn't occur, the destination prints an error and boots
the guest:

qemu-system-ppc64: Expected vmdescription section, but got 0

We end up with two running instances.

This behaviour was introduced in 2.11 by commit 58110f0acb1a "migration:
split common postcopy out of ram postcopy" to prepare ground for the
upcoming dirty bitmap postcopy support. It adds a new case where the
source may send an empty postcopy advise because dirty bitmap doesn't
need to check page sizes like RAM postcopy does.

If the source has enabled postcopy-ram, then it sends an advise with
the page size values. If the destination hasn't enabled postcopy-ram,
then loadvm_postcopy_handle_advise() leaves the page size values on
the stream and returns. This confuses qemu_loadvm_state() later on
and causes the destination to start execution.

As discussed several times, postcopy-ram should be enabled both sides
to be functional. This patch changes the destination to perform some
extra checks on the advise length to ensure this is the case. Otherwise
an error is returned and migration is aborted.

Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <151791621042.19120.3103118434734245776.stgit@bahia>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b024ee3b22..f202c3de3a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1376,7 +1376,8 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
  * *might* happen - it might be skipped if precopy transferred everything
  * quickly.
  */
-static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
+                                         uint16_t len)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
@@ -1387,8 +1388,22 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
-    if (!migrate_postcopy_ram()) {
+    switch (len) {
+    case 0:
+        if (migrate_postcopy_ram()) {
+            error_report("RAM postcopy is enabled but have 0 byte advise");
+            return -EINVAL;
+        }
         return 0;
+    case 8 + 8:
+        if (!migrate_postcopy_ram()) {
+            error_report("RAM postcopy is disabled but have 16 byte advise");
+            return -EINVAL;
+        }
+        break;
+    default:
+        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
+        return -EINVAL;
     }
 
     if (!postcopy_ram_supported_by_host(mis)) {
@@ -1807,7 +1822,7 @@ static int loadvm_process_command(QEMUFile *f)
         return loadvm_handle_cmd_packaged(mis);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        return loadvm_postcopy_handle_advise(mis);
+        return loadvm_postcopy_handle_advise(mis, len);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         return loadvm_postcopy_handle_listen(mis);
-- 
2.14.3
