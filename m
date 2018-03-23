Received: from eggs.gnu.org ([2001:4830:134:3::10]:58722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNv-0007qm-Ix
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezNNs-0005MY-DG
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40730 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezNNs-0005MN-9H
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:09:32 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 23 Mar 2018 22:08:21 +0800
Message-Id: <20180323140821.28957-5-peterx@redhat.com>
In-Reply-To: <20180323140821.28957-1-peterx@redhat.com>
References: <20180323140821.28957-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 4/4] tests: partly revert "qmp:
 introduce QMPCapability"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Revert the tests in the patch 02130314d8 ("qmp: introduce
QMPCapability", 2018-03-19) since we'll disable OOB for now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qmp-test.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index d1fa1cb217..558e83540c 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -80,8 +80,6 @@ static void test_qmp_protocol(void)
     QDict *resp, *q, *ret;
     QList *capabilities;
     QTestState *qts;
-    const QListEntry *entry;
-    QString *qstr;
 
     qts = qtest_init_without_qmp_handshake(common_args);
 
@@ -91,13 +89,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities);
-    entry = qlist_first(capabilities);
-    g_assert(entry);
-    qstr = qobject_to(QString, entry->value);
-    g_assert(qstr);
-    g_assert_cmpstr(qstring_get_str(qstr), ==, "oob");
-    QDECREF(resp);
+    g_assert(capabilities && qlist_empty(capabilities));
 
     /* Test valid command before handshake */
     resp = qtest_qmp(qts, "{ 'execute': 'query-version' }");
-- 
2.14.3
