Received: from eggs.gnu.org ([2001:4830:134:3::10]:53264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1x-0002oP-Af
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvN1w-0002Eh-44
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvN1v-0002Dy-S2
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:04 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 14:25:03 +0200
Message-Id: <20170922122505.9413-17-quintela@redhat.com>
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 16/18] migration: pass MigrationIncomingState*
 into migration check functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Alexey Perevalov <a.perevalov@samsung.com>

From: Alexey Perevalov <a.perevalov@samsung.com>

That tiny refactoring is necessary to be able to set
UFFD_FEATURE_THREAD_ID while requesting features, and then
to create downtime context in case when kernel supports it.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c    |  3 ++-
 migration/postcopy-ram.c | 10 +++++-----
 migration/postcopy-ram.h |  2 +-
 migration/savevm.c       |  2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 266cd39c36..98429dc843 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -659,6 +659,7 @@ static bool migrate_caps_check(bool *cap_list,
 {
     MigrationCapabilityStatusList *cap;
     bool old_postcopy_cap;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     old_postcopy_cap = cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM];
 
@@ -692,7 +693,7 @@ static bool migrate_caps_check(bool *cap_list,
          * special support.
          */
         if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
-            !postcopy_ram_supported_by_host()) {
+            !postcopy_ram_supported_by_host(mis)) {
             /* postcopy_ram_supported_by_host will have emitted a more
              * detailed message
              */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7e21e6fd36..c70305ccc7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -61,7 +61,7 @@ struct PostcopyDiscardState {
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
-static bool ufd_version_check(int ufd)
+static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
 {
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
@@ -124,7 +124,7 @@ static int test_ramblock_postcopiable(const char *block_name, void *host_addr,
  * normally fine since if the postcopy succeeds it gets turned back on at the
  * end.
  */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     long pagesize = getpagesize();
     int ufd = -1;
@@ -147,7 +147,7 @@ bool postcopy_ram_supported_by_host(void)
     }
 
     /* Version and features check */
-    if (!ufd_version_check(ufd)) {
+    if (!ufd_version_check(ufd, mis)) {
         goto out;
     }
 
@@ -523,7 +523,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_version_check(mis->userfault_fd)) {
+    if (!ufd_version_check(mis->userfault_fd, mis)) {
         return -1;
     }
 
@@ -661,7 +661,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 #else
 /* No target OS support, stubs just fail */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     error_report("%s: No OS support", __func__);
     return false;
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 52d51e8007..587a8b86a7 100644
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
index 231474da34..2478352baf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1380,7 +1380,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return 0;
     }
 
-    if (!postcopy_ram_supported_by_host()) {
+    if (!postcopy_ram_supported_by_host(mis)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
-- 
2.13.5
