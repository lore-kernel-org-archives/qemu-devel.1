Received: from eggs.gnu.org ([2001:4830:134:3::10]:35629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLl5-0006gV-JW
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLl4-0001u2-MF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:43 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLl4-0001te-FB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id k67so46853034wrc.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:03 +0200
Message-Id: <1499166735-39360-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/22] vapic: use tcg_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvmvapic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 82a4955..0d9ef77 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -410,7 +410,8 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
         handlers = &s->rom_state.mp;
     }
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled()) {
+        cpu_restore_state(cs, cs->mem_io_pc);
         cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
                              &current_flags);
         /* Account this instruction, because we will exit the tb.
@@ -456,7 +457,7 @@ static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ulong ip)
 
     resume_all_vcpus();
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled()) {
         /* Both tb_lock and iothread_mutex will be reset when
          *  longjmps back into the cpu_exec loop. */
         tb_lock();
-- 
1.8.3.1
