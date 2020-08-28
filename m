Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F2C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D4207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGoSunY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D4207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcKh-0006K0-3G
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcGN-0005ak-8T
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcGL-0000dM-9x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWTOH+z84MeDRfBMtXsIPBW6qvDBURO7EAsFi1//81g=;
 b=JGoSunY7a2yar27vQm/6K8jKrDSqdbp/u7BysSgRGO0oDWqWD/W1jGd+gunsNwtkR2o7Lh
 36AlgvgVc1faKRYqQiPOXtHD4PT90bIS51SpvgfUuRa+Z24saRq2XiIJC9Zqz2SvMEvVRy
 PPmYugdK2jRLwx6tyftZ30qjFRRbnaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-StxHYHVZPWWN3GCtIn86Gg-1; Fri, 28 Aug 2020 07:09:36 -0400
X-MC-Unique: StxHYHVZPWWN3GCtIn86Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE70581F02E
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:09:35 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 849BD19C59;
 Fri, 28 Aug 2020 11:09:31 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 13/16] meson: convert the speed tests
Date: Fri, 28 Aug 2020 15:07:31 +0400
Message-Id: <20200828110734.1638685-14-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 01:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Use meson benchmark() for them, adjust mtest2make.py for that.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile               |  2 +-
 scripts/mtest2make.py  |  3 ++-
 tests/Makefile.include | 11 -----------
 tests/meson.build      | 16 ++++++++++++++++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 81794d5c34..a2d068ca37 100644
--- a/Makefile
+++ b/Makefile
@@ -71,7 +71,7 @@ ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
 # reread (and MESON won't be empty anymore).
 ifneq ($(MESON),)
 Makefile.mtest: build.ninja scripts/mtest2make.py
-	$(MESON) introspect --tests | $(PYTHON) scripts/mtest2make.py > $@
+	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
 -include Makefile.mtest
 endif
 
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index d7a51bf97e..06d017154c 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -50,7 +50,8 @@ endef
 
 suites = defaultdict(Suite)
 i = 0
-for test in json.load(sys.stdin):
+introspect = json.load(sys.stdin)
+for test in introspect['tests'] + introspect['benchmarks']:
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
     executable = test['cmd'][0]
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9fb61ff900..30d4c6f932 100644
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
diff --git a/tests/meson.build b/tests/meson.build
index a2902bde45..4d6bcf06b3 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -108,6 +108,8 @@ tests = {
   'test-qapi-util': {},
 }
 
+benchs = {}
+
 if have_block
   tests += {
     'test-coroutine': {'deps': [testblock]},
@@ -166,6 +168,11 @@ if have_block
   if 'CONFIG_NETTLE' in config_host or 'CONFIG_GCRYPT' in config_host
     tests += {'test-crypto-pbkdf': {'deps': [io]}}
   endif
+  benchs += {
+     'benchmark-crypto-hash': {'deps': [crypto]},
+     'benchmark-crypto-hmac': {'deps': [crypto]},
+     'benchmark-crypto-cipher': {'deps': [crypto]},
+  }
 endif
 
 if have_system
@@ -225,6 +232,15 @@ foreach test_name, extra_args: tests
        suite: suite)
 endforeach
 
+foreach bench_name, extra_args: benchs
+  src = extra_args.get('src', [bench_name + '.c'])
+  exe = executable(bench_name, src,
+                   dependencies: [qemuutil] + extra_args.get('deps', []))
+  benchmark(bench_name, exe,
+            args: ['--tap', '-k'],
+            protocol: 'tap',
+            suite: ['speed'])
+endforeach
 
 if have_tools and 'CONFIG_VHOST_USER' in config_host
   executable('vhost-user-bridge',
-- 
2.26.2


