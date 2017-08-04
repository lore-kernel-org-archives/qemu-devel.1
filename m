Received: from eggs.gnu.org ([2001:4830:134:3::10]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVAJ-0007ol-90
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVAG-0001Kv-VU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:51 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVAG-0001K6-Ow
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:48 -0400
Received: by mail-pf0-x241.google.com with SMTP id c65so839372pfl.0
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:28:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:28:33 -0700
Message-Id: <20170804052833.10187-12-rth@twiddle.net>
In-Reply-To: <20170804052833.10187-1-rth@twiddle.net>
References: <20170804052833.10187-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 8/8] tcg/s390: Use slbgr for setcond le and leu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, cohuck@redhat.com, borntraeger@de.ibm.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 119 +++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 76 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index 0de968fde2..38b9e791ee 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -1084,11 +1084,20 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
 
     have_loc = (s390_facilities & FACILITY_LOAD_ON_COND) != 0;
 
-    /* For HAVE_LOC, only the path through do_greater is smaller.  */
+    /* For HAVE_LOC, only the paths through GTU/GT/LEU/LE are smaller.  */
+ restart:
     switch (cond) {
+    case TCG_COND_NE:
+        /* X != 0 is X > 0.  */
+        if (c2const && c2 == 0) {
+            cond = TCG_COND_GTU;
+        } else {
+            break;
+        }
+        /* fallthru */
+
     case TCG_COND_GTU:
     case TCG_COND_GT:
-    do_greater:
         /* The result of a compare has CC=2 for GT and CC=3 unused.
            ADD LOGICAL WITH CARRY considers (CC & 2) the carry bit.  */
         tgen_cmp(s, type, cond, c1, c2, c2const, true);
@@ -1096,49 +1105,33 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         tcg_out_insn(s, RRE, ALCGR, dest, dest);
         return;
 
-    case TCG_COND_GEU:
-        if (have_loc) {
-            goto do_loc;
-        }
-    do_geu:
-        /* We need "real" carry semantics, so use SUBTRACT LOGICAL
-           instead of COMPARE LOGICAL.  This may need an extra move.  */
-        if (c2const) {
-            tcg_out_mov(s, type, TCG_TMP0, c1);
-            if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RIL, SLFI, TCG_TMP0, c2);
-            } else {
-                tcg_out_insn(s, RIL, SLGFI, TCG_TMP0, c2);
-            }
-        } else if (s390_facilities & FACILITY_DISTINCT_OPS) {
-            if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RRF, SLRK, TCG_TMP0, c1, c2);
-            } else {
-                tcg_out_insn(s, RRF, SLGRK, TCG_TMP0, c1, c2);
-            }
+    case TCG_COND_EQ:
+        /* X == 0 is X <= 0.  */
+        if (c2const && c2 == 0) {
+            cond = TCG_COND_LEU;
         } else {
-            tcg_out_mov(s, type, TCG_TMP0, c1);
-            if (type == TCG_TYPE_I32) {
-                tcg_out_insn(s, RR, SLR, TCG_TMP0, c2);
-            } else {
-                tcg_out_insn(s, RRE, SLGR, TCG_TMP0, c2);
-            }
+            break;
         }
-        tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
-        tcg_out_insn(s, RRE, ALCGR, dest, dest);
-        return;
+        /* fallthru */
 
     case TCG_COND_LEU:
-        if (have_loc) {
-            goto do_loc;
-        }
-        /* fallthru */
+    case TCG_COND_LE:
+        /* As above, but we're looking for borrow, or !carry.
+           The second insn computes d - d - borrow, or -1 for true
+           and 0 for false.  So we must mask to 1 bit afterward.  */
+        tgen_cmp(s, type, cond, c1, c2, c2const, true);
+        tcg_out_insn(s, RRE, SLBGR, dest, dest);
+        tgen_andi(s, type, dest, 1);
+        return;
+
+    case TCG_COND_GEU:
     case TCG_COND_LTU:
     case TCG_COND_LT:
-        /* Swap operands so that we can use GEU/GTU/GT.  */
+    case TCG_COND_GE:
+        /* Swap operands so that we can use LEU/GTU/GT/LE.  */
         if (c2const) {
             if (have_loc) {
-                goto do_loc;
+                break;
             }
             tcg_out_movi(s, type, TCG_TMP0, c2);
             c2 = c1;
@@ -1149,51 +1142,25 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
             c1 = c2;
             c2 = t;
         }
-        if (cond == TCG_COND_LEU) {
-            goto do_geu;
-        }
         cond = tcg_swap_cond(cond);
-        goto do_greater;
-
-    case TCG_COND_NE:
-        /* X != 0 is X > 0.  */
-        if (c2const && c2 == 0) {
-            cond = TCG_COND_GTU;
-            goto do_greater;
-        }
-        break;
-
-    case TCG_COND_EQ:
-        if (have_loc) {
-            goto do_loc;
-        }
-        /* X == 0 is X <= 0 is 0 >= X.  */
-        if (c2const && c2 == 0) {
-            tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 0);
-            c2 = c1;
-            c2const = 0;
-            c1 = TCG_TMP0;
-            goto do_geu;
-        }
-        break;
+        goto restart;
 
     default:
-        break;
+        g_assert_not_reached();
     }
 
     cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
-    /* Emit: d = 1; if (cc) goto over; d = 0; over:  */
-    tcg_out_movi(s, type, dest, 1);
-    tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
-    tcg_out_movi(s, type, dest, 0);
-    return;
-
- do_loc:
-    cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
-    /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
-    tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
-    tcg_out_insn(s, RRF, LOCGR, dest, TCG_TMP0, cc);
+    if (have_loc) {
+        /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
+        tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
+        tcg_out_insn(s, RRF, LOCGR, dest, TCG_TMP0, cc);
+    } else {
+        /* Emit: d = 1; if (cc) goto over; d = 0; over:  */
+        tcg_out_movi(s, type, dest, 1);
+        tcg_out_insn(s, RI, BRC, cc, (4 + 4) >> 1);
+        tcg_out_movi(s, type, dest, 0);
+    }
 }
 
 static void tgen_movcond(TCGContext *s, TCGType type, TCGCond c, TCGReg dest,
-- 
2.13.3
