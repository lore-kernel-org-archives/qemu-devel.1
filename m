Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF76C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BDB2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BDB2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwo23-0005NB-Rg
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iwo09-0001Ku-NN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1iwo08-0001Cz-Dm
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:07:29 -0500
Received: from relay.sw.ru ([185.231.240.75]:53602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iwo08-00013P-5d; Wed, 29 Jan 2020 09:07:28 -0500
Received: from dptest2.qa.sw.ru ([10.94.4.71])
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <dplotnikov@virtuozzo.com>)
 id 1iwnzt-0003j6-AZ; Wed, 29 Jan 2020 17:07:13 +0300
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] tests: add virtuqueue size checking to
 virtio_seg_max_adjust test
Date: Wed, 29 Jan 2020 17:07:01 +0300
Message-Id: <20200129140702.5411-4-dplotnikov@virtuozzo.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is due to the change in the default virtqueue_size in the
latest machine type to improve guest disks performance.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 tests/acceptance/virtio_seg_max_adjust.py | 33 ++++++++++++++---------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/virtio_seg_max_adjust.py
index 5458573138..645d69b313 100755
--- a/tests/acceptance/virtio_seg_max_adjust.py
+++ b/tests/acceptance/virtio_seg_max_adjust.py
@@ -27,8 +27,10 @@ from qemu.machine import QEMUMachine
 from avocado_qemu import Test
 
 #list of machine types and virtqueue properties to test
-VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust'}
-VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust'}
+VIRTIO_SCSI_PROPS = {'seg_max_adjust': 'seg_max_adjust',
+                     'queue_size': 'virtqueue_size'}
+VIRTIO_BLK_PROPS = {'seg_max_adjust': 'seg-max-adjust',
+                    'queue_size': 'queue-size'}
 
 DEV_TYPES = {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
              'virtio-blk-pci': VIRTIO_BLK_PROPS}
@@ -40,7 +42,7 @@ VM_DEV_PARAMS = {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=scsi0'],
                                     'driver=null-co,id=drive0,if=none']}
 
 
-class VirtioMaxSegSettingsCheck(Test):
+class VirtioPramsCheck(Test):
     @staticmethod
     def make_pattern(props):
         pattern_items = ['{0} = \w+'.format(prop) for prop in props]
@@ -72,20 +74,24 @@ class VirtioMaxSegSettingsCheck(Test):
                 props[p[0]] = p[1]
         return query_ok, props, error
 
-    def check_mt(self, mt, dev_type_name):
+    def check_mt(self, mt, expected_props, dev_type_name):
         with QEMUMachine(self.qemu_bin) as vm:
-            vm.set_machine(mt["name"])
+            vm.set_machine(mt)
             for s in VM_DEV_PARAMS[dev_type_name]:
                 vm.add_args(s)
             vm.launch()
             query_ok, props, error = self.query_virtqueue(vm, dev_type_name)
 
         if not query_ok:
-            self.fail('machine type {0}: {1}'.format(mt['name'], error))
+            self.fail('machine type {0}: {1}'.format(mt, error))
 
         for prop_name, prop_val in props.items():
-            expected_val = mt[prop_name]
-            self.assertEqual(expected_val, prop_val)
+            expected_val = expected_props[prop_name]
+            msg = 'Property value mismatch for (MT: {0}, '\
+                  'property name: {1}): expected value: "{2}" '\
+                  'actual value: "{3}"'\
+                  .format(mt, prop_name, expected_val, prop_val)
+            self.assertEqual(expected_val, prop_val, msg)
 
     @staticmethod
     def seg_max_adjust_enabled(mt):
@@ -120,15 +126,18 @@ class VirtioMaxSegSettingsCheck(Test):
 
         for dev_type in DEV_TYPES:
             # create the list of machine types and their parameters.
-            mtypes = list()
+            mtypes = dict()
             for m in machines:
                 if self.seg_max_adjust_enabled(m):
                     enabled = 'true'
+                    queue_size = '256'
                 else:
                     enabled = 'false'
-                mtypes.append({'name': m,
-                               DEV_TYPES[dev_type]['seg_max_adjust']: enabled})
+                    queue_size = '128'
+                mtypes[m] = {
+                    DEV_TYPES[dev_type]['seg_max_adjust']: enabled,
+                    DEV_TYPES[dev_type]['queue_size']: queue_size }
 
             # test each machine type for a device type
             for mt in mtypes:
-                self.check_mt(mt, dev_type)
+                self.check_mt(mt, mtypes[mt], dev_type)
-- 
2.17.0


