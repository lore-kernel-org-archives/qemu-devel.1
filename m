Received: from eggs.gnu.org ([209.51.188.92]:39997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-0002u0-L6
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-000307-UQ
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
Received: from m50-110.126.com ([123.125.50.110]:42738)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-0002vL-Bm
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:02 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:08:48 +0800
Message-Id: <20190113140849.38339-5-lifei1214@126.com>
In-Reply-To: <20190113140849.38339-1-lifei1214@126.com>
References: <20190113140849.38339-1-lifei1214@126.com>
Subject: [Qemu-devel] [PATCH for-4.0 4/5] migration: add more error handling
 for postcopy_ram_enable_notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <fli@suse.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Fei Li <fli@suse.com>

Call postcopy_ram_incoming_cleanup() to do the cleanup when
postcopy_ram_enable_notify fails. Besides, report the error
message when qemu_ram_foreach_migratable_block() fails.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 1 +
 migration/savevm.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index e5c02a32c5..fa09dba534 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1117,6 +1117,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 
     /* Mark so that we get notified of accesses to unwritten areas */
     if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
+        error_report("ram_block_enable_notify failed");
         return -1;
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 9e45fb4f3f..d784e8aa40 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1729,6 +1729,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
      */
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_enable_notify(mis)) {
+            postcopy_ram_incoming_cleanup(mis);
             return -1;
         }
     }
-- 
2.17.2 (Apple Git-113)
