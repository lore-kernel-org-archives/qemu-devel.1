Received: from eggs.gnu.org ([2001:4830:134:3::10]:52757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7u-0007li-UE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj7r-000613-NN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:28:06 -0500
Received: from mail-by2nam01on0050.outbound.protection.outlook.com
	([104.47.34.50]:15072
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj7r-0005zr-Cn
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:28:03 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:54:43 -0500
Message-ID: <148900648332.27090.14562192041474683540.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 20/20] migration: disable save/restore
 and migration when SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

Snapshot, Restore and Migration is not implemented yet. Return error when
user tries to perform any of these operations.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 migration/migration.c |    7 +++++++
 migration/savevm.c    |   11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 3dab684..287c72b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -37,6 +37,7 @@
 #include "io/channel-buffer.h"
 #include "io/channel-tls.h"
 #include "migration/colo.h"
+#include "sysemu/sev.h"
 
 #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
 
@@ -1221,6 +1222,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         error_setg(errp, QERR_MIGRATION_ACTIVE);
         return;
     }
+
+    if (sev_enabled()) {
+        error_setg(errp, "Migration is not implemented");
+        return;
+    }
+
     if (runstate_check(RUN_STATE_INMIGRATE)) {
         error_setg(errp, "Guest is waiting for an incoming migration");
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..bf6e9b0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,7 @@
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
+#include "sysemu/sev.h"
 
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
@@ -2084,6 +2085,11 @@ int save_vmstate(Monitor *mon, const char *name)
     Error *local_err = NULL;
     AioContext *aio_context;
 
+    if (sev_enabled()) {
+        monitor_printf(mon, "savevm is not implemented\n");
+        return -1;
+    }
+
     if (!bdrv_all_can_snapshot(&bs)) {
         monitor_printf(mon, "Device '%s' is writable but does not "
                        "support snapshots.\n", bdrv_get_device_name(bs));
@@ -2245,6 +2251,11 @@ int load_vmstate(const char *name)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
+    if (sev_enabled()) {
+        error_report("loadvm is not implemented");
+        return -ENOTSUP;
+    }
+
     if (!bdrv_all_can_snapshot(&bs)) {
         error_report("Device '%s' is writable but does not support snapshots.",
                      bdrv_get_device_name(bs));
