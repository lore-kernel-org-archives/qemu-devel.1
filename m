Received: from eggs.gnu.org ([209.51.188.92]:60053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjUXN-0008UQ-Bv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gjUXL-0000I5-6Q
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:38:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gjUXK-0000Cu-Am
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 14:38:11 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FJaGvv091526
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:38:07 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q1jqam56d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:38:06 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 15 Jan 2019 19:38:04 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Tue, 15 Jan 2019 17:37:50 -0200
In-Reply-To: <20190115193750.17234-1-farosas@linux.ibm.com>
References: <20190115193750.17234-1-farosas@linux.ibm.com>
Message-Id: <20190115193750.17234-4-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 3/3] target/ppc: Enable reporting of SPRs to
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
 target/ppc/translate_init.inc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 9c6c935204..ebf202e54d 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10527,7 +10527,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
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
