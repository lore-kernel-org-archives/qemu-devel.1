Received: from eggs.gnu.org ([2001:4830:134:3::10]:43972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutS-0005LY-D5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dKutQ-0001y6-Sf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dKutQ-0001xv-Kh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12E480C0A
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 23:06:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 13 Jun 2017 20:06:27 -0300
Message-Id: <20170613230627.17942-4-ehabkost@redhat.com>
In-Reply-To: <20170613230627.17942-1-ehabkost@redhat.com>
References: <20170613230627.17942-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] device-crash-test: Mode for testing -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Extend the device-crash-test script so it can test backend objects, too.
The new mode can be enabled using the "-O" option.

The script already found a crash using the following command-line:

  $ qemu-system-x86_64 -S -machine none -object colo-compare,id=test-object
  (qemu-system-x86_64:3812): GLib-CRITICAL **: g_main_loop_quit: assertion 'loop != NULL' failed
  Segmentation fault (core dumped)

The crash above was added to the script whitelist so it will still
generate error messages but won't generate fatal errors.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 101 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 27 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 5f90e9bb54..be5369425d 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -171,6 +171,10 @@ ERROR_WHITELIST = [
     # this fails on some machine-types, but not all, so they don't have expected=True:
     {'device':'vmgenid'}, # vmgenid requires DMA write support in fw_cfg, which this machine type does not provide
 
+    # silence exitcode=1 errors caused by -object, as most of them will complain
+    # about missing options.
+    {'object': '.*', 'log':".*"},
+
     # Silence INFO messages for errors that are common on multiple
     # devices/machines:
     {'log':r"No '[\w-]+' bus found for device '[\w-]+'"},
