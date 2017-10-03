Received: from eggs.gnu.org ([2001:4830:134:3::10]:51548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1dzGc3-0001im-AQ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sandipan@linux.vnet.ibm.com>) id 1dzGby-0000Y1-8K
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:23:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45108
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sandipan@linux.vnet.ibm.com>)
	id 1dzGby-0000Wi-2s
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:23:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v936JAEx123387
	for <qemu-devel@nongnu.org>; Tue, 3 Oct 2017 02:23:18 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dbwsybrmc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 02:23:18 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sandipan@linux.vnet.ibm.com>;
	Tue, 3 Oct 2017 16:23:15 +1000
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
Date: Tue,  3 Oct 2017 11:53:10 +0530
Message-Id: <20171003062310.9919-1-sandipan@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3] target/ppc: Fix carry flag setting for
 shift algebraic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au, agraf@suse.de
Cc: nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

For POWER ISA v3.0, the XER bit CA32 needs to be set by the shift
right algebraic instructions whenever the CA bit is to be set. This
change affects the following instructions:
  * Shift Right Algebraic Word (sraw[.])
  * Shift Right Algebraic Word Immediate (srawi[.])
  * Shift Right Algebraic Doubleword (srad[.])
  * Shift Right Algebraic Doubleword Immediate (sradi[.])

Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
---
v2: Add tcg_temp_free() required in gen_sraw() and gen_srad()

v3: Remove explicit checking for ISA v3.0 when setting CA32
---
 target/ppc/int_helper.c | 8 ++++++++
 target/ppc/translate.c  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index da4e1a62c9..0bdd96aebe 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -231,6 +231,10 @@ target_ulong helper_sraw(CPUPPCState *env, target_ulong value,
         ret = (int32_t)value >> 31;
         env->ca = (ret != 0);
     }
+
+    /* update CA32 for ISA v3.0 */
+    env->ca32 = env->ca;
+
     return (target_long)ret;
 }
 
@@ -257,6 +261,10 @@ target_ulong helper_srad(CPUPPCState *env, target_ulong value,
         ret = (int64_t)value >> 63;
         env->ca = (ret != 0);
     }
+
+    /* update CA32 for ISA v3.0 */
+    env->ca32 = env->ca;
+
     return ret;
 }
 #endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 606b605ba0..c35a2027eb 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2192,6 +2192,10 @@ static void gen_srawi(DisasContext *ctx)
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
         tcg_gen_sari_tl(dst, dst, sh);
     }
+
+    /* update CA32 for ISA v3.0 */
+    tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
@@ -2269,6 +2273,10 @@ static inline void gen_sradi(DisasContext *ctx, int n)
         tcg_gen_setcondi_tl(TCG_COND_NE, cpu_ca, cpu_ca, 0);
         tcg_gen_sari_tl(dst, src, sh);
     }
+
+    /* update CA32 for ISA v3.0 */
+    tcg_gen_mov_tl(cpu_ca32, cpu_ca);
+
     if (unlikely(Rc(ctx->opcode) != 0)) {
         gen_set_Rc0(ctx, dst);
     }
-- 
2.13.5
