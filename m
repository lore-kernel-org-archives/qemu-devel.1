Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA85C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10692073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10692073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcjf-0004mq-JB
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNo-0005Dq-8w
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVcNm-0002LC-Sf
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:15:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:47574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNd-0001wi-Ox; Fri, 15 Nov 2019 09:15:21 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVcNI-0006WW-CQ; Fri, 15 Nov 2019 17:15:00 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [RFC 24/24] python: benchmark new backup architecture
Date: Fri, 15 Nov 2019 17:14:44 +0300
Message-Id: <20191115141444.24155-25-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115141444.24155-1-vsementsov@virtuozzo.com>
References: <20191115141444.24155-1-vsementsov@virtuozzo.com>
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
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org, jsnow@redhat.com, crosa@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Benchmark test for the series. This patch is RFC, it would be strange
to commit it as is.. On the other hand I feel that we should commit
some example to show usage of simplebench and bench_block_job.

May be I should add some simple example to compare backup and mirror..
Any ideas?

Anyway, this patch is here to show, how I produced the table in the
series cover-letter.

Note that all used images are 1000M files filled by ones, including
images exported by two running NBD servers, and NBD servers are running
as:

qemu-nbd --persistent --nocache -p 10810 ones1000M-source
qemu-nbd --persistent --nocache -p 10809 ones1000M-target

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/bench-example.py | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100755 python/bench-example.py

diff --git a/python/bench-example.py b/python/bench-example.py
new file mode 100755
index 0000000000..fb4c61c968
--- /dev/null
+++ b/python/bench-example.py
@@ -0,0 +1,93 @@
+#!/usr/bin/env python3
+
+import simplebench
+from qemu.bench_block_job import bench_block_copy, drv_file, drv_nbd
+
+
+def bench_func(env, case):
+    return bench_block_copy(env['qemu_binary'], env['cmd'],
+                            case['source'], case['target'])
+
+
+test_cases = [
+    {
+        'id': 'ssd -> ssd',
+        'source': drv_file('/ssd/ones1000M-source'),
+        'target': drv_file('/ssd/ones1000M-target')
+    },
+    {
+        'id': 'ssd -> hdd',
+        'source': drv_file('/ssd/ones1000M-source'),
+        'target': drv_file('/test-a/ones1000M-target')
+    },
+    {
+        'id': 'hdd -> hdd',
+        'source': drv_file('/test-a/ones1000M-source'),
+        'target': drv_file('/test-a/ones1000M-target')
+    }
+]
+
+test_envs = [
+    {
+        'id': 'backup-old',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status--before/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'backup-old(no CR)',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status--before--no-copy-range/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'backup-new',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'backup-new(no CR)',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status--no-copy_range/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'mirror',
+        'cmd': 'blockdev-mirror',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status/x86_64-softmmu/qemu-system-x86_64'
+    }
+]
+
+result = simplebench.bench(bench_func, test_envs, test_cases, count=3)
+print(simplebench.ascii(result))
+
+test_cases = [
+    {
+        'id': 'nbd -> ssd',
+        'source': drv_nbd('172.16.24.200', '10810'),
+        'target': drv_file('/ssd/ones1000M-target')
+    },
+    {
+        'id': 'ssd -> nbd',
+        'source': drv_file('/ssd/ones1000M-target'),
+        'target': drv_nbd('172.16.24.200', '10809')
+    },
+]
+
+test_envs = [
+    {
+        'id': 'backup-old',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status--before/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'backup-new',
+        'cmd': 'blockdev-backup',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status/x86_64-softmmu/qemu-system-x86_64'
+    },
+    {
+        'id': 'mirror',
+        'cmd': 'blockdev-mirror',
+        'qemu_binary': '/work/src/qemu/up-block-copy-block-status/x86_64-softmmu/qemu-system-x86_64'
+    }
+]
+
+result = simplebench.bench(bench_func, test_envs, test_cases, count=2)
+print(simplebench.ascii(result))
-- 
2.21.0


