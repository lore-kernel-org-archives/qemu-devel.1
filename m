Received: from eggs.gnu.org ([2001:4830:134:3::10]:46377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmf-0001CW-Ay
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpma-0008Rc-As
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpma-0008R5-54
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:23 -0400
Message-Id: <1500235468-15341-41-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 40/45] osdep: introduce
 qemu_mprotect_rwx/none
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

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/osdep.h |  2 ++
 util/osdep.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3cb36e6..dcecfbc 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -348,6 +348,8 @@ void sigaction_invoke(struct sigaction *action,
 #endif
 
 int qemu_madvise(void *addr, size_t len, int advice);
+int qemu_mprotect_rwx(void *addr, size_t size);
+int qemu_mprotect_none(void *addr, size_t size);
 
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
diff --git a/util/osdep.c b/util/osdep.c
index 90f4f11..85df97e 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -90,6 +90,46 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #endif
 }
 
+static int qemu_mprotect__osdep(void *addr, size_t size, int prot)
+{
+    void *start = QEMU_ALIGN_PTR_DOWN(addr, qemu_real_host_page_size);
+    void *end = QEMU_ALIGN_PTR_UP(addr + size, qemu_real_host_page_size);
+#ifdef _WIN32
+    DWORD old_protect;
+
+    if (!VirtualProtect(start, end - start, prot, &old_protect)) {
+        error_report("%s: VirtualProtect failed with error code %d",
+                     __func__, GetLastError());
+        return -1;
+    }
+    return 0;
+#else
+    if (mprotect(start, end - start, prot)) {
+        error_report("%s: mprotect failed: %s", __func__, strerror(errno));
+        return -1;
+    }
+    return 0;
+#endif
+}
+
+int qemu_mprotect_rwx(void *addr, size_t size)
+{
+#ifdef _WIN32
+    return qemu_mprotect__osdep(addr, size, PAGE_EXECUTE_READWRITE);
+#else
+    return qemu_mprotect__osdep(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
+#endif
+}
+
+int qemu_mprotect_none(void *addr, size_t size)
+{
+#ifdef _WIN32
+    return qemu_mprotect__osdep(addr, size, PAGE_NOACCESS);
+#else
+    return qemu_mprotect__osdep(addr, size, PROT_NONE);
+#endif
+}
+
 #ifndef _WIN32
 /*
  * Dups an fd and sets the flags
-- 
2.7.4
