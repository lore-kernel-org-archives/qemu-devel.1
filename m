Received: from eggs.gnu.org ([2001:4830:134:3::10]:60822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLo4-0001zH-BR
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eRLo3-0001P1-Eh
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 12:35:56 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 19 Dec 2017 14:34:23 -0300
Message-Id: <20171219173425.8113-8-f4bug@amsat.org>
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
References: <20171219173425.8113-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 7/9] iotests: replace lambda function by lambda
 expression for python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/qemu-iotests/065 | 4 ++--
 tests/qemu-iotests/139 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/065 b/tests/qemu-iotests/065
index 72aa9707c7..e95f7f817b 100755
--- a/tests/qemu-iotests/065
+++ b/tests/qemu-iotests/065
@@ -59,7 +59,7 @@ class TestQemuImgInfo(TestImageInfoSpecific):
                     :data.index('')]
         for field in data:
             self.assertTrue(re.match('^ {4}[^ ]', field) is not None)
-        data = map(lambda line: line.strip(), data)
+        data = [line.strip() for line in data]
         self.assertEqual(data, self.human_compare)
 
 class TestQMP(TestImageInfoSpecific):
@@ -80,7 +80,7 @@ class TestQMP(TestImageInfoSpecific):
 
     def test_qmp(self):
         result = self.vm.qmp('query-block')['return']
-        drive = filter(lambda drive: drive['device'] == 'drive0', result)[0]
+        drive = [drive for drive in result if drive['device'] == 'drive0'][0]
         data = drive['inserted']['image']['format-specific']
         self.assertEqual(data['type'], iotests.imgfmt)
         self.assertEqual(data['data'], self.compare)
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index f8f02808a9..b54c816c16 100644
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -51,7 +51,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist = True):
         result = self.vm.qmp('query-named-block-nodes')
-        nodes = filter(lambda x: x['node-name'] == node, result['return'])
+        nodes = [x for x in result['return'] if x['node-name'] == node]
         self.assertLessEqual(len(nodes), 1)
         self.assertEqual(must_exist, len(nodes) == 1)
 
-- 
2.15.1
