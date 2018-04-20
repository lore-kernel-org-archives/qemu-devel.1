Received: from eggs.gnu.org ([2001:4830:134:3::10]:38835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ag5-0006R5-2D
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ag0-000395-3y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9afz-00036f-SB
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:22:28 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:40 -0300
Message-Id: <20180420181951.7252-14-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 13/24] avocado_qemu: Functional test for
 RHBZ#1431939
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Alistair Francis <alistair23@gmail.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>

From: Amador Pahim <apahim@redhat.com>

This issue was fixed in commit d81d857.

According to the RHBZ1431939, the issue is 'host nodes' returning '128'.
It should return empty value when using default policy or 0 when using
bind policy.

Test consists in inspect the result of the 'info memdev' QMP command
after hot-adding memory.

Signed-off-by: Amador Pahim <apahim@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_info_memdev_host_nodes.py | 66 ++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 tests/avocado/test_info_memdev_host_nodes.py

diff --git a/tests/avocado/test_info_memdev_host_nodes.py b/tests/avocado/test_info_memdev_host_nodes.py
new file mode 100644
index 0000000000..69891b723d
--- /dev/null
+++ b/tests/avocado/test_info_memdev_host_nodes.py
@@ -0,0 +1,66 @@
+from avocado import main
+from avocado_qemu import test
+
+
+class TestInfoMemdev(test.QemuTest):
+    """
+
+    :avocado: enable
+    :avocado: tags=qmp,object_add,device_add,memdev
+    """
+
+    def setUp(self):
+        self.vm.args.extend(['-m', '4G,slots=32,maxmem=40G'])
+        self.vm.launch()
+
+    def test_hotplug_memory_default_policy(self):
+        """
+        According to the RHBZ1431939, the issue is 'host nodes'
+        returning '128'. It should return empty value when memory
+        hotplug default policy is used.
+
+        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
+        :avocado: tags=RHBZ1431939
+        """
+
+        cmd = 'object_add memory-backend-ram,id=mem1,size=1G'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'device_add pc-dimm,id=dimm1,memdev=mem1'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'info memdev'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertIn('policy: default\r', res['return'])
+        self.assertIn('host nodes: \r', res['return'])
+
+    def test_hotplug_memory_bind_policy(self):
+        """
+        According to the RHBZ1431939, the issue is 'host nodes'
+        returning '128'. It should return 0 when memory hotplug
+        bind policy is used.
+
+        Fixed in commit d81d857f4421d205395d55200425daa6591c28a5.
+        :avocado: tags=RHBZ1431939
+        """
+
+        cmd = 'object_add memory-backend-ram,id=mem1,host-nodes=0,size=2G,policy=bind'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'device_add pc-dimm,id=dimm1,memdev=mem1'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertEqual('', res['return'])
+
+        cmd = 'info memdev'
+        res = self.vm.qmp('human-monitor-command', command_line=cmd)
+        self.assertIn('policy: bind\r', res['return'])
+        self.assertIn('host nodes: 0\r', res['return'])
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+if __name__ == "__main__":
+    avocado.main()
-- 
2.14.3
