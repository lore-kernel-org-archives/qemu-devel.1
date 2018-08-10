Received: from eggs.gnu.org ([2001:4830:134:3::10]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxiK-00063T-Bu
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fnxiJ-0003uD-AF
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 23:03:44 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Thu,  9 Aug 2018 23:01:34 -0400
Message-Id: <20180810030139.25916-3-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
References: <20180810030139.25916-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 2/7] target/s390x: add BAL and BALR instructions
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

These instructions are provided for compatibility purposes and are
used only by old software, in the new code BAS and BASR are preferred.
The difference between the old and new instruction exists only in the
24-bit mode.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/insn-data.def |  3 +++
 target/s390x/translate.c   | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 5c6f33ed9c..9c7b434fca 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -102,6 +102,9 @@
     D(0x9400, NI,      SI,    Z,   la1, i2_8u, new, 0, ni, nz64, MO_UB)
     D(0xeb54, NIY,     SIY,   LD,  la1, i2_8u, new, 0, ni, nz64, MO_UB)
 
+/* BRANCH AND LINK */
+    C(0x0500, BALR,    RR_a,  Z,   0, r2_nz, r1, 0, bal, 0)
+    C(0x4500, BAL,     RX_a,  Z,   0, a2, r1, 0, bal, 0)
 /* BRANCH AND SAVE */
     C(0x0d00, BASR,    RR_a,  Z,   0, r2_nz, r1, 0, bas, 0)
     C(0x4d00, BAS,     RX_a,  Z,   0, a2, r1, 0, bas, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 57c03cbf58..316ff79250 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1463,6 +1463,39 @@ static DisasJumpType op_bas(DisasContext *s, DisasOps *o)
     }
 }
 
+static void save_link_info(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 t;
+
+    if (s->base.tb->flags & (FLAG_MASK_32 | FLAG_MASK_64)) {
+        tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
+        return;
+    }
+    gen_op_calc_cc(s);
+    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
+    tcg_gen_ori_i64(o->out, o->out, ((s->ilen / 2) << 30) | s->pc_tmp);
+    t = tcg_temp_new_i64();
+    tcg_gen_shri_i64(t, psw_mask, 16);
+    tcg_gen_andi_i64(t, t, 0x0f000000);
+    tcg_gen_or_i64(o->out, o->out, t);
+    tcg_gen_extu_i32_i64(t, cc_op);
+    tcg_gen_shli_i64(t, t, 28);
+    tcg_gen_or_i64(o->out, o->out, t);
+    tcg_temp_free_i64(t);
+}
+
+static DisasJumpType op_bal(DisasContext *s, DisasOps *o)
+{
+    save_link_info(s, o);
+    if (o->in2) {
+        tcg_gen_mov_i64(psw_addr, o->in2);
+        per_branch(s, false);
+        return DISAS_PC_UPDATED;
+    } else {
+        return DISAS_NEXT;
+    }
+}
+
 static DisasJumpType op_basi(DisasContext *s, DisasOps *o)
 {
     tcg_gen_movi_i64(o->out, pc_to_link_info(s, s->pc_tmp));
-- 
2.18.0
