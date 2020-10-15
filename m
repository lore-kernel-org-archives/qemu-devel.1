Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DD9C43457
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8B620760
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jABJneFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8B620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7p9-0003vw-3h
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dO-0008MV-VT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dM-0002M7-Ks
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:05:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4cG3037698;
 Thu, 15 Oct 2020 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=p3N/SMgrGHdT+SdeS9IRpBFzlVCTnSyUz7phq4hDfkc=;
 b=jABJneFfQZ2ZhPLWyefnq0YpBGOehjdCKofONv+PdE0GYH34QsB+kEXw3XoArk77yAll
 OJYcYWMRG7J+Lg5Xqxj/jNhjkJYtIatSJDcrndEQh7BzQmPqm1u3h8gbYNzLEluXxVa0
 w5dXPiYSK3ryulW5DBvsMkjre28xnrhVsxAYinZRYdbqSojO2hcQqfXIUaVZKp9kWcqF
 7FIHqYPXJgQijODHJl3BifbtDgd7TnwJ9qp56ta3OEmoj7k7WYHObhM75kyF+p60iY53
 3bJq64gLx5wDWITSbC80k3SkhBsVaW4o8N8WLo4CD9U9CS+I7zIqU3ErWQ8gdEcHeCOY 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 3434wkx74r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5dAo040175;
 Thu, 15 Oct 2020 18:05:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 344by5hhsg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FI5Y6D026224;
 Thu, 15 Oct 2020 18:05:34 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:34 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 09/19] multi-process: setup memory manager for remote
 device
Date: Thu, 15 Oct 2020 14:05:02 -0400
Message-Id: <42bd5e3ab96fa1d0a07eaf485ccf0773519be73f.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=4 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=4 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.78; envelope-from=jag.raman@oracle.com;
 helo=aserp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:05:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                     |  2 ++
 hw/i386/meson.build             |  1 +
 hw/i386/remote-memory.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote-memory.h | 19 ++++++++++++++
 include/io/mpqemu-link.h        | 13 +++++++++
 io/mpqemu-link.c                | 11 ++++++++
 6 files changed, 104 insertions(+)
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 include/hw/i386/remote-memory.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 487ab13..4aa00ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3109,6 +3109,8 @@ F: include/io/mpqemu-link.h
 F: hw/i386/remote-msg.c
 F: include/hw/i386/remote-obj.h
 F: hw/i386/remote-obj.c
+F: include/hw/i386/remote-memory.h
+F: hw/i386/remote-memory.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 9735f6b..b698b36 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -27,6 +27,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-msg.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-obj.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-memory.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote-memory.c b/hw/i386/remote-memory.c
new file mode 100644
index 0000000..27bc8a7
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
+    SyncSysmemMsg *sysmem_info = &msg->data.sync_sysmem;
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
index 3505e06..e33181a 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -14,6 +14,7 @@
 #include "qom/object.h"
 #include "qemu/thread.h"
 #include "io/channel.h"
+#include "exec/hwaddr.h"
 
 #define REMOTE_MAX_FDS 8
 
@@ -24,12 +25,22 @@
  *
  * MPQemuCmd enum type to specify the command to be executed on the remote
  * device.
+ *
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  */
 typedef enum {
     MPQEMU_CMD_INIT,
+    SYNC_SYSMEM,
+    RET_MSG,
     MPQEMU_CMD_MAX,
 } MPQemuCmd;
 
+typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    off_t offsets[REMOTE_MAX_FDS];
+} SyncSysmemMsg;
+
 /**
  * MPQemuMsg:
  * @cmd: The remote command
@@ -40,12 +51,14 @@ typedef enum {
  * MPQemuMsg Format of the message sent to the remote device from QEMU.
  *
  */
+
 typedef struct {
     int cmd;
     size_t size;
 
     union {
         uint64_t u64;
+        SyncSysmemMsg sync_sysmem;
     } data;
 
     int fds[REMOTE_MAX_FDS];
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index d646aad..b30e27c 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -233,5 +233,16 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
         }
     }
 
+     /* Verify message specific fields. */
+    switch (msg->cmd) {
+    case SYNC_SYSMEM:
+        if (msg->num_fds == 0 || msg->size != sizeof(SyncSysmemMsg)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+
     return true;
 }
-- 
1.8.3.1


