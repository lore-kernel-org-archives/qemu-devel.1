Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A193C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AAA2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AAA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZdAm-0000zK-IS
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 10:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZd5G-0003FV-LB
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iZd5F-0002eV-12
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 10:48:58 -0500
Received: from relay.sw.ru ([185.231.240.75]:52184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZd5E-0002c3-PX; Tue, 26 Nov 2019 10:48:56 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iZd57-00069i-K4; Tue, 26 Nov 2019 18:48:49 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 1/3] python: add simplebench.py
Date: Tue, 26 Nov 2019 18:48:46 +0300
Message-Id: <20191126154848.193407-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191126154848.193407-1-vsementsov@virtuozzo.com>
References: <20191126154848.193407-1-vsementsov@virtuozzo.com>
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
 stefanha@gmail.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add simple benchmark table creator.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/simplebench.py | 128 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 python/simplebench.py

diff --git a/python/simplebench.py b/python/simplebench.py
new file mode 100644
index 0000000000..59e7314ff6
--- /dev/null
+++ b/python/simplebench.py
@@ -0,0 +1,128 @@
+#!/usr/bin/env python
+#
+# Simple benchmarking framework
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
+
+def bench_one(test_func, test_env, test_case, count=5, initial_run=True):
+    """Benchmark one test-case
+
+    test_func   -- benchmarking function with prototype
+                   test_func(env, case), which takes test_env and test_case
+                   arguments and returns {'seconds': int} (which is benchmark
+                   result) on success and {'error': str} on error. Returned
+                   dict may contain any other additional fields.
+    test_env    -- test environment - opaque first argument for test_func
+    test_case   -- test case - opaque second argument for test_func
+    count       -- how many times to call test_func, to calculate average
+    initial_run -- do initial run of test_func, which don't get into result
+
+    Returns dict with the following fields:
+        'runs':     list of test_func results
+        'average':  average seconds per run (exists only if at least one run
+                    succeeded)
+        'delta':    maximum delta between test_func result and the average
+                    (exists only if at least one run succeeded)
+        'n-failed': number of failed runs (exists only if at least one run
+                    failed)
+    """
+    if initial_run:
+        print('  #initial run:')
+        print('   ', test_func(test_env, test_case))
+
+    runs = []
+    for i in range(count):
+        print('  #run {}'.format(i+1))
+        res = test_func(test_env, test_case)
+        print('   ', res)
+        runs.append(res)
+
+    result = {'runs': runs}
+
+    successed = [r for r in runs if ('seconds' in r)]
+    if successed:
+        avg = sum(r['seconds'] for r in successed) / len(successed)
+        result['average'] = avg
+        result['delta'] = max(abs(r['seconds'] - avg) for r in successed)
+
+    if len(successed) < count:
+        result['n-failed'] = count - len(successed)
+
+    return result
+
+
+def ascii_one(result):
+    """Return ASCII representation of bench_one() returned dict."""
+    if 'average' in result:
+        s = '{:.2f} +- {:.2f}'.format(result['average'], result['delta'])
+        if 'n-failed' in result:
+            s += '\n({} failed)'.format(result['n-failed'])
+        return s
+    else:
+        return 'FAILED'
+
+
+def bench(test_func, test_envs, test_cases, *args, **vargs):
+    """Fill benchmark table
+
+    test_func -- benchmarking function, see bench_one for description
+    test_envs -- list of test environments, see bench_one
+    test_cases -- list of test cases, see bench_one
+    args, vargs -- additional arguments for bench_one
+
+    Returns dict with the following fields:
+        'envs':  test_envs
+        'cases': test_cases
+        'tab':   filled 2D array, where cell [i][j] is bench_one result for
+                 test_cases[i] for test_envs[j] (i.e., rows are test cases and
+                 columns are test environments)
+    """
+    tab = {}
+    results = {
+        'envs': test_envs,
+        'cases': test_cases,
+        'tab': tab
+    }
+    n = 1
+    n_tests = len(test_envs) * len(test_cases)
+    for env in test_envs:
+        for case in test_cases:
+            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
+                                                   env['id'], case['id']))
+            if case['id'] not in tab:
+                tab[case['id']] = {}
+            tab[case['id']][env['id']] = bench_one(test_func, env, case,
+                                                   *args, **vargs)
+            n += 1
+
+    print('Done')
+    return results
+
+
+def ascii(results):
+    """Return ASCII representation of bench() returned dict."""
+    from tabulate import tabulate
+
+    tab = [[""] + [c['id'] for c in results['envs']]]
+    for case in results['cases']:
+        row = [case['id']]
+        for env in results['envs']:
+            row.append(ascii_one(results['tab'][case['id']][env['id']]))
+        tab.append(row)
+
+    return tabulate(tab)
-- 
2.18.0


