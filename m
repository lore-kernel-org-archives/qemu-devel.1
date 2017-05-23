Received: from eggs.gnu.org ([2001:4830:134:3::10]:54693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06S-0005YK-FK
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06R-0003g3-Kk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:20 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06R-0003fy-Hc
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:19 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so21473101qka.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:19 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.17 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:42 -0700
Message-Id: <20170523030312.6360-2-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 01/31] target/s390: Use cpu_loop_exit_restore
 for tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
