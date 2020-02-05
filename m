Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4448C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06A82082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CzJ0CygX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06A82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH92-0007k7-Rs
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3j-0000oN-NX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3g-0005Hv-K4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3g-0004tO-7o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093317euoutp015307305565e66d32fd9375a9ae30ae98~wd85Vs1Y_2272522725euoutp01y
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205093317euoutp015307305565e66d32fd9375a9ae30ae98~wd85Vs1Y_2272522725euoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895197;
 bh=v5HP50D6ioOR5ulyJBYlkL4pC4y3uMp9hQG5R8Nz3DQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CzJ0CygXrniTb5uny8LT4/xGFRL67m+ZsoiqqxnRpdkdOnXUDt7dyUtKnWoGkkIEd
 irmLIwjzgAtufPZFefd13MP418OFjNrNsGd1hvLff7heP7Rg25Day3pTBmL2F1X9YN
 EoiK89FTqTJnpG3A2G3rHhjo4GsoxvEzxf8FfqLg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eucas1p145f5fb66adbfc7b10647e79fb2be701c~wd84-ansJ3063030630eucas1p1g;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.9A.60698.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093316eucas1p17ba08bfb90d6ddbf3fe5d10c1ee798f0~wd84xNQEF3269932699eucas1p1a;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093316eusmtrp15bffceee97e16800f077f220a349b9f9~wd84woqwJ1029010290eusmtrp1h;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c6-5e3a8bdc3cf1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 40.9D.08375.CDB8A3E5; Wed,  5
 Feb 2020 09:33:16 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093316eusmtip28fa9f5cac715e83348550134f511cc33~wd84QrtoM3043930439eusmtip2C;
 Wed,  5 Feb 2020 09:33:16 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 8/9] hw/misc/memexpose: Add simple tests
Date: Wed,  5 Feb 2020 10:33:04 +0100
Message-Id: <1580895185-24341-9-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djPc7p3uq3iDKb0mlrsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYorhsUlJzMstSi/TtErgyfl7o
 Zy24l1Lx+Fg/awPjJ58uRk4OCQETie3Tmxm7GLk4hARWMEpc65jEBuF8YZRoPbkIyvnMKHF8
 zkRWmJbZpx6yQCSWM0ocWrSbFa6lYeYMRpAqNgE1iZ1HPoPZIgKSEr+7TjOD2MwCGRLPZ3WD
 2cIC9hIXnr5iAbFZBFQlnu+dxwRi8woESNy5Pg1qm5zEzXOdYPWcAoESmz59BDtJQuAym8TE
 ydsYIYpcJKY/XcQEYQtLvDq+hR3ClpE4PbmHBcKul2i5s4MJormDUaJv5XQ2iIS1xJcNS4GK
 OICu05RYv0sfIuwosfjIK0aQsIQAn8SNt4IQ9/NJTNo2nRkizCvR0SYEUa0n0f3kJhPM1mWN
 j6C2ekg0X+2AhuISRolj7fvZJjDKz0JYtoCRcRWjeGppcW56arFxXmq5XnFibnFpXrpecn7u
 JkZgAjj97/jXHYz7/iQdYhTgYFTi4Q2YYBknxJpYVlyZe4hRgoNZSYT3vD5QiDclsbIqtSg/
 vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBkaF3edPRCfMWOUvsExw65n1
 dhGK8x+xSNxR4dn49cTh91eKA+PcsqtMrhkcMnpxfOH8LZ/eN9RrZ5ydx5DQVHq/TPj/tqbM
 csXzgg9zrJ0qpOd1Op6/rM3CFNP7hEdTw+ti7PTI1fGfQnIc1BSmms6advpHfJBUd6XoklbD
 48xx69vWV78J/6rEUpyRaKjFXFScCACnQ0kh/AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xe7p3uq3iDPpXqVrsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYovRsivJLS1IVMvKLS2yVog0t
 jPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyfl7oZy24l1Lx+Fg/awPjJ58uRk4O
 CQETidmnHrJ0MXJxCAksZZTYsXI1O0RCRuLH6TVsELawxJ9rXWwQRZ8YJb5um8kEkmATUJPY
 eeQzI4gtIiAp8bvrNDOIzSyQJbFz9n2wGmEBe4kLT1+xgNgsAqoSz/fOA4vzCgRI3Lk+jRVi
 gZzEzXOdYL2cAoESmz59BFssBFRz7etX1gmMfAsYGVYxiqSWFuem5xYb6hUn5haX5qXrJefn
 bmIEhuO2Yz8372C8tDH4EKMAB6MSD++KSZZxQqyJZcWVuYcYJTiYlUR4z+sDhXhTEiurUovy
 44tKc1KLDzGaAh01kVlKNDkfGCt5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtS
 i2D6mDg4pRoY0xU9+m4aq+k4ezZ+TQiNurTo5XN5Jqsbc5XfTrZfePvCrZ/PNlUw3mEpb1pt
 c0/i2aKlKbIvwswWP9GTv3qzg6NUvMPA50DFx1Pfr25jy3+5RfKk4t2LRhKmJzpLV200iGb6
 evXT50mRbY9MHqZMLeZ9kNA45cJBO/Yms/tmESurs3fb7ru6TYmlOCPRUIu5qDgRAHcHwa1d
 AgAA
