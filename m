Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA402C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B662133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B662133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFTLK-000850-CC
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRse-00024w-H7
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0002al-TJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsT-000222-Cc; Tue, 01 Oct 2019 19:48:24 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPoM088139; Tue, 1 Oct 2019 19:47:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjt6c49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:58 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlVVp088357;
 Tue, 1 Oct 2019 19:47:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjt6c40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njm6A023587;
 Tue, 1 Oct 2019 23:47:57 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577h0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:57 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlu4N23462304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:56 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 880D728059;
 Tue,  1 Oct 2019 23:47:56 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62AE528058;
 Tue,  1 Oct 2019 23:47:56 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:56 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 81/97] iotests: Test blockdev-create for vpc
Date: Tue,  1 Oct 2019 18:46:00 -0500
Message-Id: <20191001234616.7825-82-mdroth@linux.vnet.ibm.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit cb73747e1a47b93d3dfdc3f769c576b053916938)
 Conflicts:
	tests/qemu-iotests/group
*drop context dep. on tests not in 4.0
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qemu-iotests/266     | 153 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/266.out | 137 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 291 insertions(+)
 create mode 100755 tests/qemu-iotests/266
 create mode 100644 tests/qemu-iotests/266.out

diff --git a/tests/qemu-iotests/266 b/tests/qemu-iotests/266
new file mode 100755
index 0000000000..5b35cd67e4
--- /dev/null
+++ b/tests/qemu-iotests/266
@@ -0,0 +1,153 @@
+#!/usr/bin/env python
+#
+# Test VPC and file image creation
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+
+import iotests
+from iotests import imgfmt
+
+
+def blockdev_create(vm, options):
+    result = vm.qmp_log('blockdev-create', job_id='job0', options=options,
+                        filters=[iotests.filter_qmp_testfiles])
+
+    if 'return' in result:
+        assert result['return'] == {}
+        vm.run_job('job0')
+
+
+# Successful image creation (defaults)
+def implicit_defaults(vm, file_path):
+    iotests.log("=== Successful image creation (defaults) ===")
+    iotests.log("")
+
+    # 8 heads, 964 cyls/head, 17 secs/cyl
+    # (Close to 64 MB)
+    size = 8 * 964 * 17 * 512
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size })
+
+
+# Successful image creation (explicit defaults)
+def explicit_defaults(vm, file_path):
+    iotests.log("=== Successful image creation (explicit defaults) ===")
+    iotests.log("")
+
+    # 16 heads, 964 cyls/head, 17 secs/cyl
+    # (Close to 128 MB)
+    size = 16 * 964 * 17 * 512
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'subformat': 'dynamic',
+                          'force-size': False })
+
+
+# Successful image creation (non-default options)
+def non_defaults(vm, file_path):
+    iotests.log("=== Successful image creation (non-default options) ===")
+    iotests.log("")
+
+    # Not representable in CHS (fine with force-size=True)
+    size = 1048576
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'subformat': 'fixed',
+                          'force-size': True })
+
+
+# Size not representable in CHS with force-size=False
+def non_chs_size_without_force(vm, file_path):
+    iotests.log("=== Size not representable in CHS ===")
+    iotests.log("")
+
+    # Not representable in CHS (will not work with force-size=False)
+    size = 1048576
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': size,
+                          'force-size': False })
+
+
+# Zero size
+def zero_size(vm, file_path):
+    iotests.log("=== Zero size===")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 0 })
+
+
+# Maximum CHS size
+def maximum_chs_size(vm, file_path):
+    iotests.log("=== Maximum CHS size===")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 16 * 65535 * 255 * 512 })
+
+
+# Actual maximum size
+def maximum_size(vm, file_path):
+    iotests.log("=== Actual maximum size===")
+    iotests.log("")
+
+    blockdev_create(vm, { 'driver': imgfmt,
+                          'file': 'protocol-node',
+                          'size': 0xff000000 * 512,
+                          'force-size': True })
+
+
+def main():
+    for test_func in [implicit_defaults, explicit_defaults, non_defaults,
+                      non_chs_size_without_force, zero_size, maximum_chs_size,
+                      maximum_size]:
+
+        with iotests.FilePath('t.vpc') as file_path, \
+             iotests.VM() as vm:
+
+            vm.launch()
+
+            iotests.log('--- Creating empty file ---')
+            blockdev_create(vm, { 'driver': 'file',
+                                  'filename': file_path,
+                                  'size': 0 })
+
+            vm.qmp_log('blockdev-add', driver='file', filename=file_path,
+                       node_name='protocol-node',
+                       filters=[iotests.filter_qmp_testfiles])
+            iotests.log('')
+
+            print_info = test_func(vm, file_path)
+            iotests.log('')
+
+            vm.shutdown()
+            iotests.img_info_log(file_path)
+
+
+iotests.script_main(main,
+                    supported_fmts=['vpc'],
+                    supported_protocols=['file'])
diff --git a/tests/qemu-iotests/266.out b/tests/qemu-iotests/266.out
new file mode 100644
index 0000000000..b11953e81f
--- /dev/null
+++ b/tests/qemu-iotests/266.out
@@ -0,0 +1,137 @@
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Successful image creation (defaults) ===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "size": 67125248}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 64 MiB (67125248 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Successful image creation (explicit defaults) ===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "force-size": false, "size": 134250496, "subformat": "dynamic"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 128 MiB (134250496 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Successful image creation (non-default options) ===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "force-size": true, "size": 1048576, "subformat": "fixed"}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1 MiB (1048576 bytes)
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Size not representable in CHS ===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "force-size": false, "size": 1048576}}}
+{"return": {}}
+Job failed: The requested image size cannot be represented in CHS geometry
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+qemu-img: Could not open 'TEST_IMG': File too small for a VHD header
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Zero size===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 0 B (0 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Maximum CHS size===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "size": 136899993600}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 127 GiB (136899993600 bytes)
+cluster_size: 2097152
+
+--- Creating empty file ---
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "size": 0}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "TEST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
+{"return": {}}
+
+=== Actual maximum size===
+
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "vpc", "file": "protocol-node", "force-size": true, "size": 2190433320960}}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 1.99 TiB (2190433320960 bytes)
+cluster_size: 2097152
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 7aa6dc9875..3605796bb2 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -251,3 +251,4 @@
 253 rw auto quick
 255 rw auto quick
 256 rw auto quick
+266 rw quick
-- 
2.17.1


