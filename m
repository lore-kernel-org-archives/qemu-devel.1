Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348EFC10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08C22146E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QrHvxUny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08C22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSME-0001Rz-7n
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSEG-0008TE-AS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSEF-0008Lo-BK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57036)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSEF-0008LO-3K
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:54:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqOBF028656;
 Mon, 9 Mar 2020 23:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=usXpjf9SgX44iK30z296nwFn4wbvkZ91KHKXLheMRDY=;
 b=QrHvxUnyjd2crOkxr99rV3gJAndjm34pQ2d7oPlUFMWQxpMuWCsqxs9xK/7GWdv5ZVgR
 INLUH/OkgiqIzhFX/GtdOLQByBeIx/O3nzaqEJeB8Mqb4poY0TM9YvEPmBM9uYZJdNbG
 XQYiRU/yqf4UqiNkEG4eR1YRNtX9qHehWwAGkwHxgu/et9F6Oh44eiLsv3g0/EtDo8AK
 6IgYauS6m3IUxM20V7PDBYroOIFNBMWJQEWsWubw3fAsVCGiijbpiZJ7HBdee5Is5kKY
 zG8qNnyJItcQNX2Vj8f8WGUn9qmXN6grs7fNK1faY4I/lIw8hE+QOhzV17NfqSDFfT2e 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2ym3jqj5qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:54:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NhI5U120943;
 Mon, 9 Mar 2020 23:52:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2ymn3hcggs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029NqV87010916;
 Mon, 9 Mar 2020 23:52:31 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:31 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Date: Tue, 10 Mar 2020 01:54:04 +0200
Message-Id: <20200309235411.76587-8-liran.alon@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
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
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is VMware documented functionallity that some guests rely on.
Returns the BIOS UUID of the current virtual machine.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 hw/i386/vmport.c     | 14 ++++++++++++++
 include/hw/i386/pc.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 2ae5afc42b50..7687f3368a55 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -26,6 +26,7 @@
 #include "hw/i386/pc.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -121,6 +122,18 @@ static uint32_t vmport_cmd_get_version(void *opaque, uint32_t addr)
     return port_state->vmx_version;
 }
 
+static uint32_t vmport_cmd_get_bios_uuid(void *opaque, uint32_t addr)
+{
+    X86CPU *cpu = X86_CPU(current_cpu);
+    uint32_t *uuid_parts = (uint32_t*)(qemu_uuid.data);
+
+    cpu->env.regs[R_EAX] = uuid_parts[0];
+    cpu->env.regs[R_EBX] = uuid_parts[1];
+    cpu->env.regs[R_ECX] = uuid_parts[2];
+    cpu->env.regs[R_EDX] = uuid_parts[3];
+    return cpu->env.regs[R_EAX];
+}
+
 static uint32_t vmport_cmd_ram_size(void *opaque, uint32_t addr)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
@@ -171,6 +184,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     port_state = s;
     /* Register some generic port commands */
     vmport_register(VMPORT_CMD_GETVERSION, vmport_cmd_get_version, NULL);
+    vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get_bios_uuid, NULL);
     vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size, NULL);
 }
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7f15a01137b1..ea87eb93511e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -140,6 +140,7 @@ typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
 
 typedef enum {
     VMPORT_CMD_GETVERSION       = 10,
+    VMPORT_CMD_GETBIOSUUID      = 19,
     VMPORT_CMD_GETRAMSIZE       = 20,
     VMPORT_CMD_VMMOUSE_DATA     = 39,
     VMPORT_CMD_VMMOUSE_STATUS   = 40,
-- 
2.20.1


