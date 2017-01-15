Received: from eggs.gnu.org ([2001:4830:134:3::10]:35257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-00068G-VH
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-0002pU-6d
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:53 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4j-0002pA-0m
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:53 -0500
Received: by mail-pg0-x241.google.com with SMTP id 75so3586779pgf.3
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:52 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:13 -0800
Message-Id: <1484514617-11726-4-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 3/7] target/xtensa: don't continue translation
 after exception
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

There's no point in continuing translating guest instructions once an
unconditional exception is thrown.
There's also no point in updating pc before any instruction is
translated, don't do it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 96c64d6..7a198fa 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -3152,8 +3152,11 @@ void gen_intermediate_code(CPUXtensaState *env, TranslationBlock *tb)
         goto done;
     }
     if (tb->flags & XTENSA_TBFLAG_EXCEPTION) {
-        tcg_gen_movi_i32(cpu_pc, dc.pc);
+        tcg_gen_insn_start(dc.pc);
+        ++insn_count;
         gen_exception(&dc, EXCP_DEBUG);
+        dc.is_jmp = DISAS_UPDATE;
+        goto done;
     }
 
     do {
-- 
2.1.4
