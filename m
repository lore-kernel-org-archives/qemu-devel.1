Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527AC38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8388521927
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sNa/T9J2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8388521927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Kxf-0008V1-NL
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km6-00068n-OL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km4-00030y-Sl
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km4-0002zN-Ge
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:20 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrajF164104;
 Mon, 24 Feb 2020 20:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=QIN4OBnH8pfK/FQg/Ngm3RypA/DQPqJb+C20uwyiIM0=;
 b=sNa/T9J2Zx6yUkNSKIBXT1yBluwwIksfec48dOY/lbhun6iUHOdvwEdLA9nzMLCTytFn
 Y/H+YJ8Q8kDO6GYl5P+SLrjm3AGp6PX8Hwgge5Wm0fGBo68kgfyCQhO5ZZ7EMJrUi/tG
 tM3zi95QmgfPKXduR34a0Flks9HUhoh2oaRYD4QcDsmtko9Tfd8MVEvsIXgvAJErZ6C4
 gn3lf4Zcu4BvNsUCO2Ae1PvBQJteg2imUTj/9QsEjoZFJjElysjj0mxmgCjB3pi31uzA
 U/T2gEb9HXrzgf5BRrWGB7F2Zh/3yTg2D/i9FILCP0mE32Rh+2pstrDnrB9Cf61Id3Kd VA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p93g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKpuFv108591;
 Mon, 24 Feb 2020 20:56:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ybe123sm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:13 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuCvE029677;
 Mon, 24 Feb 2020 20:56:12 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:11 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 10/50] multi-process: setup a machine object for remote
 device process
Date: Mon, 24 Feb 2020 15:55:01 -0500
Message-Id: <c149a5116f8afee0ecfb5503a78de19b01a7daab.1582576372.git.jag.raman@oracle.com>
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
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01OKrajF164104
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

remote-machine object sets up various subsystems of the remote device
process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Refactor notifier code into a common file
  - Moved global initialization out of object specific code
  - Added a child property relationship between RemMachineState & RemPCIH=
ost

 Makefile.objs                 |  1 +
 exec.c                        |  3 +-
 include/exec/address-spaces.h |  2 ++
 include/remote/machine.h      | 30 ++++++++++++++++
 remote/Makefile.objs          |  1 +
 remote/machine.c              | 84 +++++++++++++++++++++++++++++++++++++=
++++++
 remote/remote-main.c          |  7 ++++
 util/Makefile.objs            |  2 ++
 8 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 include/remote/machine.h
 create mode 100644 remote/machine.c

diff --git a/Makefile.objs b/Makefile.objs
index c80e107..aad33fc 100644
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
index e524185..b4c9cc6 100644
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
@@ -3002,7 +3001,7 @@ static void tcg_commit(MemoryListener *listener)
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
index db8bfa9..56a877b 100644
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
index 0000000..7e9bdbe
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
index 2757f5a..13d4c48 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,2 +1,3 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
diff --git a/remote/machine.c b/remote/machine.c
new file mode 100644
index 0000000..97e4f19
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
index 7c0764a..ecf30e0 100644
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
index 6b38b67..80b2067 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -60,3 +60,5 @@ util-obj-y +=3D guest-random.o
 util-obj-$(CONFIG_GIO) +=3D dbus.o
 dbus.o-cflags =3D $(GIO_CFLAGS)
 dbus.o-libs =3D $(GIO_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D notify.o
--=20
1.8.3.1


