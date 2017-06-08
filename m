Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIyl1-0000Sj-WC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIyky-00082s-40
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIykx-00082Z-Uf
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:49:52 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  8 Jun 2017 16:49:49 +0200
Message-Id: <20170608144949.7918-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] hax-all: make async_safe_run_on_cpu safe on
 HAX too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vincent Palatin <vpalatin@chromium.org>

While at it, drop the current_cpu assignment since this is a
per-thread variable on modern QEMU.

Cc: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 097db5cae1..ba6117d7de 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -514,9 +514,10 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
         hax_vcpu_interrupt(env);
 
         qemu_mutex_unlock_iothread();
+        cpu_exec_start(cpu);
         hax_ret = hax_vcpu_run(vcpu);
+        cpu_exec_end(cpu);
         qemu_mutex_lock_iothread();
-        current_cpu = cpu;
 
         /* Simply continue the vcpu_run if system call interrupted */
         if (hax_ret == -EINTR || hax_ret == -EAGAIN) {
-- 
2.13.0
