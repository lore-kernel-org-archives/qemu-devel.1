Received: from eggs.gnu.org ([2001:4830:134:3::10]:34973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWiC-00045V-Ea
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWiB-0007jf-6d
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:32 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50770)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWi3-00079i-Rk
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:55:26 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:55:02 +0300
Message-ID: <154401450219.8440.17609948220770657087.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 32/39] windbg: implement kd_api_read_io_space
 and kd_api_write_io_space
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 windbgstub-utils.c              |   62 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++
 3 files changed, 72 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2843ad055e..f0a786cdef 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -76,6 +76,8 @@ void kd_api_restore_breakpoint(CPUState *cs, PacketData *pd);
 void kd_api_continue(CPUState *cs, PacketData *pd);
 void kd_api_read_control_space(CPUState *cs, PacketData *pd);
 void kd_api_write_control_space(CPUState *cs, PacketData *pd);
+void kd_api_read_io_space(CPUState *cs, PacketData *pd);
+void kd_api_write_io_space(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 8aa258e9fd..b3c2504be2 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -10,6 +10,7 @@
  */
 
 #include "exec/windbgstub-utils.h"
+#include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 
 static const char *kd_api_names[] = {
@@ -326,6 +327,67 @@ void kd_api_continue(CPUState *cs, PacketData *pd)
     }
 }
 
+void kd_api_read_io_space(CPUState *cs, PacketData *pd)
+{
+    DBGKD_READ_WRITE_IO64 *io = &pd->m64.u.ReadWriteIo;
+    CPUArchState *env = cs->env_ptr;
+
+    target_ulong addr = ldtul_p(&io->IoAddress);
+    uint32_t value = 0;
+
+    switch (io->DataSize) {
+    case 1:
+        value = address_space_ldub(&address_space_io, addr,
+                                   cpu_get_mem_attrs(env), NULL);
+        stl_p(&io->DataValue, value);
+        break;
+    case 2:
+        value = address_space_lduw(&address_space_io, addr,
+                                   cpu_get_mem_attrs(env), NULL);
+        stl_p(&io->DataValue, value);
+        break;
+    case 4:
+        value = address_space_ldl(&address_space_io, addr,
+                                  cpu_get_mem_attrs(env), NULL);
+        stl_p(&io->DataValue, value);
+        break;
+    default:
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        return;
+    }
+
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+}
+
+void kd_api_write_io_space(CPUState *cs, PacketData *pd)
+{
+    DBGKD_READ_WRITE_IO64 *io = &pd->m64.u.ReadWriteIo;
+    CPUArchState *env = cs->env_ptr;
+
+    target_ulong addr = ldtul_p(&io->IoAddress);
+    uint32_t value = ldl_p(&io->DataValue);
+
+    switch (io->DataSize) {
+    case 1:
+        address_space_stb(&address_space_io, addr, value,
+                          cpu_get_mem_attrs(env), NULL);
+        break;
+    case 2:
+        address_space_stw(&address_space_io, addr, value,
+                          cpu_get_mem_attrs(env), NULL);
+        break;
+    case 4:
+        address_space_stl(&address_space_io, addr, value,
+                          cpu_get_mem_attrs(env), NULL);
+        break;
+    default:
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        return;
+    }
+
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+}
+
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd)
 {
 }
diff --git a/windbgstub.c b/windbgstub.c
index d64bbc3f34..78f96a6621 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -196,6 +196,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_control_space(cs, data);
         break;
 
+    case DbgKdReadIoSpaceApi:
+        kd_api_read_io_space(cs, data);
+        break;
+
+    case DbgKdWriteIoSpaceApi:
+        kd_api_write_io_space(cs, data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
