Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B31C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34D021D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAQ+JQE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34D021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiJA-0007wL-7k
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi8c-0002Pr-Hp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi8a-0004Vy-RW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:53:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi8Z-0004UC-DL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:53:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGqUic144690;
 Tue, 10 Mar 2020 16:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=wROV/nYpL91JIG0MUHki0fUEQr6jGrkMkk/D+jAEc4k=;
 b=LAQ+JQE5yGx1Cxi/YL8H+46xcnraxT1LD2m3lBoL6ml/7vrU/N7rJ7EHsha+NGU2rsQT
 TDdVUi/dqcZ9hnAVlUWOQ1uhhn9Bt5RLS1XqJtZmq++EoIa/iBWJWPXzC259iiE9gNeg
 /pQ8cB/fmXwgCduN7P/y6s4pSE7bBd5K8rZkeJrOP4h7EqXMxlud5VNLsHG+RoQJlOoQ
 m+SGRuMxhjj2pEDaHlQH7Jrd1v/cexmfCikq3LkIPOcVuW4ymspiyLKpfOo+rHwr0GB0
 RAPpFsJBMYf20V4XZheo90yHKpZLtDyZoTOLo5XV/nuz3At7cozfoFg7axwMhQXEatIZ wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:53:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcTPm055083;
 Tue, 10 Mar 2020 16:51:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2yp8psg4uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpil9030793;
 Tue, 10 Mar 2020 16:51:44 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:44 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/16] hw/i386/vmport: Define enum for all commands
Date: Tue, 10 Mar 2020 18:53:24 +0200
Message-Id: <20200310165332.140774-9-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

No functional change.

Defining an enum for all VMPort commands have the following advantages:
* It gets rid of the error-prone requirement to update VMPORT_ENTRIES
when new VMPort commands are added to QEMU.
* It makes it clear to know by looking at one place at the source, what
are all the VMPort commands supported by QEMU.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmmouse.c        | 18 ++++++------------
 hw/i386/vmport.c         | 11 ++---------
 include/hw/i386/vmport.h | 11 ++++++++++-
 3 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 49a546fd3bb6..afb8e9e09a30 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -34,12 +34,6 @@
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
@@ -197,10 +191,10 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
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
@@ -219,7 +213,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
             break;
         }
         break;
-    case VMMOUSE_DATA:
+    case VMPORT_CMD_VMMOUSE_DATA:
         vmmouse_data(s, data, data[1]);
         break;
     default:
@@ -276,9 +270,9 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
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
index 7723d37a0657..0ea5e5f4dd14 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -31,10 +31,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#define VMPORT_CMD_GETVERSION 0x0a
-#define VMPORT_CMD_GETRAMSIZE 0x14
-
-#define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
 /* Enum taken from open-vm-tools lib/include/vm_vmx_type.h */
@@ -64,12 +60,9 @@ typedef struct VMPortState {
 
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
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index f0c1e985ca08..0501ccac6ddf 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -4,12 +4,21 @@
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


