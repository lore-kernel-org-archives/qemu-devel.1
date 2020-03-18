Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68712C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328B8206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 01:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVutRdIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328B8206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jENHN-0000Cm-Dy
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 21:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jENG0-0007Rt-Vm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jENFz-0004UN-Gm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jENFz-0004QY-Bc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 21:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584493946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKMemzxXZBqk7hT78k1ip1hdWck5pBCC98Uw9VTFjSo=;
 b=fVutRdIOZH3e+9Si4RSxAOYsVR+dJ5JUsO131hN3s4/yZs3eOmTH8ninORn89JJUjJWwKQ
 RUkdQ1czrfXOmQuCHVEAmyO+Hw3zl1L7eELIwsNfVJ7COOS11jdbpUduzSlQVdTRZca8qm
 GZlg/2sKYoUzxp8FEqaCahxnm2GUkLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-xYSISwthPhuw69n-uEXj1g-1; Tue, 17 Mar 2020 21:12:22 -0400
X-MC-Unique: xYSISwthPhuw69n-uEXj1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D591B1857BE0;
 Wed, 18 Mar 2020 01:12:21 +0000 (UTC)
Received: from localhost (ovpn-118-148.rdu2.redhat.com [10.10.118.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731B37386D;
 Wed, 18 Mar 2020 01:12:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/4] scripts/simplebench: add simplebench.py
Date: Tue, 17 Mar 2020 21:12:14 -0400
Message-Id: <20200318011217.2102748-2-ehabkost@redhat.com>
In-Reply-To: <20200318011217.2102748-1-ehabkost@redhat.com>
References: <20200318011217.2102748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add simple benchmark table creator.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20200228071914.11746-2-vsementsov@virtuozzo.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/simplebench/simplebench.py | 128 +++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 scripts/simplebench/simplebench.py

diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/simpl=
ebench.py
new file mode 100644
index 0000000000..59e7314ff6
--- /dev/null
+++ b/scripts/simplebench/simplebench.py
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
+def bench_one(test_func, test_env, test_case, count=3D5, initial_run=3DTru=
e):
+    """Benchmark one test-case
+
+    test_func   -- benchmarking function with prototype
+                   test_func(env, case), which takes test_env and test_cas=
e
+                   arguments and returns {'seconds': int} (which is benchm=
ark
+                   result) on success and {'error': str} on error. Returne=
d
+                   dict may contain any other additional fields.
+    test_env    -- test environment - opaque first argument for test_func
+    test_case   -- test case - opaque second argument for test_func
+    count       -- how many times to call test_func, to calculate average
+    initial_run -- do initial run of test_func, which don't get into resul=
t
+
+    Returns dict with the following fields:
+        'runs':     list of test_func results
+        'average':  average seconds per run (exists only if at least one r=
un
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
+    runs =3D []
+    for i in range(count):
+        print('  #run {}'.format(i+1))
+        res =3D test_func(test_env, test_case)
+        print('   ', res)
+        runs.append(res)
+
+    result =3D {'runs': runs}
+
+    successed =3D [r for r in runs if ('seconds' in r)]
+    if successed:
+        avg =3D sum(r['seconds'] for r in successed) / len(successed)
+        result['average'] =3D avg
+        result['delta'] =3D max(abs(r['seconds'] - avg) for r in successed=
)
+
+    if len(successed) < count:
+        result['n-failed'] =3D count - len(successed)
+
+    return result
+
+
+def ascii_one(result):
+    """Return ASCII representation of bench_one() returned dict."""
+    if 'average' in result:
+        s =3D '{:.2f} +- {:.2f}'.format(result['average'], result['delta']=
)
+        if 'n-failed' in result:
+            s +=3D '\n({} failed)'.format(result['n-failed'])
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
+        'tab':   filled 2D array, where cell [i][j] is bench_one result fo=
r
+                 test_cases[i] for test_envs[j] (i.e., rows are test cases=
 and
+                 columns are test environments)
+    """
+    tab =3D {}
+    results =3D {
+        'envs': test_envs,
+        'cases': test_cases,
+        'tab': tab
+    }
+    n =3D 1
+    n_tests =3D len(test_envs) * len(test_cases)
+    for env in test_envs:
+        for case in test_cases:
+            print('Testing {}/{}: {} :: {}'.format(n, n_tests,
+                                                   env['id'], case['id']))
+            if case['id'] not in tab:
+                tab[case['id']] =3D {}
+            tab[case['id']][env['id']] =3D bench_one(test_func, env, case,
+                                                   *args, **vargs)
+            n +=3D 1
+
+    print('Done')
+    return results
+
+
+def ascii(results):
+    """Return ASCII representation of bench() returned dict."""
+    from tabulate import tabulate
+
+    tab =3D [[""] + [c['id'] for c in results['envs']]]
+    for case in results['cases']:
+        row =3D [case['id']]
+        for env in results['envs']:
+            row.append(ascii_one(results['tab'][case['id']][env['id']]))
+        tab.append(row)
+
+    return tabulate(tab)
--=20
2.24.1


