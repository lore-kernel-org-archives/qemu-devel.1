Received: from eggs.gnu.org ([2001:4830:134:3::10]:41665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6R0-00022T-EL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qr-0005B7-Ot
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41853
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qr-0005AA-Ic
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8aNZ074951
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:45 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29aj6q9j37-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:44 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:44 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:08:31 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-68-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 67/81] target/sparc: Restore ldstub of odd asis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Fixes the booting of ss20 roms.

Cc: qemu-stable@nongnu.org
Reported-by: Michael Russo <mike@papersolve.com>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <rth@twiddle.net>
(cherry picked from commit 3db010c3398d03646d74f2d36a68e62539342e6c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target-sparc/translate.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/target-sparc/translate.c b/target-sparc/translate.c
index 2205f89..7245c09 100644
--- a/target-sparc/translate.c
+++ b/target-sparc/translate.c
@@ -2425,8 +2425,31 @@ static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
         gen_ldstub(dc, dst, addr, da.mem_idx);
         break;
     default:
-        /* ??? Should be DAE_invalid_asi.  */
-        gen_exception(dc, TT_DATA_ACCESS);
+        /* ??? In theory, this should be raise DAE_invalid_asi.
+           But the SS-20 roms do ldstuba [%l0] #ASI_M_CTL, %o1.  */
+        if (parallel_cpus) {
+            gen_helper_exit_atomic(cpu_env);
+        } else {
+            TCGv_i32 r_asi = tcg_const_i32(da.asi);
+            TCGv_i32 r_mop = tcg_const_i32(MO_UB);
+            TCGv_i64 s64, t64;
+
+            save_state(dc);
+            t64 = tcg_temp_new_i64();
+            gen_helper_ld_asi(t64, cpu_env, addr, r_asi, r_mop);
+
+            s64 = tcg_const_i64(0xff);
+            gen_helper_st_asi(cpu_env, addr, s64, r_asi, r_mop);
+            tcg_temp_free_i64(s64);
+            tcg_temp_free_i32(r_mop);
+            tcg_temp_free_i32(r_asi);
+
+            tcg_gen_trunc_i64_tl(dst, t64);
+            tcg_temp_free_i64(t64);
+
+            /* End the TB.  */
+            dc->npc = DYNAMIC_PC;
+        }
         break;
     }
 }
-- 
2.7.4
