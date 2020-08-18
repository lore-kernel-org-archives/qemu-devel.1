Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB5BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EB72076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+ucZSlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EB72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82qP-00019h-Fd
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kw-0004Rg-W1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Kr-0007Sa-JR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bf7APxE08Zs1aCzqQUAJprIo790d4IoAVy1ujLluwOs=;
 b=f+ucZSlqCBYP0eL7zeXJb5xFaQ9OrDg3TPx1CvtB4r19ic+d6OORGnNPT0Wx5TrLFvm9vl
 3snnHbKi+H3zW3lVEU94FUm39b4rYEYl7dL0dLyZOb6LMKMTvd3UW2spskTRJvBOX0IrqL
 1A4zJNPJpsRRf9LhaTyJkoMad3IxBAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ocj2piYZPtiigeS1fsM8lw-1; Tue, 18 Aug 2020 10:11:13 -0400
X-MC-Unique: ocj2piYZPtiigeS1fsM8lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8346081F01B
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:12 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51A1F196B6
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 053/150] meson: convert check-decodetree
Date: Tue, 18 Aug 2020 10:08:48 -0400
Message-Id: <20200818141025.21608-54-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
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
 meson.build            | 2 ++
 tests/Makefile.include | 8 +-------
 tests/meson.build      | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)
 create mode 100644 tests/meson.build

diff --git a/meson.build b/meson.build
index c87a7ea257..a11111e232 100644
--- a/meson.build
+++ b/meson.build
@@ -6,6 +6,7 @@ not_found = dependency('', required: false)
 keyval = import('unstable-keyval')
 ss = import('sourceset')
 
+sh = find_program('sh')
 cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
@@ -381,6 +382,7 @@ endif
 
 subdir('tools')
 subdir('pc-bios')
+subdir('tests')
 
 summary_info = {}
 summary_info += {'Install prefix':    config_host['prefix']}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index f277d238fb..8e953a24ee 100644
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
index 0000000000..5c52021dc9
--- /dev/null
+++ b/tests/meson.build
@@ -0,0 +1,4 @@
+test('decodetree', sh,
+     args: [ files('decode/check.sh'), config_host['PYTHON'], files('../scripts/decodetree.py') ],
+     workdir: meson.current_source_dir() / 'decode',
+     suite: 'decodetree')
-- 
2.26.2



