Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d11A2-0003tc-CR
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1d119u-0003An-Mb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:45:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34770
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1d119u-0003AU-Go
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 21:45:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3K1hdtt084669
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:45:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xaqk4q2n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:45:20 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Thu, 20 Apr 2017 11:45:17 +1000
Date: Thu, 20 Apr 2017 11:44:17 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-Id: <20170420014417.GA6677@tungsten.ozlabs.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] target/ppc: Fix emulated userspace access
 to USPRG3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On a fully emulated Power8 system, user space is currently unable to
read from USPRG3 (SPR number 0x103) because it receives an illegal
instruction exception.

However the ISA indicates that it should have read access (to the
content of SPR 0x113, similar to some other registers with user space
read-only counterparts).

This patch registers the new SPR for Book 3S processors and has it
provide read-only access to SPR 0x113.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 target/ppc/translate_init.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c1a901455c..f863875835 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8235,6 +8235,14 @@ static void gen_spr_power8_rpr(CPUPPCState *env)
 #endif
 }
 
+static void gen_spr_book3s_usprg3(CPUPPCState *env)
+{
+    spr_register(env, SPR_USPRG3, "USPRG3",
+                 &spr_read_ureg, SPR_NOACCESS,
+                 &spr_read_ureg, SPR_NOACCESS,
+                 0x00000000);
+}
+
 static void init_proc_book3s_common(CPUPPCState *env)
 {
     gen_spr_ne_601(env);
@@ -8243,6 +8251,7 @@ static void init_proc_book3s_common(CPUPPCState *env)
     gen_spr_book3s_pmu_sup(env);
     gen_spr_book3s_pmu_user(env);
     gen_spr_book3s_ctrl(env);
+    gen_spr_book3s_usprg3(env);
 }
 
 static void init_proc_970(CPUPPCState *env)
-- 
2.12.1.382.gc0f9c7058
