Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC0CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E46205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fiRdT/MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E46205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZGa-0001dY-Ky
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8j-0006Nz-AP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8h-0004B0-NN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59810)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8h-0004AY-FS
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94n9I100030;
 Thu, 24 Oct 2019 09:10:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=vKjhWVPZm7/SLDQnb0NCXeve3bJ0wUWGN6XOviUNcXE=;
 b=fiRdT/MYEBcJ6SyQUs9/HaRa/p8XmWjEDP1rUYp+CUTDMgZSa+zYrfKtLn6o1Gi77gl/
 mOQcR+hZly/5UriH74JVNHZGgYSQuIqYbTKp1MYplUQHRl6EypqTLbAxUi9hMPOR5KtH
 Zr3UfoQSQBxvgbZpdiUVHBI4mSuNvYQSTPj8teT/aJQCAWGWUj/rR4xVyQXFoxid7WUX
 LIyAubNKGJloot/u9zkE6FDM+WfQaet5i9+ghJG85z6qUUo7TcAycVjmZsjSnlVgnWFU
 xb7bqFvjZmiU+AQUIc/GAmUCznZ3Y1ae/qvzPiHs2qejAIzNQKtNUqwpBv+os7VMqgao +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2vqteq2af6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O97jh6170576;
 Thu, 24 Oct 2019 09:10:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2vtsk486ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9AVUK011830;
 Thu, 24 Oct 2019 09:10:31 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:10:30 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 16/49] multi-process: Add LSI device proxy object
Date: Thu, 24 Oct 2019 05:08:57 -0400
Message-Id: <d3c12e52cf27ac11a5a0ce3462786f55aca3a04c.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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

Adds proxy-lsi53c895a object, as a derivative of the pci-proxy-dev
object. This object is the proxy for the lsi53c895a object
instantiated by the remote process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 hw/proxy/Makefile.objs              |  1 +
 hw/proxy/proxy-lsi53c895a.c         | 91 +++++++++++++++++++++++++++++++++++++
 include/hw/proxy/proxy-lsi53c895a.h | 42 +++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 hw/proxy/proxy-lsi53c895a.c
 create mode 100644 include/hw/proxy/proxy-lsi53c895a.h

diff --git a/hw/proxy/Makefile.objs b/hw/proxy/Makefile.objs
index eb81624..f562f5a 100644
--- a/hw/proxy/Makefile.objs
+++ b/hw/proxy/Makefile.objs
@@ -1 +1,2 @@
 common-obj-$(CONFIG_MPQEMU) += qemu-proxy.o
+common-obj-$(CONFIG_MPQEMU) += proxy-lsi53c895a.o
diff --git a/hw/proxy/proxy-lsi53c895a.c b/hw/proxy/proxy-lsi53c895a.c
new file mode 100644
index 0000000..7734ae2
--- /dev/null
+++ b/hw/proxy/proxy-lsi53c895a.c
@@ -0,0 +1,91 @@
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
+static void proxy_lsi_realize(PCIProxyDev *dev, Error **errp)
+{
+    ProxyLSIState *s = LSI_PROXY_DEV(dev);
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+    uint8_t *pci_conf = pci_dev->config;
+
+    pci_conf[PCI_LATENCY_TIMER] = 0xff;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01;
+
+    dev->region[0].present = true;
+    dev->region[0].type = PCI_BASE_ADDRESS_SPACE_IO;
+    memory_region_init_io(&dev->region[0].mr, OBJECT(s), &proxy_default_ops,
+                          &dev->region[0], "proxy-lsi-io", 256);
+
+    dev->region[1].present = true;
+    dev->region[1].memory = true;
+    dev->region[1].type = PCI_BASE_ADDRESS_SPACE_MEMORY;
+    memory_region_init_io(&dev->region[1].mr, OBJECT(s), &proxy_default_ops,
+                          &dev->region[1], "proxy-lsi-mmio", 0x400);
+
+    dev->region[2].present = true;
+    dev->region[2].memory = true;
+    dev->region[2].type = PCI_BASE_ADDRESS_SPACE_MEMORY;
+    memory_region_init_io(&dev->region[2].mr, OBJECT(s), &proxy_default_ops,
+                          &dev->region[2], "proxy-lsi-ram", 0x2000);
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
index 0000000..8afb8f3
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
1.8.3.1


