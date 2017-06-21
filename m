Received: from eggs.gnu.org ([2001:4830:134:3::10]:55752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckL-0002RK-NY
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckK-00053w-QP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckK-0004zB-Hb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:24 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:50 +0800
Message-Id: <1498040401-16361-5-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 04/15] tcg: change tcg_enabled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

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
index dba9931..a313d14 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -29,7 +29,7 @@
 #include "qom/object.h"
 
 int tcg_tb_size;
-static bool tcg_allowed = true;
+bool tcg_allowed;
 
 static int tcg_init(MachineState *ms)
 {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index bb303e0..4ebf7b0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -830,6 +830,7 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
    size. */
 void tcg_exec_init(unsigned long tb_size)
 {
+    tcg_allowed = true;
     cpu_gen_init();
     page_init();
     tb_htable_init();
@@ -844,11 +845,6 @@ void tcg_exec_init(unsigned long tb_size)
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
