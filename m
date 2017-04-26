Received: from eggs.gnu.org ([2001:4830:134:3::10]:60671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3FA2-0001xY-Ot
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1d3F9x-0002uM-Rh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:23505)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1d3F9x-0002tp-Jy
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 01:06:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OP00098W3IYT000@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:06:34 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Wed, 26 Apr 2017 08:06:16 +0300
Message-id: <1493183181-21962-3-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
References: <1493183181-21962-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170426050633eucas1p131e8089df08fbd540d24b2d2a960012c@eucas1p1.samsung.com>
Subject: [Qemu-devel] [PATCH V3 2/6] migration: pass ptr to
 MigrationIncomingState into migration ufd_version_check &
 postcopy_ram_supported_by_host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: a.perevalov@samsung.com, i.maximets@samsung.com, f4bug@amsat.org, peterx@redhat.com, qemu-devel@nongnu.org

That tiny refactoring is necessary to be able to set
UFFD_FEATURE_THREAD_ID while requesting features, and then
to create downtime context in case when kernel supports it.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 include/migration/postcopy-ram.h |  2 +-
 migration/migration.c            |  2 +-
 migration/postcopy-ram.c         | 10 +++++-----
 migration/savevm.c               |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/migration/postcopy-ram.h b/include/migration/postcopy-ram.h
index 8e036b9..809f6db 100644
--- a/include/migration/postcopy-ram.h
+++ b/include/migration/postcopy-ram.h
@@ -14,7 +14,7 @@
 #define QEMU_POSTCOPY_RAM_H
 
 /* Return true if the host supports everything we need to do postcopy-ram */
-bool postcopy_ram_supported_by_host(void);
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis);
 
 /*
  * Make all of RAM sensitive to accesses to areas that haven't yet been written
diff --git a/migration/migration.c b/migration/migration.c
index ad4036f..79f6425 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -802,7 +802,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
          * special support.
          */
         if (!old_postcopy_cap && runstate_check(RUN_STATE_INMIGRATE) &&
-            !postcopy_ram_supported_by_host()) {
+            !postcopy_ram_supported_by_host(NULL)) {
             /* postcopy_ram_supported_by_host will have emitted a more
              * detailed message
              */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dc80dbb..dcf2ed1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -60,7 +60,7 @@ struct PostcopyDiscardState {
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
-static bool ufd_version_check(int ufd)
+static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
 {
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
@@ -113,7 +113,7 @@ static int test_range_shared(const char *block_name, void *host_addr,
  * normally fine since if the postcopy succeeds it gets turned back on at the
  * end.
  */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     long pagesize = getpagesize();
     int ufd = -1;
@@ -136,7 +136,7 @@ bool postcopy_ram_supported_by_host(void)
     }
 
     /* Version and features check */
-    if (!ufd_version_check(ufd)) {
+    if (!ufd_version_check(ufd, mis)) {
         goto out;
     }
 
@@ -515,7 +515,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_version_check(mis->userfault_fd)) {
+    if (!ufd_version_check(mis->userfault_fd, mis)) {
         return -1;
     }
 
@@ -653,7 +653,7 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
 
 #else
 /* No target OS support, stubs just fail */
-bool postcopy_ram_supported_by_host(void)
+bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
 {
     error_report("%s: No OS support", __func__);
     return false;
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..f01e418 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1360,7 +1360,7 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
-    if (!postcopy_ram_supported_by_host()) {
+    if (!postcopy_ram_supported_by_host(mis)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
-- 
1.9.1
