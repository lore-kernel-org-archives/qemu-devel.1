Received: from eggs.gnu.org ([2001:4830:134:3::10]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45u-00016J-1y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45t-0007WA-0J
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds45s-0007Vh-OQ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C724713A49
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 17:36:04 +0800
Message-Id: <1505295366-25295-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1505295366-25295-1-git-send-email-peterx@redhat.com>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] tests: use qmp_device_del() where proper
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
 tests/libqos/usb.c        | 11 ++---------
 tests/usb-hcd-uhci-test.c | 14 +-------------
 tests/usb-hcd-xhci-test.c | 29 ++---------------------------
 3 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 0cdfaec..973dfdd 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -60,14 +60,7 @@ void usb_test_hotplug(const char *hcd_id, const int port,
         port_check();
     }
 
-    cmd = g_strdup_printf("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'usbdev%d'"
-                           "}}", port);
-    response = qmp(cmd);
+    cmd = g_strdup_printf("usbdev%d", port);
+    qmp_device_del(cmd);
     g_free(cmd);
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
 }
diff --git a/tests/usb-hcd-uhci-test.c b/tests/usb-hcd-uhci-test.c
index 5b500fe..7471275 100644
--- a/tests/usb-hcd-uhci-test.c
+++ b/tests/usb-hcd-uhci-test.c
@@ -60,19 +60,7 @@ static void test_usb_storage_hotplug(void)
     g_assert(!qdict_haskey(response, "error"));
     QDECREF(response);
 
-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'usbdev0'"
-                           "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
-
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_device_del("usbdev0");
 }
 
 int main(int argc, char **argv)
diff --git a/tests/usb-hcd-xhci-test.c b/tests/usb-hcd-xhci-test.c
index 031764d..156f8a3 100644
--- a/tests/usb-hcd-xhci-test.c
+++ b/tests/usb-hcd-xhci-test.c
@@ -49,33 +49,8 @@ static void test_usb_uas_hotplug(void)
         added disk is visible after BUS rescan
     */
 
-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'scsi-hd'"
-                           "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
-
-    response = qmp("");
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
-
-
-    response = qmp("{'execute': 'device_del',"
-                           " 'arguments': {"
-                           "   'id': 'uas'"
-                           "}}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    QDECREF(response);
-
-    response = qmp("");
-    g_assert(response);
-    g_assert(qdict_haskey(response, "event"));
-    g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED"));
-    QDECREF(response);
+    qmp_device_del("scsi-hd");
+    qmp_device_del("uas");
 }
 
 int main(int argc, char **argv)
-- 
2.7.4
