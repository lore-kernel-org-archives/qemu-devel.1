Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A9CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62FA2339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TxTQD4pp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62FA2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GPg-0005TN-PT
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fbd-0000y0-N5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5Fbc-0001rD-0r
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:40:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5Fbb-0001pj-NS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:40:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdSYl070909;
 Tue, 3 Sep 2019 20:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=ytFWpd4znREQzr25pofBI0txEoAvZMaz2ykEabl+Lo4=;
 b=TxTQD4pp8tdJ0R7T0mO2Ikasvg/7ermRGrNEAKaYfgbcb5u9Ghqloq1i095nx2ph732V
 J0fLhlBpj6bzdGUnUFjDvEXd7jYPsn/8CukClzbh8mjP8MPXDpYMbEXDEMWzdKuKLcUF
 6ickn90ezQPdwvWIjivepYCqkm7LoCTZcLsMdYOhJsml4+7KmhanNR0r3Eh7J08Bfhms
 YNsomf7zy9kTHOqXdNYjZHeH6vU/Pe1Rd49x7+NZdSQ50Hvn+7GQB9pF7SZHA9aRpjXY
 8lLi7yX4/q0W21xbP1xbyOzCqN7RqoiEggeV67nkp1SlB631B/N2RNOayn2q0oXSYUzz 8g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2usy4u839d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:40:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcZaM178214;
 Tue, 3 Sep 2019 20:38:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegq56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KcdKg012261;
 Tue, 3 Sep 2019 20:38:39 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:38 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:36 -0400
Message-Id: <ca7893f5d90c60c5561c2372f56994463b56c5b7.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC v3 PATCH 10/45] multi-process: setup a machine
 object for remote device process
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
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
 exec.c                        |   3 +-
 include/exec/address-spaces.h |   2 +
 include/remote/machine.h      |  46 ++++++++++++++++
 remote/Makefile.objs          |   1 +
 remote/machine.c              | 118 ++++++++++++++++++++++++++++++++++++++++++
 remote/remote-main.c          |   7 +++
 6 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 include/remote/machine.h
 create mode 100644 remote/machine.c

diff --git a/exec.c b/exec.c
index b3f1aa9..04d9663 100644
--- a/exec.c
+++ b/exec.c
@@ -197,7 +197,6 @@ typedef struct subpage_t {
 #define PHYS_SECTION_WATCH 3
 
 static void io_mem_init(void);
-static void memory_map_init(void);
 static void tcg_commit(MemoryListener *listener);
 
 static MemoryRegion io_mem_watch;
@@ -3165,7 +3164,7 @@ static void tcg_commit(MemoryListener *listener)
     tlb_flush(cpuas->cpu);
 }
 
-static void memory_map_init(void)
+void memory_map_init(void)
 {
     system_memory = g_malloc(sizeof(*system_memory));
 
diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9..56a877b 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -33,6 +33,8 @@ MemoryRegion *get_system_memory(void);
  */
 MemoryRegion *get_system_io(void);
 
+void memory_map_init(void);
+
 extern AddressSpace address_space_memory;
 extern AddressSpace address_space_io;
 
diff --git a/include/remote/machine.h b/include/remote/machine.h
new file mode 100644
index 0000000..a00732d
--- /dev/null
+++ b/include/remote/machine.h
@@ -0,0 +1,46 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
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
+void qemu_run_machine_init_done_notifiers(void);
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index 2757f5a..13d4c48 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1,2 +1,3 @@
 remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
 remote-pci-obj-$(CONFIG_MPQEMU) += pcihost.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
diff --git a/remote/machine.c b/remote/machine.c
new file mode 100644
index 0000000..4ce197d
--- /dev/null
+++ b/remote/machine.c
@@ -0,0 +1,118 @@
+/*
+ * Machine for remote device
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
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
+#include "exec/ramlist.h"
+#include "qemu/thread.h"
+#include "qom/object.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "qemu/notify.h"
+
+static NotifierList machine_init_done_notifiers =
+    NOTIFIER_LIST_INITIALIZER(machine_init_done_notifiers);
+
+bool machine_init_done;
+
+void qemu_add_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_list_add(&machine_init_done_notifiers, notify);
+    if (machine_init_done) {
+        notify->notify(notify, NULL);
+    }
+}
+
+void qemu_remove_machine_init_done_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_run_machine_init_done_notifiers(void)
+{
+    machine_init_done = true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
+}
+
+static void remote_machine_init(Object *obj)
+{
+    RemMachineState *s = REMOTE_MACHINE(obj);
+    RemPCIHost *rem_host;
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+
+    Error *error_abort = NULL;
+
+    qemu_mutex_init(&ram_list.mutex);
+
+    object_property_add_child(object_get_root(), "machine", obj, &error_abort);
+    if (error_abort) {
+        error_report_err(error_abort);
+    }
+
+    memory_map_init();
+
+    system_memory = get_system_memory();
+    system_io = get_system_io();
+
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+
+    rem_host = REMOTE_HOST_DEVICE(qdev_create(NULL, TYPE_REMOTE_HOST_DEVICE));
+
+    rem_host->mr_pci_mem = pci_memory;
+    rem_host->mr_sys_mem = system_memory;
+    rem_host->mr_sys_io = system_io;
+
+    s->host = rem_host;
+
+    qemu_mutex_lock_iothread();
+    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
+    qemu_mutex_unlock_iothread();
+
+    qdev_init_nofail(DEVICE(rem_host));
+}
+
+static const TypeInfo remote_machine = {
+    .name = TYPE_REMOTE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RemMachineState),
+    .instance_init = remote_machine_init,
+};
+
+static void remote_machine_register_types(void)
+{
+    type_register_static(&remote_machine);
+}
+
+type_init(remote_machine_register_types);
diff --git a/remote/remote-main.c b/remote/remote-main.c
index ffcf47f..97dd832 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -26,10 +26,17 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "remote/pcihost.h"
+#include "remote/machine.h"
+#include "hw/boards.h"
+#include "hw/qdev-core.h"
+#include "qemu/main-loop.h"
 
 int main(int argc, char *argv[])
 {
     module_call_init(MODULE_INIT_QOM);
 
+    current_machine = MACHINE(REMOTE_MACHINE(object_new(TYPE_REMOTE_MACHINE)));
+
     return 0;
 }
-- 
1.8.3.1


