Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F85CC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 17:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C7C20725
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 17:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C7C20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jug8F-0005iN-8m
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 13:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6Q-00039c-VY; Sun, 12 Jul 2020 13:49:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:60379 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6N-0001lA-9E; Sun, 12 Jul 2020 13:49:26 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jug6B-0005LT-Ho; Sun, 12 Jul 2020 20:49:11 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/3] scripts/simplebench: compare write request performance
Date: Sun, 12 Jul 2020 20:49:16 +0300
Message-Id: <1594576158-75884-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594576158-75884-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1594576158-75884-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 13:17:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
(git commit ID: c8bb23cbdbe32f5) has the following results:

SSD:
-----------------  -------------------  -------------------
                   <qemu-img binary 1>  <qemu-img binary 2>
<simple case>      0.34 +- 0.01         10.57 +- 0.96
<general case>     0.33 +- 0.01         9.15 +- 0.85
<cluster middle>   0.33 +- 0.00         8.72 +- 0.05
<cluster overlap>  7.43 +- 1.19         14.35 +- 1.00
-----------------  -------------------  -------------------
HDD:
-----------------  -------------------  -------------------
                   <qemu-img binary 1>  <qemu-img binary 2>
<simple case>      32.61 +- 1.17        55.11 +- 1.15
<general case>     54.28 +- 8.82        60.11 +- 2.76
<cluster middle>   57.93 +- 0.47        58.53 +- 0.51
<cluster overlap>  11.47 +- 0.94        17.29 +- 4.40
-----------------  -------------------  -------------------

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 scripts/simplebench/bench_write_req.py | 173 +++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100755 scripts/simplebench/bench_write_req.py

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
new file mode 100755
index 0000000..a285ef1
--- /dev/null
+++ b/scripts/simplebench/bench_write_req.py
@@ -0,0 +1,173 @@
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
+                           case['requests'])
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
+def bench_write_req(qemu_img, image_name, block_size, block_offset, requests):
+    """Benchmark write requests
+
+    The function creates a QCOW2 image with the given path/name and fills it
+    with random data optionally. Then it runs the 'qemu-img bench' command and
+    makes series of write requests on the image clusters. Finally, it returns
+    the total time of the write operations on the disk.
+
+    qemu_img     -- path to qemu_img executable file
+    image_name   -- QCOW2 image name to create
+    block_size   -- size of a block to write to clusters
+    block_offset -- offset of the block in clusters
+    requests     -- number of write requests per cluster
+
+    Returns {'seconds': int} on success and {'error': str} on failure.
+    Return value is compatible with simplebench lib.
+    """
+
+    if not os.path.isfile(qemu_img):
+        print(f'File not found: {qemu_img}')
+        sys.exit(1)
+
+    image_dir = os.path.dirname(os.path.abspath(image_name))
+    if not os.path.isdir(image_dir):
+        print(f'Path not found: {image_name}')
+        sys.exit(1)
+
+    cluster_size = 1024 * 1024
+    image_size = 1024 * cluster_size
+    seek = 4
+    dd_count = int(image_size / cluster_size) - seek
+
+    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
+                   f'cluster_size={cluster_size}',
+                   image_name, str(image_size)]
+
+    count = requests * int(image_size / cluster_size)
+    step = str(cluster_size)
+    offset = str(block_offset)
+    cnt = str(count)
+    size = []
+    if block_size:
+        size = ['-s', f'{block_size}']
+
+    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c', cnt,
+                  '-S', step, '-o', offset, '-f', 'qcow2', image_name]
+    if block_size:
+        args_bench.extend(size)
+
+    try:
+        qemu_img_pipe(*args_create)
+    except OSError as e:
+        os.remove(image_name)
+        return {'error': 'qemu_img create failed: ' + str(e)}
+
+    try:
+        ret = qemu_img_pipe(*args_bench)
+    finally:
+        os.remove(image_name)
+        if not ret:
+            return {'error': 'qemu_img bench failed'}
+        if 'seconds' in ret:
+            ret_list = ret.split()
+            index = ret_list.index('seconds.')
+            return {'seconds': float(ret_list[index-1])}
+        else:
+            return {'error': 'qemu_img bench failed: ' + ret}
+
+
+if __name__ == '__main__':
+
+    if len(sys.argv) < 4:
+        program = os.path.basename(sys.argv[0])
+        print(f'USAGE: {program} <path to qemu-img binary file> '
+              '<path to another qemu-img to compare performance with> '
+              '<full or relative name for QCOW2 image to create>')
+        exit(1)
+
+    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
+    # for the row, other fields are handled by bench_func.
+    test_cases = [
+        {
+            'id': '<simple case>',
+            'block_size': 0,
+            'block_offset': 0,
+            'requests': 10
+        },
+        {
+            'id': '<general case>',
+            'block_size': 4096,
+            'block_offset': 0,
+            'requests': 10
+        },
+        {
+            'id': '<cluster middle>',
+            'block_size': 4096,
+            'block_offset': 524288,
+            'requests': 10
+        },
+        {
+            'id': '<cluster overlap>',
+            'block_size': 524288,
+            'block_offset': 4096,
+            'requests': 2
+        },
+    ]
+
+    # Test-envs are "columns" in benchmark resulting table, 'id is a caption
+    # for the column, other fields are handled by bench_func.
+    # Set the paths below to desired values
+    test_envs = [
+        {
+            'id': '<qemu-img binary 1>',
+            'qemu_img': f'{sys.argv[1]}',
+            'image_name': f'{sys.argv[3]}'
+        },
+        {
+            'id': '<qemu-img binary 2>',
+            'qemu_img': f'{sys.argv[2]}',
+            'image_name': f'{sys.argv[3]}'
+        },
+    ]
+
+    result = simplebench.bench(bench_func, test_envs, test_cases, count=3,
+                               initial_run=False)
+    print(simplebench.ascii(result))
-- 
1.8.3.1


