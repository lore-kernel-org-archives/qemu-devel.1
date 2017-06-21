Received: from eggs.gnu.org ([2001:4830:134:3::10]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willx8@gmail.com>) id 1dNgWG-0004UK-Jy
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willx8@gmail.com>) id 1dNgWC-0003Wv-LM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:08 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <willx8@gmail.com>) id 1dNgWC-0003Wc-D9
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:22:04 -0400
Received: by mail-pf0-x243.google.com with SMTP id y7so30870971pfd.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:22:02 -0700 (PDT)
Date: Wed, 21 Jun 2017 22:21:56 +0800
From: Wu Xiang <willx8@gmail.com>
Message-ID: <20170621142152.GA18094@wxdeubuntu.ipads-lab.se.sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] target/i386: fix interrupt CPL error when
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

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
2.7.4
