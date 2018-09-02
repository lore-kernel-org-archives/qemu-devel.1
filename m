Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGL8-0001aO-J5
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fwGL7-0003Te-Uy
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 20:34:06 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sat,  1 Sep 2018 20:33:21 -0400
Message-Id: <20180902003322.3428-3-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
References: <20180902003322.3428-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH v5 2/3] target/s390x: exception on non-aligned
 LPSW(E)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com, richard.henderson@linaro.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Both LPSW and LPSWE should raise a specification exception when their
operand is not doubleword aligned.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7363aabf3a..59b1e5893c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2835,7 +2835,8 @@ static DisasJumpType op_lpsw(DisasContext *s, DisasOps *o)
 
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld32u(t1, o->in2, get_mem_index(s));
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s),
+                        MO_TEUL | MO_ALIGN_8);
     tcg_gen_addi_i64(o->in2, o->in2, 4);
     tcg_gen_qemu_ld32u(t2, o->in2, get_mem_index(s));
     /* Convert the 32-bit PSW_MASK into the 64-bit PSW_MASK.  */
@@ -2855,7 +2856,8 @@ static DisasJumpType op_lpswe(DisasContext *s, DisasOps *o)
 
     t1 = tcg_temp_new_i64();
     t2 = tcg_temp_new_i64();
-    tcg_gen_qemu_ld64(t1, o->in2, get_mem_index(s));
+    tcg_gen_qemu_ld_i64(t1, o->in2, get_mem_index(s),
+                        MO_TEQ | MO_ALIGN_8);
     tcg_gen_addi_i64(o->in2, o->in2, 8);
     tcg_gen_qemu_ld64(t2, o->in2, get_mem_index(s));
     gen_helper_load_psw(cpu_env, t1, t2);
-- 
2.18.0
