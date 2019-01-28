Received: from eggs.gnu.org ([209.51.188.92]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goBEs-0003dP-Uu
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1goB0j-0001RK-5a
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1goB0i-0001LY-VR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:47:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2C93C04BD46
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:47:38 +0000 (UTC)
From: Caio Carrara <ccarrara@redhat.com>
Date: Mon, 28 Jan 2019 15:47:25 -0200
Message-Id: <20190128174725.8809-3-ccarrara@redhat.com>
In-Reply-To: <20190128174725.8809-1-ccarrara@redhat.com>
References: <20190128174725.8809-1-ccarrara@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] Acceptance tests: add simple migration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wainersm@redhat.com, ehabkost@redhat.com, philmd@redhat.com, crosa@redhat.com

From: Cleber Rosa <crosa@redhat.com>

This is the simplest possible migration test, exercising the multi
VM capabilities of the test class.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/migration.py | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tests/acceptance/migration.py

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
new file mode 100644
index 0000000000..973ae0ab4b
--- /dev/null
+++ b/tests/acceptance/migration.py
@@ -0,0 +1,45 @@
+# Migration test
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+
+from avocado_qemu import Test
+
+from avocado.utils import network
+from avocado.utils import wait
+
+
+class Migration(Test):
+    """
+    :avocado: enable
+    """
+
+    timeout =3D 10
+
+    @staticmethod
+    def migration_completed(vm):
+        cmd_result =3D vm.qmp('query-migrate')
+        if cmd_result is not None:
+            result =3D cmd_result.get('return')
+            if result is not None:
+                return result.get('status') =3D=3D 'completed'
+        return False
+
+    def test_tcp(self):
+        source =3D self.get_vm()
+        port =3D network.find_free_port()
+        if port is None:
+            self.cancel('Failed to find a free port')
+        dest_uri =3D 'tcp:localhost:%u' % port
+        dest =3D self.get_vm('-incoming', dest_uri)
+        dest.launch()
+        source.launch()
+        source.qmp('migrate', uri=3Ddest_uri)
+        wait.wait_for(self.migration_completed, timeout=3Dself.timeout,
+                      step=3D0.1, args=3D(source,))
--=20
2.20.1
