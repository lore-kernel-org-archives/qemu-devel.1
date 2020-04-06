Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAC7206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PXpnq2ee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAC7206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOMC-0003ID-Su
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGc-0001fe-JB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGa-0002Ar-Ux
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGa-0002AM-Mj
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369dppg089410;
 Mon, 6 Apr 2020 09:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LvBkFU1eOYEKjiZWPiX4Hx8WWcTA1vJJzDeFSp2zBG4=;
 b=PXpnq2eebIt1BRbLTNUHB89PwdPJG00/NosrHaDs8djiSopmZ7IR+yapL1mDdM4lSsRO
 /S2RE7Tt79ROj0LjjHmBPzoR5Las7icWH83isL/uhIODkXyYeQ8AZazrjoZMsu7nzfZG
 G4jkKTsaQ8PFc9Ql5CLSADkAZ98UW1xz4szcBnmOECe1dBkgSg6ggSVFBwZ72QYFLg+j
 HK/rdWwHgZybE8us/OgHZj2QsvsyK7mw+MYIIdArFWWR8NRtug/7yXdjSxzFNqLfhXxR
 D27008l9pzKX7doEmp/RlWVCElqw/75MsoLNN3S9aZAQHQJbsZlltuwq5eKOl5jaWV4v sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 306hnqwtwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369fN4b066099;
 Mon, 6 Apr 2020 09:41:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 307419xgr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:58 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369fv3G030654;
 Mon, 6 Apr 2020 09:41:57 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:57 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 15/36] multi-process: setup memory manager for remote device
Date: Mon,  6 Apr 2020 02:41:05 -0700
Message-Id: <7b1614ac098dd88b32dd06a2d7e17f7d1b85492c.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=4
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
 0369dppg089410
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

sync_sysmem_msg_t message format is defined. It is used to send
file descriptors of the RAM regions to remote device.
RAM on the remote device is configured with a set of file descriptors.
Old RAM regions are deleted and new regions, each with an fd, is
added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS              |  2 ++
 Makefile.target          |  2 ++
 exec.c                   | 17 +++++++++++
 include/exec/ram_addr.h  |  2 ++
 include/io/mpqemu-link.h | 12 ++++++++
 include/remote/memory.h  | 20 +++++++++++++
 io/mpqemu-link.c         | 13 +++++++++
 remote/memory.c          | 63 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 131 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 970cdfc2ef..7b46ec2e71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2823,6 +2823,8 @@ F: include/remote/pcihost.h
 F: remote/pcihost.c
 F: include/remote/machine.h
 F: remote/machine.c
+F: include/remote/memory.h
+F: remote/memory.c
=20
 Build and test automation
 -------------------------
diff --git a/Makefile.target b/Makefile.target
index 70fa1eeca5..500fa07fda 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -143,6 +143,8 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/replay=
.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/xen-mapcache.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/audio.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
+
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D remote/memory.o
 endif
=20
 #########################################################
diff --git a/exec.c b/exec.c
index 3bdad9d058..523e77dd09 100644
--- a/exec.c
+++ b/exec.c
@@ -2359,6 +2359,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
, MemoryRegion *mr,
=20
     return block;
 }
+
+void qemu_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                           ram_addr_t offset, Error **errp)
+{
+    char *name =3D g_strdup_printf("%d", fd);
+
+    memory_region_init(mr, NULL, name, size);
+    mr->ram =3D true;
+    mr->terminates =3D true;
+    mr->destructor =3D NULL;
+    mr->align =3D 0;
+    mr->ram_block =3D qemu_ram_alloc_from_fd(size, mr, RAM_SHARED, fd, o=
ffset,
+                                           errp);
+    mr->dirty_log_mask =3D tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+
+    g_free(name);
+}
 #endif
=20
 static
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 1b9f489ff0..d9d7314f51 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -122,6 +122,8 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, M=
emoryRegion *mr,
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
                                  off_t offset, Error **errp);
