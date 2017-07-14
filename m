Received: from eggs.gnu.org ([2001:4830:134:3::10]:42357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYV-0000CG-IM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVxYR-0004v8-AF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:39 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVxYR-0004uo-3R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:10:35 -0400
Received: by mail-wr0-x241.google.com with SMTP id k67so11312805wrc.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 03:10:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 12:10:13 +0200
Message-Id: <1500027028-4127-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/55] Revert "exec.c: Fix breakpoint
 invalidation race"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

Now that we have proper locking after MTTCG patches have landed, we
can revert the commit.  This reverts commit

a9353fe897ca2687e5b3385ed39e3db3927a90e0.

CC: Peter Maydell <peter.maydell@linaro.org>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170712215143.19594-1-bobby.prani@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                  | 25 +++++++++++++++++++------
 include/exec/exec-all.h |  3 +++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index ad103ce..2e8bc43 100644
--- a/exec.c
+++ b/exec.c
@@ -775,15 +775,28 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 #endif
 }
 
+#if defined(CONFIG_USER_ONLY)
 static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
 {
-    /* Flush the whole TB as this will not have race conditions
-     * even if we don't have proper locking yet.
-     * Ideally we would just invalidate the TBs for the
-     * specified PC.
-     */
-    tb_flush(cpu);
+    mmap_lock();
+    tb_lock();
+    tb_invalidate_phys_page_range(pc, pc + 1, 0);
+    tb_unlock();
+    mmap_unlock();
 }
+#else
+static void breakpoint_invalidate(CPUState *cpu, target_ulong pc)
+{
+    MemTxAttrs attrs;
+    hwaddr phys = cpu_get_phys_page_attrs_debug(cpu, pc, &attrs);
+    int asidx = cpu_asidx_from_attrs(cpu, attrs);
+    if (phys != -1) {
+        /* Locks grabbed by tb_invalidate_phys_addr */
+        tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
+                                phys | (pc & ~TARGET_PAGE_MASK));
+    }
+}
+#endif
 
 #if defined(CONFIG_USER_ONLY)
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8096d64..bf8da2a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -290,6 +290,9 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
                                                        uint16_t idxmap)
 {
 }
+static inline void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr)
+{
+}
 #endif
 
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
-- 
1.8.3.1
