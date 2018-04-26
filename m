Received: from eggs.gnu.org ([2001:4830:134:3::10]:43013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd6-0003Bl-3g
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fBjd4-0000e6-Hq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:20:19 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Thu, 26 Apr 2018 19:19:45 +0300
Message-Id: <20180426161958.2872-5-rkagan@virtuozzo.com>
In-Reply-To: <20180426161958.2872-1-rkagan@virtuozzo.com>
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 04/17] iotest 030: skip quorum test
 setup/teardown too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

If quorum driver is not enabled, test 030 skips the corresponding
testcase.  This, however, is insufficient: quorum is first used in the
testsuite's setUp.

To avoid erroring out here, skip setUp/tearDown, too.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 tests/qemu-iotests/030 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 640a6dfd10..6b20ff005e 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -423,6 +423,9 @@ class TestQuorum(iotests.QMPTestCase):
     backing = []
 
     def setUp(self):
+        if not iotests.supports_quorum():
+            return
+
         opts = ['driver=quorum', 'vote-threshold=2']
 
         # Initialize file names and command-line options
@@ -445,6 +448,9 @@ class TestQuorum(iotests.QMPTestCase):
         self.vm.launch()
 
     def tearDown(self):
+        if not iotests.supports_quorum():
+            return
+
         self.vm.shutdown()
         for img in self.children:
             os.remove(img)
-- 
2.14.3
