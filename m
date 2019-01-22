Received: from eggs.gnu.org ([209.51.188.92]:52445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm1Ad-00017h-Ep
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gm1Ac-0000ji-RW
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:53:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49302
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gm1Ac-0000jX-Jg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:53:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MGxTWB132946
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:45 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q64sjxsev-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 12:01:27 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 22 Jan 2019 17:01:26 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Tue, 22 Jan 2019 15:01:12 -0200
In-Reply-To: <20190122170112.8706-1-farosas@linux.ibm.com>
References: <20190122170112.8706-1-farosas@linux.ibm.com>
Message-Id: <20190122170112.8706-4-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 3/3] target/ppc: Enable reporting of SPRs to
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org

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
 target/ppc/translate_init.inc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index f29ac3558a..cba0303be2 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10531,7 +10531,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
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
