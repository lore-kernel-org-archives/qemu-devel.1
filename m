Received: from eggs.gnu.org ([208.118.235.92]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVam-0000lM-1a
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gfVai-0000dy-06
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36364
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gfVaf-0000bN-Tu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:57:11 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x04JsXts127612
	for <qemu-devel@nongnu.org>; Fri, 4 Jan 2019 14:57:09 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ptd492mrf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:57:09 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 4 Jan 2019 19:57:08 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri,  4 Jan 2019 17:56:53 -0200
In-Reply-To: <20190104195654.19976-1-farosas@linux.ibm.com>
References: <20190104195654.19976-1-farosas@linux.ibm.com>
Message-Id: <20190104195654.19976-3-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] target/ppc: Add GDB callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

These will be used to let GDB know about PPC's Special Purpose
Registers (SPR).

They take an index based on the order the registers appear in the XML
file sent by QEMU to GDB. This index does not match the actual
location of the registers in the env->spr array so the
gdb_find_spr_idx function does that conversion.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/translate_init.inc.c | 50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 03f1d34a97..f10a3637d9 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9483,6 +9483,56 @@ static bool avr_need_swap(CPUPPCState *env)
 #endif
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static int gdb_find_spr_idx(CPUPPCState *env, int n)
+{
+    int idx = -1;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (spr->name && ++idx == n) {
+            break;
+        }
+    }
+    return i;
+}
+
+static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+{
+    int reg;
+    int len;
+
+    reg = gdb_find_spr_idx(env, n);
+    if (!reg) {
+        return 0;
+    }
+
+    len = TARGET_LONG_SIZE;
+    stn_p(mem_buf, len, env->spr[reg]);
+    ppc_maybe_bswap_register(env, mem_buf, len);
+    return len;
+}
+
+static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+{
+    int reg;
+    int len;
+
+    reg = gdb_find_spr_idx(env, n);
+    if (!reg) {
+        return 0;
+    }
+
+    len = TARGET_LONG_SIZE;
+    ppc_maybe_bswap_register(env, mem_buf, len);
+    env->spr[reg] = ldn_p(mem_buf, len);
+
+    return len;
+}
+#endif
+
 static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
-- 
2.17.1
