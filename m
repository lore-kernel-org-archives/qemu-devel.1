Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F8AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB34A221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6sXY/l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB34A221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mHg-00032F-QB
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRL-0003DG-93
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23447
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRI-0006xZ-7G
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=XRgJ9IzIKFmcKhH+fpNXk20lIXDR8zIJ8F3XsBcFVks=;
 b=E6sXY/l1C2JnWDOVD9J9UMPrR4eY2G4E/GKATIfG2hqB+hxf0ze5/gkCEzciwyko/ugFmW
 g6/5uNm9x2v4UW+TXboiTWym5+8v5c9Su4rQ8BbTWamlrT+qVdt2cs4fn7VzOOC8qv2sTr
 53q9cAlz9L3vULW++4rjPx0/ZpWXiTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-bWO2AG65NAy71cZ2EryWFw-1; Thu, 06 Aug 2020 15:20:29 -0400
X-MC-Unique: bWO2AG65NAy71cZ2EryWFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A428100AA23
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:29 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 530B15FC3B
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 136/143] meson: convert check-block
Date: Thu,  6 Aug 2020 21:16:12 +0200
Message-Id: <1596741379-12902-137-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 tests/Makefile.include         | 18 ++----------------
 tests/meson.build              |  4 ++++
 tests/qemu-iotests/meson.build |  8 ++++++++
 3 files changed, 14 insertions(+), 16 deletions(-)
 create mode 100644 tests/qemu-iotests/meson.build

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7468e99..a1e4871 100644
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
@@ -487,16 +485,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 
-QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
-
-tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_scm_helper.o
-
-.PHONY: check-tests/check-block.sh
-check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
-		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
-		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
-	@$<
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -550,13 +538,13 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
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
@@ -568,8 +556,6 @@ clean: check-clean
 
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
index 0000000..60e81a2
--- /dev/null
+++ b/tests/qemu-iotests/meson.build
@@ -0,0 +1,8 @@
+dep = [qemu_img, qemu_io, qemu_nbd, emulators]
+if 'CONFIG_LINUX' in config_host
+    dep += executable('socket_scm_helper', 'socket_scm_helper.c',
+                      build_by_default: false)
+endif
+test('qemu-iotests', sh, args: [files('../check-block.sh')], depends: dep,
+     suite: 'block', timeout: 10000)
+
-- 
1.8.3.1



