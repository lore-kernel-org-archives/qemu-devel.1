Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C2C18E5A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF5C21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WgSywl+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5C21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiCc-000750-U6
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6f-0006eP-AX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6d-0006XP-Tl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6d-0006JB-Lf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGdGwG103809;
 Tue, 10 Mar 2020 16:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1BopZX2Bq3c5/duOSeJ+6j4/oECwiVetkO/A6IsO6gE=;
 b=WgSywl+ta94/2kzVOIlc+9uqX05xEme/Rh1LcfYXVYvNyKzpWFZwv009MqDdtR3gCwva
 GQUtGoY9R7vp9biJnWjEsnYHs8mLj/Q+svO0YVvCBcnZPmOQ2z0ygfum71KSXu49NQIQ
 ziEmX/xykUwRClGbbmtGRjYT9B1RYJSNdg25pZRiYV81hwRkR4ckuc3WHw78FF8scUf4
 +wR6X0vXc4WphDKzc219OLJrszP1vFSgnJjTqcilBapRuzfXcpHp0tALKJSUvDjm1HMg
 s8mdfPajrMFYEqZ+GykFP33A9CTYe/hpptzXxYux3gyi8+YO5jlCbsS56bb/ZaGZHMjJ Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yp7hm35qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbDMe101876;
 Tue, 10 Mar 2020 16:51:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yp8qp6evk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:43 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AGpgSg011587;
 Tue, 10 Mar 2020 16:51:42 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:41 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/16] hw/i386/vmport: Introduce vmport.h
Date: Tue, 10 Mar 2020 18:53:23 +0200
Message-Id: <20200310165332.140774-8-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 nikita.leshchenko@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change. This is mere refactoring.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/pc.c             |  1 +
 hw/i386/vmmouse.c        |  1 +
 hw/i386/vmport.c         |  1 +
 include/hw/i386/pc.h     | 13 -------------
 include/hw/i386/vmport.h | 16 ++++++++++++++++
 5 files changed, 19 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/i386/vmport.h

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6ab4acb0c62e..6ac71e1af32b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,6 +31,7 @@
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
+#include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
 #include "hw/block/fdc.h"
 #include "hw/ide.h"
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e8e62bd96b8c..49a546fd3bb6 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "ui/console.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 973f3f6448e9..7723d37a0657 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
 #include "hw/i386/pc.h"
+#include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/hw_accel.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5ac76d54e1f..60c988c4a5aa 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -134,19 +134,6 @@ typedef struct PCMachineClass {
 
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 
-/* vmport.c */
-#define TYPE_VMPORT "vmport"
-typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-
-static inline void vmport_init(ISABus *bus)
-{
-    isa_create_simple(bus, TYPE_VMPORT);
-}
-
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
-void vmmouse_get_data(uint32_t *data);
-void vmmouse_set_data(const uint32_t *data);
-
 /* pc.c */
 extern int fd_bootchk;
 
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
new file mode 100644
index 000000000000..f0c1e985ca08
--- /dev/null
+++ b/include/hw/i386/vmport.h
@@ -0,0 +1,16 @@
+#ifndef HW_VMPORT_H
+#define HW_VMPORT_H
+
+#define TYPE_VMPORT "vmport"
+typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
+
+static inline void vmport_init(ISABus *bus)
+{
+    isa_create_simple(bus, TYPE_VMPORT);
+}
+
+void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
+void vmmouse_get_data(uint32_t *data);
+void vmmouse_set_data(const uint32_t *data);
+
+#endif
-- 
2.20.1


