Received: from eggs.gnu.org ([2001:4830:134:3::10]:59039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfg-0003Tk-5y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnff-0000Ly-96
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:00 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51786)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnff-0000Lp-2L
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:59 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:04:57 +0300
Message-ID: <150642389679.3900.2803313967054050497.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 09/43] windbg: handler of fs/gs register
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
 include/exec/windbgstub-utils.h |    5 +++
 windbgstub-utils.c              |   63 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 90fb766839..f2402ebb34 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -62,6 +62,11 @@
     _t;                                                       \
 })
 
+typedef struct InitedAddr {
+    target_ulong addr;
+    bool is_init;
+} InitedAddr;
+
 bool windbg_on_load(void);
 void windbg_on_exit(void);
 
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index b5fb6db3f2..662096647e 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -11,10 +11,69 @@
 
 #include "exec/windbgstub-utils.h"
 
+#ifdef TARGET_X86_64
+# define OFFSET_SELF_PCR         0x18
+# define OFFSET_VERS             0x108
+#else
+# define OFFSET_SELF_PCR         0x1C
+# define OFFSET_VERS             0x34
+#endif
+
+typedef struct KDData {
+    InitedAddr KPCR;
+    InitedAddr version;
+} KDData;
+
+static KDData *kd;
+
 bool windbg_on_load(void)
 {
-    return false;
+    CPUState *cpu = qemu_get_cpu(0);
+    CPUArchState *env = cpu->env_ptr;
+
+    if (!kd) {
+        kd = g_new0(KDData, 1);
+    }
+
+    if (!kd->KPCR.is_init) {
+
+ #ifdef TARGET_X86_64
+        kd->KPCR.addr = env->segs[R_GS].base;
+ #else
+        kd->KPCR.addr = env->segs[R_FS].base;
+ #endif
+
+        static target_ulong prev_KPCR;
+        if (!kd->KPCR.addr || prev_KPCR == kd->KPCR.addr) {
+            return false;
+        }
+        prev_KPCR = kd->KPCR.addr;
+
+        if (kd->KPCR.addr != READ_VMEM(cpu, kd->KPCR.addr + OFFSET_SELF_PCR,
+                                       target_ulong)) {
+            return false;
+        }
+
+        kd->KPCR.is_init = true;
+    }
+
+    if (!kd->version.is_init && kd->KPCR.is_init) {
+        kd->version.addr = READ_VMEM(cpu, kd->KPCR.addr + OFFSET_VERS,
+                                     target_ulong);
+        if (!kd->version.addr) {
+            return false;
+        }
+        kd->version.is_init = true;
+    }
+
+    WINDBG_DEBUG("windbg_on_load: KPCR " FMT_ADDR, kd->KPCR.addr);
+    WINDBG_DEBUG("windbg_on_load: version " FMT_ADDR, kd->version.addr);
+
+    return true;
 }
 
 void windbg_on_exit(void)
-{}
+{
+    g_free(kd);
+    kd = NULL;
+}