X-CMS-MailID: 20200205093316eucas1p17ba08bfb90d6ddbf3fe5d10c1ee798f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093316eucas1p17ba08bfb90d6ddbf3fe5d10c1ee798f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093316eucas1p17ba08bfb90d6ddbf3fe5d10c1ee798f0
References: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205093316eucas1p17ba08bfb90d6ddbf3fe5d10c1ee798f0@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 MAINTAINERS                  |   1 +
 tests/qtest/Makefile.include |   2 +
 tests/qtest/memexpose-test.c | 364 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 tests/qtest/memexpose-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e016cff..6f30382 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1650,6 +1650,7 @@ F: hw/misc/memexpose/memexpose-msg.c
 F: hw/misc/memexpose/memexpose-pci.c
 F: hw/misc/memexpose/memexpose-memregion.h
 F: hw/misc/memexpose/memexpose-memregion.c
+F: tests/qtest/memexpose-test.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index eb0f23b..f19da40 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -14,6 +14,7 @@ check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
 check-qtest-pci-$(CONFIG_VGA) += display-vga-test
 check-qtest-pci-$(CONFIG_HDA) += intel-hda-test
 check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) += ivshmem-test
+check-qtest-x86_64-$(CONFIG_MEMEXPOSE) += memexpose-test
 
 DBUS_DAEMON := $(shell which dbus-daemon 2>/dev/null)
 ifneq ($(GDBUS_CODEGEN),)
