Received: from eggs.gnu.org ([2001:4830:134:3::10]:58954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20Eb-0000pb-WB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EZ-000583-OB
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:33 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:55365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EZ-00057k-J5
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:31 -0400
Received: by mail-pf0-x22e.google.com with SMTP id 17so9937919pfn.12
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:30:01 -0700
Message-Id: <20171010193003.28857-19-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 18/20] util: move
 qemu_real_host_page_size/mask to osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

These only depend on the host and therefore belong in the common
osdep, not in a target-dependent object.

While at it, query the host during an init constructor, which guarantees
the page size will be well-defined throughout the execution of the program.

Suggested-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h |  2 --
 include/qemu/osdep.h   |  6 ++++++
 exec.c                 |  4 ----
 util/pagesize.c        | 18 ++++++++++++++++++
 util/Makefile.objs     |  1 +
 5 files changed, 25 insertions(+), 6 deletions(-)
 create mode 100644 util/pagesize.c

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ffe43d5654..778031c3d7 100644
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
index 9dd318a7dd..826650c58a 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -505,6 +505,12 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+/* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
+ * when intptr_t is 32-bit and we are aligning a long long.
+ */
+extern uintptr_t qemu_real_host_page_size;
+extern intptr_t qemu_real_host_page_mask;
+
 extern int qemu_icache_linesize;
 extern int qemu_dcache_linesize;
 
diff --git a/exec.c b/exec.c
index 7a80460725..6378714a2b 100644
--- a/exec.c
+++ b/exec.c
@@ -120,8 +120,6 @@ int use_icount;
 
 uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
-uintptr_t qemu_real_host_page_size;
-intptr_t qemu_real_host_page_mask;
 
 bool set_preferred_target_page_bits(int bits)
 {
@@ -3606,8 +3604,6 @@ void page_size_init(void)
 {
     /* NOTE: we can always suppose that qemu_host_page_size >=
        TARGET_PAGE_SIZE */
-    qemu_real_host_page_size = getpagesize();
-    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
     if (qemu_host_page_size == 0) {
         qemu_host_page_size = qemu_real_host_page_size;
     }
diff --git a/util/pagesize.c b/util/pagesize.c
new file mode 100644
index 0000000000..998632cf6e
--- /dev/null
+++ b/util/pagesize.c
@@ -0,0 +1,18 @@
+/*
+ * pagesize.c - query the host about its page size
+ *
+ * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+uintptr_t qemu_real_host_page_size;
+intptr_t qemu_real_host_page_mask;
+
+static void __attribute__((constructor)) init_real_host_page_size(void)
+{
+    qemu_real_host_page_size = getpagesize();
+    qemu_real_host_page_mask = -(intptr_t)qemu_real_host_page_size;
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 50a55ecc75..2973b0a323 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -40,6 +40,7 @@ util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
 util-obj-y += log.o
+util-obj-y += pagesize.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
-- 
2.13.6
