Received: from eggs.gnu.org ([2001:4830:134:3::10]:51144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45z-0001Bu-HC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds45w-0007YD-DA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds45w-0007Xk-6h
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:36:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49DD7C0587E3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:30 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 13 Sep 2017 17:36:05 +0800
Message-Id: <1505295366-25295-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1505295366-25295-1-git-send-email-peterx@redhat.com>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] libqtest: add qmp_device_add()
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

Since we have qmp_device_del(), pair them up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/libqtest.c | 15 +++++++++++++++
 tests/libqtest.h |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a34d8c4..c7da962 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -925,6 +925,21 @@ QDict *qmp(const char *fmt, ...)
     return response;
 }
 
+void qmp_device_add(const char *args)
+{
+    QDict *response;
+    char *cmd;
+
+    cmd = g_strdup_printf("{'execute': 'device_add',"
+                          " 'arguments': { %s }"
+                          "}", args);
+    response = qmp(cmd);
+    g_free(cmd);
+    g_assert(response);
+    g_assert(!qdict_haskey(response, "error"));
+    QDECREF(response);
+}
+
 void qmp_device_del(const char *id)
 {
     QDict *response1, *response2, *event = NULL;
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 0d48e4b..ecd02ac 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -920,6 +920,15 @@ QDict *qmp_fdv(int fd, const char *fmt, va_list ap);
 QDict *qmp_fd(int fd, const char *fmt, ...);
 
 /**
+ * qmp_device_add:
+ * @args: Parameters for the new device, like:
+ *        "'driver': 'XXX', 'id': 'XXX', 'addr': 'XXX'"
+ *
+ * Create a new device with parameter @args provided.
+ */
+void qmp_device_add(const char *args);
+
+/**
  * qmp_device_del:
  * @id: The device ID to be deleted
  *
-- 
2.7.4
