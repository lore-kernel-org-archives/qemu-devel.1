Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO22-0000CZ-BM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO1y-0001i5-Cs
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:06 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43328)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO1y-0001hp-4t
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:22:02 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:21:46 +0300
Message-ID: <151299850672.4808.6299375638944179634.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 05/46] windbg: added helper features
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
 include/exec/windbgstub-utils.h |   31 +++++++++++++++++++++++++++++++
 include/exec/windbgstub.h       |    6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2390597f1f..4c747fa23e 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -13,7 +13,38 @@
 #define WINDBGSTUB_UTILS_H
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "log.h"
+#include "cpu.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgkd.h"
 
+#define WINDBG_DEBUG(...) do {             \
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
+typedef struct SizedBuf {
+    uint8_t *data;
+    size_t size;
+} SizedBuf;
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
