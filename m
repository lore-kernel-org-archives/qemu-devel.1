Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179DCC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCB720873
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 14:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCB720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1WV8-0002aM-33
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 09:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1WUC-0001Nf-2U
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1j1WUA-0002Rq-SR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:26:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:45002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j1WUA-0002QC-LY
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 09:25:58 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1j1WU4-00009Q-IT; Tue, 11 Feb 2020 17:25:52 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] tests/acceptance/virtio_check_params: prepare to check
 different params
Date: Tue, 11 Feb 2020 17:25:51 +0300
Message-Id: <20200211142551.13072-3-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200211142551.13072-1-dplotnikov@virtuozzo.com>
References: <20200211142551.13072-1-dplotnikov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: cohuck@redhat.com, philmd@redhat.com, wainersm@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 tests/acceptance/virtio_check_params.py | 38 ++++++++++++++-----------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/tests/acceptance/virtio_check_params.py b/tests/acceptance/virtio_check_params.py
index deec89bf86..e578952a97 100644
--- a/tests/acceptance/virtio_check_params.py
+++ b/tests/acceptance/virtio_check_params.py
@@ -43,7 +43,7 @@ VM_DEV_PARAMS = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
 EXCLUDED_MACHINES = ['none', 'isapc', 'microvm']
 
 
-class VirtioMaxSegSettingsCheck(Test):
+class VirtioParamsCheck(Test):
     @staticmethod
     def make_pattern(props):
         pattern_items = ['{0} = \w+'.format(prop) for prop in props]
@@ -75,12 +75,12 @@ class VirtioMaxSegSettingsCheck(Test):
                 props[p[0]] = p[1]
         return query_ok, props, error
 
-    def check_mt(self, mt, dev_type_name):
-        mt['device'] = dev_type_name # Only for the debug() call.
+    def check_mt(self, mt, expected_vals, dev_type_name):
+        msg = "mt: %s dev: %s" % (mt, dev_type_name) # For debug() call only.
         logger = logging.getLogger('machine')
-        logger.debug(mt)
+        logger.debug(msg)
         with QEMUMachine(self.qemu_bin) as vm:
-            vm.set_machine(mt["name"])
+            vm.set_machine(mt)
             vm.add_args('-nodefaults')
             for s in VM_DEV_PARAMS[dev_type_name]:
                 vm.add_args(s)
@@ -92,11 +92,15 @@ class VirtioMaxSegSettingsCheck(Test):
                 error = sys.exc_info()[0]
 
         if not query_ok:
-            self.fail('machine type {0}: {1}'.format(mt['name'], error))
+            self.fail('machine type {0}: {1}'.format(mt, error))
 
         for prop_name, prop_val in props.items():
-            expected_val = mt[prop_name]
-            self.assertEqual(expected_val, prop_val)
+            expected_val = expected_vals[prop_name]
+            msg = 'Property value mismatch for (MT: {0}, '\
+                  'property name: {1}): expected value: "{2}" '\
+                  'actual value: "{3}"'\
+                  .format(mt, prop_name, expected_val, prop_val)
+            self.assertEqual(expected_val, prop_val, msg)
 
     @staticmethod
     def seg_max_adjust_enabled(mt):
@@ -128,25 +132,27 @@ class VirtioMaxSegSettingsCheck(Test):
 
     @skip("break multi-arch CI")
     def test_machine_types(self):
-        # collect all machine types except 'none', 'isapc', 'microvm'
+        # collect all machine types
         with QEMUMachine(self.qemu_bin) as vm:
             vm.launch()
             machines = [m['name'] for m in vm.command('query-machines')]
             vm.shutdown()
 
+        # ..and exclude non-relevant ones
         machines = self.filter_machines(machines)
 
         for dev_type in DEV_TYPES:
-            # create the list of machine types and their parameters.
-            mtypes = list()
+            # define expected parameters for each machine type
+            mt_expected_vals = dict()
             for m in machines:
                 if self.seg_max_adjust_enabled(m):
                     enabled = 'true'
                 else:
                     enabled = 'false'
-                mtypes.append({'name': m,
-                               DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
 
-            # test each machine type for a device type
-            for mt in mtypes:
-                self.check_mt(mt, dev_type)
+                mt_expected_vals[m] = {
+                    DEV_TYPES[dev_type]['seg_max_adjust']: enabled }
+
+            # test each machine type
+            for mt in mt_expected_vals:
+                self.check_mt(mt, mt_expected_vals[mt], dev_type)
-- 
2.17.0


