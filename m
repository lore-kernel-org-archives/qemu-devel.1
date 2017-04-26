Received: from eggs.gnu.org ([2001:4830:134:3::10]:52213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRT-0000Dd-LA
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3NRR-0006kO-W7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3NRR-0006k1-Qw
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCC697F4AB
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 13:57:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 26 Apr 2017 14:57:05 +0100
Message-Id: <20170426135707.5261-4-dgilbert@redhat.com>
In-Reply-To: <20170426135707.5261-1-dgilbert@redhat.com>
References: <20170426135707.5261-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] libqtest: Ignore QMP events when parsing
 the response for HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com

From: Thomas Huth <thuth@redhat.com>

When running certain HMP commands (like "device_del") via QMP, we
can sometimes get a QMP event in the response first, so that the
"g_assert(ret)" statement in qtest_hmp() triggers and the test
fails. Fix this by ignoring such QMP events while looking for the
real return value from QMP.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1490860207-8302-2-git-send-email-thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Added note to qtest_hmp/qtest_hmpv's header description to say
  it discards events
---
 tests/libqtest.c | 6 ++++++
 tests/libqtest.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 99b1195355..0b0bf1d460 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -588,6 +588,12 @@ char *qtest_hmpv(QTestState *s, const char *fmt, va_list ap)
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
diff --git a/tests/libqtest.h b/tests/libqtest.h
index 2c9962d94f..ee237448da 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -132,11 +132,12 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
 QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 
 /**
- * qtest_hmpv:
+ * qtest_hmp:
  * @s: #QTestState instance to operate on.
  * @fmt...: HMP command to send to QEMU
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
+ * QMP events are discarded.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
@@ -149,6 +150,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...);
  * @ap: HMP command arguments
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
+ * QMP events are discarded.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-- 
2.12.2
