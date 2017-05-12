Received: from eggs.gnu.org ([2001:4830:134:3::10]:45734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAd-0001Kw-K5
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KAc-0004BL-Tp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:27 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KAc-0004AE-Qo
	for qemu-devel@nongnu.org; Fri, 12 May 2017 19:40:26 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so9846470qke.2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 16:40:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 12 May 2017 16:40:09 -0700
Message-Id: <20170512234009.32557-10-rth@twiddle.net>
In-Reply-To: <20170512234009.32557-1-rth@twiddle.net>
References: <20170512234009.32557-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 9/9] target/s390x: implement serialization in
 BRANCH CONDITION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

From: Aurelien Jarno <aurelien@aurel32.net>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170509082800.10756-4-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 3a0a3ee..4c48c59 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1518,6 +1518,21 @@ static ExitStatus op_bc(DisasContext *s, DisasOps *o)
     int imm = is_imm ? get_field(s->fields, i2) : 0;
     DisasCompare c;
 
+    /* BCR with R2 = 0 causes no branching */
+    if (have_field(s->fields, r2) && get_field(s->fields, r2) == 0) {
+        if (m1 == 14) {
+            /* Perform serialization */
+            /* FIXME: check for fast-BCR-serialization facility */
+            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        }
+        if (m1 == 15) {
+            /* Perform serialization */
+            /* FIXME: perform checkpoint-synchronisation */
+            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        }
+        return NO_EXIT;
+    }
+
     disas_jcc(s, &c, m1);
     return help_branch(s, &c, is_imm, imm, o->in2);
 }
-- 
2.9.3
