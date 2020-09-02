Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E478C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316A12084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ig8wCKzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316A12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNi2-0001yZ-4k
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDNhN-0001Nb-0L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:00:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58010
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDNhK-0000s1-PL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OPM6aLAKDeqhhlimuVd9BEfaem2kSw+PI3nNmgdfB2E=;
 b=ig8wCKzQKF2hQELf/6UU7edRSVNu3N72/ccpKjGz6AZqlW4cd3t1P+7YyOGbFb2a1nQ44T
 gtWFc8A5ZApQ4tJSTf6E1oS+zQ7TjBZIUWL3G5/LxYqUUKFavnoQwqm+jyNp/fDL6qTvVw
 haD8IaIl861zSN9RuwMaVyTFE6o6axg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-VzbEnevMPzqqzx3990J6JQ-1; Wed, 02 Sep 2020 04:00:47 -0400
X-MC-Unique: VzbEnevMPzqqzx3990J6JQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B93AE10ABDAF;
 Wed,  2 Sep 2020 08:00:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6646578374;
 Wed,  2 Sep 2020 08:00:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-iotests: move check-block back to Makefiles
Date: Wed,  2 Sep 2020 04:00:46 -0400
Message-Id: <20200902080046.10412-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
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
Cc: alex.bennee@linaro.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

check-block has its own test harness, unlike every other test.  If
we capture its output, as is in general nicer to do without V=1,
there will be no sign of progress.  So for lack of a better option
just move the invocation of the test back to Makefile rules.

As a side effect, this will also fix "make check" in --disable-tools
builds, as they were trying to run qemu-iotests without having
made qemu-img before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  2 --
 tests/Makefile.include         | 15 ++++++++++++---
 tests/qemu-iotests/meson.build |  4 ----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 55c7d2318c..356af9142c 100644
--- a/meson.build
+++ b/meson.build
@@ -1095,11 +1095,9 @@ if have_tools
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
-  qemu_block_tools += [qemu_img, qemu_io]
   if targetos != 'windows'
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
-    qemu_block_tools += [qemu_nbd]
   endif
 
   subdir('storage-daemon')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 9ac8f5b86a..08301f5bc9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -468,7 +468,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -523,8 +522,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 # Consolidated targets
 
 .PHONY: check-block check-unit check check-clean get-vm-images
-check-block:
-check-build: build-unit
+check:
+
+ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
+QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+check: check-block
+check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
+		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
+	@$<
+endif
+
+check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
 
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 3de09fb8fa..60470936b4 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -4,7 +4,3 @@ if 'CONFIG_LINUX' in config_host
 else
     socket_scm_helper = []
 endif
-test('qemu-iotests', sh, args: [files('../check-block.sh')],
-     depends: [qemu_block_tools, emulators, socket_scm_helper],
-     suite: 'block', timeout: 10000)
-
-- 
2.26.2


