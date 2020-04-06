Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D31C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5AF206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qtGXMYqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5AF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLORJ-0005Qf-IQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGq-0002Gs-35
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGo-0002LU-5K
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGn-0002Kv-Rn
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cxbO025132;
 Mon, 6 Apr 2020 09:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FSSEMZbZRp9M2EFIdlYF63J5crNdAd2cSzpn8GgSEFw=;
 b=qtGXMYqBN8pNq0+uZhMqwu3BeceOPe3Ogif28PNuXdNzxZUZgRerw0xZmMgHO5MD3Yzs
 vCpIMYlv5qh4SRjRb4R8GFdlp4J59lON8QVVsAnf30o9yzRPNd/1CptEb2Xz1TpTePDO
 yOWZMZF2/FBckzfTkyPOoDShhCSqHF6nj3L7GZb07dg8N8V/CcmD+Z4F/RGR+NFI06SC
 P9geAWu7xGHzSa19CxwGqXCkyPMEUGS0rKW7E4zG8kzUoeO/QzBAEvdXriBWCF/WXKvZ
 Swk2cz/ilf4YjguHayrO3L/gwMH7mcrk36/67Uwsfwdn1MZhg8/LcVD/wiWhcfyIUkGw 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 306jvmwr5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cjB6092316;
 Mon, 6 Apr 2020 09:42:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 3073spk6cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369g8Jt013703;
 Mon, 6 Apr 2020 09:42:08 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:08 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 22/36] multi-process: Synchronize remote memory
Date: Mon,  6 Apr 2020 02:41:12 -0700
Message-Id: <4d80a92957c091e3d9c8f18ccc13a1bc278c5aeb.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=4 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=4
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 0369cxbO025132
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add memory-listener object which is used to keep the view of the RAM
in sync between QEMU and remote process.
A MemoryListener is registered for system-memory AddressSpace. The
listener sends SYNC_SYSMEM message to the remote process when memory
listener commits the changes to memory, the remote process receives
the message and processes it in the handler for SYNC_SYSMEM message.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS                    |   2 +
 Makefile.target                |   3 +
 hw/proxy/memory-sync.c         | 212 +++++++++++++++++++++++++++++++++
 hw/proxy/qemu-proxy.c          |   6 +
 include/hw/proxy/memory-sync.h |  37 ++++++
 include/hw/proxy/qemu-proxy.h  |   6 +
 remote/remote-main.c           |  11 ++
 7 files changed, 277 insertions(+)
 create mode 100644 hw/proxy/memory-sync.c
 create mode 100644 include/hw/proxy/memory-sync.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e2ac5b08a4..58aea19d34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2828,6 +2828,8 @@ F: remote/memory.c
 F: hw/proxy/Makefile.objs
 F: hw/proxy/qemu-proxy.c
 F: include/hw/proxy/qemu-proxy.h
+F: include/hw/proxy/memory-sync.h
+F: hw/proxy/memory-sync.c
=20
 Build and test automation
 -------------------------
diff --git a/Makefile.target b/Makefile.target
index 500fa07fda..c64d860895 100644
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
index 0000000000..3edbb19efe
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
index 7fd0a312a5..2ac4c1528a 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -13,6 +13,8 @@
 #include "io/mpqemu-link.h"
 #include "hw/proxy/qemu-proxy.h"
 #include "hw/pci/pci.h"
+#include "hw/proxy/memory-sync.h"
+#include "qom/object.h"
=20
 static int config_op_send(PCIProxyDev *dev, uint32_t addr, uint32_t *val=
, int l,
                           unsigned int op)
@@ -138,6 +140,10 @@ static void pci_proxy_dev_realize(PCIDevice *device,=
 Error **errp)
             error_propagate(errp, local_err);
         }
     }
+
+    dev->sync =3D REMOTE_MEM_SYNC(object_new(TYPE_MEMORY_LISTENER));
+
+    configure_memory_sync(dev->sync, dev->mpqemu_link);
 }
=20
 static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/proxy/memory-sync.h b/include/hw/proxy/memory-syn=
c.h
new file mode 100644
index 0000000000..d8329c9b52
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
index 9e4127eccb..6d14876ba9 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -14,6 +14,7 @@
=20
 #include "io/mpqemu-link.h"
 #include "hw/pci/pci.h"
+#include "hw/proxy/memory-sync.h"
=20
 #define TYPE_PCI_PROXY_DEV "pci-proxy-dev"
=20
@@ -39,8 +40,13 @@ typedef struct ProxyMemoryRegion {
 struct PCIProxyDev {
     PCIDevice parent_dev;
=20
+    int n_mr_sections;
+    MemoryRegionSection *mr_sections;
+
     MPQemuLinkState *mpqemu_link;
=20
+    RemoteMemSync *sync;
+
     int socket;
=20
     ProxyMemoryRegion region[PCI_NUM_REGIONS];
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 4f512aa5a8..ed51499ace 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -34,6 +34,7 @@
 #include "block/block.h"
 #include "exec/ramlist.h"
 #include "exec/memattrs.h"
+#include "exec/address-spaces.h"
=20
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -204,6 +205,16 @@ static void process_msg(GIOCondition cond, MPQemuLin=
kState *link,
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
2.25.GIT


