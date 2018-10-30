Received: from eggs.gnu.org ([2001:4830:134:3::10]:48222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa28-00082P-VT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa25-0002Hl-M9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:39022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa25-0002Dt-CX
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id r10-v6so13975942wrv.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:06 +0100
Message-Id: <1540929011-19894-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] target/i386: Clear RF on SYSCALL
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Rudolf Marek <rudolf.marek@sysgo.com>, Roman Kapl <rka@sysgo.com>

From: Rudolf Marek <rudolf.marek@sysgo.com>

Fix the SYSCALL instruction in 64-bit (long mode). The RF flag
should be cleared in R11 as well as in the RFLAGS. Intel
and AMD CPUs behave same. AMD has this documented in the
APM vol 3.

Signed-off-by: Roman Kapl <rka@sysgo.com>
Signed-off-by: Rudolf Marek <rudolf.marek@sysgo.com>
Message-Id: <20181019122449.26387-1-rka@sysgo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/seg_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 33714bc..63e265c 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -991,11 +991,11 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
         int code64;
 
         env->regs[R_ECX] = env->eip + next_eip_addend;
-        env->regs[11] = cpu_compute_eflags(env);
+        env->regs[11] = cpu_compute_eflags(env) & ~RF_MASK;
 
         code64 = env->hflags & HF_CS64_MASK;
 
-        env->eflags &= ~env->fmask;
+        env->eflags &= ~(env->fmask | RF_MASK);
         cpu_load_eflags(env, env->eflags, 0);
         cpu_x86_load_seg_cache(env, R_CS, selector & 0xfffc,
                            0, 0xffffffff,
-- 
1.8.3.1
