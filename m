Received: from eggs.gnu.org ([2001:4830:134:3::10]:60192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfc-0004R9-Ux
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfa-0005em-KN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfa-0005dJ-Db
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:30 -0400
Received: by mail-wm0-x241.google.com with SMTP id i131so3750555wma.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:27 +0200
Message-Id: <1505824179-21541-39-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 38/50] target/mips: Convert VM clock update
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, James Hogan <james.hogan@imgtec.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Convert the fprintf() messages in kvm_mips_update_state() to use
warn_report() as they aren't errors, but are just warnings.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: James Hogan <james.hogan@imgtec.com>
Message-Id: <e6acff8db6d264f913a18c86858b9aa600554e51.1505158760.git.alistair.francis@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/mips/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index a23aa43..3b7b1d9 100644
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
1.8.3.1
