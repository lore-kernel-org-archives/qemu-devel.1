Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BAC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C4C2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oi4cNqGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C4C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITNV-0001I9-RD
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITMh-0000lM-3E
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITMb-0002OM-4Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600247066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pmQj9D3oj5azyJfN4pDUPZ65bh9EuotL2ZXMEohF4fA=;
 b=Oi4cNqGUONJeJkYPRUaL/DDjj4GdVDBBRUw9g5WUE9ymM8E/FDDpVTk/LUX9J1JMZ67/dZ
 WS+DY6gJdxHBgq3+ZyjtxN55awTLoIxZPwidskYf0thJsedhP/3XfYn9FLRTjdJqQj46rd
 YOiKHrHYTLEgHiYRqohWzSWkMTeZUUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-eygDPNwLOQuhKcjdd6A37w-1; Wed, 16 Sep 2020 05:04:23 -0400
X-MC-Unique: eygDPNwLOQuhKcjdd6A37w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5002E107464B
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:04:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C8945DE46;
 Wed, 16 Sep 2020 09:04:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] mtest2make: add support for introspected test dependencies
Date: Wed, 16 Sep 2020 05:04:21 -0400
Message-Id: <20200916090421.9582-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now all "make check" targets depend blindly on "all".  If Meson
is 0.56.0 or newer, we can use the correct dependencies using the new
"depends" entry in "meson introspect --tests".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  2 +-
 scripts/mtest2make.py | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7c60b9dcb8..cb5cd930c8 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,7 @@ ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
 # reread (and MESON won't be empty anymore).
 ifneq ($(MESON),)
 Makefile.mtest: build.ninja scripts/mtest2make.py
-	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
+	$(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
 endif
 
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 9cbb2e374d..c3489a4605 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -5,6 +5,7 @@
 # Author: Paolo Bonzini <pbonzini@redhat.com>
 
 from collections import defaultdict
+import itertools
 import json
 import os
 import shlex
@@ -36,7 +37,7 @@ SPEED = quick
 introspect = json.load(sys.stdin)
 i = 0
 
-def process_tests(test, suites):
+def process_tests(test, targets, suites):
     global i
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
@@ -58,12 +59,19 @@ def process_tests(test, suites):
     i += 1
     if test['workdir'] is not None:
         print('.test.dir.%d := %s' % (i, shlex.quote(test['workdir'])))
+
+    if 'depends' in test:
+        deps = (targets.get(x, []) for x in test['depends'])
+        deps = itertools.chain.from_iterable(deps)
+    else:
+        deps = ['all']
+
     print('.test.name.%d := %s' % (i, test['name']))
     print('.test.driver.%d := %s' % (i, driver))
     print('.test.env.%d := $(.test.env) %s' % (i, env))
     print('.test.cmd.%d := %s' % (i, cmd))
     print('.PHONY: run-test-%d' % (i,))
-    print('run-test-%d: all' % (i,))
+    print('run-test-%d: %s' % (i, ' '.join(deps)))
     print('\t@$(call .test.run,%d,$(.test.output-format))' % (i,))
 
     test_suites = test['suite'] or ['default']
@@ -102,16 +110,19 @@ def emit_suite(name, suite, prefix):
     print('.tests += $(.test.$(SPEED).%s)' % (target, ))
     print('endif')
 
+targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
+           for t in introspect['targets']}
+
 testsuites = defaultdict(Suite)
 for test in introspect['tests']:
-    process_tests(test, testsuites)
+    process_tests(test, targets, testsuites)
 emit_prolog(testsuites, 'check')
 for name, suite in testsuites.items():
     emit_suite(name, suite, 'check')
 
 benchsuites = defaultdict(Suite)
 for test in introspect['benchmarks']:
-    process_tests(test, benchsuites)
+    process_tests(test, targets, benchsuites)
 emit_prolog(benchsuites, 'bench')
 for name, suite in benchsuites.items():
     emit_suite(name, suite, 'bench')
-- 
2.26.2


