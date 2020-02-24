Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3BC38BF0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25E620CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkMaJLVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25E620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kzi-0003nm-QR
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmE-0006Qx-Dw
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmC-0003A2-Du
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:30 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6KmC-00038M-4B
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqfaK017769;
 Mon, 24 Feb 2020 20:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=V18b2Y/tB/tfdr7XeGv9QQmUAm7T3jOAre8HMAsld8o=;
 b=SkMaJLVopjO463DsdQpFrTUlqcIpTxgl/LQ25f8p+/a0WIXoHC7dDWMwuDFSCxqdTxxv
 TTVMGOhFtxxxb27uzPVmaJ/VCB+OTcV7RHZD2t4Tl5qoCJNmtBO024vNy2m96qJHu7sL
 t4Sst/3TzJDIQLm8gS8Xu3L3o1UDvDJbhRztpBSEm6RGAOsvaW3xVYa4NI2OULPC8CxD
 CXT1lfnCk2xjtsOh5CVC23gricMS4lOARxKabJ0tcGiiylP+e9TaZpm1bwfXw5DnPxJT
 l3a/ZT2uVrkzbx0puhE5qfIPwgz3r2hdK6urMsbjjmHp1Ib5tH1tneQILEIHRVyWhV61 mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yavxrhyeu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:23 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq65D108991;
 Mon, 24 Feb 2020 20:56:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2ybe123t2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:22 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuLAf028318;
 Mon, 24 Feb 2020 20:56:21 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:21 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/50] multi-process: Synchronize remote memory
Date: Mon, 24 Feb 2020 15:55:07 -0500
Message-Id: <52bdcfdf44bcc4cd8a1a707b9c22f545fe0f1491.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=4 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
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
 01OKqfaK017769
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

Add memory-listener object which is used to keep the view of the RAM
in sync between QEMU and remote process.
A MemoryListener is registered for system-memory AddressSpace. The
listener sends SYNC_SYSMEM message to the remote process when memory
listener commits the changes to memory, the remote process receives
the message and processes it in the handler for SYNC_SYSMEM message.

TODO: No need to create object for remote memory listener.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile.target                |   3 +
 hw/proxy/memory-sync.c         | 212 +++++++++++++++++++++++++++++++++++=
++++++
 hw/proxy/qemu-proxy.c          |   5 +
 include/hw/proxy/memory-sync.h |  37 +++++++
 include/hw/proxy/qemu-proxy.h  |   5 +
 remote/remote-main.c           |  11 +++
 6 files changed, 273 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/Makefile.target b/Makefile.target
index cfd36c1..271d883 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -127,6 +127,9 @@ obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
 obj-y +=3D target/$(TARGET_BASE_ARCH)/
 obj-y +=3D disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+obj-$(CONFIG_MPQEMU) +=3D hw/proxy/memory-sync.o
+endif
 LIBS :=3D $(libs_cpu) $(LIBS)
=20
 obj-$(CONFIG_PLUGIN) +=3D plugins/
