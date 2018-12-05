Received: from eggs.gnu.org ([2001:4830:134:3::10]:33541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWff-000146-Lo
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfb-0005Wg-J9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50086)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfW-0005T0-1n
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:51 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:52:42 +0300
Message-ID: <154401436261.8440.3115424707501252121.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 07/39] windbg: hook to wrmsr operation
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

Insert hook to wrmsr operation. Windows kernel put address on KPCR struct
to fs/gs (x32/x64) register. Needs catch this moment and allow windbgstub
handle packets from client.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    3 +++
 include/exec/windbgstub.h       |    2 ++
 stubs/windbgstub.c              |    4 ++++
 target/i386/misc_helper.c       |    3 +++
 target/i386/windbgstub.c        |    9 +++++++++
 windbgstub.c                    |   24 ++++++++++++++++++++++++
 6 files changed, 45 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index e7db062289..e076227b39 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -56,4 +56,7 @@ typedef struct InitedAddr {
 const char *kd_api_name(int id);
 const char *kd_pkt_type_name(int id);
 
+bool windbg_on_load(void);
+void windbg_on_reset(void);
+
 #endif /* WINDBGSTUB_UTILS_H */
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
index 576acb1ee8..daa413da41 100644
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -18,6 +18,8 @@
 #define WINDBG_DPRINT false
 #endif
 
+void windbg_try_load(void);
+
 int windbg_server_start(const char *device);
 
 #endif /* WINDBGSTUB_H */
diff --git a/stubs/windbgstub.c b/stubs/windbgstub.c
index 36ad918dad..67205ae1f7 100644
--- a/stubs/windbgstub.c
+++ b/stubs/windbgstub.c
@@ -12,6 +12,10 @@
 #include "qemu/osdep.h"
 #include "exec/windbgstub.h"
 
+void windbg_try_load(void)
+{
+}
+
 int windbg_server_start(const char *device)
 {
     return 0;
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 78f2020ef2..6ae67cf885 100644
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
index 8caaa7cd38..e55054c63d 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -11,3 +11,12 @@
 
 #include "qemu/osdep.h"
 #include "exec/windbgstub-utils.h"
+
+bool windbg_on_load(void)
+{
+    return false;
+}
+
+void windbg_on_reset(void)
+{
+}
diff --git a/windbgstub.c b/windbgstub.c
index 85e2215f73..d7fadda096 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -14,6 +14,8 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qemu/cutils.h"
+#include "sysemu/reset.h"
+#include "sysemu/kvm.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgstub-utils.h"
 
@@ -50,6 +52,21 @@ static void windbg_exit(void)
     g_free(windbg_state);
 }
 
+static void windbg_handle_reset(void *opaque)
+{
+    windbg_state_clean(windbg_state);
+    windbg_on_reset();
+}
+
+void windbg_try_load(void)
+{
+    if (windbg_state && !windbg_state->is_loaded) {
+        if (windbg_on_load()) {
+            windbg_state->is_loaded = true;
+        }
+    }
+}
+
 int windbg_server_start(const char *device)
 {
     Chardev *chr = NULL;
@@ -59,6 +76,11 @@ int windbg_server_start(const char *device)
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
@@ -76,6 +98,8 @@ int windbg_server_start(const char *device)
     qemu_chr_fe_set_handlers(&windbg_state->chr, windbg_chr_can_receive,
                              windbg_chr_receive, NULL, NULL, NULL, NULL, true);
 
+    qemu_register_reset(windbg_handle_reset, NULL);
+
     atexit(windbg_exit);
     return 0;
 }
