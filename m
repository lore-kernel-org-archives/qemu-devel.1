Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUp4-0006BI-Vv
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1drUp1-0002GR-4K
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:47 -0400
Received: from mail-by2nam03on0068.outbound.protection.outlook.com
	([104.47.42.68]:53728
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1drUp0-0002EZ-QZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:56:43 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 11 Sep 2017 12:52:59 -0700
Message-ID: <e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1505158760.git.alistair.francis@xilinx.com>
References: <cover.1505158760.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 6/8] target/mips: Convert VM clock update
 prints to warn_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, pbonzini@redhat.com, James Hogan <james.hogan@imgtec.com>

Convert the fprintf() messages in kvm_mips_update_state() to use
warn_report() as they aren't errors, but are just warnings.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: James Hogan <james.hogan@imgtec.com>
---

 target/mips/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a23aa438d2..3b7b1d962a 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -526,7 +526,7 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
         if (!cs->vcpu_dirty) {
             ret = kvm_mips_save_count(cs);
             if (ret < 0) {
-                fprintf(stderr, "Failed saving count\n");
+                warn_report("Failed saving count");
             }
         }
     } else {
@@ -535,14 +535,14 @@ static void kvm_mips_update_state(void *opaque, int running, RunState state)
         ret = kvm_mips_put_one_ureg64(cs, KVM_REG_MIPS_COUNT_RESUME,
                                       &count_resume);
         if (ret < 0) {
-            fprintf(stderr, "Failed setting COUNT_RESUME\n");
+            warn_report("Failed setting COUNT_RESUME");
             return;
         }
 
         if (!cs->vcpu_dirty) {
             ret = kvm_mips_restore_count(cs);
             if (ret < 0) {
-                fprintf(stderr, "Failed restoring count\n");
+                warn_report("Failed restoring count");
             }
         }
     }
-- 
2.11.0
