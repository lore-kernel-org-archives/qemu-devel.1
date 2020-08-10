Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8932065C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERhOoX1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8932065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BgQ-0005JN-4a
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJl-00081Z-3a
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22409
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJj-0002yb-8v
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=sUO9Y2S65BnQB9VsGOH2uoMXaaBFvPeSWzaYGkq3nXk=;
 b=ERhOoX1pKtV8qqWVO/Hxh2NhEdh0yoyyDYbDKjDU9/tXaSAOrfZyVLUNCBwMpqCVEEOd+Z
 kMkQ81nJBFMxoqL+EznMX0ujYk2bZlvN6KGk7KS2Jq48TN9fzszz3yNqm8eJL7ceO13wUo
 V+5ckMEEXkRfBeqI3OJJ/aWALPKozg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-ZIRJbaiwPpeDX-UtYxpHuw-1; Mon, 10 Aug 2020 13:10:31 -0400
X-MC-Unique: ZIRJbaiwPpeDX-UtYxpHuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ADED57
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:30 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EA5F5F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 049/147] meson: convert check-decodetree
Date: Mon, 10 Aug 2020 19:07:27 +0200
Message-Id: <1597079345-42801-50-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
 meson.build            | 2 ++
 tests/Makefile.include | 8 +-------
 tests/meson.build      | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 tests/meson.build

diff --git a/meson.build b/meson.build
index a3c2ea7..6f1e199 100644
--- a/meson.build
+++ b/meson.build
@@ -6,6 +6,7 @@ not_found = dependency('', required: false)
 keyval = import('unstable-keyval')
 ss = import('sourceset')
 
+sh = find_program('sh')
 cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
@@ -363,6 +364,7 @@ endif
 
 subdir('tools')
 subdir('pc-bios')
+subdir('tests')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f277d23..8e953a2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -894,13 +894,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
 check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
 	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
 
-.PHONY: check-decodetree
-check-decodetree:
-	$(call quiet-command, \
-	  cd $(SRC_PATH)/tests/decode && \
-          ./check.sh "$(PYTHON)" "$(SRC_PATH)/scripts/decodetree.py", \
-          TEST, decodetree.py)
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -962,6 +955,7 @@ check-block: $(patsubst %,check-%, $(check-block-y))
 endif
 check-build: build-unit build-softfloat build-qtest
 
+check: check-block check-qapi-schema check-unit check-softfloat check-qtest
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
diff --git a/tests/meson.build b/tests/meson.build
new file mode 100644
index 0000000..5c52021
--- /dev/null
+++ b/tests/meson.build
@@ -0,0 +1,4 @@
+test('decodetree', sh,
+     args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
+     workdir: meson.current_source_dir() / 'decode',
+     suite: 'decodetree')
-- 
1.8.3.1



