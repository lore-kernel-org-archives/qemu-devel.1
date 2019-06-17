Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BECC31E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BA42084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rytlw6tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BA42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50972 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwPT-0003Tw-6c
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB5-0005Yt-Br
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwB1-0001po-5q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAz-0001mN-1D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8uWv149284;
 Mon, 17 Jun 2019 18:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=u0KD8hGcmwoPPEuwNGAsbOvcFDGhZdCGGwz4LvnSoPE=;
 b=rytlw6tWvqXPdPxpL1wH46+dxvh3Iqc+Ndl1vn6afpgH1zLGKBtxqlu9Ta7rrSzjG9XS
 bJjsZF94j6oAilSRmHnPMrzp2uGAy3czynWEj068mF2Arn37AvF8JlBDd+Fc5Y17qvOT
 bbr/ouzLHWgkoQvChaTLwDeKfOThhtmhS7tL3k1qUkbZ28nypFDWIwFOOinncTHsaYvL
 qCNa8A57tZJ/TMLPmOE8+ShZ8OKYYASlZIfcrvniugPZz2qXUj+6VNFOu89yx5a7bnMw
 O6D32DaFuIyL4qYBS040cA/9D5eSnc0xrl5TJaI4ygd4vouPApjHR5yOuUbVBNcNtA0p zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF9OB117990;
 Mon, 17 Jun 2019 18:16:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkew5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIGB55028136;
 Mon, 17 Jun 2019 18:16:11 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:11 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:05 -0700
Message-Id: <20190617181605.29863-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 16/35] multi-process: Add LSI device
 proxy object
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Adds proxy-lsi53c895a object, as a derivative of the pci-proxy-dev
object. This object is the proxy for the lsi53c895a object
instantiated by the remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/proxy/Makefile.objs              |   1 +
 hw/proxy/proxy-lsi53c895a.c         | 162 ++++++++++++++++++++++++++++
 include/hw/proxy/proxy-lsi53c895a.h |  42 ++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h

diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index eb81624cf8..f562f5a0e9 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
+common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
diff --git a/hw/proxy/proxy-lsi53c895a.c b/hw/proxy/proxy-lsi53c895a.c
new file mode 100644
index 0000000000..e8a8d36f6e
--- /dev/null
+++ b/hw/proxy/proxy-lsi53c895a.c
@@ -0,0 +1,162 @@
+/*
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
+#include <sys/types.h>
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "qemu/bitops.h"
+#include "hw/pci/pci.h"
+#include "hw/proxy/qemu-proxy.h"
+#include "hw/proxy/proxy-lsi53c895a.h"
+#include "exec/memory.h"
+
+static uint64_t proxy_lsi_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->io_io, addr, size,
+                                  false);
+}
+
+static void proxy_lsi_io_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->io_io, addr, val, size,
+                            false);
+}
+
+static const MemoryRegionOps proxy_lsi_io_ops = {
+    .read = proxy_lsi_io_read,
+    .write = proxy_lsi_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static uint64_t proxy_lsi_ram_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->ram_io, addr, size,
+                                  true);
+}
+
+static void proxy_lsi_ram_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->ram_io, addr, val, size,
+                            true);
+}
+
+static const MemoryRegionOps proxy_lsi_ram_ops = {
+    .read = proxy_lsi_ram_read,
+    .write = proxy_lsi_ram_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t proxy_lsi_mmio_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    return proxy_default_bar_read(PCI_PROXY_DEV(s), &s->mmio_io, addr, size,
+                                  true);
+}
+
+static void proxy_lsi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
+                                 unsigned size)
+{
+    ProxyLSIState *s = opaque;
+
+    proxy_default_bar_write(PCI_PROXY_DEV(s), &s->mmio_io, addr, val, size,
+                            true);
+}
+
+static const MemoryRegionOps proxy_lsi_mmio_ops = {
+    .read = proxy_lsi_mmio_read,
+    .write = proxy_lsi_mmio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void proxy_lsi_realize(PCIProxyDev *dev, Error **errp)
+{
+    ProxyLSIState *s = LSI_PROXY_DEV(dev);
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
+    memory_region_init_io(&s->mmio_io, OBJECT(s), &proxy_lsi_mmio_ops, s,
+                          "proxy-lsi-mmio", 0x400);
+    memory_region_init_io(&s->ram_io, OBJECT(s), &proxy_lsi_ram_ops, s,
+                          "proxy-lsi-ram", 0x2000);
+    memory_region_init_io(&s->io_io, OBJECT(s), &proxy_lsi_io_ops, s,
+                          "proxy-lsi-io", 256);
+
+    pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_io);
+    pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->mmio_io);
+    pci_register_bar(pci_dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ram_io);
+}
+
+static void proxy_lsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pci_class = PCI_DEVICE_CLASS(klass);
+    PCIProxyDevClass *proxy_class = PCI_PROXY_DEV_CLASS(klass);
+
+    proxy_class->realize = proxy_lsi_realize;
+    proxy_class->command = g_strdup("qemu-scsi-dev");
+
+    pci_class->vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
+    pci_class->device_id = PCI_DEVICE_ID_LSI_53C895A;
+    pci_class->class_id = PCI_CLASS_STORAGE_SCSI;
+    pci_class->subsystem_id = 0x1000;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+
+    dc->desc = "LSI Proxy Device";
+}
+
+static const TypeInfo lsi_proxy_dev_type_info = {
+    .name          = TYPE_PROXY_LSI53C895A,
+    .parent        = TYPE_PCI_PROXY_DEV,
+    .instance_size = sizeof(ProxyLSIState),
+    .class_init    = proxy_lsi_class_init,
+};
+
+static void lsi_proxy_dev_register_types(void)
+{
+    type_register_static(&lsi_proxy_dev_type_info);
+}
+
+type_init(lsi_proxy_dev_register_types)
diff --git a/include/hw/proxy/proxy-lsi53c895a.h b/include/hw/proxy/proxy-lsi53c895a.h
new file mode 100644
index 0000000000..8afb8f3fec
--- /dev/null
+++ b/include/hw/proxy/proxy-lsi53c895a.h
@@ -0,0 +1,42 @@
+/*
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
+#ifndef LSI_PROXY_H
+#define LSI_PROXY_H
+
+#include "hw/proxy/qemu-proxy.h"
+
+#define TYPE_PROXY_LSI53C895A "proxy-lsi53c895a"
+
+#define LSI_PROXY_DEV(obj) \
+            OBJECT_CHECK(ProxyLSIState, (obj), TYPE_PROXY_LSI53C895A)
+
+typedef struct ProxyLSIState {
+    PCIProxyDev parent_dev;
+
+    MemoryRegion mmio_io;
+    MemoryRegion ram_io;
+    MemoryRegion io_io;
+
+} ProxyLSIState;
+
+#endif
-- 
2.17.1


