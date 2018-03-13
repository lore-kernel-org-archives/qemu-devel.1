Received: from eggs.gnu.org ([2001:4830:134:3::10]:59117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJU-0003MO-LS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJR-0001LU-Hg
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:04 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evlJR-0001Kp-44
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:01 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Mar 2018 17:53:39 +0300
Message-id: <1520952824-3172-2-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
References: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180313145357eucas1p2c2a3b0e5b9e652afc388aa4df4010a0f@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 1/6] migration: introduce postcopy-blocktime
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

Right now it could be used on destination side to
enable vCPU blocktime calculation for postcopy live migration.
vCPU blocktime - it's time since vCPU thread was put into
interruptible sleep, till memory page was copied and thread awake.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi/migration.json   | 6 +++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e345d0c..0ee9c1f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1527,6 +1527,15 @@ bool migrate_zero_blocks(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_ZERO_BLOCKS];
 }
 
+bool migrate_postcopy_blocktime(void)
+{
+    MigrationState *s;
+
+    s = migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME];
+}
+
 bool migrate_use_compression(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 08c5d2d..aa7a884 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -225,6 +225,7 @@ int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
+bool migrate_postcopy_blocktime(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_shut(MigrationIncomingState *mis,
diff --git a/qapi/migration.json b/qapi/migration.json
index 7f465a1..676ef06 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -354,12 +354,16 @@
 #
 # @x-multifd: Use more than one fd for migration (since 2.11)
 #
+# @postcopy-blocktime: Calculate downtime for postcopy live migration
+#                     (since 2.12)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block', 'return-path', 'pause-before-switchover', 'x-multifd' ] }
+           'block', 'return-path', 'pause-before-switchover', 'x-multifd',
+           'postcopy-blocktime' ] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.7.4
