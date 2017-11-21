Received: from eggs.gnu.org ([2001:4830:134:3::10]:40366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GE-0002cP-Ak
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GB-0003Kd-TJ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38576)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9GB-0003KT-Gc
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:47 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:44 +0300
Message-ID: <151127344459.6888.9361026523542993921.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 37/45] windbg: implemented
 kd_api_read_io_space and kd_api_write_io_space
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
 windbgstub-utils.c              |   62 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 +++++
 3 files changed, 72 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 2cfca92183..7f52acbae3 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -95,6 +95,8 @@ void kd_api_restore_breakpoint(CPUState *cpu, PacketData *pd);
 void kd_api_continue(CPUState *cpu, PacketData *pd);
 void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
+void kd_api_read_io_space(CPUState *cpu, PacketData *pd);
+void kd_api_write_io_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index fe3adb0b88..3f8ce1f8be 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -11,6 +11,7 @@
 
 #include "exec/windbgstub-utils.h"
 #include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
 
 static InitedAddr KPCR;
 static InitedAddr version;
@@ -148,6 +149,67 @@ void kd_api_continue(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_read_io_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_WRITE_IO64 *io = &pd->m64.u.ReadWriteIo;
+    CPUArchState *env = cpu->env_ptr;
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
     WINDBG_ERROR("Caught unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index a04698b003..397dedd9d1 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -168,6 +168,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