@@ -289,6 +290,7 @@ tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o $(qtes
 tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redirector.o $(qtest-obj-y)
 tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-compat.o $(qtest-obj-y)
 tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/qtest/memexpose-test$(EXESUF): tests/qtest/memexpose-test.o $(libqos-pc-obj-y)
 tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o tests/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
 tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
diff --git a/tests/qtest/memexpose-test.c b/tests/qtest/memexpose-test.c
new file mode 100644
index 0000000..70a8a73
--- /dev/null
+++ b/tests/qtest/memexpose-test.c
@@ -0,0 +1,364 @@
+/*
+ *  Memexpose PCI device
+ *
+ *  Copyright (C) 2020 Samsung Electronics Co Ltd.
+ *    Igor Kotrasinski, <i.kotrasinsk@partner.samsung.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ *  for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+#include "libqos/libqos-pc.h"
+#include "libqtest-single.h"
+#include "hw/misc/memexpose/memexpose-core.h"
+
+static char *tmpshm;
+static char *tmpdir;
+
+static void save_fn(QPCIDevice *dev, int devfn, void *data)
+{
+    QPCIDevice **pdev = (QPCIDevice **) data;
+
+    *pdev = dev;
+}
+
+static QPCIDevice *get_device(QPCIBus *pcibus)
+{
+    QPCIDevice *dev;
+
+    dev = NULL;
+    qpci_device_foreach(pcibus, 0x1af4, 0x1111, save_fn, &dev);
+    g_assert(dev != NULL);
+
+    return dev;
+}
+
+typedef struct _MexpState {
+    QOSState *qs;
+    QPCIBar reg_bar, mem_bar;
+    QPCIDevice *dev;
+} MexpState;
+
+
+static inline void read_mexp_mem(MexpState *s, uint64_t off,
+                                 void *buf, size_t len)
+{
+    qpci_memread(s->dev, s->mem_bar, off, buf, len);
+}
+
+static inline void write_mexp_mem(MexpState *s, uint64_t off,
+                                  const void *buf, size_t len)
+{
+    qpci_memwrite(s->dev, s->mem_bar, off, buf, len);
+}
+
+static inline void read_mem(MexpState *s, uint64_t off,
+                            void *buf, size_t len)
+{
+    char *cbuf = buf;
+    for (size_t i = 0; i < len; i++) {
+        cbuf[i] = qtest_readb(s->qs->qts, off + i);
+    }
+}
+
+static inline void write_mem(MexpState *s, uint64_t off,
+                             const void *buf, size_t len)
+{
+    const char *cbuf = buf;
+    for (size_t i = 0; i < len; i++) {
+        qtest_writeb(s->qs->qts, off + i, cbuf[i]);
+    }
+}
+
+static inline void write_mexp_reg(MexpState *s, uint64_t off,
+                                  uint64_t val)
+{
+    qpci_io_writeq(s->dev, s->reg_bar, off, val);
+}
+
+static inline uint64_t read_mexp_reg(MexpState *s, uint64_t off)
+{
+    return qpci_io_readq(s->dev, s->reg_bar, off);
+}
+
+static void mexp_send_intr(MexpState *s, uint64_t type,
+                           uint64_t data)
+{
+    uint64_t send = 1;
+    write_mexp_reg(s, MEMEXPOSE_INTR_TX_TYPE_ADDR, type);
+    write_mexp_reg(s, MEMEXPOSE_INTR_TX_DATA_ADDR, data);
+    write_mexp_reg(s, MEMEXPOSE_INTR_SEND_ADDR, send);
+}
+
+static uint64_t mexp_recv_intr(MexpState *s, uint64_t *type,
+                               uint64_t *data)
+{
+    uint64_t recv = 0;
+    int tries = 0;
+    while (recv == 0 && tries < 100) {
+        recv = read_mexp_reg(s, MEMEXPOSE_INTR_RECV_ADDR);
+        if (recv) {
+            break;
+        }
+        tries++;
+        g_usleep(10000);
+    }
+    *type = read_mexp_reg(s, MEMEXPOSE_INTR_RX_TYPE_ADDR);
+    *data = read_mexp_reg(s, MEMEXPOSE_INTR_RX_DATA_ADDR);
+    return recv;
+}
+
+static void setup_vm_cmd(MexpState *s, const char *cmd, bool msix)
+{
+    uint64_t barsize;
+    const char *arch = qtest_get_arch();
+
+    if (strcmp(arch, "x86_64") == 0) {
+        s->qs = qtest_pc_boot(cmd);
+    } else {
+        g_printerr("memexpose-test tests are only available on x86_64\n");
+        exit(EXIT_FAILURE);
+    }
+    s->dev = get_device(s->qs->pcibus);
+    s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
+    g_assert_cmpuint(barsize, ==, MEMEXPOSE_INTR_MEM_SIZE);
+
+    if (msix) {
+        qpci_msix_enable(s->dev);
+    }
+
+    s->mem_bar = qpci_iomap(s->dev, 1, &barsize);
+
+    qpci_device_enable(s->dev);
+}
+
+static void remove_socks(char *tmp_path)
+{
+    char *memsock = g_strdup_printf("%s/qemu-mexp-mem", tmp_path);
+    g_remove(memsock);
+    g_free(memsock);
+
+    char *intsock = g_strdup_printf("%s/qemu-mexp-mem", tmp_path);
+    g_remove(intsock);
+    g_free(intsock);
+}
+static void add_socks(char *tmp_path)
+{
+    char *memsock = g_strdup_printf("%s/qemu-mexp-mem", tmp_path);
+    mkfifo(memsock, 0700);
+    g_free(memsock);
+
+    char *intsock = g_strdup_printf("%s/qemu-mexp-mem", tmp_path);
+    mkfifo(intsock, 0700);
+    g_free(intsock);
+}
+
+static void setup_vm(MexpState *s, int server)
+{
+    unsigned long shm_size = 1 << 28;
+    const char *socksrv = server ? "server,nowait," : "";
+    char *cmd = g_strdup_printf("-mem-path %s "
+                                "-device memexpose-pci,mem_chardev=mem-mem,"
+                                "intr_chardev=mem-intr,shm_size=0x%lx "
+                                "-chardev socket,%spath=%s/qemu-mexp-mem,id=mem-mem "
+                                "-chardev socket,%spath=%s/qemu-mexp-intr,id=mem-intr",
+                                tmpshm, shm_size,
+                                socksrv, tmpdir, socksrv, tmpdir);
+    setup_vm_cmd(s, cmd, false);
+    g_free(cmd);
+}
+
+static void cleanup_vm(MexpState *s)
+{
+    assert(!global_qtest);
+    g_free(s->dev);
+    qtest_shutdown(s->qs);
+}
+
+static void setup_connected_vms(MexpState *s1, MexpState *s2)
+{
+    remove_socks(tmpdir);
+    add_socks(tmpdir);
+    setup_vm(s1, 1);
+    setup_vm(s2, 0);
+
+    write_mexp_reg(s1, MEMEXPOSE_INTR_ENABLE_ADDR, 1);
+    write_mexp_reg(s2, MEMEXPOSE_INTR_ENABLE_ADDR, 1);
+}
+
+static void test_memexpose_simple_memshare(void)
+{
+    size_t sixty_four_megs = 1 << (20 + 6);
+    uint32_t in, out;
+
+    MexpState s1, s2;
+    setup_connected_vms(&s1, &s2);
+
+    in = 0xdeadbeef;
+    write_mem(&s1, sixty_four_megs, &in, 4);
+    read_mexp_mem(&s2, sixty_four_megs, &out, 4);
+    g_assert_cmphex(in, ==, out);
+    in = 0xbaba1510;
+    write_mem(&s1, sixty_four_megs, &in, 4);
+    read_mexp_mem(&s2, sixty_four_megs, &out, 4);
+    g_assert_cmphex(in, ==, out);
+
+    in = 0xaaaaaaaa;
+    write_mexp_mem(&s1, sixty_four_megs, &in, 4);
+    read_mem(&s2, sixty_four_megs, &out, 4);
+    g_assert_cmphex(in, ==, out);
+    in = 0xbbbbbbbb;
+    write_mexp_mem(&s1, sixty_four_megs, &in, 4);
+    read_mem(&s2, sixty_four_megs, &out, 4);
+    g_assert_cmphex(in, ==, out);
+
+    cleanup_vm(&s1);
+    cleanup_vm(&s2);
+}
+
+static void test_memexpose_simple_interrupts(void)
+{
+    MexpState s1, s2;
+    setup_connected_vms(&s1, &s2);
+
+    mexp_send_intr(&s1, 0x1, 0xdeadbea7);
+    mexp_send_intr(&s1, 0x2, 0xdeadbaba);
+
+    uint64_t type, data, received;
+
+    received = mexp_recv_intr(&s2, &type, &data);
+    g_assert_cmpuint(received, ==, 1);
+    g_assert_cmphex(type, ==, 0x1);
+    g_assert_cmphex(data, ==, 0xdeadbea7);
+
+    received = mexp_recv_intr(&s2, &type, &data);
+    g_assert_cmpuint(received, ==, 1);
+    g_assert_cmphex(type, ==, 0x2);
+    g_assert_cmphex(data, ==, 0xdeadbaba);
+
+    cleanup_vm(&s1);
+    cleanup_vm(&s2);
+}
+
+static void test_memexpose_overfull_intr_queue(void)
+{
+    MexpState s1, s2;
+    setup_connected_vms(&s1, &s2);
+
+    unsigned int i, expected, runs = MEMEXPOSE_INTR_QUEUE_SIZE + 10;
+    uint64_t type, data;
+
+    for (i = 0; i < runs; i++) {
+        mexp_send_intr(&s1, i, i);
+    }
+
+    expected = 0;
+    while (mexp_recv_intr(&s2, &type, &data)) {
+        if (expected < MEMEXPOSE_INTR_QUEUE_SIZE) {
+            g_assert_cmphex(type, ==, expected);
+            g_assert_cmphex(data, ==, expected);
+            expected += 1;
+        } else {
+            g_assert_cmphex(type, >, expected);
+            g_assert_cmphex(type, <, runs);
+            g_assert_cmphex(data, >, expected);
+            g_assert_cmphex(data, <, runs);
+            expected = type;
+        }
+    }
+    g_assert_cmpuint(expected, >=, MEMEXPOSE_INTR_QUEUE_SIZE - 1);
+
+    cleanup_vm(&s1);
+    cleanup_vm(&s2);
+}
+
+static void test_memexpose_intr_data(void)
+{
+    MexpState s1, s2;
+    setup_connected_vms(&s1, &s2);
+
+    unsigned int i;
+    uint64_t type, data, received;
+
+    uint64_t send = 1;
+    write_mexp_reg(&s1, MEMEXPOSE_INTR_TX_TYPE_ADDR, 0);
+    for (i = 0; i < MEMEXPOSE_MAX_INTR_DATA_SIZE; i += 8) {
+        write_mexp_reg(&s1, MEMEXPOSE_INTR_TX_DATA_ADDR + i, i);
+    }
+    write_mexp_reg(&s1, MEMEXPOSE_INTR_SEND_ADDR, send);
+
+    received = mexp_recv_intr(&s2, &type, &data);
+    g_assert_cmpuint(received, ==, 1);
+    for (i = 0; i < MEMEXPOSE_MAX_INTR_DATA_SIZE; i += 8) {
+        data = read_mexp_reg(&s1, MEMEXPOSE_INTR_TX_DATA_ADDR + i);
+        g_assert_cmphex(data, ==, i);
+    }
+
+    cleanup_vm(&s1);
+    cleanup_vm(&s2);
+}
+
+static void cleanup(void)
+{
+    if (tmpshm) {
+        g_rmdir(tmpshm);
+        tmpshm = NULL;
+    }
+
+    if (tmpdir) {
+        remove_socks(tmpdir);
+        g_rmdir(tmpdir);
+        tmpdir = NULL;
+    }
+}
+
+static void abrt_handler(void *data)
+{
+    cleanup();
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    gchar dir[] = "/tmp/memexpose-test.XXXXXX";
+    gchar shmdir[] = "/dev/shm/memexpose-test.XXXXXX";
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_abrt_handler(abrt_handler, NULL);
+
+    if (mkdtemp(dir) == NULL) {
+        g_error("mkdtemp: %s", g_strerror(errno));
+        goto out;
+    }
+    tmpdir = dir;
+    if (mkdtemp(shmdir) == NULL) {
+        g_error("mkdtemp: %s", g_strerror(errno));
+        goto out;
+    }
+    tmpshm = shmdir;
+
+    qtest_add_func("/memexpose/memory", test_memexpose_simple_memshare);
+    qtest_add_func("/memexpose/interrupts", test_memexpose_simple_interrupts);
+    qtest_add_func("/memexpose/interrupts_full_queue",
+                   test_memexpose_overfull_intr_queue);
+    qtest_add_func("/memexpose/interrupts_all_data", test_memexpose_intr_data);
+    ret = g_test_run();
+
+out:
+    cleanup();
+    return ret;
+}
-- 
2.7.4


