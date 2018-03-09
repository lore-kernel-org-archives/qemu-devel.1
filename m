Received: from eggs.gnu.org ([2001:4830:134:3::10]:50198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd9-0008L2-W3
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOd6-0006nt-Ss
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOd6-0006nj-N8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:40 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:22 -0300
Message-Id: <20180309202827.12085-4-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/8] device-crash-test: Accept machine=DEFAULT
 to test the default machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

This will be useful for running a smaller test set on
"make check", instead of testing every single machine-type/device
combination.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 364c779cdb..632b128e44 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -41,6 +41,11 @@ Test a single QEMU binary:
 
     device-crash-test /path/to/qemu/binary
 
+Test all QEMU binaries found in the current directory, using only the default
+machine-type:
+
+    device-crash-test -t machine=DEFAULT
+
 """
 
 import sys
@@ -357,7 +362,7 @@ class QemuBinaryInfo(object):
             # there's no way to query DeviceClass::user_creatable using QMP,
             # so use 'info qdm':
             self.no_user_devs = set([d['name'] for d in infoQDM(vm, ) if d['no-user']])
-            self.machines = list(m['name'] for m in vm.command('query-machines'))
+            self.machines = vm.command('query-machines')
             self.user_devs = self.alldevs.difference(self.no_user_devs)
             self.kvm_available = vm.command('query-kvm')['enabled']
         finally:
@@ -390,6 +395,19 @@ class QemuBinaryInfo(object):
         self._machine_info[machine] = mi
         return mi
 
+    def defaultMachine(self):
+        """Default machine-type for the QEMU binary
+
+        If no default machine-type is returned by query-machines, return the
+        first machine-type in the list.
+        """
+        machines = self.machines
+        defmachine = [m['name'] for m in self.machines if m.get('is-default')]
+        if defmachine:
+            return defmachine[0]
+        else:
+            return self.machines[0]['name']
+
 
 BINARY_INFO = {}
 
@@ -455,7 +473,7 @@ def accelsToTest(args, testcase):
 
 
 def machinesToTest(args, testcase):
-    return getBinaryInfo(args, testcase['binary']).machines
+    return [m['name'] for m in getBinaryInfo(args, testcase['binary']).machines]
 
 
 def devicesToTest(args, testcase):
@@ -580,6 +598,13 @@ def main():
         return 1
 
     for t in casesToTest(args, tc):
+
+        # expand some test case variables to their actual values before
+        # using them:
+        # "-t machine=DEFAULT" can be used to use the default machine-type
+        if t['machine'] == 'DEFAULT':
+            t['machine'] = getBinaryInfo(args, t['binary']).defaultMachine()
+
         logger.info("running test case: %s", formatTestCase(t))
         total += 1
 
-- 
2.14.3