@@ -231,6 +235,7 @@ ERROR_WHITELIST = [
     {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'arm-gicv3', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'object':'colo-compare', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
@@ -245,14 +250,17 @@ def whitelistTestCaseMatch(wl, t):
     results/output match the entry.  See whitelistResultMatch().
     """
     return (('machine' not in wl or
-             'machine' not in t or
-             re.match(wl['machine'] + '$', t['machine'])) and
+             ('machine' in t and
+              re.match(wl['machine'] + '$', t['machine']))) and
             ('accel' not in wl or
              'accel' not in t or
              re.match(wl['accel'] + '$', t['accel'])) and
             ('device' not in wl or
-             'device' not in t or
-             re.match(wl['device'] + '$', t['device'])))
+             ('device' in t and
+              re.match(wl['device'] + '$', t['device']))) and
+            ('object' not in wl or
+             ('object' in t and
+              re.match(wl['object'] + '$', t['object']))))
 
 
 def whitelistCandidates(t):
@@ -330,29 +338,50 @@ def infoQDM(vm):
 
 
 class QemuBinaryInfo(object):
-    def __init__(self, binary, devtype):
-        if devtype is None:
-            devtype = 'device'
+    def __init__(self, binary, basetypes):
+        """Constructor
 
+        @basetypes: device types to be queried in advance using qom-list-types
+        """
         self.binary = binary
         self._machine_info = {}
 
-        dbg("devtype: %r", devtype)
+        dbg("basetypes: %r", basetypes)
         args = ['-S', '-machine', 'none,accel=kvm:tcg']
         dbg("querying info for QEMU binary: %s", binary)
         vm = QEMUMachine(binary=binary, args=args)
         vm.launch()
         try:
-            self.alldevs = set(qomListTypeNames(vm, implements=devtype, abstract=False))
+            self.type_lists = {}
+            for bt in basetypes:
+                self.type_lists[bt] = \
+                    set(qomListTypeNames(vm, implements=bt, abstract=False))
             # there's no way to query DeviceClass::user_creatable using QMP,
             # so use 'info qdm':
             self.no_user_devs = set([d['name'] for d in infoQDM(vm, ) if d['no-user']])
             self.machines = list(m['name'] for m in vm.command('query-machines'))
-            self.user_devs = self.alldevs.difference(self.no_user_devs)
             self.kvm_available = vm.command('query-kvm')['enabled']
         finally:
             vm.shutdown()
 
+    def getTypes(self, basetype):
+        """Return list of subtypes of @basetype
+
+        @basetype must be in the basetypes list used when
+        constructing the QemuBinaryObject, so it can be
+        loaded in advance.
+        """
+        return self.type_lists[basetype]
+
+    def getUserDevs(self, devtype):
+        """Return list of user-creatable devices that implement a devtype
+
+        @devtype must be in the basetypes list used when
+        constructing the QemuBinaryObject, so it can be
+        loaded in advance.
+        """
+        return self.getTypes(devtype).difference(self.no_user_devs)
+
     def machineInfo(self, machine):
         """Query for information on a specific machine-type
 
@@ -386,7 +415,8 @@ BINARY_INFO = {}
 
 def getBinaryInfo(args, binary):
     if binary not in BINARY_INFO:
-        BINARY_INFO[binary] = QemuBinaryInfo(binary, args.devtype)
+        BINARY_INFO[binary] = QemuBinaryInfo(binary,
+                                             [args.devtype, 'user-creatable'])
     return BINARY_INFO[binary]
 
 
@@ -397,14 +427,20 @@ def checkOneCase(args, testcase):
     or None on success
     """
     binary = testcase['binary']
-    accel = testcase['accel']
-    machine = testcase['machine']
-    device = testcase['device']
 
     dbg("will test: %r", testcase)
 
-    args = ['-S', '-machine', '%s,accel=%s' % (machine, accel),
-            '-device', qemuOptsEscape(device)]
+    args = ['-S']
+    if 'machine' in testcase:
+        m = testcase['machine']
+        if 'accel' in testcase:
+            m += ',accel=%s' % (testcase['accel'])
+        args.extend(['-machine', m])
+    if 'device' in testcase:
+        args.extend(['-device', qemuOptsEscape(testcase['device'])])
+    if 'object' in testcase:
+        args.extend(['-object', '%s,id=test-object' % (qemuOptsEscape(testcase['object']))])
+
     cmdline = ' '.join([binary] + args)
     dbg("will launch QEMU: %s", cmdline)
     vm = QEMUMachine(binary=binary, args=args)
@@ -449,16 +485,20 @@ def machinesToTest(args, testcase):
 
 
 def devicesToTest(args, testcase):
-    return getBinaryInfo(args, testcase['binary']).user_devs
+    return getBinaryInfo(args, testcase['binary']).getUserDevs(args.devtype)
 
+def objectsToTest(args, testcase):
+    return getBinaryInfo(args, testcase['binary']).getTypes('user-creatable')
 
-TESTCASE_VARIABLES = [
-    ('binary', binariesToTest),
-    ('accel', accelsToTest),
-    ('machine', machinesToTest),
-    ('device', devicesToTest),
-]
-
+def testCaseVariables(args, testcase):
+    """Generate list of test case variables over which we will iterate"""
+    yield ('binary', binariesToTest)
+    if 'device' in testcase or args.mode == 'device':
+        yield ('accel', accelsToTest)
+        yield ('machine', machinesToTest)
+        yield ('device', devicesToTest)
+    elif 'object' in testcase or args.mode == 'object':
+        yield ('object', objectsToTest)
 
 def genCases1(args, testcases, var, fn):
     """Generate new testcases for one variable
@@ -482,7 +522,7 @@ def genCases(args, testcase):
     """Generate test cases for all variables
     """
     cases = [testcase.copy()]
-    for var, fn in TESTCASE_VARIABLES:
+    for var, fn in testCaseVariables(args, testcase):
         dbg("var: %r, fn: %r", var, fn)
         cases = genCases1(args, cases, var, fn)
     return cases
@@ -534,7 +574,13 @@ def main():
     parser.add_argument('--dry-run', action='store_true',
                         help="Don't run any tests, just generate list")
     parser.add_argument('-D', '--devtype', metavar='TYPE',
-                        help="Test only device types that implement TYPE")
+                        help="Test only device types that implement TYPE",
+                        default="device")
+    parser.add_argument('-M', '--mode', metavar='MODE',
+                        help="Test mode (object, device)", choices=['object', 'device'],
+                        default='device')
+    parser.add_argument('-O', '--object', action='store_const', const='object',
+                        dest='mode')
     parser.add_argument('-Q', '--quick', action='store_true', default=True,
                         help="Quick mode: skip test cases that are expected to fail")
     parser.add_argument('-F', '--full', action='store_false', dest='quick',
@@ -578,7 +624,8 @@ def main():
         expected_match = findExpectedResult(t)
         if (args.quick and
                 (expected_match or
-                 not getBinaryInfo(args, t['binary']).machineInfo(t['machine'])['runnable'])):
+                 ('machine' in t and
+                  not getBinaryInfo(args, t['binary']).machineInfo(t['machine'])['runnable']))):
             dbg("skipped: %s", formatTestCase(t))
             skipped += 1
             continue
-- 
2.11.0.259.g40922b1
