Received: from eggs.gnu.org ([2001:4830:134:3::10]:51528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFa-0005iw-10
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFW-0006p3-1d
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:10 -0500
Received: from mail-by2nam01on0072.outbound.protection.outlook.com
	([104.47.34.72]:60830
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFV-0006ob-N3
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:05 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:15 -0600
Message-Id: <20180207160638.98872-3-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 03/26] exec: add debug version of physical
 memory read and write API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

Adds the following new APIs
- cpu_physical_memory_read_debug
- cpu_physical_memory_write_debug
- cpu_physical_memory_rw_debug
- ldl_phys_debug
- ldq_phys_debug

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                    | 41 +++++++++++++++++++++++++++++++++++++++++
 include/exec/cpu-common.h | 15 +++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/exec.c b/exec.c
index 1919052b7385..49dabdbeecbd 100644
--- a/exec.c
+++ b/exec.c
@@ -3610,6 +3610,47 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
 #define RCU_READ_UNLOCK()        rcu_read_unlock()
 #include "memory_ldst.inc.c"
 
+uint32_t ldl_phys_debug(CPUState *cpu, hwaddr addr)
+{
+    MemTxAttrs attrs;
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    uint32_t val;
+
+    /* set debug attrs to indicate memory access is from the debugger */
+    attrs.debug = 1;
+
+    cpu_physical_memory_rw_internal(cpu->cpu_ases[asidx].as,
+                                          addr, (void *) &val,
+                                          4, attrs, READ_DATA);
+    return tswap32(val);
+}
+
+uint64_t ldq_phys_debug(CPUState *cpu, hwaddr addr)
+{
+    MemTxAttrs attrs;
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    uint64_t val;
+
+    /* set debug attrs to indicate memory access is from the debugger */
+    attrs.debug = 1;
+
+    cpu_physical_memory_rw_internal(cpu->cpu_ases[asidx].as,
+                                          addr, (void *) &val,
+                                          8, attrs, READ_DATA);
+    return val;
+}
+
+void cpu_physical_memory_rw_debug(hwaddr addr, uint8_t *buf,
+                                  int len, int is_write)
+{
+    MemTxAttrs attrs;
+
+    /* set debug attrs to indicate memory access is from the debugger */
+    attrs.debug = 1;
+
+    address_space_rw(&address_space_memory, addr, attrs, buf, len, is_write);
+}
+
 /* virtual memory access for debug (includes writing to ROM) */
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
                         uint8_t *buf, int len, int is_write)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 74341b19d26a..fa01385d4f1b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -77,11 +77,26 @@ size_t qemu_ram_pagesize_largest(void);
 
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
-- 
2.14.3
