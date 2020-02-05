Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B040C352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD0821741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dr2vky4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD0821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKnL-0004BA-AI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKja-0007kj-Dq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjY-0004uH-2C
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46835)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004qN-LF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846euoutp0162afb25b7511b36c74395055aeae58b6~whKgg2DS42968129681euoutp01d
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200205132846euoutp0162afb25b7511b36c74395055aeae58b6~whKgg2DS42968129681euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909326;
 bh=v5HP50D6ioOR5ulyJBYlkL4pC4y3uMp9hQG5R8Nz3DQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dr2vky4Wn4hoMRnJYWrLML+xwpLmkW/VSeENRGqh2veKBPgJRwBlBpsR8CT1qZGrx
 I2iuMW7vrTbYgwmpQGX9cfOk2tZyqp3sNsBWpgSnw7GSwB35H+zujOG/iilmBLjwSy
 dSgJo8ELnkERmeKElMpdgwcqbFc7z4ADktxuCxZM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205132846eucas1p196a275e0b99232846414a189750e61c7~whKgRQuP92963229632eucas1p1m;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 26.5F.60679.E03CA3E5; Wed,  5
 Feb 2020 13:28:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132846eucas1p2aafe9a2377abfb6ad4e78b565e719aed~whKf0L_rO0081500815eucas1p2Z;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132846eusmtrp28a79ad7da34aa7649533ae004c14e0c3~whKfznBUu3040630406eusmtrp2H;
 Wed,  5 Feb 2020 13:28:46 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-ff-5e3ac30e5a5d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.FC.07950.D03CA3E5; Wed,  5
 Feb 2020 13:28:45 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132845eusmtip2896830231847c0af531e4bf93233fcbd~whKfZhEH10047800478eusmtip2a;
 Wed,  5 Feb 2020 13:28:45 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 8/9] hw/misc/memexpose: Add simple tests
Date: Wed,  5 Feb 2020 14:28:36 +0100
Message-Id: <1580909317-23884-9-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7p8h63iDBYuk7HYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBk/L/SzFtxLqXh8rJ+1gfGTTxcjJ4eEgInE842/mUFsIYEVjBL9JyW7GLmA7C+M
 Eu1HlzJDOJ8ZJfZuPMwE03F59UGoxHJGidU/frHCtdw//Y8RpIpNQE1i55HPYLaIgKTE767T
 YB3MAg2MEo+unwVLCAvYS/T8bQSzWQRUJa72NIMdwisQIPF36zY2iHVyEjfPdYLFOQUCJS4/
 mwK2TULgPpvEpvM3WboYOYAcF4mTTVIQ9cISr45vYYewZST+75wPdXa9RMudHUwQvR2MEn0r
 p0MtsJb4smEp2BxmAU2J9bv0IcKOEvvWt7FBjOeTuPFWECTMDGRO2jadGSLMK9HRJgRRrSfR
 /eQmE8zWZY2PWCBsD4kPK/rYIOGzhFHi173Z7BMY5WchLFvAyLiKUTy1tDg3PbXYKC+1XK84
 Mbe4NC9dLzk/dxMjMCWc/nf8yw7GXX+SDjEKcDAq8fCumGQZJ8SaWFZcmXuIUYKDWUmE97w+
 UIg3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQZGj2+rOIWd
 VA2PsVT9q0subv7qPGEhby/n/fKbcoVxk7d9zVlkFclc9uD5v959zuXTon4Ex3M++J54/wxL
 uojXXJPmh8lPUn6ab1ziULet7Pde7riacPnCkiBpp+N3p1T+M+ANOLht/74pi6fbhRWX/zv1
 /KT/05LkycGyerYFJY+1eT7a8TkosRRnJBpqMRcVJwIAiebGtwUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7q8h63iDKa/trbYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk/L/SzFtxLqXh8
 rJ+1gfGTTxcjJ4eEgInE5dUHmbsYuTiEBJYySkyas5EVIiEj8eP0GjYIW1jiz7UuNoiiT4wS
 n5/dYgJJsAmoSew88pkRxBYRkJT43XUabBKzQAujxLMn7WBFwgL2Ej1/G8GKWARUJa72NDOD
 2LwCARJ/t26D2iAncfNcJ1icUyBQ4vKzKWBXCAHVvJ54hXkCI98CRoZVjCKppcW56bnFRnrF
 ibnFpXnpesn5uZsYgUG67djPLTsYu94FH2IU4GBU4uENmGAZJ8SaWFZcmXuIUYKDWUmE97w+
 UIg3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPzgRGUVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
 ID2xJDU7NbUgtQimj4mDU6qB0UdJYXXFRcv6w3taNvP7bgxdPY+5Tm+nnXL947wa/rDMazdl
 fKblHny1Lu+DsIWo9u9XySf+XC9a94Jv8WetlLJHbBJVNk6PvAPs/j4LPM38ReJpyIRZ9qYB
 h83TVlxo//vftLyV70UN8/UrH3XOh13/3xe15WJCb6DPE417MYmP/27QjuP/qMRSnJFoqMVc
 VJwIAASkBO9oAgAA
X-CMS-MailID: 20200205132846eucas1p2aafe9a2377abfb6ad4e78b565e719aed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132846eucas1p2aafe9a2377abfb6ad4e78b565e719aed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132846eucas1p2aafe9a2377abfb6ad4e78b565e719aed
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132846eucas1p2aafe9a2377abfb6ad4e78b565e719aed@eucas1p2.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
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


