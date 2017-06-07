Received: from eggs.gnu.org ([2001:4830:134:3::10]:54585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVi-00047x-Ct
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIVVf-0000tF-4b
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:10 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIVVe-0000sK-Sa
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 03:36:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR600FJD2G3VS80@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:36:03 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 07 Jun 2017 10:35:22 +0300
Message-id: <1496820931-27416-3-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
References: <1496820931-27416-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607073602eucas1p292a25ea3edab8ba8eab3ae95fa2519de@eucas1p2.samsung.com>
Subject: [Qemu-devel] [[PATCH V7] 02/11] migration: pass
 MigrationIncomingState* into migration check functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, dgilbert@redhat.com, i.maximets@samsung.com, peterx@redhat.com

That tiny refactoring is necessary to be able to set
UFFD_FEATURE_THREAD_ID while requesting features, and then
to create downtime context in case when kernel supports it.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/migration.c    |  3 ++-
 migration/postcopy-ram.c | 10 +++++-----
 migration/postcopy-ram.h |  2 +-
 migration/savevm.c       |  2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 48c94c9..2a77636 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -726,6 +726,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
                                   Error **errp)
 {
     MigrationState *s = migrate_get_current();
+    MigrationIncomingState *mis = migration_incoming_get_current();
     MigrationCapabilityStatusList *cap;
     bool old_postcopy_cap = migrate_postcopy_ram();
 
@@ -772,7 +773,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
          * special support.
          */
         if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
-            !postcopy_ram_supported_by_host()) {
+            !postcopy_ram_supported_by_host(mis)) {
             /* postcopy_ram_supported_by_host will have emitted a more
              * detailed message
              */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9c41887..10d39a0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -63,7 +63,7 @@ struct PostcopyDiscardState {
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
-static bool ufd_version_check(int ufd)
+static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
 {
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
@@ -126,7 +126,7 @@ static int test_ramblock_postcopiable(const char *block_name, void *host_addr,
  * normally fine since if the postcopy succeeds it gets turned back on at the
  * end.
  */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     long pagesize = getpagesize();
     int ufd = -1;
@@ -149,7 +149,7 @@ bool postcopy_ram_supported_by_host(void)
     }
 
     /* Version and features check */
-    if (!ufd_version_check(ufd)) {
+    if (!ufd_version_check(ufd, mis)) {
         goto out;
     }
 
@@ -525,7 +525,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_version_check(mis->userfault_fd)) {
+    if (!ufd_version_check(mis->userfault_fd, mis)) {
         return -1;
     }
 
@@ -663,7 +663,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 #else
 /* No target OS support, stubs just fail */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     error_report("%s: No OS support", __func__);
     return false;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 52d51e8..587a8b8 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -14,7 +14,7 @@
 #define QEMU_POSTCOPY_RAM_H
 
 /* Return true if the host supports everything we need to do postcopy-ram */
-bool postcopy_ram_supported_by_host(void);
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
 
 /*
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
diff --git a/migration/savevm.c b/migration/savevm.c
index 9c320f5..8b7bab8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1380,7 +1380,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
-    if (!postcopy_ram_supported_by_host()) {
+    if (!postcopy_ram_supported_by_host(mis)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
-- 
1.9.1
