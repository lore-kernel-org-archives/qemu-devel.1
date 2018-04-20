Received: from eggs.gnu.org ([2001:4830:134:3::10]:39288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agi-00071Z-Al
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agd-000532-9k
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9agd-0004zD-0z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:07 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:43 -0300
Message-Id: <20180420181951.7252-17-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 16/24] avocado_qemu: Functional test for
 RHBZ1473203
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

From: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>

Adds regresion test for RHBZ1473203 which runs VM with 16 numa nodes and
then verifies memory allocation is accurate before and after hotplugging
memory into default and 13th node.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/test_numa_hotplug.py | 116 +++++++++++++++++++++++++++++++=
++++++
 1 file changed, 116 insertions(+)
 create mode 100644 tests/avocado/test_numa_hotplug.py

diff --git a/tests/avocado/test_numa_hotplug.py b/tests/avocado/test_numa=
_hotplug.py
new file mode 100644
index 0000000000..a99b8dcebf
--- /dev/null
+++ b/tests/avocado/test_numa_hotplug.py
@@ -0,0 +1,116 @@
+import re
+import time
+
+from avocado_qemu import test
+
+
+class TestNumaHotplug(test.QemuTest):
+    """
+    Verifies that "info numa" and "/sys/devices/system/node/" contains
+    correct values before/after inserting memory devices into default
+    and then into 13th numa node.
+
+    Associated bug trackers: RHBZ1473203
+        https://bugzilla.redhat.com/show_bug.cgi?id=3D1473203
+
+    Fixed in kernel commit dc421b200f91930c9c6a9586810ff8c232cf10fc.
+
+    :avocado: enable
+    :avocado: tags=3DRHBZ1473203,requires_linux,numa,memory,ppc64le
+    """
+
+    def setUp(self):
+        self.request_image()
+        self.vm.args.extend(["-m", "4G,slots=3D208,maxmem=3D80G"])
+        self.vm.args.extend(["-numa", "node"] * 16)
+        self.vm.launch()
+
+    def check_mem_console(self, console, exp):
+        """
+        Verifies that memory layout is according to exp using console/ss=
h
+
+        :param console: session
+        :param exp: list of MemTotals per node in MB, tolerance is +-100=
MB
+        """
+        out =3D console.cmd_output_safe("echo /sys/devices/system/node/n=
ode*")
+        nodes =3D re.findall(r"/sys/devices/system/node/node\d+", out)
+        self.assertEqual(len(nodes), len(exp), "Number of nodes is not "
+                         "%s:\n%s" % (len(exp), out))
+        for i in xrange(len(exp)):
+            out =3D console.cmd_output_safe("cat /sys/devices/system/nod=
e/"
+                                          "node%s/meminfo" % i)
+            mem =3D re.search(r"MemTotal:\s*(\d+) kB", out)
+            self.assertTrue(mem, "Failed to obtain node%s MemTotal:\n%s"
+                            % (i, out))
+            _exp =3D exp[i] * 1024
+            mem =3D int(mem.group(1))
+            self.assertGreater(mem, _exp - 102400, "TotalMem of node%s i=
s not "
+                               "%s+-51200 kb (%s)" % (i, _exp, mem))
+            self.assertLess(mem, _exp + 102400, "TotalMem of node%s is n=
ot "
+                            "%s+-51200 kb (%s)" % (i, _exp, mem))
+
+    def check_mem_monitor(self, monitor, exp):
+        """
+        Verifies that memory layout is according to exp using QMP monito=
r
+
+        :param console: session
+        :param exp: list of MemTotals per node in MB, tolerance is +-100=
MB
+        """
+        ret =3D monitor("human-monitor-command", command_line=3D"info nu=
ma")
+        out =3D ret["return"]
+        self.assertTrue(out.startswith("%s nodes" % len(exp)), "Number o=
f "
+                        "nodes is not %s:\n%s" % (len(exp), out))
+        for i in xrange(len(exp)):
+            _exp =3D "node %s size: %s MB" % (i, exp[i])
+            self.assertIn(_exp, out, "%s is not in 'info numa' output, "
+                          "probably wrong memory size reported:\n%s"
+                          % (_exp, out))
+
+    @staticmethod
+    def _retry_until_timeout(timeout, func, *args, **kwargs):
+        """
+        Repeat the function until it returns anything ignoring Assertion=
Error.
+        After the deadline repeate the function one more time without ig=
noring
+        timeout.
+        """
+        end =3D time.time() + timeout
+        while time.time() < end:
+            try:
+                ret =3D func(*args, **kwargs)
+            except AssertionError:
+                continue
+            break
+        else:
+            ret =3D func(*args, **kwargs)
+        return ret
+
+    def test_hotplug_mem_into_node(self):
+        console =3D self.vm.get_console()
+        exp =3D [256] * 16
+        self.check_mem_monitor(self.vm.qmp, exp)
+        self.check_mem_console(console, exp)
+        cmd =3D "object_add memory-backend-ram,id=3Dmem2,size=3D1G"
+        res =3D self.vm.qmp("human-monitor-command", command_line=3Dcmd)
+        self.assertEqual(res["return"], "")
+        cmd =3D "device_add pc-dimm,id=3Ddimm2,memdev=3Dmem2"
+        res =3D self.vm.qmp("human-monitor-command", command_line=3Dcmd)
+        self.assertEqual(res["return"], "")
+        exp =3D [1280] + [256] * 15
+        self.check_mem_monitor(self.vm.qmp, exp)
+        # Wait up to 10s to propagate the changes
+        self._retry_until_timeout(10, self.check_mem_console, console, e=
xp)
+        cmd =3D "object_add memory-backend-ram,id=3Dmem8,size=3D1G"
+        res =3D self.vm.qmp("human-monitor-command", command_line=3Dcmd)
+        self.assertEqual(res["return"], "")
+        cmd =3D "device_add pc-dimm,id=3Ddimm8,memdev=3Dmem8,node=3D13"
+        res =3D self.vm.qmp("human-monitor-command", command_line=3Dcmd)
+        self.assertEqual(res["return"], "")
+        time.sleep(5)
+        exp =3D [1280] + [256] * 12 + [1280] + [256] * 2
+        self.check_mem_monitor(self.vm.qmp, exp)
+        # Wait up to 10s to propagate the changes
+        self._retry_until_timeout(10, self.check_mem_console, console, e=
xp)
+        console.close()
+
+    def tearDown(self):
+        self.vm.shutdown()
--=20
2.14.3