diff --git a/hw/proxy/memory-sync.c b/hw/proxy/memory-sync.c
new file mode 100644
index 0000000..3edbb19
--- /dev/null
+++ b/hw/proxy/memory-sync.c
@@ -0,0 +1,212 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <sys/types.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "qemu/osdep.h"
+#include "qemu/compiler.h"
+#include "qemu/int128.h"
+#include "qemu/range.h"
+#include "exec/memory.h"
+#include "exec/cpu-common.h"
+#include "cpu.h"
+#include "exec/ram_addr.h"
+#include "exec/address-spaces.h"
+#include "io/mpqemu-link.h"
+#include "hw/proxy/memory-sync.h"
+
+static const TypeInfo remote_mem_sync_type_info =3D {
+    .name          =3D TYPE_MEMORY_LISTENER,
+    .parent        =3D TYPE_OBJECT,
+    .instance_size =3D sizeof(RemoteMemSync),
+};
+
+static void remote_mem_sync_register_types(void)
+{
+    type_register_static(&remote_mem_sync_type_info);
+}
+
+type_init(remote_mem_sync_register_types)
+
+static void proxy_ml_begin(MemoryListener *listener)
+{
+    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
+    int mrs;
+
+    for (mrs =3D 0; mrs < sync->n_mr_sections; mrs++) {
+        memory_region_unref(sync->mr_sections[mrs].mr);
+    }
+
+    g_free(sync->mr_sections);
+    sync->mr_sections =3D NULL;
+    sync->n_mr_sections =3D 0;
+}
+
+static int get_fd_from_hostaddr(uint64_t host, ram_addr_t *offset)
+{
+    MemoryRegion *mr;
+    ram_addr_t off;
+
+    mr =3D memory_region_from_host((void *)(uintptr_t)host, &off);
+
+    if (offset) {
+        *offset =3D off;
+    }
+
+    return memory_region_get_fd(mr);
+}
+
+static bool proxy_mrs_can_merge(uint64_t host, uint64_t prev_host, size_=
t size)
+{
+    bool merge;
+    int fd1, fd2;
+
+    fd1 =3D get_fd_from_hostaddr(host, NULL);
+
+    fd2 =3D get_fd_from_hostaddr(prev_host, NULL);
+
+    merge =3D (fd1 =3D=3D fd2);
+
+    merge &=3D ((prev_host + size) =3D=3D host);
+
+    return merge;
+}
+
+static void proxy_ml_region_addnop(MemoryListener *listener,
+                                   MemoryRegionSection *section)
+{
+    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
+    bool need_add =3D true;
+    uint64_t mrs_size, mrs_gpa, mrs_page;
+    uintptr_t mrs_host;
+    RAMBlock *mrs_rb;
+    MemoryRegionSection *prev_sec;
+
+    if (!(memory_region_is_ram(section->mr) &&
+          !memory_region_is_rom(section->mr))) {
+        return;
+    }
+
+    mrs_rb =3D section->mr->ram_block;
+    mrs_page =3D (uint64_t)qemu_ram_pagesize(mrs_rb);
+    mrs_size =3D int128_get64(section->size);
+    mrs_gpa =3D section->offset_within_address_space;
+    mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) +
+               section->offset_within_region;
+
+    if (get_fd_from_hostaddr(mrs_host, NULL) <=3D 0) {
+        return;
+    }
+
+    mrs_host =3D mrs_host & ~(mrs_page - 1);
+    mrs_gpa =3D mrs_gpa & ~(mrs_page - 1);
+    mrs_size =3D ROUND_UP(mrs_size, mrs_page);
+
+    if (sync->n_mr_sections) {
+        prev_sec =3D sync->mr_sections + (sync->n_mr_sections - 1);
+        uint64_t prev_gpa_start =3D prev_sec->offset_within_address_spac=
e;
+        uint64_t prev_size =3D int128_get64(prev_sec->size);
+        uint64_t prev_gpa_end   =3D range_get_last(prev_gpa_start, prev_=
size);
+        uint64_t prev_host_start =3D
+            (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+            prev_sec->offset_within_region;
+        uint64_t prev_host_end =3D range_get_last(prev_host_start, prev_=
size);
+
+        if (mrs_gpa <=3D (prev_gpa_end + 1)) {
+            if (mrs_gpa < prev_gpa_start) {
+                assert(0);
+            }
+
+            if ((section->mr =3D=3D prev_sec->mr) &&
+                proxy_mrs_can_merge(mrs_host, prev_host_start,
+                                    (mrs_gpa - prev_gpa_start))) {
+                uint64_t max_end =3D MAX(prev_host_end, mrs_host + mrs_s=
ize);
+                need_add =3D false;
+                prev_sec->offset_within_address_space =3D
+                    MIN(prev_gpa_start, mrs_gpa);
+                prev_sec->offset_within_region =3D
+                    MIN(prev_host_start, mrs_host) -
+                    (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr);
+                prev_sec->size =3D int128_make64(max_end - MIN(prev_host=
_start,
+                                                             mrs_host));
+            }
+        }
+    }
+
+    if (need_add) {
+        ++sync->n_mr_sections;
+        sync->mr_sections =3D g_renew(MemoryRegionSection, sync->mr_sect=
ions,
+                                    sync->n_mr_sections);
+        sync->mr_sections[sync->n_mr_sections - 1] =3D *section;
+        sync->mr_sections[sync->n_mr_sections - 1].fv =3D NULL;
+        memory_region_ref(section->mr);
+    }
+}
+
+static void proxy_ml_commit(MemoryListener *listener)
+{
+    RemoteMemSync *sync =3D container_of(listener, RemoteMemSync, listen=
er);
+    MPQemuMsg msg;
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    uintptr_t host_addr;
+    int region;
+
+    memset(&msg, 0, sizeof(MPQemuMsg));
+
+    msg.cmd =3D SYNC_SYSMEM;
+    msg.bytestream =3D 0;
+    msg.num_fds =3D sync->n_mr_sections;
+    msg.size =3D sizeof(msg.data1);
+    assert(msg.num_fds <=3D REMOTE_MAX_FDS);
+
+    for (region =3D 0; region < sync->n_mr_sections; region++) {
+        section =3D sync->mr_sections[region];
+        msg.data1.sync_sysmem.gpas[region] =3D
+            section.offset_within_address_space;
+        msg.data1.sync_sysmem.sizes[region] =3D int128_get64(section.siz=
e);
+        host_addr =3D (uintptr_t)memory_region_get_ram_ptr(section.mr) +
+                    section.offset_within_region;
+        msg.fds[region] =3D get_fd_from_hostaddr(host_addr, &offset);
+        msg.data1.sync_sysmem.offsets[region] =3D offset;
+    }
+    mpqemu_msg_send(&msg, sync->mpqemu_link->com);
+}
+
+void deconfigure_memory_sync(RemoteMemSync *sync)
+{
+    memory_listener_unregister(&sync->listener);
+}
+
+/*
+ * TODO: Memory Sync need not be instantianted once per every proxy devi=
ce.
+ *       All remote devices are going to get the exact same updates at t=
he
+ *       same time. It therefore makes sense to have a broadcast model.
+ *
+ *       Broadcast model would involve running the MemorySync object in =
a
+ *       thread. MemorySync would contain a list of mpqemu-link objects
+ *       that need notification. proxy_ml_commit() could send the same
+ *       message to all the links at the same time.
+ */
+void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_=
link)
+{
+    sync->n_mr_sections =3D 0;
+    sync->mr_sections =3D NULL;
+
+    sync->mpqemu_link =3D mpqemu_link;
+
+    sync->listener.begin =3D proxy_ml_begin;
+    sync->listener.commit =3D proxy_ml_commit;
+    sync->listener.region_add =3D proxy_ml_region_addnop;
+    sync->listener.region_nop =3D proxy_ml_region_addnop;
+    sync->listener.priority =3D 10;
+
+    memory_listener_register(&sync->listener, &address_space_memory);
+}
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index b17d9bb..d3a9d38 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -16,6 +16,8 @@
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qstring.h"
 #include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
