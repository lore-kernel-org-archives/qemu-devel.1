Received: from eggs.gnu.org ([2001:4830:134:3::10]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbg-0006k1-9n
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbf-00082Q-B7
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:36 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:47101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gbf-000822-52
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:35 -0400
Received: by mail-pf0-x243.google.com with SMTP id p87so13075443pfj.3
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:18 -0700
Message-Id: <20171020232023.15010-48-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 47/52] osdep: introduce
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
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h |  2 ++
 util/osdep.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 826650c58a..281782d526 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -371,6 +371,8 @@ void sigaction_invoke(struct sigaction *action,
 #endif
 
 int qemu_madvise(void *addr, size_t len, int advice);
+int qemu_mprotect_rwx(void *addr, size_t size);
+int qemu_mprotect_none(void *addr, size_t size);
 
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
diff --git a/util/osdep.c b/util/osdep.c
index a479fedc4a..1231f9f876 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -73,6 +73,47 @@ int qemu_madvise(void *addr, size_t len, int advice)
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
+        error_report("%s: VirtualProtect failed with error code %ld",
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
 
 static int fcntl_op_setlk = -1;
-- 
2.13.6
