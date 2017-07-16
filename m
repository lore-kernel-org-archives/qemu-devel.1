Received: from eggs.gnu.org ([2001:4830:134:3::10]:46407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmg-0001D5-05
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpma-0008RO-4j
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmZ-0008Qp-T6
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:22 -0400
Message-Id: <1500235468-15341-40-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 39/45] osdep: move
 qemu_real_host_page_size/mask to osdep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

These only depend on the host and therefore belong in the common
osdep, not in a target-dependent object.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/cpu-all.h | 2 --
 include/qemu/osdep.h   | 8 ++++++++
 exec.c                 | 5 +----
 util/osdep.c           | 9 +++++++++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ffe43d5..778031c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -229,8 +229,6 @@ extern int target_page_bits;
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
  */
-extern uintptr_t qemu_real_host_page_size;
-extern intptr_t qemu_real_host_page_mask;
 extern uintptr_t qemu_host_page_size;
 extern intptr_t qemu_host_page_mask;
 
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 8559634..3cb36e6 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -483,6 +483,14 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+void real_host_page_size_init(void);
+
+/* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
+ * when intptr_t is 32-bit and we are aligning a long long.
+ */
+extern uintptr_t qemu_real_host_page_size;
+extern intptr_t qemu_real_host_page_mask;
+
 extern int qemu_icache_linesize;
 extern int qemu_dcache_linesize;
 
diff --git a/exec.c b/exec.c
index adc160f..135dcbc 100644
--- a/exec.c
+++ b/exec.c
@@ -120,8 +120,6 @@ int use_icount;
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
-uintptr_t qemu_real_host_page_size;
-intptr_t qemu_real_host_page_mask;
 
 bool set_preferred_target_page_bits(int bits)
 {
@@ -3608,8 +3606,7 @@ void page_size_init(void)
 {
     /* NOTE: we can always suppose that qemu_host_page_size >=
        TARGET_PAGE_SIZE */
-    qemu_real_host_page_size = getpagesize();
-    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
+    real_host_page_size_init();
     if (qemu_host_page_size == 0) {
         qemu_host_page_size = qemu_real_host_page_size;
     }
diff --git a/util/osdep.c b/util/osdep.c
index a2863c8..90f4f11 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -46,6 +46,9 @@ extern int madvise(caddr_t, size_t, int);
 #define QEMU_GETLK F_GETLK
 #endif
 
+uintptr_t qemu_real_host_page_size;
+intptr_t qemu_real_host_page_mask;
+
 static bool fips_enabled = false;
 
 static const char *hw_version = QEMU_HW_VERSION;
@@ -65,6 +68,12 @@ int socket_set_nodelay(int fd)
     return qemu_setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &v, sizeof(v));
 }
 
+void real_host_page_size_init(void)
+{
+    qemu_real_host_page_size = getpagesize();
+    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
+}
+
 int qemu_madvise(void *addr, size_t len, int advice)
 {
     if (advice == QEMU_MADV_INVALID) {
-- 
2.7.4
