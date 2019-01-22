Received: from eggs.gnu.org ([209.51.188.92]:40528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm0zY-00083J-Hu
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm0zX-0001l1-5B
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gm0zV-0001Pg-2g
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:41:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MGwrLe104216
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:24 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q66uw8xmv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:24 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 22 Jan 2019 17:01:22 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Tue, 22 Jan 2019 15:01:11 -0200
In-Reply-To: <20190122170112.8706-1-farosas@linux.ibm.com>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
Message-Id: <20190122170112.8706-3-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 2/3] target/ppc: Add GDB callbacks for SPRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org

These will be used to let GDB know about PPC's Special Purpose
Registers (SPR).

They take an index based on the order the registers appear in the XML
file sent by QEMU to GDB. This index does not match the actual
location of the registers in the env->spr array so the
gdb_find_spr_idx function does that conversion.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/translate_init.inc.c | 54 ++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 710064a25d..f29ac3558a 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9487,6 +9487,55 @@ static bool avr_need_swap(CPUPPCState *env)
 #endif
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static int gdb_find_spr_idx(CPUPPCState *env, int n)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (spr->name && spr->gdb_id == n) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+{
+    int reg;
+    int len;
+
+    reg = gdb_find_spr_idx(env, n);
+    if (reg < 0) {
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
+    if (reg < 0) {
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
@@ -9716,7 +9765,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
-
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
+                             pcc->gdb_num_sprs, "power-spr.xml", 0);
+#endif
     qemu_init_vcpu(cs);
 
     pcc->parent_realize(dev, errp);
-- 
2.17.1
