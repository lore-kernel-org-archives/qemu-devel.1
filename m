Received: from eggs.gnu.org ([2001:4830:134:3::10]:59892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr70j-0008WR-0l
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cr70f-0001r4-To
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:58:57 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cr70f-0001qn-PO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:58:53 -0400
Received: by mail-yw0-x242.google.com with SMTP id h11so24424803ywa.2
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:58:53 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 23 Mar 2017 13:58:51 -0400
Message-Id: <20170323175851.14342-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg/i386: Check the size of instruction being
 translated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Sending again since I messed by pbonzini's email.

This fixes the bug: 'user-to-root privesc inside VM via bad translation
caching' reported by Jann Horn here:
https://bugs.chromium.org/p/project-zero/issues/detail?id=1122

CC: Richard Henderson <rth@twiddle.net>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/i386/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 72c1b03a2a..1d1372fb43 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4418,6 +4418,13 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
     s->vex_l = 0;
     s->vex_v = 0;
  next_byte:
+    /* x86 has an upper limit of 15 bytes for an instruction. Since we
+     * do not want to decode and generate IR for an illegal
+     * instruction, the following check limits the instruction size to
+     * 25 bytes: 14 prefix + 1 opc + 6 (modrm+sib+ofs) + 4 imm */
+    if (s->pc - pc_start > 14) {
+        goto illegal_op;
+    }
     b = cpu_ldub_code(env, s->pc);
     s->pc++;
     /* Collect prefixes.  */
-- 
2.11.0
