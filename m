Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B185FC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0B8206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0ehHath"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0B8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRIS-0001BL-ML
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4n-0002xS-82
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4l-0000X5-Sj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4l-0000Sx-J4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:52:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoeVs031202;
 Thu, 12 Mar 2020 16:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+JTlZG+9tNcR3M/UN4AXmTBqEL1Cr5/xtwgnES374Ck=;
 b=r0ehHathcYEWwNUo3ILozQuJaGxvdrLYxXQ4lO/oplpBKguIJSmPuw8GjaqXglV99o21
 2AGKMSe7zENyqfSYvLQKh26DfljPoi1qKZBZzWuftipZC9M45YwvxWR0QtJRm3mPLJj0
 cDUQjxNFc0rRcVTrQwVVjVWHSxrvs73Wsj1DZjHlrQ0Rx/Db61S8UX/byw6uFRQBq7qO
 /l9FKoeCK4nwPkzIrH0ZJ8+kWe3cCmHpgH0FSvC2fDEXiWrB6+S5MhDgI57SObRxrGFM
 x/ZcIMpQNzo0QXtYUOhe/eNg1Z7nYxlpX4mj7Z7dUkEkOk8RQtv1r7v6XUCQB1LWVK9w vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yqkg8a03h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoVh9123467;
 Thu, 12 Mar 2020 16:52:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2yp8r0snrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02CGqkgo009593;
 Thu, 12 Mar 2020 16:52:46 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:45 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/16] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Date: Thu, 12 Mar 2020 18:54:24 +0200
Message-Id: <20200312165431.82118-10-liran.alon@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
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

This is VMware documented functionallity that some guests rely on.
Returns the BIOS UUID of the current virtual machine.

Note that we also introduce a new compatability flag "x-cmds-v2" to
make sure to expose new VMPort commands only to new machine-types.
This flag will also be used by the following patches that will introduce
additional VMPort commands.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/core/machine.c        |  1 +
 hw/i386/vmport.c         | 22 ++++++++++++++++++++++
 include/hw/i386/vmport.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0e2f37420360..523fa56991dc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -42,6 +42,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "vmport", "x-read-set-eax", "off" },
     { "vmport", "x-signal-unsupported-cmd", "off" },
     { "vmport", "x-report-vmx-type", "off" },
+    { "vmport", "x-cmds-v2", "off" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 6ab094311d6c..3fb8a8bd458a 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -34,6 +34,7 @@
 #include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -44,12 +45,15 @@
 #define VMPORT_COMPAT_READ_SET_EAX_BIT              0
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT    1
 #define VMPORT_COMPAT_REPORT_VMX_TYPE_BIT           2
+#define VMPORT_COMPAT_CMDS_V2_BIT                   3
 #define VMPORT_COMPAT_READ_SET_EAX              \
     (1 << VMPORT_COMPAT_READ_SET_EAX_BIT)
 #define VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD    \
     (1 << VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT)
 #define VMPORT_COMPAT_REPORT_VMX_TYPE           \
     (1 << VMPORT_COMPAT_REPORT_VMX_TYPE_BIT)
+#define VMPORT_COMPAT_CMDS_V2                   \
+    (1 << VMPORT_COMPAT_CMDS_V2_BIT)
 
 #define VMPORT(obj) OBJECT_CHECK(VMPortState, (obj), TYPE_VMPORT)
 
@@ -144,6 +148,18 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     return port_state->vmware_vmx_version;
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
@@ -192,9 +208,13 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &s->io, 0x5658);
 
     port_state = s;
+
     /* Register some generic port commands */
     vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
+    if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
+        vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
+    }
 }
 
 static Property vmport_properties[] = {
@@ -205,6 +225,8 @@ static Property vmport_properties[] = {
                     VMPORT_COMPAT_SIGNAL_UNSUPPORTED_CMD_BIT, true),
     DEFINE_PROP_BIT("x-report-vmx-type", VMPortState, compat_flags,
                     VMPORT_COMPAT_REPORT_VMX_TYPE_BIT, true),
+    DEFINE_PROP_BIT("x-cmds-v2", VMPortState, compat_flags,
+                    VMPORT_COMPAT_CMDS_V2_BIT, true),
 
     /* Default value taken from open-vm-tools code VERSION_MAGIC definition */
     DEFINE_PROP_UINT32("vmware-vmx-version", VMPortState,
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


