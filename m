Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOe-0005Sb-1n
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYuOZ-0006nc-H4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYuOX-0006jZ-Hq
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:01:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so4937245wmd.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 07:01:19 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 15:01:13 +0000
Message-Id: <20181217150116.10446-2-alex.bennee@linaro.org>
In-Reply-To: <20181217150116.10446-1-alex.bennee@linaro.org>
References: <20181217150116.10446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/4] accel/tcg: export some cputlb functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

In preparation for having softmmu helpers in their own file rather
than generated as part of softmmu-template.h we need to make a couple
of helper functions public outside of cputlb.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 21 +++++++++++----------
 accel/tcg/cputlb.h | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 10 deletions(-)
 create mode 100644 accel/tcg/cputlb.h

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index af6bd8ccf9..3cae7335d0 100644
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
@@ -675,10 +676,10 @@ static inline ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr)
     return ram_addr;
 }
 
-static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                         int mmu_idx,
-                         target_ulong addr, uintptr_t retaddr,
-                         bool recheck, MMUAccessType access_type, int size)
+uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+                  int mmu_idx,
+                  target_ulong addr, uintptr_t retaddr,
+                  bool recheck, MMUAccessType access_type, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -743,10 +744,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     return val;
 }
 
-static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
-                      int mmu_idx,
-                      uint64_t val, target_ulong addr,
-                      uintptr_t retaddr, bool recheck, int size)
+void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+               int mmu_idx,
+               uint64_t val, target_ulong addr,
+               uintptr_t retaddr, bool recheck, int size)
 {
     CPUState *cpu = ENV_GET_CPU(env);
     hwaddr mr_offset;
@@ -809,8 +810,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
 /* Return true if ADDR is present in the victim tlb, and has been copied
    back to the main tlb.  */
-static bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
-                           size_t elt_ofs, target_ulong page)
+bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
+                    size_t elt_ofs, target_ulong page)
 {
     size_t vidx;
 
diff --git a/accel/tcg/cputlb.h b/accel/tcg/cputlb.h
new file mode 100644
index 0000000000..da09f45b86
--- /dev/null
+++ b/accel/tcg/cputlb.h
@@ -0,0 +1,21 @@
+/*
+ * CPU TLB Helpers
+ */
+
+#ifndef CPUTLB_H
+#define CPUTBL_H
+
+uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+                  int mmu_idx,
+                  target_ulong addr, uintptr_t retaddr,
+                  bool recheck, MMUAccessType access_type, int size);
+
+void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
+               int mmu_idx,
+               uint64_t val, target_ulong addr,
+               uintptr_t retaddr, bool recheck, int size);
+
+bool victim_tlb_hit(CPUArchState *env, size_t mmu_idx, size_t index,
+                    size_t elt_ofs, target_ulong page);
+
+#endif
-- 
2.17.1
