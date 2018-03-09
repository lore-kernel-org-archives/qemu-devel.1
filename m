Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdL-00007F-BU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdI-0006sg-70
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOdI-0006sU-1O
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:52 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:24 -0300
Message-Id: <20180309202827.12085-6-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] device-crash-test: Remove runnable-machine
 check
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

This optimization to skip tests if the machine is not runnable is
unreliable and makes the script ignore actual QEMU crashes, so
we're safer simply removing it.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index b9a7470efc..f406890519 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -372,33 +372,6 @@ class QemuBinaryInfo(object):
         finally:
             vm.shutdown()
 
-    def machineInfo(self, machine):
-        """Query for information on a specific machine-type
-
-        Results are cached internally, in case the same machine-
-        type is queried multiple times.
-        """
-        if machine in self._machine_info:
-            return self._machine_info[machine]
-
-        mi = {}
-        args = ['-S', '-machine', '%s' % (machine)]
-        dbg("querying machine info for binary=%s machine=%s", self.binary, machine)
-        vm = QEMUMachine(binary=self.binary, args=args)
-        try:
-            vm.launch()
-            mi['runnable'] = True
-        except KeyboardInterrupt:
-            raise
-        except:
-            dbg("exception trying to run binary=%s machine=%s", self.binary, machine, exc_info=sys.exc_info())
-            dbg("log: %r", vm.get_log())
-            mi['runnable'] = False
-
-        vm.shutdown()
-        self._machine_info[machine] = mi
-        return mi
-
     def defaultMachine(self):
         """Default machine-type for the QEMU binary
 
@@ -613,9 +586,7 @@ def main():
         total += 1
 
         expected_match = findExpectedResult(t)
-        if (args.quick and
-                (expected_match or
-                 not getBinaryInfo(args, t['binary']).machineInfo(t['machine'])['runnable'])):
+        if args.quick and expected_match:
             dbg("skipped: %s", formatTestCase(t))
             skipped += 1
             continue
-- 
2.14.3
