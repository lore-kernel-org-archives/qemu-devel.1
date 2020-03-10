Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B4AC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2326221D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FwGKI6E7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2326221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBiCc-000748-E1
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6h-0006kf-Ql
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBi6g-0006nz-LZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBi6g-0006iV-D1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:51:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGcZLA010742;
 Tue, 10 Mar 2020 16:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=fbv9ovVqUbpKVUHDgKy1vLVDoNHDgmR6Pzcslc7ttFw=;
 b=FwGKI6E7GhGrd8H3DOO0OL1Kneh7JcmLdqAnKB3/6FSmqhecNw6x6lXj4F7175ne9Vcc
 nJKgaCZGet851jDbvKwFvl6Su2GQc9EiRCbHAdC3t3Qsq3Lkm+XRBK3WutPdev6RdVJ9
 //FFzAReXc7RjCAVXDre0yIeGPHeM8RBvCm7pWlj/T8rDBno7rCJBAabw8Mz01DNpvOM
 41CE1eiOGXYlHp1jsmJYZczUPekgDT/kWKlt5CacI54cjCtuJWfGNhjPb9bpu8pksZQi
 AYLA8fDAOboFL6+f9QSxwglS1EM5GSgo9flNlFxiXaDU8VPhuzOlUCQ5RsmEc6gjhzem EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2yp9v61vdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AGbbhP030468;
 Tue, 10 Mar 2020 16:51:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2yp8rjyhb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 16:51:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02AGpkeh030856;
 Tue, 10 Mar 2020 16:51:46 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 09:51:46 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/16] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Date: Tue, 10 Mar 2020 18:53:25 +0200
Message-Id: <20200310165332.140774-10-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200310165332.140774-1-liran.alon@oracle.com>
References: <20200310165332.140774-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100103
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

This is VMware documented functionallity that some guests rely on.
Returns the BIOS UUID of the current virtual machine.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c         | 17 +++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 0ea5e5f4dd14..ef94f4fe78c6 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -27,6 +27,7 @@
 #include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -136,6 +137,18 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     return port_state->vmx_version;
 }
 
+static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    uint32_t *uuid_parts = (uint32_t *)(qemu_uuid.data);
+
+    cpu->env.regs[R_EAX] = le32_to_cpu(uuid_parts[0]);
+    cpu->env.regs[R_EBX] = le32_to_cpu(uuid_parts[1]);
+    cpu->env.regs[R_ECX] = le32_to_cpu(uuid_parts[2]);
+    cpu->env.regs[R_EDX] = le32_to_cpu(uuid_parts[3]);
+    return cpu->env.regs[R_EAX];
+}
+
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
@@ -184,9 +197,13 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &s->io, 0x5658);
 
     port_state = s;
+
     /* Register some generic port commands */
     vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
+    if (s->version > 1) {
+        vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
+    }
 }
 
 static Property vmport_properties[] = {
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
index 0501ccac6ddf..7f33512ca6f0 100644
--- a/include/hw/i386/vmport.h
+++ b/include/hw/i386/vmport.h
@@ -6,6 +6,7 @@ typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
 typedef enum {
     VMPORT_CMD_GETVERSION       = 10,
+    VMPORT_CMD_GETBIOSUUID      = 19,
     VMPORT_CMD_GETRAMSIZE       = 20,
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
-- 
2.20.1


