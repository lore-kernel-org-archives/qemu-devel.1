Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1283DC2D0F0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49252071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdhGlM8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49252071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJH1T-0001r5-0u
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqY-0000gW-II
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqX-0005wl-2Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqW-0005w1-Tc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pTlxa/x9EP+upjPVUSiOgJyID2EhyRKFM+xAXG+zpU=;
 b=ZdhGlM8Mz6rLRN8rHTiAaOY39tbv8y8J/u908m0lcfnjtck/kaZCeTFQbjqVmVerbIpQuJ
 3UJj7kikzgR7osxzAO4hQzDStEl/7SKStqivKRhR17eFNyCZvqNnUL3c91MEJcFIm/9Ngk
 NfwZrtmLF9fmXsrr+f+x3A7nIYltl5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-SCYK1mAUOtWTJfCNoPfK1w-1; Tue, 31 Mar 2020 09:22:22 -0400
X-MC-Unique: SCYK1mAUOtWTJfCNoPfK1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B6E018FF66D;
 Tue, 31 Mar 2020 13:22:21 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE15D1001B28;
 Tue, 31 Mar 2020 13:22:19 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 14/14] qtest: add tulip test case
Date: Tue, 31 Mar 2020 21:21:39 +0800
Message-Id: <1585660899-11228-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

The tulip networking card emulation has an OOB issue in
'tulip_copy_tx_buffers' when the guest provide malformed descriptor.
This test will trigger a ASAN heap overflow crash. To trigger this
issue we can construct the data as following:

1. construct a 'tulip_descriptor'. Its control is set to
'0x7ff | 0x7ff << 11', this will make the 'tulip_copy_tx_buffers's
'len1' and 'len2' to 0x7ff(2047). So 'len1+len2' will overflow
'TULIPState's 'tx_frame' field. This descriptor's 'buf_addr1' and
'buf_addr2' should set to a guest address.

2. write this descriptor to tulip device's CSR4 register. This will
set the 'TULIPState's 'current_tx_desc' field.

3. write 'CSR6_ST' to tulip device's CSR6 register. This will trigger
'tulip_xmit_list_update' and finally calls 'tulip_copy_tx_buffers'.

Following shows the backtrack of crash:

=3D=3D31781=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x628000007cd0 at pc 0x7fe03c5a077a bp 0x7fff05b46770 sp 0x7fff05b45f18
WRITE of size 2047 at 0x628000007cd0 thread T0
    #0 0x7fe03c5a0779  (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x79779)
    #1 0x5575fb6daa6a in flatview_read_continue /home/test/qemu/exec.c:3194
    #2 0x5575fb6daccb in flatview_read /home/test/qemu/exec.c:3227
    #3 0x5575fb6dae66 in address_space_read_full /home/test/qemu/exec.c:324=
0
    #4 0x5575fb6db0cb in address_space_rw /home/test/qemu/exec.c:3268
    #5 0x5575fbdfd460 in dma_memory_rw_relaxed /home/test/qemu/include/syse=
mu/dma.h:87
    #6 0x5575fbdfd4b5 in dma_memory_rw /home/test/qemu/include/sysemu/dma.h=
:110
    #7 0x5575fbdfd866 in pci_dma_rw /home/test/qemu/include/hw/pci/pci.h:78=
7
    #8 0x5575fbdfd8a3 in pci_dma_read /home/test/qemu/include/hw/pci/pci.h:=
794
    #9 0x5575fbe02761 in tulip_copy_tx_buffers hw/net/tulip.c:585
    #10 0x5575fbe0366b in tulip_xmit_list_update hw/net/tulip.c:678
    #11 0x5575fbe04073 in tulip_write hw/net/tulip.c:783

Signed-off-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tests/qtest/Makefile.include |  1 +
 tests/qtest/tulip-test.c     | 91 ++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 92 insertions(+)
 create mode 100644 tests/qtest/tulip-test.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 10a28de..9e5a51d 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -217,6 +217,7 @@ qos-test-obj-y +=3D tests/qtest/es1370-test.o
 qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
 qos-test-obj-y +=3D tests/qtest/megasas-test.o
 qos-test-obj-y +=3D tests/qtest/ne2000-test.o
