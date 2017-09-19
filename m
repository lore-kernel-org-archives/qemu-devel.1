Received: from eggs.gnu.org ([2001:4830:134:3::10]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duLhG-0001Dt-GC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1duLhF-0006T1-IK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:30 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1duLhF-0006RW-AK
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:48:29 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 19 Sep 2017 19:48:03 +0300
Message-id: <1505839684-10046-10-git-send-email-a.perevalov@samsung.com>
In-reply-to: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164826eucas1p249e6e9759612d74cd5c69bd375a01cd9@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v10 09/10] migration: add blocktime calculation
 into postcopy-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, quintela@redhat.com, heetae82.ahn@samsung.com

This patch just requests blocktime calculation, but doesn't
add any facility to check or show it.

Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
---
 tests/postcopy-test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2a..1db5359 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -425,6 +425,17 @@ static void test_migrate(void)
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
+#ifdef UFFD_FEATURE_THREAD_ID
+    global_qtest = to;
+    rsp = qmp("{ 'execute': 'migrate-set-capabilities',"
+                  "'arguments': { "
+                      "'capabilities': [ {"
+                          "'capability': 'postcopy-blocktime',"
+                          "'state': true } ] } }");
+    g_assert(qdict_haskey(rsp, "return"));
+    QDECREF(rsp);
+#endif
+
     /* We want to pick a speed slow enough that the test completes
      * quickly, but that it doesn't complete precopy even on a slow
      * machine, so also set the downtime.
@@ -441,7 +452,6 @@ static void test_migrate(void)
     g_assert(qdict_haskey(rsp, "return"));
     QDECREF(rsp);
 
-
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-- 
1.9.1
