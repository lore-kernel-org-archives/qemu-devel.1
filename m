Received: from eggs.gnu.org ([2001:4830:134:3::10]:50989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveS-0000Wk-EA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gYveQ-0000PW-59
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gYveO-0000HY-Du
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:21:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A43889ADC
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:21:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Dec 2018 17:21:25 +0100
Message-Id: <1545063690-10116-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1545063690-10116-1-git-send-email-thuth@redhat.com>
References: <1545063690-10116-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] tests/machine-none: Make test independent
 of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Apart from using qmp() in one spot, this test does not have any
dependencies to the global_qtest variable, so we can simply get
rid of it here by replacing the qmp() with qtest_qmp().

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/machine-none-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
index 2b3b750..4c6d470 100644
--- a/tests/machine-none-test.c
+++ b/tests/machine-none-test.c
@@ -75,6 +75,7 @@ static void test_machine_cpu_cli(void)
     QDict *response;
     const char *arch = qtest_get_arch();
     const char *cpu_model = get_cpu_model_by_arch(arch);
+    QTestState *qts;
 
     if (!cpu_model) {
         if (!(!strcmp(arch, "microblaze") || !strcmp(arch, "microblazeel"))) {
@@ -83,13 +84,13 @@ static void test_machine_cpu_cli(void)
         }
         return; /* TODO: die here to force all targets have a test */
     }
-    global_qtest = qtest_initf("-machine none -cpu '%s'", cpu_model);
+    qts = qtest_initf("-machine none -cpu '%s'", cpu_model);
 
-    response = qmp("{ 'execute': 'quit' }");
+    response = qtest_qmp(qts, "{ 'execute': 'quit' }");
     g_assert(qdict_haskey(response, "return"));
     qobject_unref(response);
 
-    qtest_quit(global_qtest);
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
