Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C056C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F61204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N71frTXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F61204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7giV-0002N1-4i
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHG-0004qi-U6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gHE-0006BS-9k
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:38:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id t14so14087608wmi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oV+3W0z2SKY8GvtrZaZqrI2d6ErQI+K2CaJOFXI3BXg=;
 b=N71frTXISHhRUGwvJzl5txfVUqWWAEQiZSKsH+Xf+tWJLOUfhhDAOYkzwl1mOKMN2Y
 dIXAwEfRVaUzqBPeSoTcnrncyoMG2mDvELHvGDZJR5a73IgRa2aGMxq+uuF8PDbTBJQ2
 LdY4kFodI8aRT/hFH3TW8+xojgZRghmVxFV9W0ILNvGkwtiTAIZGySE5a9BYRGwq47kP
 mBcpxJ5b4+dSLZgYbWmJyTzFEu9utGE0O4PwT9QF/ADYLN/toQ7U9Ow3ikKfW78SbAsj
 9obkIAIx/jfdGczS6cWVDUBEZ5vxQKjYmCO5URg2vkeUcQJTPLHXkH1N+3PTLRmal5MS
 jKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oV+3W0z2SKY8GvtrZaZqrI2d6ErQI+K2CaJOFXI3BXg=;
 b=kwAFdMCDX0lT0z2GXxLDA+0GQ2Mph5vGy0lIpj+HjUjKxXAjKQ9oXabm5VYztYmpe2
 nY/VaCn1IbtFIUvFzRffEqrtYHOLgGdmdc9ePF0ZUU1+tk3DumFZ5V73k6eFYPjIsOK/
 W9nGhoqohkGwkKqaPXqxeSE5CveNYSDSJgBPHm6iQU+jciW6CFhkunv120T45qQKq96x
 kx5ru+6k1UNBsZpLbjP1hhXn3WdbRHOB56rka5VzeZV60gKSby8Rfxdmqi7shm11Qzd+
 M20nt18857lcSDqsH3Deuqz1FxSMGPghYi1pf0msX8aISLFqhMCCzvTh9mx7EMrGo67p
 lNow==
X-Gm-Message-State: AOAM533Dz9vhApiR1L7HkYqIh/2G2KPFY5RqhPna2LIyEWh8J4ZFEXCW
 flu2fRFcE9VgP/Ku2FIVGUwO7gxXPMo=
X-Google-Smtp-Source: ABdhPJz9GaUGnFn+a8ChzCAO4+Ckbk9irqmbZJG3tIHyjR9FwhRXYVKwIftIjbn7Vvrs8NQe/J1wAQ==
X-Received: by 2002:a1c:bd04:: with SMTP id n4mr15735928wmf.83.1597675098359; 
 Mon, 17 Aug 2020 07:38:18 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.38.17 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:38:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 054/150] meson: convert check-qapi-schema
Date: Mon, 17 Aug 2020 16:35:47 +0200
Message-Id: <20200817143723.343284-55-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 tests/Makefile.include        | 218 +-------------------------------
 tests/meson.build             |   2 +
 tests/qapi-schema/meson.build | 225 ++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+), 216 deletions(-)
 create mode 100644 tests/qapi-schema/meson.build

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b3f8fdd321..676d099631 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -161,201 +161,6 @@ check-unit-y += tests/test-qapi-util$(EXESUF)
 
 check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
 