+void qemu_ram_init_from_fd(MemoryRegion *mr, int fd, uint64_t size,
+                           ram_addr_t offset, Error **errp);
=20
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
                                   MemoryRegion *mr, Error **errp);
diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
index ef95599bca..d46cb81058 100644
--- a/include/io/mpqemu-link.h
+++ b/include/io/mpqemu-link.h
@@ -16,6 +16,8 @@
=20
 #include "qom/object.h"
 #include "qemu/thread.h"
+#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
=20
 #define TYPE_MPQEMU_LINK "mpqemu-link"
 #define MPQEMU_LINK(obj) \
@@ -27,15 +29,23 @@
=20
 /**
  * mpqemu_cmd_t:
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  *
  * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
  * device.
  */
 typedef enum {
     INIT =3D 0,
+    SYNC_SYSMEM,
     MAX,
 } mpqemu_cmd_t;
=20
+typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    ram_addr_t offsets[REMOTE_MAX_FDS];
+} sync_sysmem_msg_t;
+
 /**
  * MPQemuMsg:
  * @cmd: The remote command
@@ -49,6 +59,7 @@ typedef enum {
  * MPQemuMsg Format of the message sent to the remote device from QEMU.
  *
  */
+
 typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
@@ -56,6 +67,7 @@ typedef struct {
=20
     union {
         uint64_t u64;
+        sync_sysmem_msg_t sync_sysmem;
     } data1;
=20
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000000..e2e479bb6f
--- /dev/null
+++ b/include/remote/memory.h
@@ -0,0 +1,20 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MEMORY_H
+#define REMOTE_MEMORY_H
+
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "io/mpqemu-link.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp);
+
+#endif
diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
index fa9b3a66b1..330a6deffe 100644
--- a/io/mpqemu-link.c
+++ b/io/mpqemu-link.c
@@ -348,6 +348,19 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
             }
         }
     }
+     /* Verify message specific fields. */
+    switch (msg->cmd) {
+    case SYNC_SYSMEM:
+        if (msg->num_fds =3D=3D 0 || msg->bytestream !=3D 0) {
+            return false;
+        }
+        if (msg->size !=3D sizeof(msg->data1)) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
=20
     return true;
 }
diff --git a/remote/memory.c b/remote/memory.c
new file mode 100644
index 0000000000..2c8b7bb42f
--- /dev/null
+++ b/remote/memory.c
@@ -0,0 +1,63 @@
+/*
+ * Memory manager for remote device
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <stdint.h>
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qemu/queue.h"
+#include "qemu-common.h"
+#include "remote/memory.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "io/mpqemu-link.h"
+#include "qemu/main-loop.h"
+#include "qapi/error.h"
+
+void remote_sysmem_reconfig(MPQemuMsg *msg, Error **errp)
+{
+    sync_sysmem_msg_t *sysmem_info =3D &msg->data1.sync_sysmem;
+    MemoryRegion *sysmem, *subregion, *next;
+    Error *local_err =3D NULL;
+    int region;
+
+    sysmem =3D get_system_memory();
+
+    qemu_mutex_lock_iothread();
+
+    memory_region_transaction_begin();
+
+    QTAILQ_FOREACH_SAFE(subregion, &sysmem->subregions, subregions_link,=
 next) {
+        if (subregion->ram) {
+            memory_region_del_subregion(sysmem, subregion);
+            qemu_ram_free(subregion->ram_block);
+        }
+    }
+
+    for (region =3D 0; region < msg->num_fds; region++) {
+        subregion =3D g_new(MemoryRegion, 1);
+        qemu_ram_init_from_fd(subregion, msg->fds[region],
+                              sysmem_info->sizes[region],
+                              sysmem_info->offsets[region], &local_err);
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
+
+    qemu_mutex_unlock_iothread();
+}
--=20
2.25.GIT


