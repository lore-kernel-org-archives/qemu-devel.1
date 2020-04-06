Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFCC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83CF206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISvN+VlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83CF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOJL-0006ue-1R
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGh-0001s8-7O
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOGf-0002EE-LB
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOGf-0002D3-Cb
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:42:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369d0OR025179;
 Mon, 6 Apr 2020 09:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ryAEnQCWEwuN6zdfMf72ZhZnYh5nhoAZMWkb6smGonw=;
 b=ISvN+VlA6F/Y3DJe1iA1vQaK5mwvXQVykyW3THggOfkgbntYGR6Jr5sQp9GCcQ3j98B6
 3n+XugaL5uJFA4qDjhwF3T5yztsYKA/e0lqeSsOSMnmXksbKtQWM9bHFANyNX+A/0Q83
 kj3kS4spN5ZkFmRPUO/az0Wri3pzBlOx0JYaRPteHcLbzHZId/UPLyMv3jhp3NbKF1zE
 K6ZhtOunEGPTU+CWB6yRnoZgKkkmPAI+UXSPktL+CqEqBAQRIcPYJsFb2V991ZBVBwSQ
 N2cF9LpsMQhAqRGT7vl4o2CjVgB9lCVOJ8EcE0LEQaSTngwtOkJBS3Q9U0kFI8SDB0H5 vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 306jvmwr4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369cfE2092163;
 Mon, 6 Apr 2020 09:41:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 3073spk5xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:41:57 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0369ftxW030651;
 Mon, 6 Apr 2020 09:41:55 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:41:55 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 14/36] multi-process: setup a machine object for remote
 device process
Date: Mon,  6 Apr 2020 02:41:04 -0700
Message-Id: <17fc1bb4e32a3d088a4ad72e9173e942f4cbe5b6.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060083
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 0369d0OR025179
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

remote-machine object sets up various subsystems of the remote device
process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS                   |  2 +
 Makefile.objs                 |  1 +
 exec.c                        |  3 +-
 include/exec/address-spaces.h |  2 +
 include/remote/machine.h      | 30 +++++++++++++
 remote/Makefile.objs          |  1 +
 remote/machine.c              | 84 +++++++++++++++++++++++++++++++++++
 remote/remote-main.c          |  7 +++
 util/Makefile.objs            |  2 +
 9 files changed, 130 insertions(+), 2 deletions(-)
 create mode 100644 include/remote/machine.h
 create mode 100644 remote/machine.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 95c7ac77bd..970cdfc2ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2821,6 +2821,8 @@ F: include/io/mpqemu-link.h
 F: io/mpqemu-link.c
 F: include/remote/pcihost.h
 F: remote/pcihost.c
+F: include/remote/machine.h
+F: remote/machine.c
=20
 Build and test automation
 -------------------------
diff --git a/Makefile.objs b/Makefile.objs
index f6654633b4..ff3f06b146 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -31,6 +31,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D migration/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote/
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D accel/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D util/
=20
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D cpus-common.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D dma-helpers.o
diff --git a/exec.c b/exec.c
index d99bfef193..3bdad9d058 100644
--- a/exec.c
+++ b/exec.c
@@ -161,7 +161,6 @@ typedef struct subpage_t {
 #define PHYS_SECTION_UNASSIGNED 0
=20
 static void io_mem_init(void);
-static void memory_map_init(void);
 static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
=20
@@ -2951,7 +2950,7 @@ static void tcg_commit(MemoryListener *listener)
     tlb_flush(cpuas->cpu);
 }
=20
-static void memory_map_init(void)
+void memory_map_init(void)
 {
     system_memory =3D g_malloc(sizeof(*system_memory));
=20
diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.=
h
index db8bfa9a92..56a877b7ba 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -33,6 +33,8 @@ MemoryRegion *get_system_memory(void);
  */
 MemoryRegion *get_system_io(void);
=20
+void memory_map_init(void);
+
 extern AddressSpace address_space_memory;
 extern AddressSpace address_space_io;
=20
diff --git a/include/remote/machine.h b/include/remote/machine.h
new file mode 100644
index 0000000000..7e9bdbe28e
--- /dev/null
+++ b/include/remote/machine.h
@@ -0,0 +1,30 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MACHINE_H
+#define REMOTE_MACHINE_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/boards.h"
+#include "remote/pcihost.h"
+#include "qemu/notify.h"
+
+typedef struct RemMachineState {
+    MachineState parent_obj;
+
+    RemPCIHost *host;
+} RemMachineState;
+
+#define TYPE_REMOTE_MACHINE "remote-machine"
+#define REMOTE_MACHINE(obj) \
+    OBJECT_CHECK(RemMachineState, (obj), TYPE_REMOTE_MACHINE)
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 2757f5a265..13d4c48988 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,2 +1,3 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
diff --git a/remote/machine.c b/remote/machine.c
new file mode 100644
index 0000000000..97e4f194ea
--- /dev/null
+++ b/remote/machine.c
@@ -0,0 +1,84 @@
+/*
+ * Machine for remote device
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
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ioport.h"
+#include "qemu/thread.h"
+#include "qom/object.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "qemu/notify.h"
+
+static void remote_machine_init(Object *obj)
+{
+    RemMachineState *s =3D REMOTE_MACHINE(obj);
+    RemPCIHost *rem_host;
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+
+    Error *error_abort =3D NULL;
+
+    object_property_add_child(object_get_root(), "machine", obj, &error_=
abort);
+    if (error_abort) {
+        error_report_err(error_abort);
+    }
+
+    memory_map_init();
+
+    system_memory =3D get_system_memory();
+    system_io =3D get_system_io();
+
+    pci_memory =3D g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+
+    rem_host =3D REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_D=
EVICE));
+
+    rem_host->mr_pci_mem =3D pci_memory;
+    rem_host->mr_sys_mem =3D system_memory;
+    rem_host->mr_sys_io =3D system_io;
+
+    s->host =3D rem_host;
+
+    object_property_add_child(OBJECT(s), "remote-device", OBJECT(rem_hos=
t),
+                              &error_abort);
+    if (error_abort) {
+        error_report_err(error_abort);
+        return;
+    }
+
+    qemu_mutex_lock_iothread();
+    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, =
-1);
+    qemu_mutex_unlock_iothread();
+
+    qdev_init_nofail(DEVICE(rem_host));
+}
+
+static const TypeInfo remote_machine =3D {
+    .name =3D TYPE_REMOTE_MACHINE,
+    .parent =3D TYPE_MACHINE,
+    .instance_size =3D sizeof(RemMachineState),
+    .instance_init =3D remote_machine_init,
+};
+
+static void remote_machine_register_types(void)
+{
+    type_register_static(&remote_machine);
+}
+
+type_init(remote_machine_register_types);
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 7c0764ad01..ecf30e0cba 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -14,10 +14,17 @@
 #include <stdio.h>
=20
 #include "qemu/module.h"
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qemu/main-loop.h"
=20
 int main(int argc, char *argv[])
 {
     module_call_init(MODULE_INIT_QOM);
=20
+    current_machine =3D MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MA=
CHINE)));
+
     return 0;
 }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 6718a38b61..3c0e3a57c0 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -63,3 +63,5 @@ util-obj-y +=3D guest-random.o
 util-obj-$(CONFIG_GIO) +=3D dbus.o
 dbus.o-cflags =3D $(GIO_CFLAGS)
 dbus.o-libs =3D $(GIO_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D notify.o
--=20
2.25.GIT


