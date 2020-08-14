Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABADC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984472074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR7fjg65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984472074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Vxh-00080C-K9
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 05:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vme-0005K2-LH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6VmZ-0002s5-EG
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T78SE27uKMpCfD06l+wPEicngg3BIdqVahqPM440AiM=;
 b=ZR7fjg65LroQtUdIFokhg3xzw6sytfbXfzJlVYnUqnPatPq51N7iFz7N7PupnPvoLY8vSB
 c0oYx4ScMhWs41AVlVYLl7KSttDx8Yq01HIZIfkb9nEjrkfmmgRrU3Mfr4psu6MM4f7eXP
 DlcWwa5nqUX3a78AmWE+PhurOBasUPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-f0PigDdONamSAQrbqLZo1g-1; Fri, 14 Aug 2020 05:13:47 -0400
X-MC-Unique: f0PigDdONamSAQrbqLZo1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE201853DA0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 934C6747C3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:13:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 024/150] meson: add testsuite Makefile generator
Date: Fri, 14 Aug 2020 05:11:20 -0400
Message-Id: <20200814091326.16173-25-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 Makefile               |   6 ++-
 scripts/mtest2make.py  | 102 +++++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include |   1 -
 3 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 scripts/mtest2make.py

diff --git a/Makefile b/Makefile
index 6198236c40..7419d5e19b 100644
--- a/Makefile
+++ b/Makefile
@@ -65,6 +65,10 @@ clean-ctlist:
 ninja-clean::
 ninja-distclean::
 
+Makefile.mtest: build.ninja scripts/mtest2make.py
+	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+-include Makefile.mtest
+
 .git-submodule-status: git-submodule-update config-host.mak
 
 # Check that we're not trying to do an out-of-tree build from
@@ -820,7 +824,7 @@ distclean: clean ninja-distclean
 	rm -f roms/seabios/config.mak roms/vgabios/config.mak
 	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -rf meson-private meson-logs meson-info compile_commands.json
-	rm -f Makefile.ninja ninjatool ninjatool.stamp
+	rm -f Makefile.ninja ninjatool ninjatool.stamp Makefile.mtest
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
new file mode 100644
index 0000000000..bdb257bbd9
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
+.test-human-tap = $1 < /dev/null | ./scripts/tap-driver.pl --test-name="$2" $(if $(V),,--show-failures-only)
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
+    print('check-%s: all %s' % (name, executables))
+    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
+    print('check-report.tap: check-report-%s.tap' % name)
+    print('check-report-%s.tap: %s' % (name, executables))
+    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c7e4646ded..ad54100369 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -674,7 +674,6 @@ check-report-unit.tap: $(check-unit-y)
 # Reports and overall runs
 
 check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check-report-unit.tap
-	$(call quiet-command, cat $^ | scripts/tap-merge.pl >$@,"GEN","$@")
 
 # FPU Emulation tests (aka softfloat)
 #
-- 
2.26.2



