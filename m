Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJC-0007bS-UQ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJ8-0003iB-T5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59724)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJ8-0003fV-Fb
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:06 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:01 +0300
Message-ID: <154409754088.5432.4509352196163025918.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 04/39] windbg: add helper features
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

Add some helper features for windbgstub.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |   40 +++++++++++++++++++
 include/exec/windbgstub.h       |    6 +++
 windbgstub-utils.c              |   83 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index e80b9cba8f..e7db062289 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -13,7 +13,47 @@
 #define WINDBGSTUB_UTILS_H
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "log.h"
+#include "cpu.h"
 #include "exec/windbgstub.h"
 #include "exec/windbgkd.h"
 
+#define DPRINTF(fmt, ...)                                                      \
+    do {                                                                       \
+        if (WINDBG_DPRINT) {                                                   \
+            qemu_log("windbg: " fmt, ##__VA_ARGS__);                           \
+        }                                                                      \
+    } while (0)
+
+#define WINDBG_ERROR(...) error_report("windbg: " __VA_ARGS__)
+
+#define FMT_ADDR "addr:0x" TARGET_FMT_lx
+#define FMT_ERR "Error:%d"
+
+#define PTR(var) ((uint8_t *) (&var))
+
+#define VMEM_ADDR(cpu, addr)                                                   \
+    ({                                                                         \
+        target_ulong _addr;                                                    \
+        cpu_memory_rw_debug(cpu, addr, PTR(_addr), sizeof(target_ulong), 0);   \
+        ldtul_p(&_addr);                                                       \
+    })
+
+#if TARGET_LONG_BITS == 64
+#define sttul_p(p, v) stq_p(p, v)
+#define ldtul_p(p) ldq_p(p)
+#else
+#define sttul_p(p, v) stl_p(p, v)
+#define ldtul_p(p) ldl_p(p)
+#endif
+
+typedef struct InitedAddr {
+    target_ulong addr;
+    bool is_init;
+} InitedAddr;
+
+const char *kd_api_name(int id);
+const char *kd_pkt_type_name(int id);
+
 #endif /* WINDBGSTUB_UTILS_H */
diff --git a/include/exec/windbgstub.h b/include/exec/windbgstub.h
index 9656c152ef..576acb1ee8 100644
--- a/include/exec/windbgstub.h
+++ b/include/exec/windbgstub.h
@@ -12,6 +12,12 @@
 #ifndef WINDBGSTUB_H
 #define WINDBGSTUB_H
 
+#ifdef DEBUG_WINDBG
+#define WINDBG_DPRINT true
+#else
+#define WINDBG_DPRINT false
+#endif
+
 int windbg_server_start(const char *device);
 
 #endif /* WINDBGSTUB_H */
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 7f603b7f3f..968e5cb2dd 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,3 +10,86 @@
  */
 
 #include "exec/windbgstub-utils.h"
+
+static const char *kd_api_names[] = {
+    "DbgKdReadVirtualMemoryApi",
+    "DbgKdWriteVirtualMemoryApi",
+    "DbgKdGetContextApi",
+    "DbgKdSetContextApi",
+    "DbgKdWriteBreakPointApi",
+    "DbgKdRestoreBreakPointApi",
+    "DbgKdContinueApi",
+    "DbgKdReadControlSpaceApi",
+    "DbgKdWriteControlSpaceApi",
+    "DbgKdReadIoSpaceApi",
+    "DbgKdWriteIoSpaceApi",
+    "DbgKdRebootApi",
+    "DbgKdContinueApi2",
+    "DbgKdReadPhysicalMemoryApi",
+    "DbgKdWritePhysicalMemoryApi",
+    "DbgKdQuerySpecialCallsApi",
+    "DbgKdSetSpecialCallApi",
+    "DbgKdClearSpecialCallsApi",
+    "DbgKdSetInternalBreakPointApi",
+    "DbgKdGetInternalBreakPointApi",
+    "DbgKdReadIoSpaceExtendedApi",
+    "DbgKdWriteIoSpaceExtendedApi",
+    "DbgKdGetVersionApi",
+    "DbgKdWriteBreakPointExApi",
+    "DbgKdRestoreBreakPointExApi",
+    "DbgKdCauseBugCheckApi",
+    "",
+    "",
+    "",
+    "",
+    "",
+    "",
+    "DbgKdSwitchProcessor",
+    "DbgKdPageInApi",
+    "DbgKdReadMachineSpecificRegister",
+    "DbgKdWriteMachineSpecificRegister",
+    "OldVlm1",
+    "OldVlm2",
+    "DbgKdSearchMemoryApi",
+    "DbgKdGetBusDataApi",
+    "DbgKdSetBusDataApi",
+    "DbgKdCheckLowMemoryApi",
+    "DbgKdClearAllInternalBreakpointsApi",
+    "DbgKdFillMemoryApi",
+    "DbgKdQueryMemoryApi",
+    "DbgKdSwitchPartition",
+    "DbgKdWriteCustomBreakpointApi",
+    "DbgKdGetContextExApi",
+    "DbgKdSetContextExApi",
+    "DbgKdUnknownApi",
+};
+
+static const char *kd_packet_type_names[] = {
+    "PACKET_TYPE_UNUSED",
+    "PACKET_TYPE_KD_STATE_CHANGE32",
+    "PACKET_TYPE_KD_STATE_MANIPULATE",
+    "PACKET_TYPE_KD_DEBUG_IO",
+    "PACKET_TYPE_KD_ACKNOWLEDGE",
+    "PACKET_TYPE_KD_RESEND",
+    "PACKET_TYPE_KD_RESET",
+    "PACKET_TYPE_KD_STATE_CHANGE64",
+    "PACKET_TYPE_KD_POLL_BREAKIN",
+    "PACKET_TYPE_KD_TRACE_IO",
+    "PACKET_TYPE_KD_CONTROL_REQUEST",
+    "PACKET_TYPE_KD_FILE_IO",
+    "PACKET_TYPE_MAX",
+};
+
+const char *kd_api_name(int id)
+{
+    return (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate)
+        ? kd_api_names[id - DbgKdMinimumManipulate]
+        : kd_api_names[DbgKdMaximumManipulate - DbgKdMinimumManipulate];
+}
+
+const char *kd_pkt_type_name(int id)
+{
+    return (id >= 0 && id < PACKET_TYPE_MAX)
+        ? kd_packet_type_names[id]
+        : kd_packet_type_names[PACKET_TYPE_MAX - 1];
+}
