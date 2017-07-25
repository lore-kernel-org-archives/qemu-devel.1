Received: from eggs.gnu.org ([2001:4830:134:3::10]:46088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BN-0002Ba-PL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da7BM-0004P0-QI
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1da7BM-0004NI-Kq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 17:15:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A47CF12BBC
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 21:15:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 25 Jul 2017 16:15:17 -0500
Message-Id: <20170725211523.3998-7-eblake@redhat.com>
In-Reply-To: <20170725211523.3998-1-eblake@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/12] tests/libqos/usb: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com

From: Markus Armbruster <armbru@redhat.com>

Leaving interpolation into JSON to qmp() is more robust than building
QMP input manually, as explained in the previous commit.

The case in usb_test_hotplug() is slightly more complicated: it
interpolates *into* JSON values.  Clean it up by building the values
separately, so we can again leave interpolation to qmp().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1500645206-13559-6-git-send-email-armbru@redhat.com>
[fix commit message typo]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqos/usb.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 0cdfaecda7..f88d4a6a3a 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -40,18 +40,20 @@ void uhci_port_test(struct qhc *hc, int port, uint16_t expect)
 void usb_test_hotplug(const char *hcd_id, const int port,
                       void (*port_check)(void))
 {
+    char id[32];
+    char *bus;
     QDict *response;
-    char  *cmd;

-    cmd = g_strdup_printf("{'execute': 'device_add',"
-                          " 'arguments': {"
-                          "   'driver': 'usb-tablet',"
-                          "   'port': '%d',"
-                          "   'bus': '%s.0',"
-                          "   'id': 'usbdev%d'"
-                          "}}", port, hcd_id, port);
-    response = qmp(cmd);
-    g_free(cmd);
+    sprintf(id, "usbdev%d", port);
+    bus = g_strdup_printf("%s.0", hcd_id);
+    response = qmp("{'execute': 'device_add',"
+                   " 'arguments': {"
+                   "   'driver': 'usb-tablet',"
+                   "   'port': %s,"
+                   "   'bus': %s,"
+                   "   'id': %s"
+                   " }}", id + 6, bus, id);
+    g_free(bus);
     g_assert(response);
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
@@ -60,12 +62,8 @@ void usb_test_hotplug(const char *hcd_id, const int port,
         port_check();
     }

-    cmd = g_strdup_printf("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'usbdev%d'"
-                           "}}", port);
-    response = qmp(cmd);
-    g_free(cmd);
+    response = qmp("{'execute': 'device_del', 'arguments': { 'id': %s }}",
+                   id);
     g_assert(response);
     g_assert(qdict_haskey(response, "event"));
     g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-- 
2.13.3
