Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWX-0004Ml-OE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWW-0007RR-Cw
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:57 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWW-0007QX-6Y
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:14:56 -0400
Received: by mail-wm0-x241.google.com with SMTP id j85so30446722wmj.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:14:56 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.14.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:14:54 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:08 +0200
Message-Id: <1499238885-26161-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/42] target/i386: simplify handling of
 conforming code segments on interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Move the handling of conforming code segments before the handling
of stack switch.

Because dpl == cpl after the new "if", it's now unnecessary to check
the C bit when testing dpl < cpl.  Furthermore, dpl > cpl is checked
slightly above the modified code, so the final "else" is unreachable
and we can remove it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/seg_helper.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 9af69c2..600a4d7 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -692,7 +692,10 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
     if (!(e2 & DESC_P_MASK)) {
         raise_exception_err(env, EXCP0B_NOSEG, selector & 0xfffc);
     }
-    if (!(e2 & DESC_C_MASK) && dpl < cpl) {
+    if (e2 & DESC_C_MASK) {
+        dpl = cpl;
+    }
+    if (dpl < cpl) {
         /* to inner privilege */
         get_ss_esp_from_tss(env, &ss, &esp, dpl, 0);
         if ((ss & 0xfffc) == 0) {
@@ -719,7 +722,7 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         new_stack = 1;
         sp_mask = get_sp_mask(ss_e2);
         ssp = get_seg_base(ss_e1, ss_e2);
-    } else if ((e2 & DESC_C_MASK) || dpl == cpl) {
+    } else  {
         /* to same privilege */
         if (vm86) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
@@ -728,13 +731,6 @@ static void do_interrupt_protected(CPUX86State *env, int intno, int is_int,
         sp_mask = get_sp_mask(env->segs[R_SS].flags);
         ssp = env->segs[R_SS].base;
         esp = env->regs[R_ESP];
-        dpl = cpl;
-    } else {
-        raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
-        new_stack = 0; /* avoid warning */
-        sp_mask = 0; /* avoid warning */
-        ssp = 0; /* avoid warning */
-        esp = 0; /* avoid warning */
     }
 
     shift = type >> 3;
@@ -919,25 +915,21 @@ static void do_interrupt64(CPUX86State *env, int intno, int is_int,
     if (!(e2 & DESC_L_MASK) || (e2 & DESC_B_MASK)) {
         raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
     }
-    if ((!(e2 & DESC_C_MASK) && dpl < cpl) || ist != 0) {
+    if (e2 & DESC_C_MASK) {
+        dpl = cpl;
+    }
+    if (dpl < cpl || ist != 0) {
         /* to inner privilege */
         new_stack = 1;
         esp = get_rsp_from_tss(env, ist != 0 ? ist + 3 : dpl);
         ss = 0;
-    } else if ((e2 & DESC_C_MASK) || dpl == cpl) {
+    } else {
         /* to same privilege */
         if (env->eflags & VM_MASK) {
             raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
         }
         new_stack = 0;
         esp = env->regs[R_ESP];
-    } else {
-        raise_exception_err(env, EXCP0D_GPF, selector & 0xfffc);
-        new_stack = 0; /* avoid warning */
-        esp = 0; /* avoid warning */
-    }
-    if (e2 & DESC_C_MASK) {
-        dpl = cpl;
     }
     esp &= ~0xfLL; /* align stack */
 
-- 
1.8.3.1
