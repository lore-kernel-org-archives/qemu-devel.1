Received: from eggs.gnu.org ([2001:4830:134:3::10]:51487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhY-0000se-Cn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhV-00024e-9G
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:28 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePEhV-00023x-5e
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:36:25 -0500
Received: by mail-qt0-x241.google.com with SMTP id w10so5525245qtb.10
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:36:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 18:35:55 -0300
Message-Id: <20171213213557.26561-5-f4bug@amsat.org>
In-Reply-To: <20171213213557.26561-1-f4bug@amsat.org>
References: <20171213213557.26561-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/6] qtest.py: add
 verify_machine(supported_machines)
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

We can now restrict tests to specific machines.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qtest.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/qtest.py b/scripts/qtest.py
index 733686a6fe..429eb67c2a 100644
--- a/scripts/qtest.py
+++ b/scripts/qtest.py
@@ -19,6 +19,7 @@ import re
 import unittest
 import logging
 import tempfile
+import subprocess
 
 
 qemu_prog = os.environ.get('QEMU_PROG', 'qemu')
@@ -210,3 +211,18 @@ def notrun(reason):
 def verify_platform(supported_oses=['linux']):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
         notrun('not suitable for this OS: %s' % sys.platform)
+
+def verify_machine(supported_machines):
+    if 'any' in supported_machines:
+        return
+    args = list((qemu_prog, "-machine", "help"))
+    subp = subprocess.Popen(args, stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT)
+    exitcode = subp.wait()
+    if exitcode < 0:
+        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
+                                                            ' '.join(args)))
+    machines = re.split("\n([\w\.-]+)\s.*", subp.communicate()[0])
+
+    if True not in [x in machines for x in supported_machines]:
+        notrun('not machine suitable for this test')
-- 
2.15.1
