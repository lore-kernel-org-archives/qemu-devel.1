Received: from eggs.gnu.org ([2001:4830:134:3::10]:36920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAW-00053q-8l
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAU-0001t0-6U
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAT-0001rd-TB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:34 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A008811D8
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:02:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:02:04 -0200
Message-Id: <20170117010204.4909-10-ehabkost@redhat.com>
In-Reply-To: <20170117010204.4909-1-ehabkost@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 9/9] tests: Test case for
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Test code to sanity-check the results of
query-cpu-model-expansion.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include        |   3 +
 tests/query-cpu-model-test.py | 398 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+)
 create mode 100755 tests/query-cpu-model-test.py

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d9809c6229..75f5c9052d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -253,6 +253,9 @@ check-qtest-x86_64-y += $(check-qtest-i386-y)
 gcov-files-i386-y += i386-softmmu/hw/timer/mc146818rtc.c
 gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y))
 
+check-simpleqtest-x86_64-y += $(SRC_PATH)/tests/query-cpu-model-test.py
+check-simpleqtest-i386-y += $(SRC_PATH)/tests/query-cpu-model-test.py
+
 check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-mips-y = tests/endianness-test$(EXESUF)
diff --git a/tests/query-cpu-model-test.py b/tests/query-cpu-model-test.py
new file mode 100755
index 0000000000..c19bd1bbc3
--- /dev/null
+++ b/tests/query-cpu-model-test.py
@@ -0,0 +1,398 @@
+#!/usr/bin/env python
+#
+# query-cpu-model-* validation and sanity checks
+#
+#  Copyright (c) 2016-2017 Red Hat Inc
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
+
+import sys, os
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
+from qtest import QEMUQtestMachine
+import unittest
+import logging
+import copy
+
+UNSAFE_FEATURES = {
+    'x86_64': ['pmu', 'host-cache-info'],
+    'i386': ['pmu', 'host-cache-info'],
+}
+
+# testing every single CPU model takes a while, so test just a few ones:
+X86_MODELS_TO_TEST = set(['base', 'host',
+                          'qemu64', 'qemu32', 'kvm64', 'kvm32',
+                          '486', 'pentium', 'athlon', 'n270',
+                          'Haswell-noTSX', 'Haswell', 'Broadwell',
+                          'Opteron_G5'])
+
+MODELS_TO_TEST = {
+    'x86_64': X86_MODELS_TO_TEST,
+    'i386': X86_MODELS_TO_TEST,
+}
+
+# Validation of the expanded CPU models will be based on the QOM
+# properties of CPU objects.
+# QOM properties that don't affect guest ABI can be safely ignored
+# when validating the results.
+IGNORE_QOM_PROPS = {
+    # the 'type' property just identifies the QOM class being used
+    # to build the CPU, and shouldn't affect the guest ABI
+    'x86_64': ['type'],
+    'i386': ['type'],
+    # 'static', 'migration-safe', and 'description' are just
+    # information for the user, and don't affect guest ABI
+    's390x': ['type', 'static', 'migration-safe', 'description'],
+}
+
+def toQemuOpts(*args):
+    """Convert arguments to a QemuOpts string, with appropriate escaping
+
+    Each argument can be a single string, or a dictionary.
+    """
+    logging.debug('toQemuOpts(%r)', args)
+    r = []
+    for a in args:
+        if type(a) is dict:
+            for k,v in a.items():
+                if type(v) is bool:
+                    if v:
+                        v = 'on'
+                    else:
+                        v = 'off'
+                v = str(v)
+                a = '%s=%s' % (k, v)
+                r.append(a)
+        else:
+            a = str(a)
+            r.append(a)
+    return ','.join([o.replace(',', ',,') for o in r])
+
+def cpuPath(vm, cpu_index):
+    """Return qom_path for a given CPU, using query-cpus"""
+    cpus = vm.command('query-cpus')
+    return cpus[cpu_index]['qom_path']
+
+def allProps(vm, path):
+    """Return a dictionary containing all properties for a QOM object"""
+    props = vm.command('qom-list', path=path)
+    r = {}
+    for prop in props:
+        pname = prop['name']
+        v = vm.command('qom-get', path=path, property=pname)
+        r[pname] = v
+    return r
+
+def allCpuProps(vm, cpu_index):
+    """Return all properties for a given CPU"""
+    return allProps(vm, cpuPath(vm, cpu_index))
+
+
+class CPUModelTest(unittest.TestCase):
+    longMessage = True
+    maxDiff = None
+
+    def runAndGetProps(self, model):
+        # Helper to run QEMU using a CpuModelInfo struct and get
+        # all CPU properties
+        cpu_opt = toQemuOpts(model['name'], model.get('props', {}))
+        logging.debug('cpu option: %s', cpu_opt)
+
+        vm = QEMUQtestMachine(args=['-machine', 'accel=%s' % (self.accel), '-S',
+                                    '-cpu', cpu_opt], name='qom-fetch',
+                              logging=False)
+        try:
+            vm.launch()
+            props = allCpuProps(vm, 0)
+        finally:
+            vm.shutdown()
+
+        # remove the properties we can ignore
+        for p in IGNORE_QOM_PROPS.get(self.target['arch'], []):
+            del props[p]
+
+        return props
+
+    def tryGetProps(self, model, msg):
+        """Try to get QOM props for model, if runnable"""
+        if model.has_key('qom-props'):
+            return
+
+        if model.get('runnable') != False:
+            logging.info("%s: maybe runnable, fetching QOM properties", msg)
+            try:
+                model['qom-props'] = self.runAndGetProps(model['model'])
+            except:
+                if model.get('runnable'):
+                    # explicitly marked as runnable, raise exception
+                    raise
+                logging.info("%s: failed to run VM, ignoring", msg)
+
+    def unsafeFeatures(self):
+        return UNSAFE_FEATURES.get(self.target['arch'], [])
+
+    def isMigrationSafe(self, model):
+        name = model['name']
+        if not self.cpu_models[name]['migration-safe']:
+            return False
+        for p in model.get('props', {}).keys():
+            if p in self.unsafeFeatures():
+                return False
+        return True
+
+    def checkOneExpansion(self, model, type, msg):
+        """Perform one query-cpu-model-expansion operation, validate results
+
+        @model is a CpuModelExpansionInfo struct, with some extra keys:
+        * model['runnable'] will be set to True if the CPU model is
+          runnable on this host
+        * model['qom-props'] will be set to the full list of properties for the
+          CPU, if the model is runnable
+
+        Returns a new CpuModelExpansion struct like @model, with
+        the expanded CPU model data.
+        """
+        logging.info("%s: testing type=%s", msg, type)
+        logging.debug("%s: model: %r", msg, model)
+
+        model_name = model['model']['name']
+
+        self.tryGetProps(model, msg)
+
+        expanded = self.vm.command('query-cpu-model-expansion',
+                                   type=type, model=model['model'])
+
+        logging.debug("%s: expanded: %r", msg, expanded)
+
+        # static expansion mode should always result in a static and
+        # migration safe CPU model
+        if type == 'static':
+            expanded_model = self.cpu_models[expanded['model']['name']]
+            self.assertTrue(self.isMigrationSafe(expanded_model))
+            self.assertTrue(expanded_model['static'])
+
+        # static expansion should never enable migration-unsafe
+        # features:
+        if type == 'static':
+            for f in self.unsafeFeatures():
+                self.assertFalse(expanded['model']['props'].get(f))
+
+        # Some expansions are known to be precise, and shouldn't lose any
+        # features:
+        # * full expansion
+        # * static expansion of a known migration-safe model
+        precise_expansion = (type == 'full') or \
+                            self.isMigrationSafe(model['model'])
+
+        expanded['runnable'] = model.get('runnable')
+        self.tryGetProps(expanded, msg)
+        if precise_expansion:
+            self.assertEquals(model.get('qom-props'),
+                              expanded.get('qom-props'),
+                              msg)
+
+        logging.debug("%s: result: %r", msg, expanded)
+        return expanded
+
+    def checkExpansions(self, model, msg):
+        """Perform multiple expansion operations on model, validate results
+
+        @model is a CpuModelExpansionInfo struct, with some extra keys:
+        * model['runnable'] should be set to True if the CPU model is
+          runnable on this host
+        * model['qom-props'] will be set to the full list of properties for
+          the CPU, if the model is runnable
+        """
+        exp_s = self.checkOneExpansion(model, 'static',
+                                       '%s.static' % (msg))
+        exp_f = self.checkOneExpansion(model, 'full',
+                                       '%s.full' % (msg))
+        exp_ss = self.checkOneExpansion(exp_s, 'static',
+                                        '%s.static.static' % (msg))
+        exp_sf = self.checkOneExpansion(exp_s, 'full',
+                                        '%s.static.full' % (msg))
+        exp_ff = self.checkOneExpansion(exp_f, 'full',
+                                        '%s.full.full' % (msg))
+
+        # static expansion twice should result in the same data:
+        self.assertEquals(exp_s, exp_ss, '%s: static != static+static' % (msg))
+        # full expansion twice should also result in the same data:
+        self.assertEquals(exp_f, exp_ff, '%s: full != full+full' % (msg))
+
+        # migration-safe CPU models have an extra feature:
+        # their static expansion should be equivalent to the full
+        # expansion (as their static expansion is also precise)
+        if self.isMigrationSafe(model['model']):
+            self.assertEquals(exp_sf['model']['props'], exp_f['model']['props'],
+                              '%s: props: static+full != full' % (msg))
+            self.assertEquals(exp_sf.get('qom-props'), exp_f.get('qom-props'),
+                              '%s: qom-props: static+full != full' % (msg))
+
+    def tryToMakeRunnable(self, model):
+        """Try to create a runnable version of the CPU model, by disabling
+        unavailable features
+        """
+        devprops = self.vm.command('device-list-properties',
+                                   typename=model['typename'])
+        proptypes = dict((p['name'], p['type']) for p in devprops)
+
+        props = {}
+        for f in model['unavailable-features']:
+            # try to disable only boolean properties:
+            if proptypes.get(f) == 'bool':
+                props[f] = False
+
+        if not props:
+            # no property found to be disabled, there's nothing we can do
+            return None
+
+        runnable_model = {
+            'model': {
+                'name':  model['name'],
+                'props': props,
+            },
+        }
+        return runnable_model
+
+    def commandAvailable(self, command):
+        commands = self.vm.command('query-commands')
+        names = set([c['name'] for c in commands])
+        return command in names
+
+    def checkOneCPUModel(self, m):
+        """Run multiple query-cpu-model-expansion checks
+
+        * Test simple CPU model name
+        * Test CPU model with unsafe features explicitly disabled
+          if it's not migration-safe
+        * Test CPU model with unsafe features enabled
+        * Test CPU model with unavailable features disabled,
+          if unavailable-features is set
+
+        @m is a CpuDefinitionInfo struct from query-cpu-definitions
+        """
+        msg = '%s.%s' % (self.accel, m['name'])
+        logging.info("%s: checkOneCPUModel", msg)
+
+
+        # some validations on query-cpu-definitions output:
+        if m.get('static'):
+            self.assertTrue(m['migration-safe'])
+
+        # simulate return value of query-cpu-expansion for the model:
+        model = {
+            'model': {
+                'name': m['name'],
+            },
+        }
+        if m.has_key('unavailable-features'):
+            model['runnable'] = len(m['unavailable-features']) == 0
+        self.checkExpansions(model, msg)
+
+        # explicit test to check we do the right thing when
+        # unsafe features are enabled explicitly:
+        for f in self.unsafeFeatures():
+            # enabled:
+            unsafe_model = {
+                'model': {
+                    'name':  m['name'],
+                    'props': { f: True },
+                },
+                'runnable': model.get('runnable'),
+            }
+            self.checkExpansions(unsafe_model, msg + ".unsafe." + f)
+
+        # Try to make CPU model migration-safe by disabling
+        # all known migration-unsafe features:
+        if not m['migration-safe']:
+            # enabled:
+            safe_model = {
+                'model': {
+                    'name':  m['name'],
+                    'props': {}
+                },
+                'runnable': model.get('runnable'),
+            }
+            for f in self.unsafeFeatures():
+                safe_model['model']['props'][f] = False
+            self.checkExpansions(safe_model, msg + ".safe")
+
+        # if not runnable, try to create a runnable version of the CPU model:
+        if m.get('unavailable-features'):
+            runnable_model = self.tryToMakeRunnable(m)
+            if runnable_model:
+                self.checkExpansions(runnable_model, msg + ".runnable")
+
+    @classmethod
+    def setUpClass(klass):
+        vm = QEMUQtestMachine(args=['-S'], logging=False)
+        try:
+            vm.launch()
+            klass.kvm = vm.command('query-kvm')
+            klass.target = vm.command('query-target')
+        finally:
+            vm.shutdown()
+
+    def setUp(self):
+        self.vm = None
+
+    def tearDown(self):
+        if self.vm:
+            self.vm.shutdown()
+
+    def checkAllCPUModels(self):
+        # use <accel>:tcg so QEMU won't refuse to start if KVM is unavailable
+        self.vm = QEMUQtestMachine(args=['-S', '-machine',
+                                    'accel=%s:tcg' % (self.accel)],
+                              logging=False)
+        self.vm.launch()
+
+        models = self.vm.command('query-cpu-definitions')
+        self.cpu_models = dict((m['name'], m) for m in models)
+
+        if self.accel == 'kvm':
+            if not self.vm.command('query-kvm')['enabled']:
+                self.skipTest("Failed to enable KVM")
+
+        to_test = MODELS_TO_TEST.get(self.target['arch'])
+        for m in models:
+            if to_test and m['name'] not in to_test:
+                continue
+            self.checkOneCPUModel(m)
+
+
+    def testTCGModels(self):
+        self.accel = 'tcg'
+        self.checkAllCPUModels()
+
+    def testKVMModels(self):
+        if not self.kvm['present']:
+            self.skipTest("KVM is not present")
+
+        self.accel = 'kvm'
+        self.checkAllCPUModels()
+
+
+
+if __name__ == '__main__':
+    if os.getenv('QTEST_LOG_LEVEL'):
+        logging.basicConfig(level=int(os.getenv('QTEST_LOG_LEVEL')))
+    elif '--verbose' in sys.argv:
+        logging.basicConfig(level=logging.INFO)
+    else:
+        logging.basicConfig(level=logging.WARN)
+    unittest.main()
-- 
2.11.0.259.g40922b1
