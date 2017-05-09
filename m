Received: from eggs.gnu.org ([2001:4830:134:3::10]:49327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V7-0002hg-OQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d80V7-000063-0t
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:09 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d80V6-00005g-Rn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:28:08 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  9 May 2017 10:28:00 +0200
Message-Id: <20170509082800.10756-4-aurelien@aurel32.net>
In-Reply-To: <20170509082800.10756-1-aurelien@aurel32.net>
References: <20170509082800.10756-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 3/3] target/s390x: implement serialization in
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/translate.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index c58c27f8e9..2f07ce2be9 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1517,6 +1517,21 @@ static ExitStatus op_bc(DisasContext *s, DisasOps *o)
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
2.11.0
