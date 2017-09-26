Received: from eggs.gnu.org ([2001:4830:134:3::10]:60510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnim-0006OR-56
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnig-0001us-GH
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:12 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52480)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnig-0001uW-84
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:08:06 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:08:03 +0300
Message-ID: <150642408350.3900.16985989168069353852.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 42/43] windbg: implemented kd_api_fill_memory
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
 include/exec/windbgstub-utils.h |    1 +
 windbgstub-utils.c              |   36 ++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    4 ++++
 3 files changed, 41 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index ba001ddb42..d1a10c862e 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -119,6 +119,7 @@ void kd_api_get_version(CPUState *cpu, PacketData *pd);
 void kd_api_read_msr(CPUState *cpu, PacketData *pd);
 void kd_api_write_msr(CPUState *cpu, PacketData *pd);
 void kd_api_search_memory(CPUState *cpu, PacketData *pd);
+void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 2d3fbcc41c..3832e0b116 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -1570,6 +1570,42 @@ void kd_api_search_memory(CPUState *cpu, PacketData *pd)
     pd->extra_size = 0;
 }
 
+void kd_api_fill_memory(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_FILL_MEMORY *m64c = &pd->m64.u.FillMemory;
+
+    uint32_t len = ldl_p(&m64c->Length);
+    target_ulong addr = ldq_p(&m64c->Address);
+    uint16_t pattern = ldl_p(&m64c->PatternLength);
+    uint16_t flags = ldl_p(&m64c->Flags);
+
+    uint8_t mem[len];
+    int i, err;
+    for (i = 0; i < len; ++i) {
+        mem[i] = pd->extra[i % pattern];
+    }
+
+    switch (flags) {
+    case DBGKD_FILL_MEMORY_VIRTUAL:
+        err = cpu_memory_rw_debug(cpu, addr, mem, len, 1);
+        if (err) {
+            pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+            WINDBG_DEBUG("fill_memory: No physical page mapped: " FMT_ADDR,
+                        addr);
+        }
+        break;
+
+    case DBGKD_FILL_MEMORY_PHYSICAL:
+        cpu_physical_memory_rw(addr, mem, len, 1);
+        break;
+
+    default:
+        break;
+    }
+
+    pd->extra_size = 0;
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 7cff6bc514..b01ddcf009 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -209,6 +209,10 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_search_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdFillMemoryApi:
+        kd_api_fill_memory(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
