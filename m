Received: from eggs.gnu.org ([2001:4830:134:3::10]:39397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9ago-00076e-D9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f9agn-0005em-CD
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f9agn-0005c9-47
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 14:23:17 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 20 Apr 2018 15:19:44 -0300
Message-Id: <20180420181951.7252-18-ehabkost@redhat.com>
In-Reply-To: <20180420181951.7252-1-ehabkost@redhat.com>
References: <20180420181951.7252-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 17/24] avocado_qemu: Remove duplicate PortTracker
 implementation
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

From: Cleber Rosa <crosa@redhat.com>

The PortTracker class was introduced on Avocado's own utility
libraries, starting with version 54.0, and it actually received fixes
after that.

Let's avoid this duplicate implementation and rely on the standard
one.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/avocado/README.rst           |  2 +-
 tests/avocado/avocado_qemu/test.py | 45 +-------------------------------------
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/tests/avocado/README.rst b/tests/avocado/README.rst
index 07852e790a..50bc865fc1 100644
--- a/tests/avocado/README.rst
+++ b/tests/avocado/README.rst
@@ -6,7 +6,7 @@ Framework. To install Avocado, follow the instructions from this link::
 Tests here are written keeping the minimum amount of dependencies. To
 run the tests, you need the Avocado core package (`python-avocado` on
 Fedora, `avocado-framework` on pip). Extra dependencies should be
-documented in this file.
+documented in this file.  The current minimum required version is 54.0.
 
 In this directory, an ``avocado_qemu`` package is provided, containing
 the ``test`` module, which inherits from ``avocado.Test`` and provides
diff --git a/tests/avocado/avocado_qemu/test.py b/tests/avocado/avocado_qemu/test.py
index 5e42cac8d0..dfffa2a03b 100644
--- a/tests/avocado/avocado_qemu/test.py
+++ b/tests/avocado/avocado_qemu/test.py
@@ -34,7 +34,6 @@ import uuid
 import aexpect
 
 from avocado import Test
-from avocado.utils.data_structures import Borg
 from avocado.utils import network
 from avocado.utils import process
 from avocado.utils import path as utils_path
@@ -223,48 +222,6 @@ def _handle_prompts(session, username, password, prompt, timeout=60,
     return output
 
 
-class _PortTracker(Borg):
-
-    """
-    Tracks ports used in the host machine.
-    """
-
-    def __init__(self):
-        Borg.__init__(self)
-        self.address = 'localhost'
-        self.start_port = 5000
-        if not hasattr(self, 'retained_ports'):
-            self._reset_retained_ports()
-
-    def __str__(self):
-        return 'Ports tracked: %r' % self.retained_ports
-
-    def _reset_retained_ports(self):
-        self.retained_ports = []
-
-    def register_port(self, port):
-        if ((port not in self.retained_ports) and
-                (network.is_port_free(port, self.address))):
-            self.retained_ports.append(port)
-        else:
-            raise ValueError('Port %d in use' % port)
-        return port
-
-    def find_free_port(self, start_port=None):
-        if start_port is None:
-            start_port = self.start_port
-        port = start_port
-        while ((port in self.retained_ports) or
-               (not network.is_port_free(port, self.address))):
-            port += 1
-        self.retained_ports.append(port)
-        return port
-
-    def release_port(self, port):
-        if port in self.retained:
-            self.retained.remove(port)
-
-
 class _VM(qemu.QEMUMachine):
     '''A QEMU VM'''
 
@@ -273,7 +230,7 @@ class _VM(qemu.QEMUMachine):
         if arch is None:
             arch = os.uname()[4]
         self.arch = arch
-        self.ports = _PortTracker()
+        self.ports = network.PortTracker()
         self.name = "qemu-%s" % str(uuid.uuid4())[:8]
         if qemu_bin is None:
             qemu_bin = _get_qemu_bin(arch)
-- 
2.14.3
