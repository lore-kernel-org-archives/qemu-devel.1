Received: from eggs.gnu.org ([2001:4830:134:3::10]:49544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvb-0005kz-GY
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvY-0002NY-91
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:23 -0500
Received: from mail-sn1nam01on0054.outbound.protection.outlook.com
	([104.47.32.54]:7443
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvY-0002N2-2Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:20 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:26 -0600
Message-Id: <20171206200346.116537-4-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 03/23] exec: add debug version of physical
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
 exec.c                    | 31 +++++++++++++++++++++++++++++++
 include/exec/cpu-common.h | 15 +++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/exec.c b/exec.c
index 9b0ab1648945..e1837cad61f9 100644
--- a/exec.c
+++ b/exec.c
@@ -3540,6 +3540,37 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
 #define RCU_READ_UNLOCK()        rcu_read_unlock()
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
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_DEBUG, buf,
+                     len, is_write);
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
2.9.5
