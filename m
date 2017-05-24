Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbry-0001a6-Rk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbrx-0000r0-Uh
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:54 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbrx-0000qs-R4
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:22:53 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so27540833qtb.2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:22:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:14 -0700
Message-Id: <20170524192246.15905-2-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 01/33] target/s390x: Use
 cpu_loop_exit_restore for tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 0c6a0d9..e3325a4 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -41,15 +41,9 @@
 void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
               int mmu_idx, uintptr_t retaddr)
 {
-    int ret;
-
-    ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
+    int ret = s390_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret != 0)) {
-        if (likely(retaddr)) {
-            /* now we have a real cpu fault */
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 
-- 
2.9.4
