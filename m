Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297A9C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE1620730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bud90L7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE1620730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywWK-0000ek-Fc
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQH-0008KT-MP
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQC-0000Dh-M7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51786)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQC-00008T-0h
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113111euoutp029230faded0822d955196827631e723ab~wL6jCVKnH3205332053euoutp02F
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113111euoutp029230faded0822d955196827631e723ab~wL6jCVKnH3205332053euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815871;
 bh=ejRMInsI0eAgVGBJdITPaeVcgEyvGRYngnK3dXvgDzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bud90L7yRcJnxRAxKcYOpbtCFE/j+QN3qzbzc9M1JzArVrxqFB7z6EhD3c8PbAn5I
 lb5Ptj8SXkwn89YVTrL378O9G+lv2mvAfv6pOGYvanfDhPjZOKqr/OHwPBxNq8764I
 tXKMDcycfsoku221ybLWziqF86cNfKZPGOWil4Ak=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204113110eucas1p1d070397e7469d97bbe8bee57d6b79b0a~wL6i1RKr32652426524eucas1p1a;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.10.60698.EF5593E5; Tue,  4
 Feb 2020 11:31:10 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113110eucas1p2f9ab3639730113139730d1853772d100~wL6ifqt0z0684606846eucas1p2G;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113110eusmtrp195b7659a7f76325945a4cb30c6b5e553~wL6ifKT3N2102721027eusmtrp1-;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-67-5e3955fe9775
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.AC.08375.EF5593E5; Tue,  4
 Feb 2020 11:31:10 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113110eusmtip2a9dd98ee43404e462ba57526ef21ea9c~wL6iK_KWY1661216612eusmtip2W;
 Tue,  4 Feb 2020 11:31:10 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 8/9] hw/misc/memexpose: Add simple tests
Date: Tue,  4 Feb 2020 12:30:50 +0100
Message-Id: <1580815851-28887-9-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7djPc7r/Qi3jDFZcMLDYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlrFpw
 jrWgO7Viwe23bA2Mc327GDk5JARMJF7uuMDUxcjFISSwglFi5qnVLBDOF0aJI3eXs0E4nxkl
 tr7vYYJpOd/eyQ5iCwksZ5TY08sI1zGv/zsbSIJNQE1i55HPjCC2iICkxO+u08wgNrNAhsTz
 Wd1gtrCAmcTHZR+Bajg4WARUJc7clwYJ8woESKxZcp8FYpecxM1znWDlnAKBEu/3TAI7VULg
 OpvEhiX/oA5ykXj54h0jhC0s8er4FnYIW0bi9OQeqEH1Ei13dkA1dzBK9K2czgaRsJb4smEp
 C8gRzAKaEut36UOEHSUWfv3ODhKWEOCTuPFWEOJ8PolJ26YzQ4R5JTrahCCq9SS6n9xkgtm6
 rPER1FYPiYMPW6BhuIRR4u2UXpYJjPKzEJYtYGRcxSieWlqcm55abJyXWq5XnJhbXJqXrpec
 n7uJERj9p/8d/7qDcd+fpEOMAhyMSjy8Go4WcUKsiWXFlbmHGCU4mJVEeM/rW8YJ8aYkVlal
 FuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwGjZv7CT7+xZ8+nH3nZf
 PX39a8VpZovpe0vm8v1tUDGo2ftheX75gqvMVzfbWT+sk7xYWndgK2N9X0KAy7f+1ie7T3Y9
 jFs6T/iMQPPzG1b719xzqPnfbrzYVKoy6uqZD507L3tYMe385HktcLvphbh55pP520om9MRI
 Jm1782DDid1pm9YbhmxRYinOSDTUYi4qTgQAJEGnR/oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7r/Qi3jDBZMlrLYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrFpwjrWgO7Viwe23bA2Mc327GDk5
 JARMJM63d7J3MXJxCAksZZS41N3OCpGQkfhxeg0bhC0s8edaFxtE0SdGiQWntzCCJNgE1CR2
 HvkMZosISEr87jrNDGIzC2RJ7Jx9nwnEFhYwk/i47CNQDQcHi4CqxJn70iBhXoEAiTVL7rNA
 zJeTuHmuE6yVUyBQ4v2eSWCtQkA1F3bNYp/AyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+
 7iZGYDBuO/Zz8w7GSxuDDzEKcDAq8fBesLOIE2JNLCuuzD3EKMHBrCTCe17fMk6INyWxsiq1
 KD++qDQntfgQoynQTROZpUST84GRklcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1
 ILUIpo+Jg1OqgZFzqluUvOwFG5fDXccup52/4362dOPsBW+usy9+e3Zz+/YwJXurt/c+v7A0
 rHxXqbvvpY7Juws3dshPtA1+pr53hbg956KdvUffMiTXy7uf4zsR8blgYsA0+TUnTB/q3pp5
 atWXUI/2JREFtX4btytysxmKliX/6F+1Ke9/bAbfks1/FDSuLE5VYinOSDTUYi4qTgQAffb6
 N1wCAAA=
X-CMS-MailID: 20200204113110eucas1p2f9ab3639730113139730d1853772d100
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113110eucas1p2f9ab3639730113139730d1853772d100
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113110eucas1p2f9ab3639730113139730d1853772d100
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113110eucas1p2f9ab3639730113139730d1853772d100@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
index 2142c07..55bc6ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1649,6 +1649,7 @@ F: hw/misc/memexpose/memexpose-msg.c
 F: hw/misc/memexpose/memexpose-pci.c
 F: hw/misc/memexpose/memexpose-memregion.h
 F: hw/misc/memexpose/memexpose-memregion.c
+F: tests/memexpose-test.c
 
 nvme
 M: Keith Busch <keith.busch@intel.com>
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index e6bb4ab..3b580bc 100644
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
 tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(test-util-obj-y) libvhost-user.a
 tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
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


