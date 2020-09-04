Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965DC28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F2820709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 11:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy5AhG6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F2820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEACt-0003fn-2n
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 07:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6Y-0000XG-VP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6W-0005G8-UQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599219724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gc1B/W89GvvvRY7k2w2ghryiN2TJQ9l1ISINzY4H78=;
 b=Fy5AhG6wFGTgcZOwu6718VsCmFFTAGZ0WteDESgMqAaDS30dQPx/1MgcmtZqaS1i/0lduX
 sL1F0NjZ+j5nLLAayAMdFduEYhNEhf5Bls5fLBReWNfTOSSQk7AaV160Ux8Z4ZMPb7k7Hf
 fDBRTXwSeMdEOyZ9TUOtZX6gPtXsVT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-cSCpqdftPWuHHLv0bHsO2A-1; Fri, 04 Sep 2020 07:42:01 -0400
X-MC-Unique: cSCpqdftPWuHHLv0bHsO2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A4E8D6DF7
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 11:41:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8CB27D55B;
 Fri,  4 Sep 2020 11:41:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/46] meson: convert the speed tests
Date: Fri,  4 Sep 2020 07:40:59 -0400
Message-Id: <20200904114122.31307-24-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use meson benchmark() for them, adjust mtest2make.py for that.
A new target "make bench" can be used to run all benchmarks.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200828110734.1638685-14-marcandre.lureau@redhat.com>
[Rewrite mtest2make part. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile               |  3 ++-
 scripts/mtest2make.py  |  9 ++++++++-
 tests/Makefile.include | 15 ++++-----------
 tests/meson.build      | 15 +++++++++++++++
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index ed354c43b0..d4d6a67d96 100644
--- a/Makefile
+++ b/Makefile
@@ -64,7 +64,7 @@ ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
 # reread (and MESON won't be empty anymore).
 ifneq ($(MESON),)
 Makefile.mtest: build.ninja scripts/mtest2make.py
-	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
 endif
 
@@ -283,6 +283,7 @@ help:
 	@echo  ''
 	@echo  'Test targets:'
 	$(call print-help,check,Run all tests (check-help for details))
+	$(call print-help,bench,Run all benchmarks)
 	$(call print-help,docker,Help about targets running tests inside containers)
 	$(call print-help,vm-help,Help about targets running tests inside VM)
 	@echo  ''
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index af6dd0d3b1..9cbb2e374d 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -103,10 +103,17 @@ def emit_suite(name, suite, prefix):
     print('endif')
 
 testsuites = defaultdict(Suite)
-for test in introspect:
+for test in introspect['tests']:
     process_tests(test, testsuites)
 emit_prolog(testsuites, 'check')
 for name, suite in testsuites.items():
     emit_suite(name, suite, 'check')
 
+benchsuites = defaultdict(Suite)
+for test in introspect['benchmarks']:
+    process_tests(test, benchsuites)
+emit_prolog(benchsuites, 'bench')
+for name, suite in benchsuites.items():
+    emit_suite(name, suite, 'bench')
+
 print('run-tests: $(patsubst %, run-test-%, $(.tests))')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 0388a0e4fd..fe22ccfcc6 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -38,16 +38,8 @@ export SRC_PATH
 SYSEMU_TARGET_LIST := $(subst -softmmu.mak,,$(notdir \
    $(wildcard $(SRC_PATH)/default-configs/*-softmmu.mak)))
 
-check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hash$(EXESUF)
-check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-hmac$(EXESUF)
-check-speed-$(CONFIG_BLOCK) += tests/benchmark-crypto-cipher$(EXESUF)
-
 QEMU_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 
-tests/benchmark-crypto-hash$(EXESUF): tests/benchmark-crypto-hash.o $(test-crypto-obj-y)
-tests/benchmark-crypto-hmac$(EXESUF): tests/benchmark-crypto-hmac.o $(test-crypto-obj-y)
-tests/benchmark-crypto-cipher$(EXESUF): tests/benchmark-crypto-cipher.o $(test-crypto-obj-y)
-
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
 
@@ -97,9 +89,6 @@ define do_test_tap
 	  "TAP","$@")
 endef
 
-check-speed: $(check-speed-y)
-	$(call do_test_human, $^)
-
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
@@ -212,6 +201,10 @@ check-clean:
 
 clean: check-clean
 
+# For backwards compatibility
+
+check-speed: bench-speed
+
 # Build the help program automatically
 
 -include $(wildcard tests/*.d)
diff --git a/tests/meson.build b/tests/meson.build
index e97927d0be..17536de589 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -111,6 +111,8 @@ test_deps = {
   'test-qht-par': qht_bench,
 }
 
+benchs = {}
+
 if have_block
   tests += {
     'test-coroutine': [testblock],
@@ -167,6 +169,11 @@ if have_block
   if 'CONFIG_NETTLE' in config_host or 'CONFIG_GCRYPT' in config_host
     tests += {'test-crypto-pbkdf': [io]}
   endif
+  benchs += {
+     'benchmark-crypto-hash': [crypto],
+     'benchmark-crypto-hmac': [crypto],
+     'benchmark-crypto-cipher': [crypto],
+  }
 endif
 
 if have_system
@@ -230,6 +237,14 @@ foreach test_name, extra: tests
        suite: ['unit'])
 endforeach
 
+foreach bench_name, deps: benchs
+  exe = executable(bench_name, bench_name + '.c',
+                   dependencies: [qemuutil] + deps)
+  benchmark(bench_name, exe,
+            args: ['--tap', '-k'],
+            protocol: 'tap',
+            suite: ['speed'])
+endforeach
 
 if have_tools and 'CONFIG_VHOST_USER' in config_host
   executable('vhost-user-bridge',
-- 
2.26.2



