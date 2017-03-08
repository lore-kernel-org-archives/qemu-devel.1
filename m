Received: from eggs.gnu.org ([2001:4830:134:3::10]:51742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj4m-00056U-60
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj4j-0005Cm-02
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:24:52 -0500
Received: from mail-by2nam01on0051.outbound.protection.outlook.com
	([104.47.34.51]:27136
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj4i-0005Cf-Ka
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:24:48 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:51:48 -0500
Message-ID: <148900630884.27090.10960732348509149156.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 04/20] exec: add debug version of
 physical memory read and write api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

The patch adds the following new APIs
- cpu_physical_memory_read_debug
- cpu_physical_memory_write_debug
- cpu_physical_memory_rw_debug
- ldl_phys_debug
- ldq_phys_debug

The idea behind this patch is that if all the qemu monitor memory dumps
and gdbserver accesses are done through these common APIs then in future
we can define some kind of global debug policy to control debug behavior.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                    |   32 ++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h |   15 +++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/exec.c b/exec.c
index 48ae29c..772a959 100644
--- a/exec.c
+++ b/exec.c
@@ -3326,6 +3326,38 @@ static inline MemoryRegion *address_space_translate_cached(
 #define RCU_READ_UNLOCK()        ((void)0)
 #include "memory_ldst.inc.c"
 
+uint32_t ldl_phys_debug(CPUState *cpu, hwaddr addr)
+{
+    MemTxAttrs attrs = MEMTXATTRS_DEBUG;
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    uint32_t val;
+
+    cpu_physical_memory_rw_debug_internal(cpu->cpu_ases[asidx].as,
+                                          addr, (void *) &val,
+                                          4, attrs, READ_DATA);
+    return tswap32(val);
+}
+
+uint64_t ldq_phys_debug(CPUState *cpu, hwaddr addr)
+{
+    MemTxAttrs attrs = MEMTXATTRS_DEBUG;
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    uint64_t val;
+
+    cpu_physical_memory_rw_debug_internal(cpu->cpu_ases[asidx].as,
+                                          addr, (void *) &val,
+                                          8, attrs, READ_DATA);
+    return val;
+}
+
+void cpu_physical_memory_rw_debug(hwaddr addr, uint8_t *buf,
+                                  int len, int is_write)
+{
+    cpu_physical_memory_rw_debug_internal(&address_space_memory, addr,
+                                          buf, len, MEMTXATTRS_DEBUG,
+                                          is_write ? WRITE_DATA : READ_DATA);
+}
+
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         uint8_t *buf, int len, int is_write)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b62f0d8..4a9c842 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -74,11 +74,26 @@ size_t qemu_ram_pagesize_largest(void);
 
 void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
                             int len, int is_write);
+void cpu_physical_memory_rw_debug(hwaddr addr, uint8_t *buf,
+                                  int len, int is_write);
 static inline void cpu_physical_memory_read(hwaddr addr,
                                             void *buf, int len)
 {
     cpu_physical_memory_rw(addr, buf, len, 0);
 }
+static inline void cpu_physical_memory_read_debug(hwaddr addr,
+                                                  void *buf, int len)
+{
+    cpu_physical_memory_rw_debug(addr, buf, len, 0);
+}
+static inline void cpu_physical_memory_write_debug(hwaddr addr,
+                                                   const void *buf, int len)
+{
+    cpu_physical_memory_rw_debug(addr, (void *)buf, len, 1);
+}
+uint32_t ldl_phys_debug(CPUState *cpu, hwaddr addr);
+uint64_t ldq_phys_debug(CPUState *cpu, hwaddr addr);
+
 static inline void cpu_physical_memory_write(hwaddr addr,
                                              const void *buf, int len)
 {
