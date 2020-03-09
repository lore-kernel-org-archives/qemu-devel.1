Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC81C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5D22146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GcMKgC+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSLM-0000aR-Sp
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSEA-0008JR-O5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSE9-0008HU-FT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33468)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSE9-0008H9-7j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NrN7A077661;
 Mon, 9 Mar 2020 23:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=AI8fsWz4vAA3zeztXvmKiyZ4peItDxs1dxwAZoFxQw4=;
 b=GcMKgC+Znjp+BD2kFwa1N4o8eFQFNKYfCy2SkBe3vecWWeNuRJXP9cUBN+2dYp57AtvO
 xCgvmwexJnZ9ksXNWRNN+hDGkC7QoOZ1LYPLvVp03vaPPvlHS3q3PMofRNJ7qCNwzfCk
 nUcLjtrB1UhSOQUKQsDGlSDnFmJaLtoafCgrgrPm8Xn8QTPzLZaweyfYKOIHRu9Jn7Pd
 kiqa4DwROzxEMn8+A4BOp2OKXr0GbL0FIoAi6dUEWIlOTyLqu1+aF+yI/2+V0q2Htlar
 kpyuUHkZprru0jIOwwIDlJmI4MPLmyQgQMVJol8YgWPHgou3nHQjdjNYEtXhTt5ath6/ vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2ym48st1b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:54:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029Nh7MS120687;
 Mon, 9 Mar 2020 23:52:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2ymn3hcg7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqQWO008473;
 Mon, 9 Mar 2020 23:52:26 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:25 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/14] hw/i386/vmport: Define enum for all commands
Date: Tue, 10 Mar 2020 01:54:03 +0200
Message-Id: <20200309235411.76587-7-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090144
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
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change.

Defining an enum for all VMPort commands have the following advantages:
* It gets rid of the error-prone requirement to update VMPORT_ENTRIES
when new VMPort commands are added to QEMU.
* It makes it clear to know by looking at one place at the source, what
are all the VMPort commands supported by QEMU.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmmouse.c    | 18 ++++++------------
 hw/i386/vmport.c     | 11 ++---------
 include/hw/i386/pc.h | 11 ++++++++++-
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e8e62bd96b8c..a61042fc0c5e 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -33,12 +33,6 @@
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
 
-/* VMMouse Commands */
-#define VMMOUSE_GETVERSION	10
-#define VMMOUSE_DATA		39
-#define VMMOUSE_STATUS		40
-#define VMMOUSE_COMMAND		41
-
 #define VMMOUSE_READ_ID			0x45414552
 #define VMMOUSE_DISABLE			0x000000f5
 #define VMMOUSE_REQUEST_RELATIVE	0x4c455252
@@ -196,10 +190,10 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
     command = data[2] & 0xFFFF;
 
     switch (command) {
-    case VMMOUSE_STATUS:
+    case VMPORT_CMD_VMMOUSE_STATUS:
         data[0] = vmmouse_get_status(s);
         break;
-    case VMMOUSE_COMMAND:
+    case VMPORT_CMD_VMMOUSE_COMMAND:
         switch (data[1]) {
         case VMMOUSE_DISABLE:
             vmmouse_disable(s);
@@ -218,7 +212,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
             break;
         }
         break;
-    case VMMOUSE_DATA:
+    case VMPORT_CMD_VMMOUSE_DATA:
         vmmouse_data(s, data, data[1]);
         break;
     default:
@@ -275,9 +269,9 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    vmport_register(VMMOUSE_STATUS, vmmouse_ioport_read, s);
-    vmport_register(VMMOUSE_COMMAND, vmmouse_ioport_read, s);
-    vmport_register(VMMOUSE_DATA, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_STATUS, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_COMMAND, vmmouse_ioport_read, s);
+    vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_ioport_read, s);
 }
 
 static Property vmmouse_properties[] = {
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index c03f57f2f636..2ae5afc42b50 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -30,10 +30,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#define VMPORT_CMD_GETVERSION 0x0a
-#define VMPORT_CMD_GETRAMSIZE 0x14
-
-#define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
 typedef enum {
@@ -60,12 +56,9 @@ typedef struct VMPortState {
 
 static VMPortState *port_state;
 
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque)
+void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque)
 {
-    if (command >= VMPORT_ENTRIES) {
-        return;
-    }
-
+    assert(command < VMPORT_ENTRIES);
     trace_vmport_register(command, func, opaque);
     port_state->func[command] = func;
     port_state->opaque[command] = opaque;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5ac76d54e1f..7f15a01137b1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -138,12 +138,21 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
+typedef enum {
+    VMPORT_CMD_GETVERSION       = 10,
+    VMPORT_CMD_GETRAMSIZE       = 20,
+    VMPORT_CMD_VMMOUSE_DATA     = 39,
+    VMPORT_CMD_VMMOUSE_STATUS   = 40,
+    VMPORT_CMD_VMMOUSE_COMMAND  = 41,
+    VMPORT_ENTRIES
+} VMPortCommand;
+
 static inline void vmport_init(ISABus *bus)
 {
     isa_create_simple(bus, TYPE_VMPORT);
 }
 
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
+void vmport_register(VMPortCommand command, VMPortReadFunc *func, void *opaque);
 void vmmouse_get_data(uint32_t *data);
 void vmmouse_set_data(const uint32_t *data);
 
-- 
2.20.1


