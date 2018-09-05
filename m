Received: from eggs.gnu.org ([2001:4830:134:3::10]:57772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMrv-0005t6-TW
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fxMru-0006ib-RX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:38939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fxMrr-0006e9-VI
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 21:44:29 -0400
Received: by mail-lj1-x233.google.com with SMTP id l15-v6so4804104lji.6
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 18:44:26 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue,  4 Sep 2018 18:43:40 -0700
Message-Id: <20180905014352.970-4-jcmvbkbc@gmail.com>
In-Reply-To: <20180905014352.970-1-jcmvbkbc@gmail.com>
References: <20180905014352.970-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 03/15] target/xtensa: extract test for syscall
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
Cc: Max Filippov <jcmvbkbc@gmail.com>

- mark syscall instruction;
- put syscall exception check right after privileged exception check;

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index ebee7bd65e48..450e30d316a8 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1047,6 +1047,11 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
         return;
     }
 
+    if (op_flags & XTENSA_OP_SYSCALL) {
+        gen_exception_cause(dc, SYSCALL_CAUSE);
+        return;
+    }
+
     for (slot = 0; slot < slots; ++slot) {
         XtensaOpcodeOps *ops = slot_prop[slot].ops;
 
@@ -2557,12 +2562,6 @@ static void translate_subx(DisasContext *dc, const uint32_t arg[],
     }
 }
 
-static void translate_syscall(DisasContext *dc, const uint32_t arg[],
-                              const uint32_t par[])
-{
-    gen_exception_cause(dc, SYSCALL_CAUSE);
-}
-
 static void translate_waiti(DisasContext *dc, const uint32_t arg[],
                             const uint32_t par[])
 {
@@ -4094,7 +4093,7 @@ static const XtensaOpcodeOps core_ops[] = {
         .par = (const uint32_t[]){3},
     }, {
         .name = "syscall",
-        .translate = translate_syscall,
+        .op_flags = XTENSA_OP_SYSCALL,
     }, {
         .name = "umul.aa.hh",
         .translate = translate_mac16,
-- 
2.11.0
