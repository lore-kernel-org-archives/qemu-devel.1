Received: from eggs.gnu.org ([2001:4830:134:3::10]:51511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEha-0000wE-Kh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhZ-0002A4-Lx
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:30 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhZ-00029c-Hp
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:29 -0500
Received: by mail-qt0-x242.google.com with SMTP id a16so5587469qtj.3
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:36:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:56 -0300
Message-Id: <20171213213557.26561-6-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/6] qtest.py: add a simple main() which calls
 unittest.main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

We can now write complex qtests with a high-level language (Python).
(partly copied from iotests::main)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qtest.py | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index 429eb67c2a..581451836c 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -226,3 +226,36 @@ def verify_machine(supported_machines):
 
     if True not in [x in machines for x in supported_machines]:
         notrun('not machine suitable for this test')
+
+def main(supported_oses=['linux'], supported_machines=['any']):
+    '''Run tests'''
+
+    global debug
+
+    verify_platform(supported_oses)
+    verify_machine(supported_machines)
+
+    verbosity = 0
+    level = logging.WARN
+    if '-d' in sys.argv:
+        verbosity = 2
+        level = logging.DEBUG
+    if '-v' in sys.argv:
+        verbosity = 1
+        level = logging.INFO
+    if '-q' in sys.argv:
+        level = logging.NOTSET
+
+    import StringIO
+    output = sys.stdout if verbosity else StringIO.StringIO()
+
+    logging.basicConfig(level=level)
+
+    class MyTestRunner(unittest.TextTestRunner):
+        def __init__(self, stream=output, descriptions=True,
+                     verbosity=verbosity):
+            unittest.TextTestRunner.__init__(self, stream, descriptions,
+                                             verbosity)
+
+    # unittest.main() will use sys.exit() so expect a SystemExit exception
+    unittest.main(testRunner=MyTestRunner)
-- 
2.15.1
