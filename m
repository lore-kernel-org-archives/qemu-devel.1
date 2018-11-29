Received: from eggs.gnu.org ([2001:4830:134:3::10]:54181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLE-0006h8-RZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLD-00020O-Rr
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:30:56 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40048)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNLD-0001sw-EY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:30:55 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 29 Nov 2018 17:30:42 +0300
Message-ID: <154350184211.8036.11928187976370255901.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
References: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 34/39] windbg: implement kd_api_get_version
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
 include/exec/windbgstub-utils.h |    1 +
 target/i386/windbgstub.c        |   61 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 +++
 3 files changed, 66 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index fa67a7048d..adfc9936f3 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -80,6 +80,7 @@ void kd_api_read_io_space(CPUState *cs, PacketData *pd);
 void kd_api_write_io_space(CPUState *cs, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cs, PacketData *pd);
+void kd_api_get_version(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index c982eff590..a5be1bc158 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -15,6 +15,9 @@
 #ifdef TARGET_X86_64
 #define OFFSET_KPCR_SELF 0x18
 #define OFFSET_KPCR_LOCK_ARRAY 0x28
+#define OFFSET_KDBG_LIST 0x0
+#define OFFSET_KDBG_KERNBASE 0x18
+#define OFFSET_KDBG_MODULELIST 0x48
 #define OFFSET_KPRCB 0x20
 #define OFFSET_KPRCB_CURRTHREAD 0x8
 #else  /* TARGET_I386 */
@@ -1080,6 +1083,64 @@ void kd_api_set_context_ex(CPUState *cs, PacketData *pd)
     stl_p(&ctx->BytesCopied, len);
 }
 
+void kd_api_get_version(CPUState *cs, PacketData *pd)
+{
+    DBGKD_GET_VERSION64 *kdver = (DBGKD_GET_VERSION64 *) (PTR(pd->m64) + 0x10);
+#ifdef TARGET_X86_64
+    target_ulong kdbg = kdDebuggerDataBlock.addr;
+    target_ulong dDataList = VMEM_ADDR(cs, kdbg + OFFSET_KDBG_LIST);
+    target_ulong kernbase = VMEM_ADDR(cs, kdbg + OFFSET_KDBG_KERNBASE);
+    target_ulong modules = VMEM_ADDR(cs, kdbg + OFFSET_KDBG_MODULELIST);
+
+    /* TODO: Fix this hardcoded value.
+     * Receives 0xF if the target's operating system is a free build,
+     * and 0xC if it is a checked build.
+     */
+    stw_p(&kdver->MajorVersion, 0xF);
+    /* TODO: Fix this hardcoded value. Needs NtBuildNumber. How to get it? */
+    stw_p(&kdver->MinorVersion, 0x1db1);
+    stb_p(&kdver->ProtocolVersion, DBGKD_64BIT_PROTOCOL_VERSION2);
+    /* TODO: Fix this hardcoded value. */
+    stb_p(&kdver->KdSecondaryVersion, 0);
+    stw_p(&kdver->Flags,
+          DBGKD_VERS_FLAG_MP | DBGKD_VERS_FLAG_DATA | DBGKD_VERS_FLAG_PTR64);
+    stw_p(&kdver->MachineType, IMAGE_FILE_MACHINE_AMD64);
+    stb_p(&kdver->MaxPacketType, PACKET_TYPE_MAX);
+    stb_p(&kdver->MaxStateChange,
+          DbgKdMaximumStateChange - DbgKdMinimumStateChange);
+    stb_p(&kdver->MaxManipulate,
+          DbgKdMaximumManipulate - DbgKdMinimumManipulate);
+    /* FIXME: Maybe DBGKD_SIMULATION_EXDI? */
+    stb_p(&kdver->Simulation, DBGKD_SIMULATION_NONE);
+    stw_p(&kdver->Unused[0], 0);
+    sttul_p(&kdver->KernBase, kernbase);
+    sttul_p(&kdver->PsLoadedModuleList, modules);
+    sttul_p(&kdver->DebuggerDataList, dDataList);
+#else /* TARGET_I386 */
+    int err = cpu_memory_rw_debug(cs, kdVersion.addr, (uint8_t *) kdver,
+                                  sizeof(DBGKD_MANIPULATE_STATE64) - 0x10, 0);
+    if (!err) {
+        stw_p(&kdver->MajorVersion, kdver->MajorVersion);
+        stw_p(&kdver->MinorVersion, kdver->MinorVersion);
+        stb_p(&kdver->ProtocolVersion, kdver->ProtocolVersion);
+        stb_p(&kdver->KdSecondaryVersion, kdver->KdSecondaryVersion);
+        stw_p(&kdver->Flags, kdver->Flags);
+        stw_p(&kdver->MachineType, kdver->MachineType);
+        stb_p(&kdver->MaxPacketType, kdver->MaxPacketType);
+        stb_p(&kdver->MaxStateChange, kdver->MaxStateChange);
+        stb_p(&kdver->MaxManipulate, kdver->MaxManipulate);
+        stb_p(&kdver->Simulation, kdver->Simulation);
+        stw_p(&kdver->Unused[0], kdver->Unused[0]);
+        sttul_p(&kdver->KernBase, kdver->KernBase);
+        sttul_p(&kdver->PsLoadedModuleList, kdver->PsLoadedModuleList);
+        sttul_p(&kdver->DebuggerDataList, kdver->DebuggerDataList);
+    } else {
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+        WINDBG_ERROR("get_version: " FMT_ERR, err);
+    }
+#endif /* TARGET_I386 */
+}
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/windbgstub.c b/windbgstub.c
index 25331f218f..366856bc81 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -212,6 +212,10 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_write_physical_memory(cs, data);
         break;
 
+    case DbgKdGetVersionApi:
+        kd_api_get_version(cs, data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
