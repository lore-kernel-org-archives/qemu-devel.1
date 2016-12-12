Received: from eggs.gnu.org ([2001:4830:134:3::10]:55143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyg-0002e4-6y
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGGyf-0003Lo-EC
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGGyf-0003LM-9n
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 22:08:33 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 12 Dec 2016 11:08:08 +0800
Message-Id: <1481512100-10380-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests PATCH v8 02/14] x86/asm: add
 cpu_relax()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: drjones@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, rkrcmar@redhat.com, pbonzini@redhat.com, peterx@redhat.com

This will be useful to be put inside loops.

Suggested-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 lib/x86/asm/barrier.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/x86/asm/barrier.h b/lib/x86/asm/barrier.h
index 7c108bd..193fb4c 100644
--- a/lib/x86/asm/barrier.h
+++ b/lib/x86/asm/barrier.h
@@ -13,4 +13,15 @@
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+static inline void rep_nop(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
+static inline void cpu_relax(void)
+{
+	rep_nop();
+}
+
 #endif
-- 
2.7.4
