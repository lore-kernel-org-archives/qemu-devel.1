Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A754C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF00520872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzwyTus7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF00520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKmN-0001MB-K8
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKks-0000MF-T9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJKkp-0002nP-MU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600452303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGenVNsFHAsSYoxzYlDtrDLuy8WLSGh5++O8wHq504k=;
 b=MzwyTus7QO8fNDO9Z/Pyd1Asw4LzRZKiPfaIahkCEUO1pnSbrIi9Ld+uar94KJlnrsfA+B
 AImcnEV5LDfe6OITvSc16f79ggF4YYnyfvwpempRulP4v6EqV/tFkHpPEpFTuVqRgQouE0
 j/SnPf6bON48LKxNxlfQLZ1ZnjlDArQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-C-LytfRHM9u0xjxpasFifg-1; Fri, 18 Sep 2020 14:04:56 -0400
X-MC-Unique: C-LytfRHM9u0xjxpasFifg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3C7D5703F;
 Fri, 18 Sep 2020 18:04:54 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38C1B1002D53;
 Fri, 18 Sep 2020 18:04:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PULL 1/2] scripts/simplebench: compare write request performance
Date: Fri, 18 Sep 2020 14:04:50 -0400
Message-Id: <20200918180451.1121055-2-ehabkost@redhat.com>
In-Reply-To: <20200918180451.1121055-1-ehabkost@redhat.com>
References: <20200918180451.1121055-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

The script 'bench_write_req.py' allows comparing performances of write
request for two qemu-img binary files.
An example with (qemu-img binary 1) and without (qemu-img binary 2) the
applied patch "qcow2: skip writing zero buffers to empty COW areas"
(git commit ID: c8bb23cbdbe32f5) has the following results:

SSD:
----------------  -------------------  -------------------
                  <qemu-img binary 1>  <qemu-img binary 2>
<cluster front>   0.10 +- 0.00         8.16 +- 0.65
<cluster middle>  0.10 +- 0.00         7.37 +- 1.10
<cross cluster>   7.40 +- 1.08         21.97 +- 4.19
<cluster 64K>     2.14 +- 0.94         8.48 +- 1.66
----------------  -------------------  -------------------
HDD:
----------------  -------------------  -------------------
                  <qemu-img binary 1>  <qemu-img binary 2>
<cluster front>   2.30 +- 0.01         6.19 +- 0.06
<cluster middle>  2.20 +- 0.09         6.20 +- 0.06
<cross cluster>   8.32 +- 0.16         8.26 +- 0.14
<cluster 64K>     8.20 +- 0.05         6.26 +- 0.10
----------------  -------------------  -------------------

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1594741846-475697-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/simplebench/bench_write_req.py | 170 +++++++++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100755 scripts/simplebench/bench_write_req.py

diff --git a/scripts/simplebench/bench_write_req.py b/scripts/simplebench/bench_write_req.py
new file mode 100755
index 0000000000..ca1178fd68
--- /dev/null
+++ b/scripts/simplebench/bench_write_req.py
@@ -0,0 +1,170 @@
+#!/usr/bin/env python3
+#
+# Test to compare performance of write requests for two qemu-img binary files.
+#
+# The idea of the test comes from intention to check the benefit of c8bb23cbdbe
+# "qcow2: skip writing zero buffers to empty COW areas".
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
+                           case['cluster_size'])
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
+def bench_write_req(qemu_img, image_name, block_size, block_offset,
+                    cluster_size):
+    """Benchmark write requests
+
+    The function creates a QCOW2 image with the given path/name. Then it runs
+    the 'qemu-img bench' command and makes series of write requests on the
+    image clusters. Finally, it returns the total time of the write operations
+    on the disk.
+
+    qemu_img     -- path to qemu_img executable file
+    image_name   -- QCOW2 image name to create
+    block_size   -- size of a block to write to clusters
+    block_offset -- offset of the block in clusters
+    cluster_size -- size of the image cluster
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
+    image_size = 1024 * 1024 * 1024
+
+    args_create = [qemu_img, 'create', '-f', 'qcow2', '-o',
+                   f'cluster_size={cluster_size}',
+                   image_name, str(image_size)]
+
+    count = int(image_size / cluster_size) - 1
+    step = str(cluster_size)
+
+    args_bench = [qemu_img, 'bench', '-w', '-n', '-t', 'none', '-c',
+                  str(count), '-s', f'{block_size}', '-o', str(block_offset),
+                  '-S', step, '-f', 'qcow2', image_name]
+
+    try:
+        qemu_img_pipe(*args_create)
+    except OSError as e:
+        os.remove(image_name)
+        return {'error': 'qemu_img create failed: ' + str(e)}
+
+    try:
+        ret = qemu_img_pipe(*args_bench)
+    except OSError as e:
+        os.remove(image_name)
+        return {'error': 'qemu_img bench failed: ' + str(e)}
+
+    os.remove(image_name)
+
+    if 'seconds' in ret:
+        ret_list = ret.split()
+        index = ret_list.index('seconds.')
+        return {'seconds': float(ret_list[index-1])}
+    else:
+        return {'error': 'qemu_img bench failed: ' + ret}
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
+            'id': '<cluster front>',
+            'block_size': 4096,
+            'block_offset': 0,
+            'cluster_size': 1048576
+        },
+        {
+            'id': '<cluster middle>',
+            'block_size': 4096,
+            'block_offset': 524288,
+            'cluster_size': 1048576
+        },
+        {
+            'id': '<cross cluster>',
+            'block_size': 1048576,
+            'block_offset': 4096,
+            'cluster_size': 1048576
+        },
+        {
+            'id': '<cluster 64K>',
+            'block_size': 4096,
+            'block_offset': 0,
+            'cluster_size': 65536
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
2.26.2


