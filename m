Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A450DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7902A208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XJmTS+S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7902A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1ZuY-0006jS-R8
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgY-0004dL-De
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZgV-0005cg-J8
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:23:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIN20f119493;
 Fri, 31 Jul 2020 18:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=iTrAPmYTdGk8QMAOQLSemHOl6ugjtva2hUJyXQQ6dJI=;
 b=XJmTS+S/nfPP+EmdXoJGAwB8ApTiNNHuZqBs+dn9SIz+k9zjnRdV75AnJU7+97Y6NcXX
 HokSBiYyiM7HsYTiHXXG3jKcFPrN9ZArbJW36ZWNUNiQoVPG7r8K3ZME8bdzfaBlJub+
 fIBU2ucPwYjZY7mi2cyqEVAGg6wTEoB1Pj70Jk5cJSaO9bViFHN7a5u6O/wQQ3ia8U5A
 tb2ZBwr5BjOoe99k7TD6Xry/Lg0Qldnam/jdLlBFnxlDEAMx/Oh6+XlD5fwnC12Y+ddJ
 s2UqNvyFeYJ3Vx1R4sGLtJlupPiKVnUU3ede1bjcyPOJeoxMAJYn2jZB+8QUGyyb8wxX BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jtgau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:23:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIItib086263;
 Fri, 31 Jul 2020 18:20:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 32hu608m17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:53 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06VIKpNd020186;
 Fri, 31 Jul 2020 18:20:51 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:51 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/20] multi-process: setup memory manager for remote device
Date: Fri, 31 Jul 2020 14:20:17 -0400
Message-Id: <2bebe51b049f2f6583c5227fc12a60c63229a2f6.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
Received-SPF: pass client-ip=156.151.31.86; envelope-from=jag.raman@oracle.com;
 helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:51:59
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SyncSysMemMsg message format is defined. It is used to send
file descriptors of the RAM regions to remote device.
RAM on the remote device is configured with a set of file descriptors.
Old RAM regions are deleted and new regions, each with an fd, is
added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS                     |  2 ++
 hw/i386/Makefile.objs           |  1 +
 hw/i386/remote-memory.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote-memory.h | 19 ++++++++++++++
 include/io/mpqemu-link.h        | 13 +++++++++
 io/mpqemu-link.c                | 13 +++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 include/hw/i386/remote-memory.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fd278f..2da7680 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3049,6 +3049,8 @@ F: include/io/mpqemu-link.h
 F: hw/i386/remote-msg.c
 F: include/hw/i386/remote-obj.h
 F: hw/i386/remote-obj.c
+F: include/hw/i386/remote-memory.h
+F: hw/i386/remote-memory.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 30d7102..4ba47e0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_PC) += port92.o
 obj-$(CONFIG_MPQEMU) += remote.o
 obj-$(CONFIG_MPQEMU) += remote-msg.o
 obj-$(CONFIG_MPQEMU) += remote-obj.o
+obj-$(CONFIG_MPQEMU) += remote-memory.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_ACPI) += acpi-common.o
diff --git a/hw/i386/remote-memory.c b/hw/i386/remote-memory.c
new file mode 100644
index 0000000..759b8e9
--- /dev/null
+++ b/hw/i386/remote-memory.c
@@ -0,0 +1,58 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include "hw/i386/remote-memory.h"
+#include "exec/address-spaces.h"
+#include "exec/ram_addr.h"
+#include "qapi/error.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
+{
+    SyncSysmemMsg *sysmem_info = &msg->data1.sync_sysmem;
+    MemoryRegion *sysmem, *subregion, *next;
+    static unsigned int suffix;
+    Error *local_err = NULL;
+    char *name;
+    int region;
+
+    sysmem = get_system_memory();
+
+    memory_region_transaction_begin();
+
+    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link, next) {
+        if (subregion->ram) {
+            memory_region_del_subregion(sysmem, subregion);
+            object_unparent(OBJECT(subregion));
+        }
+    }
+
+    for (region = 0; region < msg->num_fds; region++) {
+        subregion = g_new(MemoryRegion, 1);
+        name = g_strdup_printf("remote-mem-%u", suffix++);
+        memory_region_init_ram_from_fd(subregion, NULL,
+                                       name, sysmem_info->sizes[region],
+                                       RAM_SHARED, msg->fds[region],
+                                       sysmem_info->offsets[region],
+                                       &local_err);
+        g_free(name);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            break;
+        }
+
+        memory_region_add_subregion(sysmem, sysmem_info->gpas[region],
+                                    subregion);
+    }
+
+    memory_region_transaction_commit();
+}
diff --git a/include/hw/i386/remote-memory.h b/include/hw/i386/remote-memory.h
new file mode 100644
index 0000000..aab3e4d
--- /dev/null
+++ b/include/hw/i386/remote-memory.h
@@ -0,0 +1,19 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MEMORY_H
+#define REMOTE_MEMORY_H
+
+#include "exec/hwaddr.h"
+#include "io/mpqemu-link.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp);
+
+#endif
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index 8591ad2..98383f9 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -15,6 +15,8 @@
 #include "qemu/thread.h"
 #include "io/channel.h"
 #include "io/channel-socket.h"
+#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -25,13 +27,22 @@
  *
  * MPQemuCmd enum type to specify the command to be executed on the remote
  * device.
+ *
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  */
 typedef enum {
     INIT = 0,
+    SYNC_SYSMEM,
     RET_MSG,
     MAX = INT_MAX,
 } MPQemuCmd;
 
+typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    off_t offsets[REMOTE_MAX_FDS];
+} SyncSysmemMsg;
+
 /**
  * Maximum size of data2 field in the message to be transmitted.
  */
@@ -50,6 +61,7 @@ typedef enum {
  * MPQemuMsg Format of the message sent to the remote device from QEMU.
  *
  */
+
 typedef struct {
     int cmd;
     int bytestream;
@@ -57,6 +69,7 @@ typedef struct {
 
     union {
         uint64_t u64;
+        SyncSysmemMsg sync_sysmem;
     } data1;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index d4dd0fe..aad1d77 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -245,6 +245,19 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             }
         }
     }
+     /* Verify message specific fields. */
+    switch (msg->cmd) {
+    case SYNC_SYSMEM:
+        if (msg->num_fds == 0 || msg->bytestream) {
+            return false;
+        }
+        if (msg->size != sizeof(msg->data1)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
 
     return true;
 }
-- 
1.8.3.1


