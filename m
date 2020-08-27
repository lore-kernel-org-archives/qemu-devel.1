Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6357C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:19:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783082177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MwBxXsE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783082177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBMVB-0000ex-Hm
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 14:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOi-00014J-FW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kBMOg-0007Dr-5T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 14:13:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI54Jv096560;
 Thu, 27 Aug 2020 18:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=THfOZ04d/paWD1Q/f3YSUVGWzg8L0nQEaHOMTmy8jlc=;
 b=MwBxXsE9F4jB9vBEzSsnRCHu0eh6NOnoKsoYlkO2i3/FQd7vnDd14wn2iqvhlW+E0mWB
 kiTlil4DOBGgbxwvrmm4ER6UmdW157gCFCFbIzsLaxSCeqgSYiu363Mkzwnqc56I9tS5
 HN5lelVZbCFrxlam65m/OnkdpSNNJXwTJpQHjcFJ+pIlwIx0Zn8+vbjHtHsTvJ9j/EVd
 JiLu4B0GAPmSaKDJ1Mxd41hMBEOm8ArwzIjGNrbQp+ztYhP4Bp4LQiwNCEObrWmyj2h/
 0jdc0VDUJIH7Wjzvew/BIEudLkalTZYXtINgrZJVZ24ht6cZ4VzbjkF/0n44KwhV2hJR Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 336ht3g186-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Aug 2020 18:13:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07RI4iFA074845;
 Thu, 27 Aug 2020 18:13:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 333ru1sy84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Aug 2020 18:13:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07RID5me021209;
 Thu, 27 Aug 2020 18:13:05 GMT
Received: from flaka.hsd1.ca.comcast.net (/10.159.136.159)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 27 Aug 2020 11:13:03 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v9 10/20] multi-process: setup memory manager for remote device
Date: Thu, 27 Aug 2020 11:12:21 -0700
Message-Id: <20200827181231.22778-11-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=4 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270136
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 13:54:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
 stefanha@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

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
 hw/i386/meson.build             |  1 +
 hw/i386/remote-memory.c         | 58 +++++++++++++++++++++++++++++++++
 include/hw/i386/remote-memory.h | 19 +++++++++++
 include/io/mpqemu-link.h        | 13 ++++++++
 io/mpqemu-link.c                | 11 +++++++
 6 files changed, 104 insertions(+)
 create mode 100644 hw/i386/remote-memory.c
 create mode 100644 include/hw/i386/remote-memory.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ac8eefaa3f..14b8c005fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3050,6 +3050,8 @@ F: include/io/mpqemu-link.h
 F: hw/i386/remote-msg.c
 F: include/hw/i386/remote-obj.h
 F: hw/i386/remote-obj.c
+F: include/hw/i386/remote-memory.h
+F: hw/i386/remote-memory.c
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 7b35f35d86..36e151c80a 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -26,6 +26,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-msg.c'))
 i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-obj.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote-memory.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote-memory.c b/hw/i386/remote-memory.c
new file mode 100644
index 0000000000..27bc8a7674
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
index 0000000000..aab3e4d85d
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
index e02b5ce663..b348c658d1 100644
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
     INIT = 0,
+    SYNC_SYSMEM,
+    RET_MSG,
     MAX = INT_MAX,
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
index 1dd776f81b..0d1eaaca7f 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -277,5 +277,16 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
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
2.25.GIT


