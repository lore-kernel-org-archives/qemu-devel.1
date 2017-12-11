Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2O-0000cP-BV
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2L-000223-5K
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:28 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43422)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO2K-00021N-Pg
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:25 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:22:09 +0300
Message-ID: <151299852937.4808.10432683992168626870.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 09/46] windbg: handler of fs/gs register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Added handler of fs/gs register. It tries to find and check KPCR and version address.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    8 ++++++
 target/i386/windbgstub.c        |   49 ++++++++++++++++++++++++++++++++++++++-
 windbgstub-utils.c              |   13 ++++++++++
 windbgstub.c                    |   10 ++++++++
 4 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a181e172e9..ced03b0663 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -47,6 +47,14 @@ typedef struct SizedBuf {
     size_t size;
 } SizedBuf;
 
+typedef struct InitedAddr {
+    target_ulong addr;
+    bool is_init;
+} InitedAddr;
+
+InitedAddr *windbg_get_KPCR(void);
+InitedAddr *windbg_get_version(void);
+
 bool windbg_on_load(void);
 
 #endif
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 0938f738e6..47ee5840ef 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -14,9 +14,56 @@
 #ifndef TARGET_X86_64
 #include "exec/windbgstub-utils.h"
 
+#ifdef TARGET_X86_64
+# define OFFSET_SELF_PCR         0x18
+# define OFFSET_VERS             0x108
+#else
+# define OFFSET_SELF_PCR         0x1C
+# define OFFSET_VERS             0x34
+#endif
+
 bool windbg_on_load(void)
 {
-    return false;
+    CPUState *cpu = qemu_get_cpu(0);
+    CPUArchState *env = cpu->env_ptr;
+    InitedAddr *KPCR = windbg_get_KPCR();
+    InitedAddr *version = windbg_get_version();
+
+    if (!KPCR->is_init) {
+
+ #ifdef TARGET_X86_64
+        KPCR->addr = env->segs[R_GS].base;
+ #else
+        KPCR->addr = env->segs[R_FS].base;
+ #endif
+
+        static target_ulong prev_KPCR;
+        if (!KPCR->addr || prev_KPCR == KPCR->addr) {
+            return false;
+        }
+        prev_KPCR = KPCR->addr;
+
+        if (KPCR->addr != READ_VMEM(cpu, KPCR->addr + OFFSET_SELF_PCR,
+                                    target_ulong)) {
+            return false;
+        }
+
+        KPCR->is_init = true;
+    }
+
+    if (!version->is_init && KPCR->is_init) {
+        version->addr = READ_VMEM(cpu, KPCR->addr + OFFSET_VERS,
+                                  target_ulong);
+        if (!version->addr) {
+            return false;
+        }
+        version->is_init = true;
+    }
+
+    WINDBG_DEBUG("windbg_on_load: KPCR " FMT_ADDR, KPCR->addr);
+    WINDBG_DEBUG("windbg_on_load: version " FMT_ADDR, version->addr);
+
+    return true;
 }
 
 #endif
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index dc5e505c63..347c61553a 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,3 +10,16 @@
  */
 
 #include "exec/windbgstub-utils.h"
+
+static InitedAddr KPCR;
+static InitedAddr version;
+
+InitedAddr *windbg_get_KPCR(void)
+{
+    return &KPCR;
+}
+
+InitedAddr *windbg_get_version(void)
+{
+    return &version;
+}
diff --git a/windbgstub.c b/windbgstub.c
index a2a6eb81b4..e9aabd807b 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -17,6 +17,7 @@
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 #include "sysemu/kvm.h"
+#include "sysemu/reset.h"
 
 typedef struct WindbgState {
     bool is_loaded;
@@ -46,6 +47,13 @@ static void windbg_exit(void)
     g_free(windbg_state);
 }
 
+static void windbg_handle_reset(void *opaque)
+{
+    windbg_state->is_loaded = false;
+    windbg_get_KPCR()->is_init = false;
+    windbg_get_version()->is_init = false;
+}
+
 void windbg_try_load(void)
 {
     if (windbg_state && !windbg_state->is_loaded) {
@@ -85,6 +93,8 @@ int windbg_server_start(const char *device)
     qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
                              windbg_chr_receive, NULL, NULL, NULL, NULL, true);
 
+    qemu_register_reset(windbg_handle_reset, NULL);
+
     atexit(windbg_exit);
     return 0;
 }
