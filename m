Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A08C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE83B20815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE83B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTq0-0006z7-QB
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtL-0002lz-Br
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRtJ-0003h8-3r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57580)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRtI-0003EN-Ou; Tue, 01 Oct 2019 19:49:12 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NmnCY005158; Tue, 1 Oct 2019 19:48:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxwett-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:49 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NmmJ1005008;
 Tue, 1 Oct 2019 19:48:48 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdfxwec3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:48:48 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlEk022439;
 Tue, 1 Oct 2019 23:47:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma04dal.us.ibm.com with ESMTP id 2v9y57yd5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:25 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlOdR47513940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:24 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FC8B2805A;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18D1E28058;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:24 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/97] iotests: add iotest 256 for testing blockdev-backup
 across iothread contexts
Date: Tue,  1 Oct 2019 18:45:02 -0500
Message-Id: <20191001234616.7825-24-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: John Snow <jsnow@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20190523170643.20794-6-jsnow@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
[mreitz: Moved from 250 to 256]
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit ba7704f2228f16ed61b9903801e28e17666c7e38)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/256     | 122 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/256.out | 119 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 242 insertions(+)
 create mode 100755 tests/qemu-iotests/256
 create mode 100644 tests/qemu-iotests/256.out

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
new file mode 100755
index 0000000000..c594a43205
--- /dev/null
+++ b/tests/qemu-iotests/256
@@ -0,0 +1,122 @@
+#!/usr/bin/env python
+#
+# Test incremental/backup across iothread contexts
+#
+# Copyright (c) 2019 John Snow for Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# owner=jsnow@redhat.com
+
+import os
+import iotests
+from iotests import log
+
+iotests.verify_image_format(supported_fmts=['qcow2'])
+size = 64 * 1024 * 1024
+
+with iotests.FilePath('img0') as img0_path, \
+     iotests.FilePath('img1') as img1_path, \
+     iotests.FilePath('img0-full') as img0_full_path, \
+     iotests.FilePath('img1-full') as img1_full_path, \
+     iotests.FilePath('img0-incr') as img0_incr_path, \
+     iotests.FilePath('img1-incr') as img1_incr_path, \
+     iotests.VM() as vm:
+
+    def create_target(filepath, name, size):
+        basename = os.path.basename(filepath)
+        nodename = "file_{}".format(basename)
+        log(vm.command('blockdev-create', job_id='job1',
+                       options={
+                           'driver': 'file',
+                           'filename': filepath,
+                           'size': 0,
+                       }))
+        vm.run_job('job1')
+        log(vm.command('blockdev-add', driver='file',
+                       node_name=nodename, filename=filepath))
+        log(vm.command('blockdev-create', job_id='job2',
+                       options={
+                           'driver': iotests.imgfmt,
+                           'file': nodename,
+                           'size': size,
+                       }))
+        vm.run_job('job2')
+        log(vm.command('blockdev-add', driver=iotests.imgfmt,
+                       node_name=name,
+                       file=nodename))
+
+    log('--- Preparing images & VM ---\n')
+    vm.add_object('iothread,id=iothread0')
+    vm.add_object('iothread,id=iothread1')
+    vm.add_device('virtio-scsi-pci,id=scsi0,iothread=iothread0')
+    vm.add_device('virtio-scsi-pci,id=scsi1,iothread=iothread1')
+    iotests.qemu_img_create('-f', iotests.imgfmt, img0_path, str(size))
+    iotests.qemu_img_create('-f', iotests.imgfmt, img1_path, str(size))
+    vm.add_drive(img0_path, interface='none')
+    vm.add_device('scsi-hd,id=device0,drive=drive0,bus=scsi0.0')
+    vm.add_drive(img1_path, interface='none')
+    vm.add_device('scsi-hd,id=device1,drive=drive1,bus=scsi1.0')
+
+    log('--- Starting VM ---\n')
+    vm.launch()
+
+    log('--- Create Targets & Full Backups ---\n')
+    create_target(img0_full_path, 'img0-full', size)
+    create_target(img1_full_path, 'img1-full', size)
+    ret = vm.qmp_log('transaction', indent=2, actions=[
+        { 'type': 'block-dirty-bitmap-add',
+          'data': { 'node': 'drive0', 'name': 'bitmap0' }},
+        { 'type': 'block-dirty-bitmap-add',
+          'data': { 'node': 'drive1', 'name': 'bitmap1' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive0',
+                    'target': 'img0-full',
+                    'sync': 'full',
+                    'job-id': 'j0' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive1',
+                    'target': 'img1-full',
+                    'sync': 'full',
+                    'job-id': 'j1' }}
+    ])
+    if "error" in ret:
+        raise Exception(ret['error']['desc'])
+    vm.run_job('j0', auto_dismiss=True)
+    vm.run_job('j1', auto_dismiss=True)
+
+    log('\n--- Create Targets & Incremental Backups ---\n')
+    create_target(img0_incr_path, 'img0-incr', size)
+    create_target(img1_incr_path, 'img1-incr', size)
+    ret = vm.qmp_log('transaction', indent=2, actions=[
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive0',
+                    'target': 'img0-incr',
+                    'sync': 'incremental',
+                    'bitmap': 'bitmap0',
+                    'job-id': 'j2' }},
+        { 'type': 'blockdev-backup',
+          'data': { 'device': 'drive1',
+                    'target': 'img1-incr',
+                    'sync': 'incremental',
+                    'bitmap': 'bitmap1',
+                    'job-id': 'j3' }}
+    ])
+    if "error" in ret:
+        raise Exception(ret['error']['desc'])
+    vm.run_job('j2', auto_dismiss=True)
+    vm.run_job('j3', auto_dismiss=True)
+
+    log('\n--- Done ---')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/256.out b/tests/qemu-iotests/256.out
new file mode 100644
index 0000000000..eec38614ec
--- /dev/null
+++ b/tests/qemu-iotests/256.out
@@ -0,0 +1,119 @@
+--- Preparing images & VM ---
+
+--- Starting VM ---
+
+--- Create Targets & Full Backups ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "name": "bitmap0",
+          "node": "drive0"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "name": "bitmap1",
+          "node": "drive1"
+        },
+        "type": "block-dirty-bitmap-add"
+      },
+      {
+        "data": {
+          "device": "drive0",
+          "job-id": "j0",
+          "sync": "full",
+          "target": "img0-full"
+        },
+        "type": "blockdev-backup"
+      },
+      {
+        "data": {
+          "device": "drive1",
+          "job-id": "j1",
+          "sync": "full",
+          "target": "img1-full"
+        },
+        "type": "blockdev-backup"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{"data": {"device": "j0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Create Targets & Incremental Backups ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job1"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "job2"}}
+{"return": {}}
+{}
+{
+  "execute": "transaction",
+  "arguments": {
+    "actions": [
+      {
+        "data": {
+          "bitmap": "bitmap0",
+          "device": "drive0",
+          "job-id": "j2",
+          "sync": "incremental",
+          "target": "img0-incr"
+        },
+        "type": "blockdev-backup"
+      },
+      {
+        "data": {
+          "bitmap": "bitmap1",
+          "device": "drive1",
+          "job-id": "j3",
+          "sync": "incremental",
+          "target": "img1-incr"
+        },
+        "type": "blockdev-backup"
+      }
+    ]
+  }
+}
+{
+  "return": {}
+}
+{"data": {"device": "j2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Done ---
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 19e2bb3aec..7aa6dc9875 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -250,3 +250,4 @@
 248 rw auto quick
 253 rw auto quick
 255 rw auto quick
+256 rw auto quick
-- 
2.17.1


