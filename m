Received: from eggs.gnu.org ([2001:4830:134:3::10]:57360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4Z-0002Js-3M
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cbm4X-000242-Da
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cbm4X-00023Q-93
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:35:29 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v19AXXO9106643
	for <qemu-devel@nongnu.org>; Thu, 9 Feb 2017 05:35:28 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28gm30g7kf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 05:35:28 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 9 Feb 2017 20:35:25 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  9 Feb 2017 16:04:04 +0530
In-Reply-To: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486636445-24109-1-git-send-email-nikunj@linux.vnet.ibm.com>
Message-Id: <1486636445-24109-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 5/6] target-ppc: support for 32-bit carry and
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com

POWER ISA 3.0 adds CA32 and OV32 status in 64-bit mode. Add the flags
and corresponding defines. Moreover, CA32 is set when CA is set and
OV32 is set when OV is set, there is no need to have a new
fields in the CPUPPCState structure.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 target/ppc/cpu.h       | 26 ++++++++++++++++++++++++++
 target/ppc/translate.c |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bc2a2ce..181919b 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1354,11 +1354,15 @@ int ppc_compat_max_threads(PowerPCCPU *cpu);
 #define XER_SO  31
 #define XER_OV  30
 #define XER_CA  29
+#define XER_OV32  19
+#define XER_CA32  18
 #define XER_CMP  8
 #define XER_BC   0
 #define xer_so  (env->so)
 #define xer_ov  (env->ov)
 #define xer_ca  (env->ca)
+#define xer_ov32  (env->ov)
+#define xer_ca32  (env->ca)
 #define xer_cmp ((env->xer >> XER_CMP) & 0xFF)
 #define xer_bc  ((env->xer >> XER_BC)  & 0x7F)
 
@@ -2325,11 +2329,21 @@ enum {
 
 /*****************************************************************************/
 
+#ifndef TARGET_PPC64
 static inline target_ulong cpu_read_xer(CPUPPCState *env)
 {
     return env->xer | (env->so << XER_SO) | (env->ov << XER_OV) | (env->ca << XER_CA);
 }
+#else
+static inline target_ulong cpu_read_xer(CPUPPCState *env)
+{
+    return env->xer | (env->so << XER_SO) |
+        (env->ov << XER_OV) | (env->ca << XER_CA) |
+        (env->ov << XER_OV32) | (env->ca << XER_CA32);
+}
+#endif
 
+#ifndef TARGET_PPC64
 static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
 {
     env->so = (xer >> XER_SO) & 1;
@@ -2337,6 +2351,18 @@ static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
     env->ca = (xer >> XER_CA) & 1;
     env->xer = xer & ~((1u << XER_SO) | (1u << XER_OV) | (1u << XER_CA));
 }
+#else
+static inline void cpu_write_xer(CPUPPCState *env, target_ulong xer)
+{
+    env->so = (xer >> XER_SO) & 1;
+    env->ov = ((xer >> XER_OV) & 1) | ((xer >> XER_OV32) & 1);
+    env->ca = ((xer >> XER_CA) & 1) | ((xer >> XER_CA32) & 1);
+    env->xer = xer & ~((1ul << XER_SO) |
+                       (1ul << XER_OV) | (1ul << XER_CA) |
+                       (1ul << XER_OV32) | (1ul << XER_CA32));
+}
+#endif
+
 
 static inline void cpu_get_tb_cpu_state(CPUPPCState *env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ba2616..724ad17 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3715,6 +3715,12 @@ static void gen_read_xer(TCGv dst)
     tcg_gen_or_tl(t0, t0, t1);
     tcg_gen_or_tl(dst, dst, t2);
     tcg_gen_or_tl(dst, dst, t0);
+#ifdef TARGET_PPC64
+    tcg_gen_shli_tl(t0, cpu_ov, XER_OV32);
+    tcg_gen_or_tl(dst, dst, t0);
+    tcg_gen_shli_tl(t0, cpu_ca, XER_CA32);
+    tcg_gen_or_tl(dst, dst, t0);
+#endif
     tcg_temp_free(t0);
     tcg_temp_free(t1);
     tcg_temp_free(t2);
-- 
2.7.4
