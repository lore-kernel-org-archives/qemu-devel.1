Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfU-000795-OH
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dLwfR-0007Qg-D1
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:28 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:20723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dLwfR-0007Px-3w
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 15:12:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ORN00H8DMONOA20@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 16 Jun 2017 20:12:23 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 16 Jun 2017 22:12:01 +0300
Message-id: <1497640325-10960-5-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
References: <1497640325-10960-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170616191222eucas1p2fc88d38fb9f84f7da04d853811dd07db@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v9 4/8] migration: split ufd_version_check onto
 receive/request features part
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

This modification is necessary for userfault fd features which are
required to be requested from userspace.
UFFD_FEATURE_THREAD_ID is a one of such "on demand" feature, which will
be introduced in the next patch.

QEMU have to use separate userfault file descriptor, due to
userfault context has internal state, and after first call of
ioctl UFFD_API it changes its state to UFFD_STATE_RUNNING (in case of
success), but kernel while handling ioctl UFFD_API expects UFFD_STATE_WAIT_API.
So only one ioctl with UFFD_API is possible per ufd.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 migration/postcopy-ram.c | 94 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index b35baf3..d152f1a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -63,16 +63,67 @@ struct PostcopyDiscardState {
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
-static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
+
+/**
+ * receive_ufd_features: check userfault fd features, to request only supported
+ * features in the future.
+ *
+ * Returns: true on success
+ *
+ * __NR_userfaultfd - should be checked before
+ *  @features: out parameter will contain uffdio_api.features provided by kernel
+ *              in case of success
+ */
+static bool receive_ufd_features(uint64_t *features)
 {
-    struct uffdio_api api_struct;
-    uint64_t ioctl_mask;
+    struct uffdio_api api_struct = {0};
+    int ufd;
+    bool ret = true;
+
+    /* if we are here __NR_userfaultfd should exists */
+    ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
+    if (ufd == -1) {
+        error_report("%s: syscall __NR_userfaultfd failed: %s", __func__,
+                     strerror(errno));
+        return false;
+    }
 
+    /* ask features */
     api_struct.api = UFFD_API;
     api_struct.features = 0;
     if (ioctl(ufd, UFFDIO_API, &api_struct)) {
         error_report("%s: UFFDIO_API failed: %s", __func__,
                      strerror(errno));
+        ret = false;
+        goto release_ufd;
+    }
+
+    *features = api_struct.features;
+
+release_ufd:
+    close(ufd);
+    return ret;
+}
+
+/**
+ * request_ufd_features: this function should be called only once on a newly
+ * opened ufd, subsequent calls will lead to error.
+ *
+ * Returns: true on succes
+ *
+ * @ufd: fd obtained from userfaultfd syscall
+ * @features: bit mask see UFFD_API_FEATURES
+ */
+static bool request_ufd_features(int ufd, uint64_t features)
+{
+    struct uffdio_api api_struct = {0};
+    uint64_t ioctl_mask;
+
+    api_struct.api = UFFD_API;
+    api_struct.features = features;
+    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
+        error_report("%s failed: UFFDIO_API failed: %s", __func__,
+                     strerror(errno));
         return false;
     }
 
@@ -84,11 +135,42 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
         return false;
     }
 
+    return true;
+}
+
+static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
+{
+    uint64_t asked_features = 0;
+    static uint64_t supported_features;
+
+    /*
+     * it's not possible to
+     * request UFFD_API twice per one fd
+     * userfault fd features is persistent
+     */
+    if (!supported_features) {
+        if (!receive_ufd_features(&supported_features)) {
+            error_report("%s failed", __func__);
+            return false;
+        }
+    }
+
+    /*
+     * request features, even if asked_features is 0, due to
+     * kernel expects UFFD_API before UFFDIO_REGISTER, per
+     * userfault file descriptor
+     */
+    if (!request_ufd_features(ufd, asked_features)) {
+        error_report("%s failed: features %" PRIu64, __func__,
+                     asked_features);
+        return false;
+    }
+
     if (getpagesize() != ram_pagesize_summary()) {
         bool have_hp = false;
         /* We've got a huge page */
 #ifdef UFFD_FEATURE_MISSING_HUGETLBFS
-        have_hp = api_struct.features & UFFD_FEATURE_MISSING_HUGETLBFS;
+        have_hp = supported_features & UFFD_FEATURE_MISSING_HUGETLBFS;
 #endif
         if (!have_hp) {
             error_report("Userfault on this host does not support huge pages");
@@ -149,7 +231,7 @@ bool postcopy_ram_supported_by_host(MigrationIncomingState *mis)
     }
 
     /* Version and features check */
-    if (!ufd_version_check(ufd, mis)) {
+    if (!ufd_check_and_apply(ufd, mis)) {
         goto out;
     }
 
@@ -525,7 +607,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
      * Although the host check already tested the API, we need to
      * do the check again as an ABI handshake on the new fd.
      */
-    if (!ufd_version_check(mis->userfault_fd, mis)) {
+    if (!ufd_check_and_apply(mis->userfault_fd, mis)) {
         return -1;
     }
 
-- 
1.8.3.1
