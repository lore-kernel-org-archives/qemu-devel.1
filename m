Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84E2C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:07:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F18E20644
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uJ41ZY6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F18E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPVp8-0005eu-FV
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVc1-0008QD-9F
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kPVbz-0008DK-9H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 14:53:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095InboQ184803;
 Mon, 5 Oct 2020 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=F3L+Qi2YWEmdK76twogizPK1cGdF9XZFzke5h/1StmY=;
 b=uJ41ZY6BY/jTpPVdvBowOKt0CVCY4jZKd3UlPCKxcyb1ERZGmoj1+A6K/QPND6gM837u
 Q3QdnJipxI9xbwq4aRdloN10YKSdfMSz2/MQVaJ5VvZSG1HVdcdg/d+2IU8DjYN9f3S7
 9LGdj0+5gTmKGWVTSdZN+f1sLDpFZLBF5B+PDdyElX/oCIZghG+zbxGdgtu3BUaSKwen
 NeXcxelgkfLSfYZHk6X70NC03vngXyZWt2kywp7VlRq+7PikVemrmcd4SF5BmRXxt0JK
 pff5nSjeTRb+Mj3JSBQcZATCoB1wr8+EDQagR16SJtXGWnPEZXr1TjnlTQKuNA51Wa4x jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 33xhxmq5ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 05 Oct 2020 18:53:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 095IpDPL182592;
 Mon, 5 Oct 2020 18:51:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 33y2vkvf0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 05 Oct 2020 18:51:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 095IpHd5001855;
 Mon, 5 Oct 2020 18:51:17 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 05 Oct 2020 11:51:17 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v10 04/19] multi-process: setup a machine object for remote
 device process
Date: Mon,  5 Oct 2020 11:50:52 -0700
Message-Id: <1aee60860b445c6b17b29b22e797e7a87011097d.1601923020.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1601923020.git.elena.ufimtseva@oracle.com>
References: <cover.1601923020.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 malwarescore=0 suspectscore=1 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010050136
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:40:53
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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

remote-machine object sets up various subsystems of the remote
device process. Instantiate PCI host bridge object and initialize RAM, IO &
PCI memory regions.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                  |  2 ++
 hw/i386/meson.build          |  1 +
 hw/i386/remote.c             | 69 ++++++++++++++++++++++++++++++++++++
 include/hw/i386/remote.h     | 28 +++++++++++++++
 include/hw/pci-host/remote.h |  1 +
 5 files changed, 101 insertions(+)
 create mode 100644 hw/i386/remote.c
 create mode 100644 include/hw/i386/remote.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 76cff0fc12..38d19c83cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3043,6 +3043,8 @@ M: John G Johnson <john.g.johnson@oracle.com>
 S: Maintained
 F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
+F: hw/i386/remote.c
+F: include/hw/i386/remote.h
 
 Build and test automation
 -------------------------
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63918fbe22..1c1668c5db 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -23,6 +23,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'pc_sysfw.c',
   'acpi-build.c',
   'port92.c'))
+i386_ss.add(when: 'CONFIG_MPQEMU', if_true: files('remote.c'))
 
 subdir('kvm')
 subdir('xen')
diff --git a/hw/i386/remote.c b/hw/i386/remote.c
new file mode 100644
index 0000000000..a67be33396
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
index 0000000000..5b36b25ca1
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
index bab6d3c4f0..cc0fff4ae3 100644
--- a/include/hw/pci-host/remote.h
+++ b/include/hw/pci-host/remote.h
@@ -25,6 +25,7 @@ typedef struct RemotePCIHost {
 
     MemoryRegion *mr_pci_mem;
     MemoryRegion *mr_sys_io;
+    MemoryRegion *mr_sys_mem;
 } RemotePCIHost;
 
 #endif
-- 
2.25.GIT


