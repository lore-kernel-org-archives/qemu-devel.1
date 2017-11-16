Received: from eggs.gnu.org ([2001:4830:134:3::10]:39571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJue-0001Ai-DF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJud-0001fh-HW
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJud-0001dt-Bg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:08:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:06:09 +0800
Message-Id: <20171116130610.23582-27-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 26/27] tests: qmp-test: verify command batching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

OOB introduced DROP event for flow control.  This should not affect old
QMP clients.  Add a command batching check to make sure of it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 292c5f135a..729ec59b0a 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -78,6 +78,7 @@ static void test_qmp_protocol(void)
     QList *capabilities;
     const QListEntry *entry;
     QString *qstr;
+    int i;
 
     global_qtest = qtest_init_without_qmp_handshake(common_args);
 
@@ -135,6 +136,24 @@ static void test_qmp_protocol(void)
     g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
     QDECREF(resp);
 
+    /*
+     * Test command batching.  In current test OOB is not enabled, we
+     * should be able to run as many commands in batch as we like.
+     * Using 16 (>8, which is OOB queue length) to make sure OOB
+     * won't break existing clients.
+     */
+    for (i = 0; i < 16; i++) {
+        qmp_async("{ 'execute': 'query-version' }");
+    }
+    /* Verify the replies to make sure no command is dropped. */
+    for (i = 0; i < 16; i++) {
+        resp = qmp_receive();
+        /* It should never be dropped.  Each of them should be a reply. */
+        g_assert(qdict_haskey(resp, "return"));
+        g_assert(!qdict_haskey(resp, "event"));
+        QDECREF(resp);
+    }
+
     qtest_end();
 }
 
-- 
2.13.6
