Received: from eggs.gnu.org ([2001:4830:134:3::10]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDuy-0000nH-5F
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpDuq-0003sZ-25
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dpDup-0003ry-Qc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:29:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Sep 2017 14:29:06 +0100
Message-Id: <20170905132908.30931-3-stefanha@redhat.com>
In-Reply-To: <20170905132908.30931-1-stefanha@redhat.com>
References: <20170905132908.30931-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] iotests.py: add FilePath context manager
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The scratch/ (TEST_DIR) directory is not automatically cleaned up after
test execution.  It is the responsibility of tests to remove any files
they create.

A nice way of doing this is to declare files at the beginning of the
test and automatically remove them with a context manager:

  with iotests.FilePath('test.img') as img_path:
      qemu_img(...)
      qemu_io(...)
  # img_path is guaranteed to be deleted here

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170824072202.26818-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7233983f3c..07fa1626a0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -160,6 +160,32 @@ class Timeout:
     def timeout(self, signum, frame):
         raise Exception(self.errmsg)
 
+
+class FilePath(object):
+    '''An auto-generated filename that cleans itself up.
+
+    Use this context manager to generate filenames and ensure that the file
+    gets deleted::
+
+        with TestFilePath('test.img') as img_path:
+            qemu_img('create', img_path, '1G')
+        # migration_sock_path is automatically deleted
+    '''
+    def __init__(self, name):
+        filename = '{0}-{1}'.format(os.getpid(), name)
+        self.path = os.path.join(test_dir, filename)
+
+    def __enter__(self):
+        return self.path
+
+    def __exit__(self, exc_type, exc_val, exc_tb):
+        try:
+            os.remove(self.path)
+        except OSError:
+            pass
+        return False
+
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
 
-- 
2.13.5
