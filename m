Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rcf-0002sd-9y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RcZ-0004jP-DE
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:09:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56504)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4RcZ-0004im-5y
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:09:23 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:09:19 +0300
Message-ID: <150824575888.6816.8665703540737889367.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 05/43] windbg: added helper features
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

Added some helper features for windbgstub.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |   34 ++++++++++++++++++++++++++++++++++
 include/exec/windbgstub.h       |    6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2390597f1f..1c27ee4ce8 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -13,7 +13,41 @@
 #define WINDBGSTUB_UTILS_H
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "log.h"
+#include "cpu.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgkd.h"
 
+#ifndef TARGET_I386
+#error Unsupported Architecture
+#endif
+#ifdef TARGET_X86_64 /* Unimplemented yet */
+#error Unsupported Architecture
+#endif
+
+# define WINDBG_DEBUG(...) do {            \
+    if (WINDBG_DEBUG_ON) {                 \
+        qemu_log(WINDBG ": " __VA_ARGS__); \
+        qemu_log("\n");                    \
+    }                                      \
+} while (false)
+
+#define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
+
+#define FMT_ADDR "addr:0x" TARGET_FMT_lx
+#define FMT_ERR  "Error:%d"
+
+#define UINT8_P(ptr) ((uint8_t *) (ptr))
+#define UINT32_P(ptr) ((uint32_t *) (ptr))
+#define PTR(var) UINT8_P(&var)
+
+#define sizeof_field(type, field) sizeof(((type *) NULL)->field)
+
+#define READ_VMEM(cpu, addr, type) ({                         \
+    type _t;                                                  \
+    cpu_memory_rw_debug(cpu, addr, PTR(_t), sizeof(type), 0); \
+    _t;                                                       \
+})
+
 #endif
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
index 1a6e1cc6e5..21bc552e58 100755
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -12,6 +12,12 @@
 #ifndef WINDBGSTUB_H
 #define WINDBGSTUB_H
 
+#define WINDBG "windbg"
+
+#ifndef WINDBG_DEBUG_ON
+#define WINDBG_DEBUG_ON false
+#endif
+
 int windbg_server_start(const char *device);
 
 #endif
