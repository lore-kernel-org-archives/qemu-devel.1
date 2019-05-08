Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB20C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F6E21655
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F6E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38271 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONfl-0007DM-Cn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:35:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hONcR-0005VL-P1
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hONcQ-00047d-1H
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hONcK-00045G-Ff; Wed, 08 May 2019 10:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BC4C309B15A;
	Wed,  8 May 2019 14:32:17 +0000 (UTC)
Received: from thuth.com (ovpn-116-100.ams2.redhat.com [10.36.116.100])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 76F1C19729;
	Wed,  8 May 2019 14:32:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 16:32:09 +0200
Message-Id: <20190508143209.24350-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 08 May 2019 14:32:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] tests: qpci_unplug_acpi_device_test() should
 not rely on global_qtest
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
	Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libqos functions should not use functions that require global_qtest to
be set, since such library functions could also be used by tests that
deal with multiple test states. Add a parameter to this function to
explicitly specify the test state.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/e1000e-test.c     |  4 +++-
 tests/ivshmem-test.c    |  9 ++++++---
 tests/libqos/pci-pc.c   | 10 +++++-----
 tests/libqos/pci.h      |  2 +-
 tests/virtio-blk-test.c |  3 ++-
 tests/virtio-net-test.c |  4 +++-
 tests/virtio-rng-test.c |  5 ++++-
 7 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
index 77ba8095bb..6a946c0484 100644
--- a/tests/e1000e-test.c
+++ b/tests/e1000e-test.c
@@ -231,8 +231,10 @@ static void test_e1000e_multiple_transfers(void *obj=
, void *data,
=20
 static void test_e1000e_hotplug(void *obj, void *data, QGuestAllocator *=
 alloc)
 {
+    QTestState *qts =3D global_qtest;  /* TODO: get rid of global_qtest =
here */
+
     qtest_qmp_device_add("e1000e", "e1000e_net", "{'addr': '0x06'}");
-    qpci_unplug_acpi_device_test("e1000e_net", 0x06);
+    qpci_unplug_acpi_device_test(qts, "e1000e_net", 0x06);
 }
=20
 static void data_test_clear(void *sockets)
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 227561fbca..a467b8c03d 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -383,18 +383,21 @@ static void test_ivshmem_server(void)
=20
 static void test_ivshmem_hotplug(void)
 {
+    QTestState *qts;
     const char *arch =3D qtest_get_arch();
=20
-    qtest_start("-object memory-backend-ram,size=3D1M,id=3Dmb1");
+    qts =3D qtest_init("-object memory-backend-ram,size=3D1M,id=3Dmb1");
=20
+    global_qtest =3D qts;  /* TODO: Get rid of global_qtest here */
     qtest_qmp_device_add("ivshmem-plain", "iv1",
                          "{'addr': %s, 'memdev': 'mb1'}",
                          stringify(PCI_SLOT_HP));
     if (strcmp(arch, "ppc64") !=3D 0) {
-        qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
+        qpci_unplug_acpi_device_test(qts, "iv1", PCI_SLOT_HP);
     }
=20
-    qtest_end();
+    qtest_quit(qts);
+    global_qtest =3D NULL;
 }
=20
 static void test_ivshmem_memdev(void)
diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
index 407d8aff78..634fedd049 100644
--- a/tests/libqos/pci-pc.c
+++ b/tests/libqos/pci-pc.c
@@ -176,19 +176,19 @@ void qpci_free_pc(QPCIBus *bus)
     g_free(s);
 }
=20
-void qpci_unplug_acpi_device_test(const char *id, uint8_t slot)
+void qpci_unplug_acpi_device_test(QTestState *qts, const char *id, uint8=
_t slot)
 {
     QDict *response;
=20
-    response =3D qmp("{'execute': 'device_del', 'arguments': {'id': %s}}=
",
-                   id);
+    response =3D qtest_qmp(qts, "{'execute': 'device_del',"
+                              " 'arguments': {'id': %s}}", id);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     qobject_unref(response);
=20
-    outb(ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
+    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
=20
-    qmp_eventwait("DEVICE_DELETED");
+    qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
=20
 static void qpci_pc_register_nodes(void)
diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
index 8e1d292a7d..a5389a5845 100644
--- a/tests/libqos/pci.h
+++ b/tests/libqos/pci.h
@@ -123,7 +123,7 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64=
_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
=20
-void qpci_unplug_acpi_device_test(const char *id, uint8_t slot);
+void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_=
t slot);
=20
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr);
 #endif
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index b65365934b..fe1168a90a 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -679,6 +679,7 @@ static void pci_hotplug(void *obj, void *data, QGuest=
Allocator *t_alloc)
 {
     QVirtioPCIDevice *dev1 =3D obj;
     QVirtioPCIDevice *dev;
+    QTestState *qts =3D dev1->pdev->bus->qts;
=20
     /* plug secondary disk */
     qtest_qmp_device_add("virtio-blk-pci", "drv1",
@@ -693,7 +694,7 @@ static void pci_hotplug(void *obj, void *data, QGuest=
Allocator *t_alloc)
     qos_object_destroy((QOSGraphObject *)dev);
=20
     /* unplug secondary disk */
-    qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
+    qpci_unplug_acpi_device_test(qts, "drv1", PCI_SLOT_HP);
 }
=20
 /*
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 0d956f36fe..163126cf07 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -162,13 +162,15 @@ static void stop_cont_test(void *obj, void *data, Q=
GuestAllocator *t_alloc)
=20
 static void hotplug(void *obj, void *data, QGuestAllocator *t_alloc)
 {
+    QVirtioPCIDevice *dev =3D obj;
+    QTestState *qts =3D dev->pdev->bus->qts;
     const char *arch =3D qtest_get_arch();
=20
     qtest_qmp_device_add("virtio-net-pci", "net1",
                          "{'addr': %s}", stringify(PCI_SLOT_HP));
=20
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
-        qpci_unplug_acpi_device_test("net1", PCI_SLOT_HP);
+        qpci_unplug_acpi_device_test(qts, "net1", PCI_SLOT_HP);
     }
 }
=20
diff --git a/tests/virtio-rng-test.c b/tests/virtio-rng-test.c
index 5309c7c8ab..fcb22481bd 100644
--- a/tests/virtio-rng-test.c
+++ b/tests/virtio-rng-test.c
@@ -16,13 +16,16 @@
=20
 static void rng_hotplug(void *obj, void *data, QGuestAllocator *alloc)
 {
+    QVirtioPCIDevice *dev =3D obj;
+    QTestState *qts =3D dev->pdev->bus->qts;
+
     const char *arch =3D qtest_get_arch();
=20
     qtest_qmp_device_add("virtio-rng-pci", "rng1",
                          "{'addr': %s}", stringify(PCI_SLOT_HP));
=20
     if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D 0=
) {
-        qpci_unplug_acpi_device_test("rng1", PCI_SLOT_HP);
+        qpci_unplug_acpi_device_test(qts, "rng1", PCI_SLOT_HP);
     }
 }
=20
--=20
2.21.0


