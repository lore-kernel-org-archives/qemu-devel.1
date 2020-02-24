Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740BBC38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEC12176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F+7Y8qLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEC12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KuK-0002V2-Ak
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km6-00068d-My
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km4-00030n-Tp
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km4-0002zQ-HD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqce8017751;
 Mon, 24 Feb 2020 20:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=WBrnbGpMhzlyGR4oqAtWQqui+tPjDdZ73FRvxPG/KUA=;
 b=F+7Y8qLKJBvQPb99fnsnDXdrUdrDepjYOYc2Z4hxWbF9NWEFJmhm1PzWniyBI4oUCY2N
 /SU7EhE3ij5aGviAd7zp8+Lyx5lcUpNu1sKMvgLoqdBqBrsGzSVh+xXYR6Ese/NfeIku
 jNqp76ZRaiG7XR1Nqm64bAyh5Ef2Yx8znSNPOP4Ia34/RvziarRbFG+enJccJEqNzlc5
 J7v22lMz5VQrgeMSN7uqsTIcVQlkT/ctLrw5BhCAtlg1HC0qcE3PLk/zuZzgFAsNsHSt
 NUx9uCcgqPvds6seur39GUSYvZly8ckccPYm4wHOtMoERDkf+ZmSGpgS+06EpI2SsZna Kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yavxrhye0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqgd1090019;
 Mon, 24 Feb 2020 20:56:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2yby5dmapv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuD2c028264;
 Mon, 24 Feb 2020 20:56:13 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:13 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/50] multi-process: setup memory manager for remote device
Date: Mon, 24 Feb 2020 15:55:02 -0500
Message-Id: <5085342396f18b6f265ab24d9d7910fea5333e80.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 suspectscore=4 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=4 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 01OKqce8017751
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

sync_sysmem_msg_t message format is defined. It is used to send
file descriptors of the RAM regions to remote device.
RAM on the remote device is configured with a set of file descriptors.
Old RAM regions are deleted and new regions, each with an fd, is
added to the RAM.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Refactored remote_ram_init_from_fd into common code

 Makefile.target          |  2 ++
 exec.c                   | 17 +++++++++++++
 include/exec/ram_addr.h  |  2 ++
 include/io/mpqemu-link.h | 11 +++++++++
 include/remote/memory.h  | 20 +++++++++++++++
 remote/memory.c          | 63 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 6 files changed, 115 insertions(+)
 create mode 100644 include/remote/memory.h
 create mode 100644 remote/memory.c

diff --git a/Makefile.target b/Makefile.target
index 375fdaa..cfd36c1 100644
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
index b4c9cc6..8e77c4c 100644
--- a/exec.c
+++ b/exec.c
@@ -2410,6 +2410,23 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
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
index 1b9f489..d9d7314 100644
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
index ae04fca..78c0818 100644
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
@@ -34,6 +36,7 @@
  * mpqemu_cmd_t:
  * PCI_CONFIG_READ        PCI configuration space read
  * PCI_CONFIG_WRITE       PCI configuration space write
+ * SYNC_SYSMEM      Shares QEMU's RAM with remote device's RAM
  *
  * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
  * device.
@@ -42,6 +45,7 @@ typedef enum {
     INIT =3D 0,
     PCI_CONFIG_READ,
     PCI_CONFIG_WRITE,
+    SYNC_SYSMEM,
     MAX,
 } mpqemu_cmd_t;
=20
@@ -59,12 +63,19 @@ typedef enum {
  *
  */
 typedef struct {
+    hwaddr gpas[REMOTE_MAX_FDS];
+    uint64_t sizes[REMOTE_MAX_FDS];
+    ram_addr_t offsets[REMOTE_MAX_FDS];
+} sync_sysmem_msg_t;
+
+typedef struct {
     mpqemu_cmd_t cmd;
     int bytestream;
     size_t size;
=20
     union {
         uint64_t u64;
+        sync_sysmem_msg_t sync_sysmem;
     } data1;
=20
     int fds[REMOTE_MAX_FDS];
diff --git a/include/remote/memory.h b/include/remote/memory.h
new file mode 100644
index 0000000..e2e479b
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
diff --git a/remote/memory.c b/remote/memory.c
new file mode 100644
index 0000000..2c8b7bb
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
1.8.3.1


