Received: from eggs.gnu.org ([2001:4830:134:3::10]:36120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLNjI-0000oE-5C
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLNjG-00017z-Nv
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:04 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLNjG-00017m-IG
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:54:02 -0400
Received: by mail-pf0-x244.google.com with SMTP id s66so713497pfs.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 22:54:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 14 Jun 2017 22:53:53 -0700
Message-Id: <20170615055356.20684-3-rth@twiddle.net>
In-Reply-To: <20170615055356.20684-1-rth@twiddle.net>
References: <20170615055356.20684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 2/5] target/s390x: Enforce instruction features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, aurelien@aurel32.net

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index af18ffb..48cee25 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -55,6 +55,7 @@ typedef struct DisasFields DisasFields;
 
 struct DisasContext {
     struct TranslationBlock *tb;
+    const unsigned long *features;
     const DisasInsn *insn;
     DisasFields *fields;
     uint64_t ex_value;
@@ -5600,6 +5601,12 @@ static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
     }
 #endif
 
+    /* Check for insn feature enabled.  */
+    if (!test_bit(insn->fac, s->features)) {
+        gen_program_exception(s, PGM_OPERATION);
+        return EXIT_NORETURN;
+    }
+
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
         int spec = insn->spec, excp = 0, r;
@@ -5726,6 +5733,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
     }
 
     dc.tb = tb;
+    dc.features = cpu->model->features;
     dc.pc = pc_start;
     dc.cc_op = CC_OP_DYNAMIC;
     dc.ex_value = tb->cs_base;
-- 
2.9.4
