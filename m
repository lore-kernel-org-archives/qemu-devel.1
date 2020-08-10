Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4058CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1224620838
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtu1jaul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1224620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CHv-0002Md-63
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM5-0003kg-7l
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM2-0003O1-IV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=pw6jQgzJowoLxo1o6vZ+RJZ8mSIYpQphma7uRLHyF64=;
 b=Gtu1jaulU5KwvsuR3lqsYxGfjJwSYnahQtpCwTFZMYizrI08yK64HT7Gma6efV4LS81Z95
 MDfGAzm7K71+8oGj3AkofMQk2lLB4DWUwlh1SRbNE6eEeXhrow3t9o9BS/fMur0hNUj+pT
 BaqFctqMXc9SXDhxpPWqb9R8oscaNLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-vszdb35CP8SIiYl3s9Mb0A-1; Mon, 10 Aug 2020 13:12:55 -0400
X-MC-Unique: vszdb35CP8SIiYl3s9Mb0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5482E800472
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:54 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A87A5F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 137/147] meson: convert check-block
Date: Mon, 10 Aug 2020 19:08:55 +0200
Message-Id: <1597079345-42801-138-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 13:09:25
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  2 ++
 tests/Makefile.include         | 16 ++--------------
 tests/meson.build              |  4 ++++
 tests/qemu-iotests/meson.build | 10 ++++++++++
 4 files changed, 18 insertions(+), 14 deletions(-)
 create mode 100644 tests/qemu-iotests/meson.build

diff --git a/meson.build b/meson.build
index a858af5..9e37814 100644
--- a/meson.build
+++ b/meson.build
@@ -991,9 +991,11 @@ if have_tools
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
   qemu_io = executable('qemu-io', files('qemu-io.c'),
              dependencies: [block, qemuutil], install: true)
+  qemu_block_tools = [qemu_img, qemu_io]
   if host_machine.system() == 'linux' or host_machine.system() == 'sunos' or host_machine.system().endswith('bsd')
     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
                dependencies: [block, qemuutil], install: true)
+    qemu_block_tools += [qemu_nbd]
   endif
 
   subdir('storage-daemon')
diff --git a/tests/Makefile.include b/tests/Makefile.include
index c3874ca..e023df8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -160,8 +160,6 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 
-check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
-
 generated-files-y += tests/test-qapi-types.h
 generated-files-y += tests/include/test-qapi-types-sub-module.h
 generated-files-y += tests/test-qapi-types-sub-sub-module.h
@@ -480,14 +478,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 
-QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
-
-.PHONY: check-tests/check-block.sh
-check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
-		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
-	@$<
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -541,13 +531,13 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
 # Consolidated targets
 
-.PHONY: check-block check-unit check check-clean get-vm-images
+.PHONY: check-unit check check-clean get-vm-images
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
 check-build: build-unit
 
-check: check-block check-unit
+check: check-unit
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -f tests/test-qapi-gen-timestamp
@@ -559,8 +549,6 @@ clean: check-clean
 
 # Build the help program automatically
 
-all: $(QEMU_IOTESTS_HELPERS-y)
-
 -include $(wildcard tests/*.d)
 
 endif
diff --git a/tests/meson.build b/tests/meson.build
index d724402..f834c27 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,3 +1,7 @@
+if have_system and 'CONFIG_POSIX' in config_host
+  subdir('qemu-iotests')
+endif
+
 test('decodetree', sh,
      args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
      workdir: meson.current_source_dir() / 'decode',
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
new file mode 100644
index 0000000..3de09fb
--- /dev/null
+++ b/tests/qemu-iotests/meson.build
@@ -0,0 +1,10 @@
+if 'CONFIG_LINUX' in config_host
+    socket_scm_helper = executable('socket_scm_helper', 'socket_scm_helper.c',
+                                    build_by_default: false)
+else
+    socket_scm_helper = []
+endif
+test('qemu-iotests', sh, args: [files('../check-block.sh')],
+     depends: [qemu_block_tools, emulators, socket_scm_helper],
+     suite: 'block', timeout: 10000)
+
-- 
1.8.3.1



