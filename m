Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F41C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FCF21556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 20:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z9Oi3BGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCF21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6KpC-0003Bi-RP
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 15:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km3-00060w-IG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km2-0002x3-4O
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km1-0002vk-Rd
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKraG5164141;
 Mon, 24 Feb 2020 20:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=KV8kDjxArLU2g0UIpoGF6YobT97Ym3GFYX9DX+iqJX4=;
 b=z9Oi3BGE6txObhVEznnHDpQ9w37OLW46z8bPctUqUZ1r8oXaqwHdN4TAMRqM3cVTnt91
 BisQ0tnbV6pcvZXG6a73f2DqXp6JfLP76Ob0cV+P1kIu8K9sVXXXNUCQaZ+ULAZyKEhD
 Qtj6AbCheut5p8BaQZV3Kqrjwinh2BFxytQSDFe/WwcdHaPfZC40VME8tpFIxX4QcXzk
 l4hQa6ceEC9h3HHZ8Afd/3Xdw0vYJpd/sse5n3Bizm3FUyY6PvgTbNFz3Z/D66oeTi35
 L7+OmVWffKdGzEl5O4eEcQndVlQNTNYZyyJm2ZDixo9X/ba/Dh2l8AoLl8O5q7C13Bnq LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p93c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq8TA089084;
 Mon, 24 Feb 2020 20:56:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2yby5dmaja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OKuA5j028314;
 Mon, 24 Feb 2020 20:56:10 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:10 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/50] multi-process: setup PCI host bridge for remote
 device
Date: Mon, 24 Feb 2020 15:55:00 -0500
Message-Id: <52ffd24f1ab55b596619a92b3b44d462fc235ee4.1582576372.git.jag.raman@oracle.com>
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
 suspectscore=1 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
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
 01OKraG5164141
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

PCI host bridge is setup for the remote device process. It is
implemented using remote-pcihost object. It is an extension of the PCI
host bridge setup by QEMU.
Remote-pcihost configures a PCI bus which could be used by the remote
 PCI device to latch on to.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 v4 -> v5:
  - Setting PCI bus name on the fly
  - Unable to grab the PCI bus name from object hierarchy as
    RemPCIHost have access to it during instantiation

 hw/pci/Makefile.objs     |  2 +-
 include/remote/pcihost.h | 45 ++++++++++++++++++++++++++++++++++
 remote/Makefile.objs     |  1 +
 remote/pcihost.c         | 64 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 include/remote/pcihost.h
 create mode 100644 remote/pcihost.c

diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 955be54..90693a7 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -13,6 +13,6 @@ common-obj-$(CONFIG_PCI_EXPRESS) +=3D pcie_port.o pcie_=
host.o
 common-obj-$(call lnot,$(CONFIG_PCI)) +=3D pci-stub.o
 common-obj-$(CONFIG_ALL) +=3D pci-stub.o
=20
-remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci.o pci_bridge.o pci_host.o pcie_=
host.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D msi.o msix.o
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcie.o
diff --git a/include/remote/pcihost.h b/include/remote/pcihost.h
new file mode 100644
index 0000000..7aca9cc
--- /dev/null
+++ b/include/remote/pcihost.h
@@ -0,0 +1,45 @@
+/*
+ * PCI Host for remote device
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef REMOTE_PCIHOST_H
+#define REMOTE_PCIHOST_H
+
+#include <stddef.h>
+#include <stdint.h>
+
+#include "exec/memory.h"
+#include "hw/pci/pcie_host.h"
+
+#define TYPE_REMOTE_HOST_DEVICE "remote-pcihost"
+#define REMOTE_HOST_DEVICE(obj) \
+    OBJECT_CHECK(RemPCIHost, (obj), TYPE_REMOTE_HOST_DEVICE)
+
+typedef struct RemPCIHost {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+    /*< public >*/
+
+    /*
+     * Memory Controller Hub (MCH) may not be necessary for the emulatio=
n
+     * program. The two important reasons for implementing a PCI host in=
 the
+     * emulation program are:
+     * - Provide a PCI bus for IO devices
+     * - Enable translation of guest PA to the PCI bar regions
+     *
+     * For both the above mentioned purposes, it doesn't look like we wo=
uld
+     * need the MCH
+     */
+
+    MemoryRegion *mr_pci_mem;
+    MemoryRegion *mr_sys_mem;
+    MemoryRegion *mr_sys_io;
+} RemPCIHost;
+
+#endif
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
index a9b2256..2757f5a 100644
--- a/remote/Makefile.objs
+++ b/remote/Makefile.objs
@@ -1 +1,2 @@
 remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcihost.o
diff --git a/remote/pcihost.c b/remote/pcihost.c
new file mode 100644
index 0000000..dbe0819
--- /dev/null
+++ b/remote/pcihost.c
@@ -0,0 +1,64 @@
+/*
+ * Remote PCI host device
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/qdev-properties.h"
+#include "remote/pcihost.h"
+#include "exec/memory.h"
+
+static const char *remote_host_root_bus_path(PCIHostState *host_bridge,
+                                             PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static void remote_host_realize(DeviceState *dev, Error **errp)
+{
+    char *busname =3D g_strdup_printf("remote-pci-%ld", (unsigned long)g=
etpid());
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
+    RemPCIHost *s =3D REMOTE_HOST_DEVICE(dev);
+
+    pci->bus =3D pci_root_bus_new(DEVICE(s), busname,
+                                s->mr_pci_mem, s->mr_sys_io,
+                                0, TYPE_PCIE_BUS);
+}
+
+static void remote_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
+
+    hc->root_bus_path =3D remote_host_root_bus_path;
+    dc->realize =3D remote_host_realize;
+
+    dc->user_creatable =3D false;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name =3D "pci";
+}
+
+static const TypeInfo remote_host_info =3D {
+    .name =3D TYPE_REMOTE_HOST_DEVICE,
+    .parent =3D TYPE_PCIE_HOST_BRIDGE,
+    .instance_size =3D sizeof(RemPCIHost),
+    .class_init =3D remote_host_class_init,
+};
+
+static void remote_machine_register(void)
+{
+    type_register_static(&remote_host_info);
+}
+
+type_init(remote_machine_register)
--=20
1.8.3.1