-qapi-schema += alternate-any.json
-qapi-schema += alternate-array.json
-qapi-schema += alternate-base.json
-qapi-schema += alternate-branch-if-invalid.json
-qapi-schema += alternate-clash.json
-qapi-schema += alternate-conflict-dict.json
-qapi-schema += alternate-conflict-enum-bool.json
-qapi-schema += alternate-conflict-enum-int.json
-qapi-schema += alternate-conflict-string.json
-qapi-schema += alternate-conflict-bool-string.json
-qapi-schema += alternate-conflict-num-string.json
-qapi-schema += alternate-empty.json
-qapi-schema += alternate-invalid-dict.json
-qapi-schema += alternate-nested.json
-qapi-schema += alternate-unknown.json
-qapi-schema += args-alternate.json
-qapi-schema += args-any.json
-qapi-schema += args-array-empty.json
-qapi-schema += args-array-unknown.json
-qapi-schema += args-bad-boxed.json
-qapi-schema += args-boxed-anon.json
-qapi-schema += args-boxed-string.json
-qapi-schema += args-int.json
-qapi-schema += args-invalid.json
-qapi-schema += args-member-array-bad.json
-qapi-schema += args-member-case.json
-qapi-schema += args-member-unknown.json
-qapi-schema += args-name-clash.json
-qapi-schema += args-union.json
-qapi-schema += args-unknown.json
-qapi-schema += bad-base.json
-qapi-schema += bad-data.json
-qapi-schema += bad-ident.json
-qapi-schema += bad-if.json
-qapi-schema += bad-if-empty.json
-qapi-schema += bad-if-empty-list.json
-qapi-schema += bad-if-list.json
-qapi-schema += bad-type-bool.json
-qapi-schema += bad-type-dict.json
-qapi-schema += bad-type-int.json
-qapi-schema += base-cycle-direct.json
-qapi-schema += base-cycle-indirect.json
-qapi-schema += command-int.json
-qapi-schema += comments.json
-qapi-schema += doc-bad-alternate-member.json
-qapi-schema += doc-bad-boxed-command-arg.json
-qapi-schema += doc-bad-command-arg.json
-qapi-schema += doc-bad-enum-member.json
-qapi-schema += doc-bad-event-arg.json
-qapi-schema += doc-bad-feature.json
-qapi-schema += doc-bad-section.json
-qapi-schema += doc-bad-symbol.json
-qapi-schema += doc-bad-union-member.json
-qapi-schema += doc-before-include.json
-qapi-schema += doc-before-pragma.json
-qapi-schema += doc-duplicated-arg.json
-qapi-schema += doc-duplicated-return.json
-qapi-schema += doc-duplicated-since.json
-qapi-schema += doc-empty-arg.json
-qapi-schema += doc-empty-section.json
-qapi-schema += doc-empty-symbol.json
-qapi-schema += doc-good.json
-qapi-schema += doc-interleaved-section.json
-qapi-schema += doc-invalid-end.json
-qapi-schema += doc-invalid-end2.json
-qapi-schema += doc-invalid-return.json
-qapi-schema += doc-invalid-section.json
-qapi-schema += doc-invalid-start.json
-qapi-schema += doc-missing-colon.json
-qapi-schema += doc-missing-expr.json
-qapi-schema += doc-missing-space.json
-qapi-schema += doc-missing.json
-qapi-schema += doc-no-symbol.json
-qapi-schema += doc-undoc-feature.json
-qapi-schema += double-type.json
-qapi-schema += duplicate-key.json
-qapi-schema += empty.json
-qapi-schema += enum-bad-member.json
-qapi-schema += enum-bad-name.json
-qapi-schema += enum-bad-prefix.json
-qapi-schema += enum-clash-member.json
-qapi-schema += enum-dict-member-unknown.json
-qapi-schema += enum-if-invalid.json
-qapi-schema += enum-int-member.json
-qapi-schema += enum-member-case.json
-qapi-schema += enum-missing-data.json
-qapi-schema += enum-wrong-data.json
-qapi-schema += event-boxed-empty.json
-qapi-schema += event-case.json
-qapi-schema += event-member-invalid-dict.json
-qapi-schema += event-nest-struct.json
-qapi-schema += features-bad-type.json
-qapi-schema += features-deprecated-type.json
-qapi-schema += features-duplicate-name.json
-qapi-schema += features-if-invalid.json
-qapi-schema += features-missing-name.json
-qapi-schema += features-name-bad-type.json
-qapi-schema += features-no-list.json
-qapi-schema += features-unknown-key.json
-qapi-schema += flat-union-array-branch.json
-qapi-schema += flat-union-bad-base.json
-qapi-schema += flat-union-bad-discriminator.json
-qapi-schema += flat-union-base-any.json
-qapi-schema += flat-union-base-union.json
-qapi-schema += flat-union-clash-member.json
-qapi-schema += flat-union-discriminator-bad-name.json
-qapi-schema += flat-union-empty.json
-qapi-schema += flat-union-inline.json
-qapi-schema += flat-union-inline-invalid-dict.json
-qapi-schema += flat-union-int-branch.json
-qapi-schema += flat-union-invalid-branch-key.json
-qapi-schema += flat-union-invalid-discriminator.json
-qapi-schema += flat-union-invalid-if-discriminator.json
-qapi-schema += flat-union-no-base.json
-qapi-schema += flat-union-optional-discriminator.json
-qapi-schema += flat-union-string-discriminator.json
-qapi-schema += funny-char.json
-qapi-schema += funny-word.json
-qapi-schema += ident-with-escape.json
-qapi-schema += include-before-err.json
-qapi-schema += include-cycle.json
-qapi-schema += include-extra-junk.json
-qapi-schema += include-nested-err.json
-qapi-schema += include-no-file.json
-qapi-schema += include-non-file.json
-qapi-schema += include-repetition.json
-qapi-schema += include-self-cycle.json
-qapi-schema += include-simple.json
-qapi-schema += indented-expr.json
-qapi-schema += leading-comma-list.json
-qapi-schema += leading-comma-object.json
-qapi-schema += missing-colon.json
-qapi-schema += missing-comma-list.json
-qapi-schema += missing-comma-object.json
-qapi-schema += missing-type.json
-qapi-schema += nested-struct-data.json
-qapi-schema += nested-struct-data-invalid-dict.json
-qapi-schema += non-objects.json
-qapi-schema += oob-test.json
-qapi-schema += allow-preconfig-test.json
-qapi-schema += pragma-doc-required-crap.json
-qapi-schema += pragma-extra-junk.json
-qapi-schema += pragma-name-case-whitelist-crap.json
-qapi-schema += pragma-non-dict.json
-qapi-schema += pragma-unknown.json
-qapi-schema += pragma-returns-whitelist-crap.json
-qapi-schema += qapi-schema-test.json
-qapi-schema += quoted-structural-chars.json
-qapi-schema += redefined-builtin.json
-qapi-schema += redefined-command.json
-qapi-schema += redefined-event.json
-qapi-schema += redefined-type.json
-qapi-schema += reserved-command-q.json
-qapi-schema += reserved-enum-q.json
-qapi-schema += reserved-member-has.json
-qapi-schema += reserved-member-q.json
-qapi-schema += reserved-member-u.json
-qapi-schema += reserved-member-underscore.json
-qapi-schema += reserved-type-kind.json
-qapi-schema += reserved-type-list.json
-qapi-schema += returns-alternate.json
-qapi-schema += returns-array-bad.json
-qapi-schema += returns-dict.json
-qapi-schema += returns-unknown.json
-qapi-schema += returns-whitelist.json
-qapi-schema += string-code-point-31.json
-qapi-schema += string-code-point-127.json
-qapi-schema += struct-base-clash-deep.json
-qapi-schema += struct-base-clash.json
-qapi-schema += struct-data-invalid.json
-qapi-schema += struct-member-if-invalid.json
-qapi-schema += struct-member-invalid-dict.json
-qapi-schema += struct-member-invalid.json
-qapi-schema += trailing-comma-list.json
-qapi-schema += trailing-comma-object.json
-qapi-schema += type-bypass-bad-gen.json
-qapi-schema += unclosed-list.json
-qapi-schema += unclosed-object.json
-qapi-schema += unclosed-string.json
-qapi-schema += union-base-empty.json
-qapi-schema += union-base-no-discriminator.json
-qapi-schema += union-branch-case.json
-qapi-schema += union-branch-if-invalid.json
-qapi-schema += union-branch-invalid-dict.json
-qapi-schema += union-clash-branches.json
-qapi-schema += union-empty.json
-qapi-schema += union-invalid-base.json
-qapi-schema += union-optional-branch.json
-qapi-schema += union-unknown.json
-qapi-schema += unknown-escape.json
-qapi-schema += unknown-expr-key.json
-
-
-check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
-
 generated-files-y += tests/test-qapi-types.h
 generated-files-y += tests/include/test-qapi-types-sub-module.h
 generated-files-y += tests/test-qapi-types-sub-sub-module.h
