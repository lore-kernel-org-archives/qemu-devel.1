Received: from eggs.gnu.org ([2001:4830:134:3::10]:60226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniH-0005xF-6M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniD-0001gO-23
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52368)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwniC-0001g5-MO
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:36 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:07:34 +0300
Message-ID: <150642405450.3900.12154700716266164817.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 37/43] windbg: implemented kd_api_read_io_space
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

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 windbgstub-utils.c              |   57 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++
 3 files changed, 67 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index f6a60292a2..07e11c0494 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -111,6 +111,8 @@ void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_continue(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
+void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
+void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 8d5136f310..6bf9868e51 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -11,6 +11,7 @@
 
 #include "exec/windbgstub-utils.h"
 #include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
 
 #define IS_LOCAL_BP_ENABLED(dr7, index) (((dr7) >> ((index) * 2)) & 1)
 
@@ -1113,6 +1114,62 @@ void kd_api_write_control_space(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_read_io_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_WRITE_IO64 *io = &pd->m64.u.ReadWriteIo;
+    CPUArchState *env = cpu->env_ptr;
+    target_ulong addr = ldtul_p(&io->IoAddress);
+
+    switch (io->DataSize) {
+    case 1:
+        io->DataValue = address_space_ldub(&address_space_io, addr,
+                                           cpu_get_mem_attrs(env), NULL);
+        break;
+    case 2:
+        io->DataValue = address_space_lduw(&address_space_io, addr,
+                                           cpu_get_mem_attrs(env), NULL);
+        break;
+    case 4:
+        io->DataValue = address_space_ldl(&address_space_io, addr,
+                                          cpu_get_mem_attrs(env), NULL);
+        break;
+    default:
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        return;
+    }
+
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+}
+
+void kd_api_write_io_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_WRITE_IO64 *io = &pd->m64.u.ReadWriteIo;
+    CPUArchState *env = cpu->env_ptr;
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
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 19a4f0184b..0363d9a5c8 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -161,6 +161,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_restore_breakpoint(cpu, &ctx->data);
         break;
 
+    case DbgKdReadIoSpaceApi:
+        kd_api_read_io_space(cpu, &ctx->data);
+        break;
+
+    case DbgKdWriteIoSpaceApi:
+        kd_api_write_io_space(cpu, &ctx->data);
+        break;
+
     case DbgKdContinueApi:
     case DbgKdContinueApi2:
         kd_api_continue(cpu, &ctx->data);
