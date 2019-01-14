Received: from eggs.gnu.org ([209.51.188.92]:45161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gj4Ms-0007nI-J1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gj4Mr-0001Aq-MO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:41:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gj4Mr-0000or-B9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:41:37 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0EFViZ2080268
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 10:41:29 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q0ut8n4h2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 10:41:29 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Mon, 14 Jan 2019 15:41:27 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Mon, 14 Jan 2019 13:41:12 -0200
In-Reply-To: <20190114154113.6188-1-farosas@linux.ibm.com>
References: <20190114154113.6188-1-farosas@linux.ibm.com>
Message-Id: <20190114154113.6188-4-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 3/3] target/ppc: Enable reporting of SPRs to
 GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This allows reading and writing of SPRs via GDB:

(gdb) p/x $srr1
$1 = 0x8000000002803033

(gdb) p/x $pvr
$2 = 0x4b0201
(gdb) set $pvr=0x4b0000
(gdb) p/x $pvr
$3 = 0x4b0000

They can also be shown as a group:
(gdb) info reg spr

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/translate_init.inc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index bbb468f38d..ebf202e54d 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9761,7 +9761,10 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
                                  32, "power-vsx.xml", 0);
     }
-
+#ifndef CONFIG_USER_ONLY
+    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
+                             ppc_gdb_gen_spr_xml(cs), "power-spr.xml", 0);
+#endif
     qemu_init_vcpu(cs);
 
     pcc->parent_realize(dev, errp);
@@ -10524,7 +10527,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->gdb_num_core_regs = 71;
-
+#ifndef CONFIG_USER_ONLY
+    cc->gdb_get_dynamic_xml = ppc_gdb_get_dynamic_xml;
+#endif
 #ifdef USE_APPLE_GDB
     cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
     cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
-- 
2.17.1