@@ -501,13 +306,6 @@ tests/test-qapi-gen-timestamp: \
 	@rm -f tests/test-qapi-doc.texi
 	@>$@
 
-tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
-	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
-		-o tests/qapi-schema -p "doc-good-" $<, \
-		"GEN","$@")
-	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
-	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-good-qmp-*.[ch]
-
 tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/dbus-vmstate1-gen-timestamp ;
 tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
 	$(call quiet-command,$(GDBUS_CODEGEN) $< \
@@ -720,7 +518,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
 .PHONY: clean-tcg
 clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
-# Other tests
 
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
 
@@ -730,16 +527,6 @@ check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
 		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
 	@$<
 
-.PHONY: check-tests/qapi-schema/frontend
-check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-y))
-	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
-	  PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py $^, \
-	  TEST, check-qapi-schema)
-
-.PHONY: check-tests/qapi-schema/doc-good.texi
-check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
-	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
-
 # Python venv for running tests
 
 .PHONY: check-venv check-acceptance
@@ -793,15 +580,14 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
 
 # Consolidated targets
 
-.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean get-vm-images
-check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
+.PHONY: check-block check-qtest check-unit check check-clean get-vm-images
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 ifeq ($(CONFIG_TOOLS),y)
 check-block: $(patsubst %,check-%, $(check-block-y))
 endif
 check-build: build-unit build-qtest
 
