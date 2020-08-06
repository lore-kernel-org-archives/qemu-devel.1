Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790D4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872FD2177B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 19:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMMx/rQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872FD2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3lSb-0005Gt-E2
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 15:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lO2-00049Q-7Q
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lNy-0006Pa-HP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=ib/JJMFn6AYHdBHahDo8e8TPKoZujYWfLCTlVIdDUzw=;
 b=LMMx/rQ0QLFQrmIBRl/tCAp62a1JkeAjCsu4M+NQTDlKv4E2/k22aXJIfb/xWe91gUElm6
 ValvNxNPBFXjcwN3euIvCj1OKJipNjidFyLz4rnz2kTHlZY+BHiHQY2mgdTwT954Rn/PJT
 3gKb0U/a/lOyEt1q60CH2+4r4Tf9EJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-leOnZDiCNS6ghn3yOZX2AA-1; Thu, 06 Aug 2020 15:17:03 -0400
X-MC-Unique: leOnZDiCNS6ghn3yOZX2AA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09536107BA59
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:03 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51BD65F9DC
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:17:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 020/143] meson: add testsuite Makefile generator
Date: Thu,  6 Aug 2020 21:14:16 +0200
Message-Id: <1596741379-12902-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rules to execute tests are generated by a simple Python program
that integrates into the existing "make check" mechanism.  This
provides familiarity for developers, and also allows piecewise
conversion of the testsuite Makefiles to meson.

The generated rules are based on QEMU's existing test harness
Makefile and TAP parser.
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |   4 ++
 scripts/mtest2make.py  | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   1 -
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 scripts/mtest2make.py

diff --git a/Makefile b/Makefile
index 9a75047..6248fd0 100644
--- a/Makefile
+++ b/Makefile
@@ -58,6 +58,10 @@ ninjatool: ninjatool.stamp
 ninjatool.stamp: $(SRC_PATH)/scripts/ninjatool.py config-host.mak
 	$(MESON) setup --reconfigure . $(SRC_PATH) && touch $@
 
+Makefile.mtest: build.ninja scripts/mtest2make.py
+	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+-include Makefile.mtest
+
 .git-submodule-status: git-submodule-update config-host.mak
 
 # Check that we're not trying to do an out-of-tree build from
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
new file mode 100644
index 0000000..e978303
--- /dev/null
+++ b/scripts/mtest2make.py
@@ -0,0 +1,102 @@
+#! /usr/bin/env python3
+
+# Create Makefile targets to run tests, from Meson's test introspection data.
+#
+# Author: Paolo Bonzini <pbonzini@redhat.com>
+
+from collections import defaultdict
+import json
+import os
+import shlex
+import sys
+
+class Suite(object):
+    def __init__(self):
+        self.tests = list()
+        self.slow_tests = list()
+        self.executables = set()
+
+print('''
+SPEED = quick
+
+# $1 = test command, $2 = test name
+.test-human-tap = $1 < /dev/null | ./scripts/tap-driver.pl --test-name="$2" $(if $(V),, --show-failures-only)
+.test-human-exitcode = $1 < /dev/null
+.test-tap-tap = $1 < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $2/" || true
+.test-tap-exitcode = printf "%s\\n" 1..1 "`$1 < /dev/null > /dev/null || echo "not "`ok 1 $2"
+.test.print = echo $(if $(V),'$1','Running test $2') >&3
+.test.env = MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))}
+
+# $1 = test name, $2 = test target (human or tap)
+.test.run = $(call .test.print,$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.cmd.$1),$(.test.name.$1))
+
+define .test.human_k
+        @exec 3>&1; rc=0; $(foreach TEST, $1, $(call .test.run,$(TEST),human) || rc=$$?;) \\
+              exit $$rc
+endef
+define .test.human_no_k
+        $(foreach TEST, $1, @exec 3>&1; $(call .test.run,$(TEST),human)
+)
+endef
+.test.human = \\
+        $(if $(findstring k, $(MAKEFLAGS)), $(.test.human_k), $(.test.human_no_k))
+
+define .test.tap
+        @exec 3>&1; { $(foreach TEST, $1, $(call .test.run,$(TEST),tap); ) } \\
+              | ./scripts/tap-merge.pl | tee "$@" \\
+              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)
+endef
+''')
+
+suites = defaultdict(Suite)
+i = 0
+for test in json.load(sys.stdin):
+    env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
+                    for k, v in test['env'].items()))
+    executable = os.path.relpath(test['cmd'][0])
+    if test['workdir'] is not None:
+        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+    else:
+        test['cmd'][0] = executable
+    cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
+    if test['workdir'] is not None:
+        cmd = '(cd %s && %s)' % (shlex.quote(test['workdir']), cmd)
+    driver = test['protocol'] if 'protocol' in test else 'exitcode'
+
+    i += 1
+    print('.test.name.%d := %s' % (i, test['name']))
+    print('.test.driver.%d := %s' % (i, driver))
+    print('.test.cmd.%d := %s' % (i, cmd))
+
+    test_suites = test['suite'] or ['default']
+    is_slow = any(s.endswith('-slow') for s in test_suites)
+    for s in test_suites:
+        # The suite name in the introspection info is "PROJECT:SUITE"
+        s = s.split(':')[1]
+        if s.endswith('-slow'):
+            s = s[:-5]
+        if is_slow:
+            suites[s].slow_tests.append(i)
+        else:
+            suites[s].tests.append(i)
+        suites[s].executables.add(executable)
+
+print('.PHONY: check check-report.tap')
+print('check:')
+print('check-report.tap:')
+print('\t@cat $^ | scripts/tap-merge.pl >$@')
+for name, suite in suites.items():
+    executables = ' '.join(suite.executables)
+    slow_test_numbers = ' '.join((str(x) for x in suite.slow_tests))
+    test_numbers = ' '.join((str(x) for x in suite.tests))
+    print('.test.suite-quick.%s := %s' % (name, test_numbers))
+    print('.test.suite-slow.%s := $(.test.suite-quick.%s) %s' % (name, name, slow_test_numbers))
+    print('check-build: %s' % executables)
+    print('.PHONY: check-%s' % name)
+    print('.PHONY: check-report-%s.tap' % name)
+    print('check: check-%s' % name)
+    print('check-%s: %s' % (name, executables))
+    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
+    print('check-report.tap: check-report-%s.tap' % name)
+    print('check-report-%s.tap: %s' % (name, executables))
+    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 985cd14..5e9dff9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -674,7 +674,6 @@ check-report-unit.tap: $(check-unit-y)
 # Reports and overall runs
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
 
 # FPU Emulation tests (aka softfloat)
 #
-- 
1.8.3.1



