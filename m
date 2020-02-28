Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E9C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488D52469C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488D52469C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Zxx-0006ov-Gk
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 02:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvm-0002Zf-8l
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j7Zvl-00061U-0K
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:19:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:51948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zvk-00060e-OS; Fri, 28 Feb 2020 02:19:28 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j7Zve-0002hc-HV; Fri, 28 Feb 2020 10:19:22 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] scripts/simplebench: add example usage of simplebench
Date: Fri, 28 Feb 2020 10:19:13 +0300
Message-Id: <20200228071914.11746-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228071914.11746-1-vsementsov@virtuozzo.com>
References: <20200228071914.11746-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This example may be used as a template for custom benchmark.
It illustrates three things to prepare:
 - define bench_func
 - define test environments (columns)
 - define test cases (rows)
And final call of simplebench API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/simplebench/bench-example.py | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 scripts/simplebench/bench-example.py

diff --git a/scripts/simplebench/bench-example.py b/scripts/simplebench/bench-example.py
new file mode 100644
index 0000000000..c642a5b891
--- /dev/null
+++ b/scripts/simplebench/bench-example.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python3
+#
+# Benchmark example
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+import simplebench
+from bench_block_job import bench_block_copy, drv_file, drv_nbd
+
+
+def bench_func(env, case):
+    """ Handle one "cell" of benchmarking table. """
+    return bench_block_copy(env['qemu_binary'], env['cmd'],
+                            case['source'], case['target'])
+
+
+# You may set the following five variables to correct values, to turn this
+# example to real benchmark.
+ssd_source = '/path-to-raw-source-image-at-ssd'
+ssd_target = '/path-to-raw-target-image-at-ssd'
+hdd_target = '/path-to-raw-source-image-at-hdd'
+nbd_ip = 'nbd-ip-addr'
+nbd_port = 'nbd-port-number'
+
+# Test-cases are "rows" in benchmark resulting table, 'id' is a caption for
+# the row, other fields are handled by bench_func.
+test_cases = [
+    {
+        'id': 'ssd -> ssd',
+        'source': drv_file(ssd_source),
+        'target': drv_file(ssd_target)
+    },
+    {
+        'id': 'ssd -> hdd',
+        'source': drv_file(ssd_source),
+        'target': drv_file(hdd_target)
+    },
+    {
+        'id': 'ssd -> nbd',
+        'source': drv_file(ssd_source),
+        'target': drv_nbd(nbd_ip, nbd_port)
+    },
+]
+
+# Test-envs are "columns" in benchmark resulting table, 'id is a caption for
+# the column, other fields are handled by bench_func.
+test_envs = [
+    {
+        'id': 'backup-1',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/path-to-qemu-binary-1'
+    },
+    {
+        'id': 'backup-2',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/path-to-qemu-binary-2'
+    },
+    {
+        'id': 'mirror',
+        'cmd': 'blockdev-mirror',
+        'qemu_binary': '/path-to-qemu-binary-1'
+    }
+]
+
+result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
+print(simplebench.ascii(result))
-- 
2.21.0