-check: check-block check-qapi-schema check-unit check-qtest
+check: check-block check-unit check-qtest
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
diff --git a/tests/meson.build b/tests/meson.build
index ec26f92937..8be9c2233c 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -6,3 +6,5 @@ test('decodetree', sh,
 if 'CONFIG_TCG' in config_host
   subdir('fp')
 endif
+
+subdir('qapi-schema')
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
new file mode 100644
index 0000000000..ae17017504
--- /dev/null
+++ b/tests/qapi-schema/meson.build
@@ -0,0 +1,225 @@
+test_env = environment()
+test_env.set('PYTHONPATH', meson.source_root() / 'scripts')
+test_env.set('PYTHONIOENCODING', 'utf-8')
+
+schemas = [
+  'alternate-any.json',
+  'alternate-array.json',
+  'alternate-base.json',
+  'alternate-branch-if-invalid.json',
+  'alternate-clash.json',
+  'alternate-conflict-dict.json',
+  'alternate-conflict-enum-bool.json',
+  'alternate-conflict-enum-int.json',
+  'alternate-conflict-string.json',
+  'alternate-conflict-bool-string.json',
+  'alternate-conflict-num-string.json',
+  'alternate-empty.json',
+  'alternate-invalid-dict.json',
+  'alternate-nested.json',
+  'alternate-unknown.json',
+  'args-alternate.json',
+  'args-any.json',
+  'args-array-empty.json',
+  'args-array-unknown.json',
+  'args-bad-boxed.json',
+  'args-boxed-anon.json',
+  'args-boxed-string.json',
+  'args-int.json',
+  'args-invalid.json',
+  'args-member-array-bad.json',
+  'args-member-case.json',
+  'args-member-unknown.json',
+  'args-name-clash.json',
+  'args-union.json',
+  'args-unknown.json',
+  'bad-base.json',
+  'bad-data.json',
+  'bad-ident.json',
+  'bad-if.json',
+  'bad-if-empty.json',
+  'bad-if-empty-list.json',
+  'bad-if-list.json',
+  'bad-type-bool.json',
+  'bad-type-dict.json',
+  'bad-type-int.json',
+  'base-cycle-direct.json',
+  'base-cycle-indirect.json',
+  'command-int.json',
+  'comments.json',
+  'doc-bad-alternate-member.json',
+  'doc-bad-boxed-command-arg.json',
+  'doc-bad-command-arg.json',
+  'doc-bad-enum-member.json',
+  'doc-bad-event-arg.json',
+  'doc-bad-feature.json',
+  'doc-bad-section.json',
+  'doc-bad-symbol.json',
+  'doc-bad-union-member.json',
+  'doc-before-include.json',
+  'doc-before-pragma.json',
+  'doc-duplicated-arg.json',
+  'doc-duplicated-return.json',
+  'doc-duplicated-since.json',
+  'doc-empty-arg.json',
+  'doc-empty-section.json',
+  'doc-empty-symbol.json',
+  'doc-good.json',
+  'doc-interleaved-section.json',
+  'doc-invalid-end.json',
+  'doc-invalid-end2.json',
+  'doc-invalid-return.json',
+  'doc-invalid-section.json',
+  'doc-invalid-start.json',
+  'doc-missing-colon.json',
+  'doc-missing-expr.json',
+  'doc-missing-space.json',
+  'doc-missing.json',
+  'doc-no-symbol.json',
+  'doc-undoc-feature.json',
+  'double-type.json',
+  'duplicate-key.json',
+  'empty.json',
+  'enum-bad-member.json',
+  'enum-bad-name.json',
+  'enum-bad-prefix.json',
+  'enum-clash-member.json',
+  'enum-dict-member-unknown.json',
+  'enum-if-invalid.json',
+  'enum-int-member.json',
+  'enum-member-case.json',
+  'enum-missing-data.json',
+  'enum-wrong-data.json',
+  'event-boxed-empty.json',
+  'event-case.json',
+  'event-member-invalid-dict.json',
+  'event-nest-struct.json',
+  'features-bad-type.json',
+  'features-deprecated-type.json',
+  'features-duplicate-name.json',
+  'features-if-invalid.json',
+  'features-missing-name.json',
+  'features-name-bad-type.json',
+  'features-no-list.json',
+  'features-unknown-key.json',
+  'flat-union-array-branch.json',
+  'flat-union-bad-base.json',
+  'flat-union-bad-discriminator.json',
+  'flat-union-base-any.json',
+  'flat-union-base-union.json',
+  'flat-union-clash-member.json',
+  'flat-union-discriminator-bad-name.json',
+  'flat-union-empty.json',
+  'flat-union-inline.json',
+  'flat-union-inline-invalid-dict.json',
+  'flat-union-int-branch.json',
+  'flat-union-invalid-branch-key.json',
+  'flat-union-invalid-discriminator.json',
+  'flat-union-invalid-if-discriminator.json',
+  'flat-union-no-base.json',
+  'flat-union-optional-discriminator.json',
+  'flat-union-string-discriminator.json',
+  'funny-char.json',
+  'funny-word.json',
+  'ident-with-escape.json',
+  'include-before-err.json',
+  'include-cycle.json',
+  'include-extra-junk.json',
+  'include-nested-err.json',
+  'include-no-file.json',
+  'include-non-file.json',
+  'include-repetition.json',
+  'include-self-cycle.json',
+  'include-simple.json',
+  'indented-expr.json',
+  'leading-comma-list.json',
+  'leading-comma-object.json',
+  'missing-colon.json',
+  'missing-comma-list.json',
+  'missing-comma-object.json',
+  'missing-type.json',
+  'nested-struct-data.json',
+  'nested-struct-data-invalid-dict.json',
+  'non-objects.json',
+  'oob-test.json',
+  'allow-preconfig-test.json',
+  'pragma-doc-required-crap.json',
+  'pragma-extra-junk.json',
+  'pragma-name-case-whitelist-crap.json',
+  'pragma-non-dict.json',
+  'pragma-unknown.json',
+  'pragma-returns-whitelist-crap.json',
+  'qapi-schema-test.json',
+  'quoted-structural-chars.json',
+  'redefined-builtin.json',
+  'redefined-command.json',
+  'redefined-event.json',
+  'redefined-type.json',
+  'reserved-command-q.json',
+  'reserved-enum-q.json',
+  'reserved-member-has.json',
+  'reserved-member-q.json',
+  'reserved-member-u.json',
+  'reserved-member-underscore.json',
+  'reserved-type-kind.json',
+  'reserved-type-list.json',
+  'returns-alternate.json',
+  'returns-array-bad.json',
+  'returns-dict.json',
+  'returns-unknown.json',
+  'returns-whitelist.json',
+  'string-code-point-31.json',
+  'string-code-point-127.json',
+  'struct-base-clash-deep.json',
+  'struct-base-clash.json',
+  'struct-data-invalid.json',
+  'struct-member-if-invalid.json',
+  'struct-member-invalid-dict.json',
+  'struct-member-invalid.json',
+  'trailing-comma-list.json',
+  'trailing-comma-object.json',
+  'type-bypass-bad-gen.json',
+  'unclosed-list.json',
+  'unclosed-object.json',
+  'unclosed-string.json',
+  'union-base-empty.json',
+  'union-base-no-discriminator.json',
+  'union-branch-case.json',
+  'union-branch-if-invalid.json',
+  'union-branch-invalid-dict.json',
+  'union-clash-branches.json',
+  'union-empty.json',
+  'union-invalid-base.json',
+  'union-optional-branch.json',
+  'union-unknown.json',
+  'unknown-escape.json',
+  'unknown-expr-key.json',
+]
+
+# Because people may want to use test-qapi.py from the command line, we
+# are not using the "#! /usr/bin/env python3" trick here.  See
+# docs/devel/build-system.txt
+test('QAPI schema regression tests', python, args: files('test-qapi.py', schemas),
+     env: test_env, suite: ['qapi-schema', 'qapi-frontend'])
+
+diff = find_program('diff')
+
+qapi_doc = custom_target('QAPI doc',
+                         output: ['doc-good-qapi-commands.c', 'doc-good-qapi-commands.h',
+                                  'doc-good-qapi-emit-events.c', 'doc-good-qapi-emit-events.h',
+                                  'doc-good-qapi-events.c', 'doc-good-qapi-events.h',
+                                  'doc-good-qapi-init-commands.c', 'doc-good-qapi-init-commands.h',
+                                  'doc-good-qapi-introspect.c', 'doc-good-qapi-introspect.h',
+                                  'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
+                                  'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h',
+                                  'doc-good-qapi-doc.texi' ],
+                         input: files('doc-good.json'),
+                         command: [ qapi_gen, '-o', meson.current_build_dir(),
+                                    '-p', 'doc-good-', '@INPUT0@' ],
+                         depend_files: qapi_gen_depends)
+
+# "full_path()" needed here to work around
+# https://github.com/mesonbuild/meson/issues/7585
+test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+     depends: qapi_doc,
+     suite: ['qapi-schema', 'qapi-doc'])
-- 
2.26.2



