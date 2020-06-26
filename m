Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C112206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C112206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jopRO-0007or-CS
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jopOg-0005JN-4X; Fri, 26 Jun 2020 10:32:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:47852 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jopOc-0004eA-Mi; Fri, 26 Jun 2020 10:32:05 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jopOG-0006ri-H0; Fri, 26 Jun 2020 17:31:40 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2] scripts/simplebench: compare write request performance
Date: Fri, 26 Jun 2020 17:31:55 +0300
Message-Id: <1593181915-853845-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 10:31:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The script 'bench_write_req.py' allows comparing performances of write
request for two qemu-img binary files.
An example with (qemu-img binary 1) and without (qemu-img binary 2) the
applied patch "qcow2: skip writing zero buffers to empty COW areas"
(git commit ID: c8bb23cbdbe32f5)
The <unaligned> case does not involve the COW optimization.

SSD:
-----------------  -------------------  -------------------
                   <qemu-img binary 1>  <qemu-img binary 2>
<simple case>      2.72 +- 0.00         11.67 +- 1.04
<general case>     0.34 +- 0.00         8.64 +- 1.55
<cluster middle>   0.33 +- 0.01         8.13 +- 2.05
<cluster overlap>  8.46 +- 0.06         12.97 +- 1.07
<unaligned>        9.27 +- 2.04         8.83 +- 0.84
-----------------  -------------------  -------------------
HDD:
-----------------  -------------------  -------------------
                   <qemu-img binary 1>  <qemu-img binary 2>
