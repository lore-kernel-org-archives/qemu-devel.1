Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1820C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C320206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wa3Hfsf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C320206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6WoC-00055d-QD
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vo5-00007P-DK
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vnx-0003ET-Hb
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MkvASLoTGXKVIP8K4zyTxBaJ6zDnmEbeWO/Xs39iO4U=;
 b=Wa3Hfsf7E4WbMwTx5TkMzvQe/hfTEx0LHdB6cOsjM/Zu5rpSNehUiXcdbDd9Gtq4s6ymfZ
 ct5ROf9KZe/q/7XyEViJX+NkabSE1dG/D3wlWSiTNl0NbyivZpfpiiyHfCa0jucRp6ZgxB
 oVSJUjHXuIKomRVGerUh8exFY8lyk5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-yGRRaWatMMu5dn5VFkn2ag-1; Fri, 14 Aug 2020 05:15:14 -0400
X-MC-Unique: yGRRaWatMMu5dn5VFkn2ag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C48351853DAD
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 935CE5C1BD
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 141/150] meson: convert check-block
Date: Fri, 14 Aug 2020 05:13:17 -0400
Message-Id: <20200814091326.16173-142-pbonzini@redhat.com>
In-Reply-To: <20200814091326.16173-1-pbonzini@redhat.com>
References: <20200814091326.16173-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:35
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  2 ++
 tests/Makefile.include         | 16 ++--------------
 tests/meson.build              |  4 ++++
 tests/qemu-iotests/meson.build | 10 ++++++++++
 4 files changed, 18 insertions(+), 14 deletions(-)
 create mode 100644 tests/qemu-iotests/meson.build

diff --git a/meson.build b/meson.build
index 8a8c6d0fde..d764135c6d 100644
--- a/meson.build
+++ b/meson.build
@@ -999,9 +999,11 @@ if have_tools
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
index c3874cafd2..e023df817d 100644
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
index d724402cf4..f834c272e8 100644
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
index 0000000000..3de09fb8fa
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
2.26.2



