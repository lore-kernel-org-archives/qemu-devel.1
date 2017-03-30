Received: from eggs.gnu.org ([2001:4830:134:3::10]:49404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctUqS-0001VF-2f
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ctUqR-0006Zo-Di
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:50:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ctUqR-0006Xs-8z
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:50:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54B5B1555A
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:50:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Mar 2017 09:50:05 +0200
Message-Id: <1490860207-8302-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1490860207-8302-1-git-send-email-thuth@redhat.com>
References: <1490860207-8302-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] libqtest: Ignore QMP events when
 parsing the response for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

When running certain HMP commands (like "device_del") via QMP, we
can sometimes get a QMP event in the response first, so that the
"g_assert(ret)" statement in qtest_hmp() triggers and the test
fails. Fix this by ignoring such QMP events while looking for the
real return value from QMP.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a5c3d2b..c9b2d76 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -580,6 +580,12 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
                      " 'arguments': {'command-line': %s}}",
                      cmd);
     ret = g_strdup(qdict_get_try_str(resp, "return"));
+    while (ret == NULL && qdict_get_try_str(resp, "event")) {
+        /* Ignore asynchronous QMP events */
+        QDECREF(resp);
+        resp = qtest_qmp_receive(s);
+        ret = g_strdup(qdict_get_try_str(resp, "return"));
+    }
     g_assert(ret);
     QDECREF(resp);
     g_free(cmd);
-- 
1.8.3.1
