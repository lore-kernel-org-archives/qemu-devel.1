Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CFE22B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZkFAUcLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CFE22B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zjr-0000vx-Ds
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeQ-0001qv-L1
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1ZeO-0005Ja-Gh
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIE25V111434;
 Fri, 31 Jul 2020 18:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=NH5HLQlQOPmoQl57ijRKRFjElbxIl8CJ0GOUVPCdBKQ=;
 b=ZkFAUcLdzVTt+QmUAjw1DcffyJAIF9h7cCbghjMc244nVp2GAtygkWcqehdFM23mczjy
 PpCUory6rY0CpM2w4hdhpVbAo+dG9so2K3ZfI4O3rYta283DPuOHJ2InQZJIHzYQuiEV
 QukmTFR1YJ5FkxJDl3wlZlBrNTqAcfqhhhyAFO8yFXtLSF0KmhjGDUM4r3WBn457Ug04
 akJMehXNODb1l5lqrxjSz3MpJdQEA72J6PinUDTTW+TVi5sU1+CXO2RPiTe5S4K4Vn6H
 ruxYMxncofYMa+9fGEwrkaOV6gjJjuiYOrcJibDD04mTQg/lmvfQR7TC2zjM6hHl2+1A 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2130.oracle.com with ESMTP id 32hu1jtfy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:20:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIc2w137651;
 Fri, 31 Jul 2020 18:20:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 32hu64r6xb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:20:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIKgki013252;
 Fri, 31 Jul 2020 18:20:42 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:20:42 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/20] multi-process: setup a machine object for remote
 device process
Date: Fri, 31 Jul 2020 14:20:11 -0400
Message-Id: <a379f9e0ea5c1635a3a9315be415d8afd4d94444.1596217462.git.jag.raman@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
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

remote-machine object sets up various subsystems of the remote
device process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 MAINTAINERS                  |  2 ++
 hw/i386/Makefile.objs        |  1 +
 hw/i386/remote.c             | 69 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h     | 28 ++++++++++++++++++
 include/hw/pci-host/remote.h |  1 +
 5 files changed, 101 insertions(+)
 create mode 100644 hw/i386/remote.c
 create mode 100644 include/hw/i386/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d781a28..32e264e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3042,6 +3042,8 @@ M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
+F: hw/i386/remote.c
+F: include/hw/i386/remote.h
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 6abc745..5ead266 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -14,6 +14,7 @@ obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
 obj-$(CONFIG_PC) += port92.o
+obj-$(CONFIG_MPQEMU) += remote.o
 
 obj-y += kvmvapic.o
 obj-$(CONFIG_ACPI) += acpi-common.o
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
new file mode 100644
index 0000000..a67be33
--- /dev/null
+++ b/hw/i386/remote.c
@@ -0,0 +1,69 @@
+/*
+ * Machine for remote device
+ *
+ *  This machine type is used by the remote device process in multi-process
+ *  QEMU. QEMU device models depend on parent busses, interrupt controllers,
+ *  memory regions, etc. The remote machine type offers this environment so
+ *  that QEMU device models can be used as remote devices.
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
+#include "hw/i386/remote.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "qapi/error.h"
+
+static void remote_machine_init(MachineState *machine)
+{
+    MemoryRegion *system_memory, *system_io, *pci_memory;
+    RemoteMachineState *s = REMOTE_MACHINE(machine);
+    RemotePCIHost *rem_host;
+
+    system_memory = get_system_memory();
+    system_io = get_system_io();
+
+    pci_memory = g_new(MemoryRegion, 1);
+    memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
+
+    rem_host = REMOTE_HOST_DEVICE(qdev_new(TYPE_REMOTE_HOST_DEVICE));
+
+    rem_host->mr_pci_mem = pci_memory;
+    rem_host->mr_sys_mem = system_memory;
+    rem_host->mr_sys_io = system_io;
+
+    s->host = rem_host;
+
+    object_property_add_child(OBJECT(s), "remote-device", OBJECT(rem_host));
+    memory_region_add_subregion_overlap(system_memory, 0x0, pci_memory, -1);
+
+    qdev_realize(DEVICE(rem_host), sysbus_get_default(), &error_fatal);
+}
+
+static void remote_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = remote_machine_init;
+}
+
+static const TypeInfo remote_machine = {
+    .name = TYPE_REMOTE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(RemoteMachineState),
+    .class_init = remote_machine_class_init,
+};
+
+static void remote_machine_register_types(void)
+{
+    type_register_static(&remote_machine);
+}
+
+type_init(remote_machine_register_types);
diff --git a/include/hw/i386/remote.h b/include/hw/i386/remote.h
new file mode 100644
index 0000000..5b36b25
--- /dev/null
+++ b/include/hw/i386/remote.h
@@ -0,0 +1,28 @@
+/*
+ * Remote machine configuration
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_MACHINE_H
+#define REMOTE_MACHINE_H
+
+#include "qom/object.h"
+#include "hw/boards.h"
+#include "hw/pci-host/remote.h"
+
+typedef struct RemoteMachineState {
+    MachineState parent_obj;
+
+    RemotePCIHost *host;
+} RemoteMachineState;
+
+#define TYPE_REMOTE_MACHINE "remote-machine"
+#define REMOTE_MACHINE(obj) \
+    OBJECT_CHECK(RemoteMachineState, (obj), TYPE_REMOTE_MACHINE)
+
+#endif
diff --git a/include/hw/pci-host/remote.h b/include/hw/pci-host/remote.h
index bab6d3c..cc0fff4 100644
--- a/include/hw/pci-host/remote.h
+++ b/include/hw/pci-host/remote.h
@@ -25,6 +25,7 @@ typedef struct RemotePCIHost {
 
     MemoryRegion *mr_pci_mem;
     MemoryRegion *mr_sys_io;
+    MemoryRegion *mr_sys_mem;
 } RemotePCIHost;
 
 #endif
-- 
1.8.3.1


