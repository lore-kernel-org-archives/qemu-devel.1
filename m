Received: from eggs.gnu.org ([209.51.188.92]:35590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gte57-00041n-8P
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gte38-0008Dj-QO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gte38-0007wT-HW
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:48:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DAF5E59445
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 19:39:06 +0000 (UTC)
From: Caio Carrara <ccarrara@redhat.com>
Date: Tue, 12 Feb 2019 17:38:55 -0200
Message-Id: <20190212193855.13223-3-ccarrara@redhat.com>
In-Reply-To: <20190212193855.13223-1-ccarrara@redhat.com>
References: <20190212193855.13223-1-ccarrara@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/2] tests.acceptance: adds simple migration
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
Cc: Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>

This change adds the simplest possible migration test. Beyond the test
purpose itself it's also useful to exercise the multi virtual machines
capabilities from base avocado qemu test class.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Caio Carrara <ccarrara@redhat.com>
---
 tests/acceptance/migration.py | 53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tests/acceptance/migration.py

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
new file mode 100644
index 0000000000..6115cf6c24
--- /dev/null
+++ b/tests/acceptance/migration.py
@@ -0,0 +1,53 @@
+# Migration test
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Authors:
+#  Cleber Rosa <crosa@redhat.com>
+#  Caio Carrara <ccarrara@redhat.com>
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
+    def migration_finished(vm):
+        return vm.command('query-migrate')['status'] in ('completed', 'f=
ailed')
+
+    def _get_free_port(self):
+        port =3D network.find_free_port()
+        if port is None:
+            self.cancel('Failed to find a free port')
+        return port
+
+
+    def test_migration_with_tcp_localhost(self):
+        source_vm =3D self.get_vm()
+        dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
+        dest_vm =3D self.get_vm('-incoming', dest_uri)
+        dest_vm.launch()
+        source_vm.launch()
+        source_vm.qmp('migrate', uri=3Ddest_uri)
+        wait.wait_for(
+            self.migration_finished,
+            timeout=3Dself.timeout,
+            step=3D0.1,
+            args=3D(source_vm,)
+        )
+        self.assertEqual(dest_vm.command('query-migrate')['status'], 'co=
mpleted')
+        self.assertEqual(source_vm.command('query-migrate')['status'], '=
completed')
+        self.assertEqual(dest_vm.command('query-status')['status'], 'run=
ning')
+        self.assertEqual(source_vm.command('query-status')['status'], 'p=
ostmigrate')
--=20
2.20.1
