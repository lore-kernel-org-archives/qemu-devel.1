Received: from eggs.gnu.org ([2001:4830:134:3::10]:51041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45q-000135-Qh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45p-0007Ur-Qr
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds45p-0007Ue-Iy
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3570806A0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:24 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 17:36:03 +0800
Message-Id: <1505295366-25295-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1505295366-25295-1-git-send-email-peterx@redhat.com>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] libqtest: add qmp_device_del()
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

Device deletion is tricky since we'll get both a response and an event,
while the order of arrival may vary.  Provide a helper to handle this
complexity.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqtest.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/libqtest.h |  8 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index b9a1f18..a34d8c4 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -925,6 +925,54 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }
 
+void qmp_device_del(const char *id)
+{
+    QDict *response1, *response2, *event = NULL;
+    char *cmd;
+
+    /*
+     * device deletion will get one response and one event. E.g.:
+     *
+     * {'execute': 'device_del','arguments': { 'id': 'scsi-hd'}}
+     *
+     * will get this one:
+     *
+     * {"timestamp": {"seconds": 1505289667, "microseconds": 569862},
+     *  "event": "DEVICE_DELETED", "data": {"device": "scsi-hd",
+     *  "path": "/machine/peripheral/scsi-hd"}}
+     *
+     * and this one:
+     *
+     * {"return": {}}
+     *
+     * But the order of arrival may vary.  Detect both.
+     */
+
+    cmd = g_strdup_printf("{'execute': 'device_del',"
+                          " 'arguments': {"
+                          "   'id': '%s'"
+                          "}}", id);
+    response1 = qmp(cmd);
+    g_free(cmd);
+    g_assert(response1);
+    g_assert(!qdict_haskey(response1, "error"));
+
+    response2 = qmp("");
+    g_assert(response2);
+    g_assert(!qdict_haskey(response2, "error"));
+
+    if (qdict_haskey(response1, "event")) {
+        event = response1;
+    } else if (qdict_haskey(response2, "event")) {
+        event = response2;
+    }
+    g_assert(event);
+    g_assert(!strcmp(qdict_get_str(event, "event"), "DEVICE_DELETED"));
+
+    QDECREF(response1);
+    QDECREF(response2);
+}
+
 void qmp_async(const char *fmt, ...)
 {
     va_list ap;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 3ae5709..0d48e4b 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -920,6 +920,14 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
 QDict *qmp_fd(int fd, const char *fmt, ...);
 
 /**
+ * qmp_device_del:
+ * @id: The device ID to be deleted
+ *
+ * Delete the device with ID @id from QMP interface.
+ */
+void qmp_device_del(const char *id);
+
+/**
  * qtest_cb_for_every_machine:
  * @cb: Pointer to the callback function
  *
-- 
2.7.4
