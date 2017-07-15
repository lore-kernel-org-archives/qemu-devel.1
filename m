Received: from eggs.gnu.org ([2001:4830:134:3::10]:38088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbO-0003df-RV
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbO-0003Ev-4j
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:06 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbN-0003Ei-W7
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:06 -0400
Received: by mail-pg0-x242.google.com with SMTP id d193so13339788pgc.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:16 -1000
Message-Id: <20170715094243.28371-8-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 07/34] target/arm: Set is_jmp properly
 after single-stepping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

We have generated an exception, so use DISAS_NORETURN.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 1 +
 target/arm/translate.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 342ff7c..657684b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11285,6 +11285,7 @@ void gen_intermediate_code_a64(CPUState *cs, TranslationBlock *tb)
                         dc->is_jmp = DISAS_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+                        dc->is_jmp = DISAS_NORETURN;
                         /* The address covered by the breakpoint must be
                            included in [tb->pc, tb->pc + tb->size) in order
                            to for it to be properly cleared -- thus we
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2ae68ce..83e5491 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11942,6 +11942,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
                         dc->is_jmp = DISAS_UPDATE;
                     } else {
                         gen_exception_internal_insn(dc, 0, EXCP_DEBUG);
+                        dc->is_jmp = DISAS_NORETURN;
                         /* The address covered by the breakpoint must be
                            included in [tb->pc, tb->pc + tb->size) in order
                            to for it to be properly cleared -- thus we
@@ -11986,7 +11987,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             assert(num_insns == 1);
             gen_exception(EXCP_UDEF, syn_swstep(dc->ss_same_el, 0, 0),
                           default_exception_el(dc));
-            goto done_generating;
+            dc->is_jmp = DISAS_NORETURN;
+            break;
         }
 
         if (dc->thumb) {
-- 
2.9.4
