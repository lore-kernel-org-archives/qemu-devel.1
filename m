Received: from eggs.gnu.org ([2001:4830:134:3::10]:54013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g8irQ-00013N-Kf
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 05:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g8ijO-0006VB-9a
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 05:18:43 -0400
Received: from m50-132.163.com ([123.125.50.132]:43422)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g8ijN-0006Rg-Ib
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 05:18:38 -0400
From: Li Qiang <liq3ea@163.com>
Date: Sat,  6 Oct 2018 02:18:16 -0700
Message-Id: <20181006091816.7659-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] target/i386: kvm: just return after
 migrate_add_blocker failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

When migrate_add_blocker failed, the invtsc_mig_blocker is not
appended so no need to remove. This can save several instructions.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 target/i386/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 0b2a07d3a4..6ba84a39f3 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1153,7 +1153,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             if (local_err) {
                 error_report_err(local_err);
                 error_free(invtsc_mig_blocker);
-                goto fail;
+                return r;
             }
             /* for savevm */
             vmstate_x86_cpu.unmigratable = 1;
-- 
2.17.1
