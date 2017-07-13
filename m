Received: from eggs.gnu.org ([2001:4830:134:3::10]:51793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4O-0001rS-PV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf4K-0004I8-KU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf4K-0004Hw-E6
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so9397883wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:26:16 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:15 +0200
Message-Id: <1499955874-10954-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/41] Revert "exec.c: Fix breakpoint
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
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=83=C2=A9e?= <alex.bennee@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

Now that we have proper locking after MTTCG patches have landed, we
can revert the commit.  This reverts commit

a9353fe897ca2687e5b3385ed39e3db3927a90e0.

CC: Peter Maydell <peter.maydell@linaro.org>
CC: Alex BennÃ©e <alex.bennee@linaro.org>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170712215143.19594-1-bobby.prani@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

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
-- 
1.8.3.1
