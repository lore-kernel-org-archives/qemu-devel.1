Received: from eggs.gnu.org ([2001:4830:134:3::10]:38489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehh-0008M2-Vd
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gWehf-00083u-Gi
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:49 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gWehf-0007xE-6F
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:51:47 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 11 Dec 2018 17:50:55 +0800
Message-Id: <20181211095057.14623-6-fli@suse.com>
In-Reply-To: <20181211095057.14623-1-fli@suse.com>
References: <20181211095057.14623-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v8 5/7] migration: add more error
 handling for postcopy_ram_enable_notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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
2.13.7
