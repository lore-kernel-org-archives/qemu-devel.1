Received: from eggs.gnu.org ([2001:4830:134:3::10]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQTc2-0003YR-Ns
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQTbz-0002Kd-49
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:38 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:36753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQTby-0002KB-VT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 03:11:35 -0400
Received: by mail-yw0-x241.google.com with SMTP id l21so3348218ywb.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 00:11:33 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 29 Jun 2017 03:11:28 -0400
Message-Id: <20170629071129.29362-2-bobby.prani@gmail.com>
In-Reply-To: <20170629071129.29362-1-bobby.prani@gmail.com>
References: <20170629071129.29362-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] Revert "exec.c: Fix breakpoint
 invalidation race"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, pbonzini@redhat.com, ehabkost@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Now that we have proper locking after MTTCG patches have landed, we
can revert the commit.  This reverts commit

a9353fe897ca2687e5b3385ed39e3db3927a90e0.

CC: Peter Maydell <peter.maydell@linaro.org>
CC: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 exec.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 42ad1eaedd..c8403baa46 100644
--- a/exec.c
+++ b/exec.c
@@ -770,15 +770,28 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
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
-- 
2.13.0