<simple case>      617.86 +- 6.78       608.84 +- 10.72
<general case>     57.53 +- 3.56        52.99 +- 7.48
<cluster middle>   60.50 +- 1.92        56.11 +- 5.20
<cluster overlap>  12.10 +- 1.10        15.16 +- 2.56
<unaligned>        6.23 +- 0.05         6.40 +- 0.07
-----------------  -------------------  -------------------

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
v2:
  01: Three more test cases added to the script:
      <simple case>
      <general case>
      <unaligned>

 scripts/simplebench/bench_write_req.py | 201 +++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100755 scripts/simplebench/bench_write_req.py

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
new file mode 100755
index 0000000..fe92d01
--- /dev/null
+++ b/scripts/simplebench/bench_write_req.py
@@ -0,0 +1,201 @@
+#!/usr/bin/env python3
+#
+# Test to compare performance of write requests for two qemu-img binary files.
+#
+# Copyright (c) 2020 Virtuozzo International GmbH.
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
+
+import sys
+import os
+import subprocess
+import simplebench
+
+
+def bench_func(env, case):
+    """ Handle one "cell" of benchmarking table. """
+    return bench_write_req(env['qemu_img'], env['image_name'],
+                           case['block_size'], case['block_offset'],
+                           case['requests'], case['empty_image'])
+
+
+def qemu_img_pipe(*args):
+    '''Run qemu-img and return its output'''
+    subp = subprocess.Popen(list(args),
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            universal_newlines=True)
+    exitcode = subp.wait()
+    if exitcode < 0:
+        sys.stderr.write('qemu-img received signal %i: %s\n'
+                         % (-exitcode, ' '.join(list(args))))
+    return subp.communicate()[0]
+
+
+def bench_write_req(qemu_img, image_name, block_size, block_offset, requests,
+                    empty_image):
+    """Benchmark write requests
+
+    qemu_img     -- path to qemu_img executable file
+    image_name   -- QCOW2 image name to create
+    block_size   -- size of a block to write to clusters
+    block_offset -- offset of the block in clusters
+    requests     -- number of write requests per cluster, customize if zero
+    empty_image  -- if True, fill image with random data
+
+    Returns {'seconds': int} on success and {'error': str} on failure.
+    Return value is compatible with simplebench lib.
+    """
+
+    if not os.path.isfile(qemu_img):
+        print('File not found: {}'.format(qemu_img))
+        sys.exit(1)
+
+    image_dir = os.path.dirname(os.path.abspath(image_name))
+    if not os.path.isdir(image_dir):
+        print('Path not found: {}'.format(image_name))
+        sys.exit(1)
+
+    cluster_size = 1024 * 1024
+    image_size = 1024 * cluster_size
+    seek = 4
+    dd_count = int(image_size / cluster_size) - seek
+
+    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
+                   'cluster_size={}'.format(cluster_size),
+                   image_name, str(image_size)]
+
+    if requests:
+        count = requests * int(image_size / cluster_size)
+        step = str(cluster_size)
+    else:
+        # Create unaligned write requests
+        assert block_size
+        shift = int(block_size * 1.01)
+        count = int((image_size - block_offset) / shift)
+        step = str(shift)
+        depth = ['-d', '2']
+
+    offset = str(block_offset)
+    cnt = str(count)
+    size = []
+    if block_size:
+        size = ['-s', '{}'.format(block_size)]
+
+    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c', cnt,
+                  '-S', step, '-o', offset, '-f', 'qcow2', image_name]
+    if block_size:
+        args_bench.extend(size)
+    if not requests:
+        args_bench.extend(depth)
+
+    try:
+        qemu_img_pipe(*args_create)
+
+        if not empty_image:
+            dd = ['dd', 'if=/dev/urandom', 'of={}'.format(image_name),
+                  'bs={}'.format(cluster_size), 'seek={}'.format(seek),
+                  'count={}'.format(dd_count), '&&', 'sync']
+            devnull = open('/dev/null', 'w')
+            subprocess.call(dd, stderr=devnull, stdout=devnull)
+
+    except OSError as e:
+        return {'error': 'qemu_img create failed: ' + str(e)}
+
+    try:
+        ret = qemu_img_pipe(*args_bench)
+    except OSError as e:
+        return {'error': 'qemu_img bench failed: ' + str(e)}
+    finally:
+        os.remove(image_name)
+        if not ret:
+            return {'error': 'qemu_img bench failed'}
+        if 'seconds' in ret:
+            ret = ret.split()
+            index = ret.index('seconds.')
+            return {'seconds': float(ret[index-1])}
+        else:
+            return {'error': 'qemu_img bench failed: ' + ret}
+
+
+if __name__ == '__main__':
+
+    if len(sys.argv) < 4:
+        print('USAGE: {} <path to qemu-img binary file> '
+              '<path to another qemu-img to compare performance with> '
+              '<full or relative name for QCOW2 image to create>'
+              ''.format(os.path.basename(sys.argv[0])))
+        exit(1)
+
+    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
+    # for the row, other fields are handled by bench_func.
+    test_cases = [
+        {
+            'id': '<simple case>',
+            'block_size': 0,
+            'block_offset': 0,
+            'requests': 10,
+            'empty_image': False
+        },
+        {
+            'id': '<general case>',
+            'block_size': 4096,
+            'block_offset': 0,
+            'requests': 10,
+            'empty_image': False
+        },
+        {
+            'id': '<cluster middle>',
+            'block_size': 4096,
+            'block_offset': 524288,
+            'requests': 10,
+            'empty_image': False
+        },
+        {
+            'id': '<cluster overlap>',
+            'block_size': 524288,
+            'block_offset': 4096,
+            'requests': 2,
+            'empty_image': False
+        },
+        {
+            'id': '<unaligned>',
+            'block_size': 104857600,
+            'block_offset': 524288,
+            'requests': 0,
+            'empty_image': False
+        },
+    ]
+
+    # Test-envs are "columns" in benchmark resulting table, 'id is a caption
+    # for the column, other fields are handled by bench_func.
+    # Set the paths below to desired values
+    test_envs = [
+        {
+            'id': '<qemu-img binary 1>',
+            'qemu_img': '{}'.format(sys.argv[1]),
+            'image_name': '{}'.format(sys.argv[3])
+        },
+        {
+            'id': '<qemu-img binary 2>',
+            'qemu_img': '{}'.format(sys.argv[2]),
+            'image_name': '{}'.format(sys.argv[3])
+        },
+    ]
+
+    result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
+                               initial_run=False)
+    print(simplebench.ascii(result))
-- 
1.8.3.1


