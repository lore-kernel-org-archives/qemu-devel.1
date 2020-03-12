Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A986F206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kpjx/6ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A986F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRNR-0004t8-M6
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4l-0002rZ-Ji
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4g-0000Or-Jy
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4g-0000Mw-AL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmthB012070;
 Thu, 12 Mar 2020 16:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=2kx96PJyCWaObAe/S9ZZZsHhJgQc5nCYZyC7qimTRZs=;
 b=Kpjx/6ZSnNWtFJm3yKrtdxAgRAUUhGUDCbkN31GuIo4eMWMD5qMCf3ReH9pKqa1BQhK6
 6+bkw9JSOApRkyVtc8fa6CGDxcqEXBiiqqLB1gLC9tebIcw29ClVAQ/Zwl7y3/uv9YJQ
 60sHbhWhI0HlXgMI/z9ksoFLF08xq+8/mmaVv4pZBe7V6KH2vNGXx53gTJWNxbb6wGSB
 tyVLxDGvM6dYLVXqfOWgzgceyaGZyb0MKxRv3oCY36ElMR+HGX82cRimq6xeuTFlqPoI
 /Et8LC4JndKuTiBcZAw2DTaLDLVIKcMCr/fL7kuN0P+6ELh5V5UbrszB09fPzncgBzEL hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2ym31utt3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoIUB122283;
 Thu, 12 Mar 2020 16:52:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2yp8r0snpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:44 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CGqhbh030522;
 Thu, 12 Mar 2020 16:52:43 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:42 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/16] hw/i386/vmport: Define enum for all commands
Date: Thu, 12 Mar 2020 18:54:23 +0200
Message-Id: <20200312165431.82118-9-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=1 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
index e9ea5fe7f765..6ab094311d6c 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -38,10 +38,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#define VMPORT_CMD_GETVERSION 0x0a
-#define VMPORT_CMD_GETRAMSIZE 0x14
-
-#define VMPORT_ENTRIES 0x2c
 #define VMPORT_MAGIC   0x564D5868
 
 /* Compatibility flags for migration */
@@ -72,12 +68,9 @@ typedef struct VMPortState {
 
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


