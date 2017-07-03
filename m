Received: from eggs.gnu.org ([2001:4830:134:3::10]:57804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLs-0008W9-Nf
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyLr-0001db-Mx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:14583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyLr-0001cL-Cj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:07 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:12 +0800
Message-Id: <1499076743-15477-5-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 04/15] tcg: change tcg_enabled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Change the tcg_enabled() and make sure user build still enable tcg
even x86 softmmu disable tcg.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/tcg/tcg-all.c       | 2 +-
 accel/tcg/translate-all.c | 6 +-----
 bsd-user/main.c           | 1 +
 include/qemu-common.h     | 7 ++++++-
 linux-user/main.c         | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 1b13bc9..979b68a 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -33,7 +33,7 @@
 #include "qemu/main-loop.h"
 
 long tcg_tb_size;
-static bool tcg_allowed = true;
+bool tcg_allowed;
 
 #ifndef CONFIG_USER_ONLY
 /* mask must never be zero, except for A20 change call */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index f6ad46b..bc75294 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -802,6 +802,7 @@ static void tb_htable_init(void)
    size. */
 void tcg_exec_init(unsigned long tb_size)
 {
+    tcg_allowed = true;
     cpu_gen_init();
     page_init();
     tb_htable_init();
@@ -813,11 +814,6 @@ void tcg_exec_init(unsigned long tb_size)
 #endif
 }
 
-bool tcg_enabled(void)
-{
-    return tcg_ctx.code_gen_buffer != NULL;
-}
-
 /*
  * Allocate a new translation block. Flush the translation buffer if
  * too many translation blocks or too much generated code.
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 04f95dd..276aea7 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -35,6 +35,7 @@
 #include "trace/control.h"
 #include "glib-compat.h"
 
+bool tcg_allowed = true;
 int singlestep;
 unsigned long mmap_min_addr;
 unsigned long guest_base;
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 387ef52..b5adbfa 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -76,8 +76,13 @@ int qemu_openpty_raw(int *aslave, char *pty_name);
     sendto(sockfd, buf, len, flags, destaddr, addrlen)
 #endif
 
+extern bool tcg_allowed;
 void tcg_exec_init(unsigned long tb_size);
-bool tcg_enabled(void);
+#ifdef CONFIG_TCG
+#define tcg_enabled() (tcg_allowed)
+#else
+#define tcg_enabled() 0
+#endif
 
 void cpu_exec_init_all(void);
 void cpu_exec_step_atomic(CPUState *cpu);
diff --git a/linux-user/main.c b/linux-user/main.c
index ad03c9e..a11508a 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -38,7 +38,7 @@
 #include "glib-compat.h"
 
 char *exec_path;
-
+bool tcg_allowed = true;
 int singlestep;
 static const char *filename;
 static const char *argv0;
-- 
1.9.1