+qos-test-obj-y +=3D tests/qtest/tulip-test.o
 qos-test-obj-y +=3D tests/qtest/nvme-test.o
 qos-test-obj-y +=3D tests/qtest/pca9552-test.o
 qos-test-obj-y +=3D tests/qtest/pci-test.o
diff --git a/tests/qtest/tulip-test.c b/tests/qtest/tulip-test.c
new file mode 100644
index 0000000..2fb6c4d
--- /dev/null
+++ b/tests/qtest/tulip-test.c
@@ -0,0 +1,91 @@
+/*
+ * QTest testcase for DEC/Intel Tulip 21143
+ *
+ * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "libqos/qgraph.h"
+#include "libqos/pci.h"
+#include "qemu/bitops.h"
+#include "hw/net/tulip.h"
+
+typedef struct QTulip_pci QTulip_pci;
+
+struct QTulip_pci {
+    QOSGraphObject obj;
+    QPCIDevice dev;
+};
+
+static void *tulip_pci_get_driver(void *obj, const char *interface)
+{
+    QTulip_pci *tulip_pci =3D obj;
+
+    if (!g_strcmp0(interface, "pci-device")) {
+        return &tulip_pci->dev;
+    }
+
+    fprintf(stderr, "%s not present in tulip_pci\n", interface);
+    g_assert_not_reached();
+}
+
+static void *tulip_pci_create(void *pci_bus, QGuestAllocator *alloc, void =
*addr)
+{
+    QTulip_pci *tulip_pci =3D g_new0(QTulip_pci, 1);
+    QPCIBus *bus =3D pci_bus;
+
+    qpci_device_init(&tulip_pci->dev, bus, addr);
+    tulip_pci->obj.get_driver =3D tulip_pci_get_driver;
+
+    return &tulip_pci->obj;
+}
+
+static void tulip_large_tx(void *obj, void *data, QGuestAllocator *alloc)
+{
+    QTulip_pci *tulip_pci =3D obj;
+    QPCIDevice *dev =3D &tulip_pci->dev;
+    QPCIBar bar;
+    struct tulip_descriptor context;
+    char guest_data[4096];
+    uint64_t context_pa;
+    uint64_t guest_pa;
+
+    qpci_device_enable(dev);
+    bar =3D qpci_iomap(dev, 0, NULL);
+    context_pa =3D guest_alloc(alloc, sizeof(context));
+    guest_pa =3D guest_alloc(alloc, 4096);
+    memset(guest_data, 'A', sizeof(guest_data));
+    context.status =3D TDES0_OWN;
+    context.control =3D TDES1_BUF2_SIZE_MASK << TDES1_BUF2_SIZE_SHIFT |
+                      TDES1_BUF1_SIZE_MASK << TDES1_BUF1_SIZE_SHIFT;
+    context.buf_addr2 =3D guest_pa;
+    context.buf_addr1 =3D guest_pa;
+
+    qtest_memwrite(dev->bus->qts, context_pa, &context, sizeof(context));
+    qtest_memwrite(dev->bus->qts, guest_pa, guest_data, sizeof(guest_data)=
);
+    qpci_io_writel(dev, bar, 0x20, context_pa);
+    qpci_io_writel(dev, bar, 0x30, CSR6_ST);
+    guest_free(alloc, context_pa);
+    guest_free(alloc, guest_pa);
+}
+
+static void tulip_register_nodes(void)
+{
+    QOSGraphEdgeOptions opts =3D {
+        .extra_device_opts =3D "addr=3D04.0",
+    };
+    add_qpci_address(&opts, &(QPCIAddress) { .devfn =3D QPCI_DEVFN(4, 0) }=
);
+
+    qos_node_create_driver("tulip", tulip_pci_create);
+    qos_node_consumes("tulip", "pci-bus", &opts);
+    qos_node_produces("tulip", "pci-device");
+
+    qos_add_test("tulip_large_tx", "tulip", tulip_large_tx, NULL);
+}
+
+libqos_init(tulip_register_nodes);
--=20
2.5.0


