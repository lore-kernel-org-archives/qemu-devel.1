Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E8AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8994A20768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8994A20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnyFQ-0004ND-Nl
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 01:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jnyES-0002zx-Mc; Wed, 24 Jun 2020 01:46:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:57740 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jnyEP-0004hB-El; Wed, 24 Jun 2020 01:45:59 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jnyE7-0006px-Sg; Wed, 24 Jun 2020 08:45:39 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH] scripts/simplebench: compare write request performance
Date: Wed, 24 Jun 2020 08:45:50 +0300
Message-Id: <1592977550-692121-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:45:53
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

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 scripts/simplebench/bench_write_req.py | 150 +++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)
 create mode 100755 scripts/simplebench/bench_write_req.py

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
new file mode 100755
index 0000000..e127dcc
--- /dev/null
+++ b/scripts/simplebench/bench_write_req.py
@@ -0,0 +1,150 @@
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
+    qemu_img     -- path to qemu_img executable file
+    image_name   -- QCOW2 image name to create
+    block_size   -- size of a block to write to clusters
+    block_offset -- offset of the block in clusters
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
+    count = requests * int(image_size / cluster_size)
+    image_size = str(image_size)
+
+    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
+                   'cluster_size={}'.format(cluster_size),
+                   image_name, image_size]
+
+    cluster_size = str(cluster_size)
+    offset = str(block_offset)
+    size = str(block_size)
+    cnt = str(count)
+    args_bench = [qemu_img, 'bench', '-c', cnt, '-w', '-t', 'none', '-s', size,
+                  '-S', cluster_size, '-o', offset, '-f', 'qcow2', image_name]
+
+    try:
+        qemu_img_pipe(*args_create)
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
+              '<full or relative name for 10G QCOW2 image to create>'
+              ''.format(os.path.basename(sys.argv[0])))
+        exit(1)
+
+    # Test-cases are "rows" in benchmark resulting table, 'id' is a caption
+    # for the row, other fields are handled by bench_func.
+    test_cases = [
+        {
+            'id': '<cluster middle>',
+            'block_size': 4096,
+            'block_offset': 524288,
+            'requests': 100
+        },
+        {
+            'id': '<cluster overlap>',
+            'block_size': 524288,
+            'block_offset': 4096,
+            'requests': 10
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


