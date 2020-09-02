Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7A6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958B720767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHrEZouF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958B720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSRA-0006hx-QQ
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMQ-0005zn-NU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56810
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMM-000759-Oj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/KpsoOA/jYXuLHzmNIdRXqyeSpxnSoo7Xv2fhUCAzM=;
 b=GHrEZouFTbDxRDpEdRwr8pO5QCAprQ14A4d+b6WYtG+SRKmyoMPT1nuSTaeLCzpmcmocvi
 ehLbP1ft+dj/nocKpARmhjT+o7TBlSPmZX9JPqtAnnjPXJ9vMitZU5VaJeNCW98EAsBwHq
 VG4NrUhyeuR+ACmUV4Gwh+5SIlNnfbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-lEwFHslZNxG6lM9i6Ex73A-1; Wed, 02 Sep 2020 08:59:26 -0400
X-MC-Unique: lEwFHslZNxG6lM9i6Ex73A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A49ED1084CA6
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 692A55D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/39] mtest2make: unify tests that appear in multiple suites
Date: Wed,  2 Sep 2020 08:58:43 -0400
Message-Id: <20200902125917.26021-6-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Whenever a test appears in multiple suites, the rules generated
by mtest2make are currently running it twice.  Instead, after
this patch we generate a phony target for each test and we have
a generic "run-tests" target depend on all the tests that were
chosen on the command line.  Tests that appear in multiple suites
will be added to the prerequisites just once.

This has other advantages: it removes the handling of -k and
it increases parallelism.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 69 ++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 27425080cf..e5dcb66bf7 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -24,33 +24,20 @@ SPEED = quick
 .test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
 .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
 .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"
-.test.print = echo $(if $(V),'$1 $2','Running test $3') >&3
+.test.human-print = echo $(if $(V),'$1 $2','Running test $3') &&
 .test.env = MALLOC_PERTURB_=$${MALLOC_PERTURB_:-$$(( $${RANDOM:-0} % 255 + 1))}
 
 # $1 = test name, $2 = test target (human or tap)
-.test.run = $(call .test.print,$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1)) && $(call .test-$2-$(.test.driver.$1),$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1),$(.test.dir.$1))
+.test.run = $(call .test.$2-print,$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1)) $(call .test-$2-$(.test.driver.$1),$(.test.env.$1),$(.test.cmd.$1),$(.test.name.$1),$(.test.dir.$1))
 
-define .test.human_k
-        @exec 3>&1; rc=0; $(foreach TEST, $1, $(call .test.run,$(TEST),human) || rc=$$?;) \\
-              exit $$rc
-endef
-define .test.human_no_k
-        $(foreach TEST, $1, @exec 3>&1; $(call .test.run,$(TEST),human)
-)
-endef
-.test.human = \\
-        $(if $(findstring k, $(MAKEFLAGS)), $(.test.human_k), $(.test.human_no_k))
-
-define .test.tap
-        @exec 3>&1; { $(foreach TEST, $1, $(call .test.run,$(TEST),tap); ) } \\
-              | ./scripts/tap-merge.pl | tee "$@" \\
-              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)
-endef
+.test.output-format = human
 ''')
 
-suites = defaultdict(Suite)
+introspect = json.load(sys.stdin)
 i = 0
-for test in json.load(sys.stdin):
+
+def process_tests(test, suites):
+    global i
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
     executable = test['cmd'][0]
@@ -89,22 +76,36 @@ for test in json.load(sys.stdin):
             suites[s].tests.append(i)
         suites[s].executables.add(executable)
 
-print('.PHONY: check check-report.tap')
-print('check:')
-print('check-report.tap:')
-print('\t@cat $^ | scripts/tap-merge.pl >$@')
-for name, suite in suites.items():
+def emit_prolog(suites, prefix):
+    all_tap = ' '.join(('%s-report-%s.tap' % (prefix, k) for k in suites.keys()))
+    print('.PHONY: %s %s-report.tap %s' % (prefix, prefix, all_tap))
+    print('%s: run-tests' % (prefix,))
+    print('%s-report.tap %s: %s-report%%.tap:' % (prefix, all_tap, prefix))
+    print('''\t$(MAKE) .test.output-format=tap -Otarget check$* | ./scripts/tap-merge.pl | tee "$@" \\
+              | ./scripts/tap-driver.pl $(if $(V),, --show-failures-only)''')
+
+def emit_suite(name, suite, prefix):
     executables = ' '.join(suite.executables)
     slow_test_numbers = ' '.join((str(x) for x in suite.slow_tests))
     test_numbers = ' '.join((str(x) for x in suite.tests))
     print('.test.suite-quick.%s := %s' % (name, test_numbers))
     print('.test.suite-slow.%s := $(.test.suite-quick.%s) %s' % (name, name, slow_test_numbers))
-    print('check-build: %s' % executables)
-    print('.PHONY: check-%s' % name)
-    print('.PHONY: check-report-%s.tap' % name)
-    print('check: check-%s' % name)
-    print('check-%s: all %s' % (name, executables))
-    print('\t$(call .test.human, $(.test.suite-$(SPEED).%s))' % (name, ))
-    print('check-report.tap: check-report-%s.tap' % name)
-    print('check-report-%s.tap: %s' % (name, executables))
-    print('\t$(call .test.tap, $(.test.suite-$(SPEED).%s))' % (name, ))
+    print('%s-build: %s' % (prefix, executables))
+    print('.PHONY: %s-%s' % (prefix, name))
+    print('.PHONY: %s-report-%s.tap' % (prefix, name))
+    print('%s-%s: run-tests' % (prefix, name))
+    print('ifneq ($(filter check check-%s, $(MAKECMDGOALS)),)' % name)
+    print('.tests += $(.test.suite-$(SPEED).%s)' % name)
+    print('endif')
+
+testsuites = defaultdict(Suite)
+for test in introspect:
+    process_tests(test, testsuites)
+emit_prolog(testsuites, 'check')
+for name, suite in testsuites.items():
+    emit_suite(name, suite, 'check')
+
+print('.PHONY: $(patsubst %, run-test-%, $(.tests))')
+print('$(patsubst %, run-test-%, $(sort $(.tests))): run-test-%: all')
+print('\t@$(call .test.run,$*,$(.test.output-format))')
+print('run-tests: $(patsubst %, run-test-%, $(.tests))')
-- 
2.26.2



