Received: from eggs.gnu.org ([2001:4830:134:3::10]:58745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfJ-0003C8-W8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfI-0008Ik-Vt
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51694)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfI-0008IW-Nn
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:36 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:04:34 +0300
Message-ID: <150642387446.3900.8629683985208127854.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 05/43] windbg: added helper features
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
 include/exec/windbgstub-utils.h |   46 +++++++++++++++++++++++++++++++++++++++
 include/exec/windbgstub.h       |    3 +++
 windbgstub.c                    |    1 +
 3 files changed, 50 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2390597f1f..65f336e4bf 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -13,7 +13,53 @@
 #define WINDBGSTUB_UTILS_H
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
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
+#if (WINDBG_DEBUG_ON)
+
+# define WINDBG_DEBUG(...) do {    \
+    printf("Debug: " __VA_ARGS__); \
+    printf("\n");                  \
+} while (false)
+
+# define WINDBG_ERROR(...) do {    \
+    printf("Error: " __VA_ARGS__); \
+    printf("\n");                  \
+} while (false)
+
+#else
+
+# define WINDBG_DEBUG(...)
+# define WINDBG_ERROR(...) error_report(WINDBG ": " __VA_ARGS__)
+
+#endif
+
+#define FMT_ADDR "addr:0x" TARGET_FMT_lx
+#define FMT_ERR  "Error:%d"
+
+#define UINT8_P(ptr) ((uint8_t *) (ptr))
+#define UINT32_P(ptr) ((uint32_t *) (ptr))
+#define FIELD_P(type, field, ptr) ((typeof_field(type, field) *) (ptr))
+#define PTR(var) UINT8_P(&var)
+
+#define M64_SIZE sizeof(DBGKD_MANIPULATE_STATE64)
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
index 1a6e1cc6e5..703fc26b8f 100755
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -12,6 +12,9 @@
 #ifndef WINDBGSTUB_H
 #define WINDBGSTUB_H
 
+#define WINDBG "windbg"
+#define WINDBG_DEBUG_ON false
+
 int windbg_server_start(const char *device);
 
 #endif
diff --git a/windbgstub.c b/windbgstub.c
index 4951f59203..3830446988 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/windbgstub.h"
+#include "exec/windbgstub-utils.h"
 
 int windbg_server_start(const char *device)
 {
