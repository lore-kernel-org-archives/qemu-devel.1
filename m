Received: from eggs.gnu.org ([2001:4830:134:3::10]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhI3-0002Rr-8g
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWhHz-0000Nw-9j
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWhHz-0000NX-40
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:28:23 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:27:57 +0000
Message-Id: <20170126102757.23280-2-berrange@redhat.com>
In-Reply-To: <20170126102757.23280-1-berrange@redhat.com>
References: <20170126102757.23280-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1] io: fix possible double free of task error
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

If a QIOTask has an error set and the calling code uses
qio_task_propagate_error() to steal the reference to
that Error object, the task would not clear its own
reference. This would lead to a double-free when
qio_task_free runs, if the caller had (correctly) freed
the Error object they now owned.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/task.c            | 1 +
 tests/test-io-task.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/io/task.c b/io/task.c
index 60bf1a9..3ce5560 100644
--- a/io/task.c
+++ b/io/task.c
@@ -157,6 +157,7 @@ bool qio_task_propagate_error(QIOTask *task,
 {
     if (task->err) {
         error_propagate(errp, task->err);
+        task->err = NULL;
         return true;
     }
 
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index ff62272..141aa2c 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -127,7 +127,7 @@ static void test_task_failure(void)
     g_assert(data.source == obj);
     g_assert(data.err == err);
     g_assert(data.freed == false);
-
+    error_free(data.err);
 }
 
 
@@ -238,6 +238,8 @@ static void test_task_thread_failure(void)
     g_assert(data.source == obj);
     g_assert(data.err != NULL);
 
+    error_free(data.err);
+
     self = g_thread_self();
 
     /* Make sure the test_task_thread_worker actually got
-- 
2.9.3