=20
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
=20
@@ -243,6 +245,8 @@ static void init_proxy(PCIDevice *dev, char *command,=
 char *exec_name,
=20
     mpqemu_init_channel(pdev->mpqemu_link, &pdev->mpqemu_link->com,
                         pdev->socket);
+
+    configure_memory_sync(pdev->sync, pdev->mpqemu_link);
 }
=20
 static void pci_proxy_dev_realize(PCIDevice *device, Error **errp)
@@ -261,6 +265,7 @@ static void pci_proxy_dev_realize(PCIDevice *device, =
Error **errp)
     dev->set_proxy_sock =3D set_proxy_sock;
     dev->get_proxy_sock =3D get_proxy_sock;
     dev->init_proxy =3D init_proxy;
+    dev->sync =3D REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
 }
=20
 static void send_bar_access_msg(PCIProxyDev *dev, MemoryRegion *mr,
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-syn=
c.h
new file mode 100644
index 0000000..d8329c9
--- /dev/null
+++ b/include/hw/proxy/memory-sync.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MEMORY_SYNC_H
+#define MEMORY_SYNC_H
+
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "exec/memory.h"
+#include "io/mpqemu-link.h"
+
+#define TYPE_MEMORY_LISTENER "memory-listener"
+#define REMOTE_MEM_SYNC(obj) \
+            OBJECT_CHECK(RemoteMemSync, (obj), TYPE_MEMORY_LISTENER)
+
+typedef struct RemoteMemSync {
+    Object obj;
+
+    MemoryListener listener;
+
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
+    MPQemuLinkState *mpqemu_link;
+} RemoteMemSync;
+
+void configure_memory_sync(RemoteMemSync *sync, MPQemuLinkState *mpqemu_=
link);
+void deconfigure_memory_sync(RemoteMemSync *sync);
+
+#endif
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.=
h
index 44e370e..c93ffe3 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -10,6 +10,7 @@
 #define QEMU_PROXY_H
=20
 #include "io/mpqemu-link.h"
+#include "hw/proxy/memory-sync.h"
=20
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
=20
@@ -37,8 +38,12 @@ extern const MemoryRegionOps proxy_default_ops;
 struct PCIProxyDev {
     PCIDevice parent_dev;
=20
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
     MPQemuLinkState *mpqemu_link;
=20
+    RemoteMemSync *sync;
     pid_t remote_pid;
     int socket;
=20
diff --git a/remote/remote-main.c b/remote/remote-main.c
index acd8daf..9512a3b 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -34,6 +34,7 @@
 #include "block/block.h"
 #include "exec/ramlist.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
=20
 static MPQemuLinkState *mpqemu_link;
 PCIDevice *remote_pci_dev;
@@ -161,6 +162,16 @@ static void process_msg(GIOCondition cond, MPQemuCha=
nnel *chan)
             goto finalize_loop;
         }
         break;
+    case SYNC_SYSMEM:
+        /*
+         * TODO: ensure no active DMA is happening when
+         * sysmem is being updated
+         */
+        remote_sysmem_reconfig(msg, &err);
+        if (err) {
+            goto finalize_loop;
+        }
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
--=20
1.8.3.1


