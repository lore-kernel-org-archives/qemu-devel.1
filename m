Received: from eggs.gnu.org ([2001:4830:134:3::10]:60371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qS-00019H-H8
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qN-0005wn-CB
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qN-0005vi-61
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:25 -0400
Message-Id: <1500520169-23367-40-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 39/43] osdep: introduce
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
 util/osdep.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0cba871..2c7d7db 100644
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
index a2863c8..f72d679 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -81,6 +81,47 @@ int qemu_madvise(void *addr, size_t len, int advice)
 #endif
 }
 
+static int qemu_mprotect__osdep(void *addr, size_t size, int prot)
+{
+    g_assert(!((uintptr_t)addr & ~qemu_real_host_page_mask));
+    g_assert(!(size & ~qemu_real_host_page_mask));
+
+#ifdef _WIN32
+    DWORD old_protect;
+
+    if (!VirtualProtect(addr, size, prot, &old_protect)) {
+        error_report("%s: VirtualProtect failed with error code %d",
+                     __func__, GetLastError());
+        return -1;
+    }
+    return 0;
+#else
+    if (mprotect(addr, size, prot)) {
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
