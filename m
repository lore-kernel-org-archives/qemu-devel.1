Received: from eggs.gnu.org ([2001:4830:134:3::10]:40882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP5-0008Fd-IE
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLSP4-0007Zp-Q6
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:31 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLSP4-0007Zk-JO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 06:53:30 -0400
Received: by mail-wr0-x241.google.com with SMTP id z45so2762515wrb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 03:53:30 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 12:52:37 +0200
Message-Id: <1497523981-38449-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
References: <1497523981-38449-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/41] hax-all: make async_safe_run_on_cpu safe
 on HAX too
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
index 097db5c..ba6117d 100644
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
1.8.3.1
