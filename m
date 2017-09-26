Received: from eggs.gnu.org ([2001:4830:134:3::10]:58966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfd-0003Pr-4Z
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfZ-0000Cm-O0
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51760)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfZ-0000CS-Ey
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:53 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:04:51 +0300
Message-ID: <150642389121.3900.12320775067244184010.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 08/43] windbg: hook to wrmsr operation
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
 include/exec/windbgstub-utils.h |    3 +++
 include/exec/windbgstub.h       |    1 +
 target/i386/misc_helper.c       |    3 +++
 windbgstub-utils.c              |    8 ++++++++
 windbgstub.c                    |    8 ++++++++
 5 files changed, 23 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 65f336e4bf..90fb766839 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -62,4 +62,7 @@
     _t;                                                       \
 })
 
+bool windbg_on_load(void);
+void windbg_on_exit(void);
+
 #endif
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
index 703fc26b8f..2dbf1b1f13 100755
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -15,6 +15,7 @@
 #define WINDBG "windbg"
 #define WINDBG_DEBUG_ON false
 
+void windbg_try_load(void);
 int windbg_server_start(const char *device);
 
 #endif
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
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index dc5e505c63..b5fb6db3f2 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,3 +10,11 @@
  */
 
 #include "exec/windbgstub-utils.h"
+
+bool windbg_on_load(void)
+{
+    return false;
+}
+
+void windbg_on_exit(void)
+{}
diff --git a/windbgstub.c b/windbgstub.c
index 378d1b911f..99c3ef9b14 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -39,8 +39,16 @@ static void windbg_chr_receive(void *opaque, const uint8_t *buf, int size)
     }
 }
 
+void windbg_try_load(void)
+{
+    if (windbg_state && !windbg_state->is_loaded) {
+        windbg_state->is_loaded = windbg_on_load();
+    }
+}
+
 static void windbg_exit(void)
 {
+    windbg_on_exit();
     g_free(windbg_state);
 }
 
