Received: from eggs.gnu.org ([2001:4830:134:3::10]:51202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds465-0001Ig-N9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds464-0007ce-IQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds464-0007cJ-9v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 640C45F73C
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:39 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 17:36:06 +0800
Message-Id: <1505295366-25295-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1505295366-25295-1-git-send-email-peterx@redhat.com>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] tests: use qmp_device_add() where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, peterx@redhat.com

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqos/pci.c        | 15 +++------------
 tests/libqos/usb.c        | 17 ++++-------------
 tests/usb-hcd-uhci-test.c | 14 ++------------
 tests/usb-hcd-xhci-test.c | 23 +++--------------------
 4 files changed, 12 insertions(+), 57 deletions(-)

diff --git a/tests/libqos/pci.c b/tests/libqos/pci.c
index 2dcdead..7724fcb 100644
--- a/tests/libqos/pci.c
+++ b/tests/libqos/pci.c
@@ -394,21 +394,12 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 void qpci_plug_device_test(const char *driver, const char *id,
                            uint8_t slot, const char *opts)
 {
-    QDict *response;
     char *cmd;
 
-    cmd = g_strdup_printf("{'execute': 'device_add',"
-                          " 'arguments': {"
-                          "   'driver': '%s',"
-                          "   'addr': '%d',"
-                          "   %s%s"
-                          "   'id': '%s'"
-                          "}}", driver, slot,
+    cmd = g_strdup_printf("'driver': '%s', 'addr': '%d',"
+                          "%s%s 'id': '%s'", driver, slot,
                           opts ? opts : "", opts ? "," : "",
                           id);
-    response = qmp(cmd);
+    qmp_device_add(cmd);
     g_free(cmd);
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
 }
diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 973dfdd..4b23373 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -40,21 +40,12 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
 void usb_test_hotplug(const char *hcd_id, const int port,
                       void (*port_check)(void))
 {
-    QDict *response;
     char  *cmd;
 
-    cmd = g_strdup_printf("{'execute': 'device_add',"
-                          " 'arguments': {"
-                          "   'driver': 'usb-tablet',"
-                          "   'port': '%d',"
-                          "   'bus': '%s.0',"
-                          "   'id': 'usbdev%d'"
-                          "}}", port, hcd_id, port);
-    response = qmp(cmd);
-    g_free(cmd);
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    cmd = g_strdup_printf("'driver': 'usb-tablet', 'port': '%d',"
+                          "'bus': '%s.0', 'id': 'usbdev%d'",
+                          port, hcd_id, port);
+    qmp_device_add(cmd);
 
     if (port_check) {
         port_check();
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 7471275..5f26207 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -48,18 +48,8 @@ static void test_uhci_hotplug(void)
 
 static void test_usb_storage_hotplug(void)
 {
-    QDict *response;
-
-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'usb-storage',"
-                   "   'drive': 'drive0',"
-                   "   'id': 'usbdev0'"
-                   "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
-
+    qmp_device_add("'driver': 'usb-storage',"
+                   "'drive': 'drive0', 'id': 'usbdev0'");
     qmp_device_del("usbdev0");
 }
 
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 156f8a3..732b414 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -23,26 +23,9 @@ static void test_xhci_hotplug(void)
 
 static void test_usb_uas_hotplug(void)
 {
-    QDict *response;
-
-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'usb-uas',"
-                   "   'id': 'uas'"
-                   "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
-
-    response = qmp("{'execute': 'device_add',"
-                   " 'arguments': {"
-                   "   'driver': 'scsi-hd',"
-                   "   'drive': 'drive0',"
-                   "   'id': 'scsi-hd'"
-                   "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
+    qmp_device_add("'driver': 'usb-uas', 'id': 'uas'");
+    qmp_device_add("'driver': 'scsi-hd', 'drive': 'drive0',"
+                   "'id': 'scsi-hd'");
 
     /* TODO:
         UAS HBA driver in libqos, to check that
-- 
2.7.4
