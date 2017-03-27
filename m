Received: from eggs.gnu.org ([2001:4830:134:3::10]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJg-0006jV-7u
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXJf-0000qA-1Q
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXJe-0000os-Rn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:16:22 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Mar 2017 18:16:10 +0200
Message-Id: <20170327161615.19637-5-pbonzini@redhat.com>
In-Reply-To: <20170327161615.19637-1-pbonzini@redhat.com>
References: <20170327161615.19637-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] tcg/i386: Check the size of instruction
 being translated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

From: Pranith Kumar <bobby.prani@gmail.com>

This fixes the bug: 'user-to-root privesc inside VM via bad translation
caching' reported by Jann Horn here:
https://bugs.chromium.org/p/project-zero/issues/detail?id=1122

Reviewed-by: Richard Henderson <rth@twiddle.net>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Message-Id: <20170323175851.14342-1-bobby.prani@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 72c1b03..1d1372f 100644
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
2.9.3
