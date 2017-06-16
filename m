Received: from eggs.gnu.org ([2001:4830:134:3::10]:49648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfW-0007Aq-EP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfS-0007RX-AP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:30 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:12201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLwfS-0007Qq-3e
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00LR5MOO6I40@mailout2.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 20:12:24 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 16 Jun 2017 22:12:02 +0300
Message-id: <1497640325-10960-6-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
References: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616191222eucas1p186aab01cb769c9c2f7a1b61be48cd9a2@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH v9 5/8] migration: introduce postcopy-blocktime
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, peterx@redhat.com, i.maximets@samsung.com, quintela@redhat.com, dgilbert@redhat.com

Right now it could be used on destination side to
enable vCPU blocktime calculation for postcopy live migration.
vCPU blocktime - it's time since vCPU thread was put into
interruptible sleep, till memory page was copied and thread awake.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/migration.c | 9 +++++++++
 migration/migration.h | 1 +
 qapi-schema.json      | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 56929dc..f920ddf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1233,6 +1233,15 @@ bool migrate_zero_blocks(void)
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
index 601e4ab..cf4d04e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -152,6 +152,7 @@ int migrate_compress_level(void);
 int migrate_compress_threads(void);
 int migrate_decompress_threads(void);
 bool migrate_use_events(void);
+bool migrate_postcopy_blocktime(void);
 
 /* Sending on the return path - generic and then for each message type */
 void migrate_send_rp_shut(MigrationIncomingState *mis,
diff --git a/qapi-schema.json b/qapi-schema.json
index 4b50b65..e906953 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -900,12 +900,15 @@
 #          offers more flexibility.
 #          (Since 2.10)
 #
+# @postcopy-blocktime: Calculate downtime for postcopy live migration
+#                     (since 2.10)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram',
-           'block' ] }
+           'block', 'postcopy-blocktime'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
1.8.3.1
