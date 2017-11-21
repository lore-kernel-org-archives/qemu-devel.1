Received: from eggs.gnu.org ([2001:4830:134:3::10]:39215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Di-0000S1-6c
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DY-0002PX-B9
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:14 -0500
Received: from mail.ispras.ru ([83.149.199.45]:37792)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9DX-0002PM-VJ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:08:04 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:08:01 +0300
Message-ID: <151127328100.6888.1314154510098298370.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 08/45] windbg: hook to wrmsr operation
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

Inserted hook to wrmsr operation. Windows Kernel put address on KPCR struct to fs/gs (x32/x64) register. Needs catch this moment and allow windbg server handle packets.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 include/exec/windbgstub.h       |    1 +
 stubs/windbgstub.c              |    3 +++
 target/i386/misc_helper.c       |    3 +++
 target/i386/windbgstub.c        |   10 ++++++++++
 windbgstub.c                    |   13 +++++++++++++
 6 files changed, 32 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index e9f5223e94..4232aeb59d 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -43,4 +43,6 @@
     _t;                                                       \
 })
 
+bool windbg_on_load(void);
+
 #endif
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
index 21bc552e58..309f692383 100755
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -18,6 +18,7 @@
 #define WINDBG_DEBUG_ON false
 #endif
 
+void windbg_try_load(void);
 int windbg_server_start(const char *device);
 
 #endif
diff --git a/stubs/windbgstub.c b/stubs/windbgstub.c
index 4951f59203..bd7e2dccd1 100755
--- a/stubs/windbgstub.c
+++ b/stubs/windbgstub.c
@@ -12,6 +12,9 @@
 #include "qemu/osdep.h"
 #include "exec/windbgstub.h"
 
+void windbg_try_load(void)
+{}
+
 int windbg_server_start(const char *device)
 {
     return 0;
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 628f64aad5..ec1fcd2899 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
+#include "exec/windbgstub.h"
 
 void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
 {
@@ -385,6 +386,8 @@ void helper_wrmsr(CPUX86State *env)
         /* XXX: exception? */
         break;
     }
+
+    windbg_try_load();
 }
 
 void helper_rdmsr(CPUX86State *env)
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index df89e1edd8..0938f738e6 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -10,3 +10,13 @@
  */
 
 #include "qemu/osdep.h"
+
+#ifndef TARGET_X86_64
+#include "exec/windbgstub-utils.h"
+
+bool windbg_on_load(void)
+{
+    return false;
+}
+
+#endif
diff --git a/windbgstub.c b/windbgstub.c
index e30b8500e0..a2a6eb81b4 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -16,6 +16,7 @@
 #include "qemu/cutils.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
+#include "sysemu/kvm.h"
 
 typedef struct WindbgState {
     bool is_loaded;
@@ -45,6 +46,13 @@ static void windbg_exit(void)
     g_free(windbg_state);
 }
 
+void windbg_try_load(void)
+{
+    if (windbg_state && !windbg_state->is_loaded) {
+        windbg_state->is_loaded = windbg_on_load();
+    }
+}
+
 int windbg_server_start(const char *device)
 {
     Chardev *chr = NULL;
@@ -54,6 +62,11 @@ int windbg_server_start(const char *device)
         exit(1);
     }
 
+    if (kvm_enabled()) {
+        WINDBG_ERROR("KVM is not supported.");
+        exit(1);
+    }
+
     if (!strstart(device, "pipe:", NULL)) {
         WINDBG_ERROR("Unsupported device. Supported only pipe.");
         exit(1);
