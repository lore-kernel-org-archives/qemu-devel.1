Received: from eggs.gnu.org ([2001:4830:134:3::10]:50793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJH-0005v7-Ka
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9YJG-0005qL-7S
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:51 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9YJG-0005pY-0y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:50:50 -0400
Received: by mail-wr0-x241.google.com with SMTP id f14-v6so24222140wre.4
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 08:50:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 20 Apr 2018 16:50:40 +0100
Message-Id: <20180420155045.18862-2-alex.bennee@linaro.org>
In-Reply-To: <20180420155045.18862-1-alex.bennee@linaro.org>
References: <20180420155045.18862-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/6] accel/tcg: export some cputlb functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

In preparation for having softmmu helpers in their own file rather
than generated as part of softmmu-template.h we need to make a couple
of helper functions public outside of cputlb.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 19 ++++++++++---------
 accel/tcg/cputlb.h | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)
 create mode 100644 accel/tcg/cputlb.h

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 05439039e9..43a89d3010 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "cputlb.h"
 #include "exec/exec-all.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
@@ -760,9 +761,9 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                         int mmu_idx,
-                         target_ulong addr, uintptr_t retaddr, int size)
+uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+                  int mmu_idx,
+                  target_ulong addr, uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr physaddr = iotlbentry->addr;
@@ -796,10 +797,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     return val;
 }
 
-static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                      int mmu_idx,
-                      uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, int size)
+void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+               int mmu_idx,
+               uint64_t val, target_ulong addr,
+               uintptr_t retaddr, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr physaddr = iotlbentry->addr;
@@ -831,8 +832,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
-static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
-                           size_t elt_ofs, target_ulong page)
+bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
+                    size_t elt_ofs, target_ulong page)
 {
     size_t vidx;
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
diff --git a/accel/tcg/cputlb.h b/accel/tcg/cputlb.h
new file mode 100644
index 0000000000..4645693eb5
--- /dev/null
+++ b/accel/tcg/cputlb.h
@@ -0,0 +1,20 @@
+/*
+ * CPU TLB Helperss
+ */
+
+#ifndef CPUTLB_H
+#define CPUTBL_H
+
+uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+                  int mmu_idx,
+                  target_ulong addr, uintptr_t retaddr, int size);
+
+void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+               int mmu_idx,
+               uint64_t val, target_ulong addr,
+               uintptr_t retaddr, int size);
+
+bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
+                    size_t elt_ofs, target_ulong page);
+
+#endif
-- 
2.17.0
