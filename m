Received: from eggs.gnu.org ([2001:4830:134:3::10]:46268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0004Mk-L6
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWV-0007Qa-LJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:57 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWV-0007Pv-En
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:55 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so258101644wrb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:55 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:07 +0200
Message-Id: <1499238885-26161-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/42] target/i386: fix interrupt CPL error when
 using ist in x86-64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wu Xiang <willx8@gmail.com>

From: Wu Xiang <willx8@gmail.com>

In do_interrupt64(), when interrupt stack table(ist) is enabled
and the the target code segment is conforming(e2 & DESC_C_MASK), the
old implementation always set new CPL to 0, and SS.RPL to 0.

This is incorrect for when CPL3 code access a CPL0 conforming code
segment, the CPL should remain unchanged. Otherwise higher privileged
code can be compromised.

The patch fix this for always set dpl = cpl when the target code segment
is conforming, and modify the last parameter `flags`, which contains
correct new CPL, in cpu_x86_load_seg_cache().

Signed-off-by: Wu Xiang <willx8@gmail.com>
Message-Id: <20170621142152.GA18094@wxdeubuntu.ipads-lab.se.sjtu.edu.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/seg_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 0374031..9af69c2 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -931,12 +931,14 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
         }
         new_stack = 0;
         esp = env->regs[R_ESP];
-        dpl = cpl;
     } else {
         raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         new_stack = 0; /* avoid warning */
         esp = 0; /* avoid warning */
     }
+    if (e2 & DESC_C_MASK) {
+        dpl = cpl;
+    }
     esp &= ~0xfLL; /* align stack */
 
     PUSHQ(esp, env->segs[R_SS].selector);
@@ -956,7 +958,7 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
 
     if (new_stack) {
         ss = 0 | dpl;
-        cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, 0);
+        cpu_x86_load_seg_cache(env, R_SS, ss, 0, 0, dpl << DESC_DPL_SHIFT);
     }
     env->regs[R_ESP] = esp;
 
-- 
1.8.3.1
