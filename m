Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5186FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1253C2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnjpwvNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1253C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CE3-0003Ab-93
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM7-0003pG-4k
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BM5-0003OP-1K
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=s31xm4JAuFhjhN3htnKViDYE1BgESjhYQhCECa8DNG0=;
 b=VnjpwvNesLwuFtnF0fVczumD315YK+zZ4IoflH4Reo8qwoY8AGEKbnaHhJx9zdE//432x7
 TVvSLGKHaITMaGmbxSjMIulgTfA+cQKXTcKzJXE50p4Hw+XcVD2ifEqpN4qTZlivLrEAqO
 ufQwHboP4At6ctecrtAiLFaojvFsE/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-2MZYqA0hOOanrTdXZRR7Zw-1; Mon, 10 Aug 2020 13:12:58 -0400
X-MC-Unique: 2MZYqA0hOOanrTdXZRR7Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C72EC80183C
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:57 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 197CB5F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:12:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 140/147] meson: convert sample plugins
Date: Mon, 10 Aug 2020 19:08:58 +0200
Message-Id: <1597079345-42801-141-git-send-email-pbonzini@redhat.com>
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
 configure                |  4 ----
 tests/Makefile.include   |  9 ---------
 tests/meson.build        |  3 +++
 tests/plugin/Makefile    | 46 ----------------------------------------------
 tests/plugin/meson.build |  7 +++++++
 5 files changed, 10 insertions(+), 59 deletions(-)
 delete mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/meson.build

diff --git a/configure b/configure
index 5d57990..ee32003 100755
--- a/configure
+++ b/configure
@@ -6825,9 +6825,6 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
-echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
-echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
-
 if test "$default_devices" = "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
 else
@@ -8312,7 +8309,6 @@ DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
-LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e023df8..aec293b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -429,15 +429,6 @@ check-speed: $(check-speed-y)
 check-report-unit.tap: $(check-unit-y)
 	$(call do_test_tap,$^)
 
-# Plugins
-ifeq ($(CONFIG_PLUGIN),y)
-.PHONY: plugins
-plugins:
-	$(call quiet-command,\
-		$(MAKE) $(SUBDIR_MAKEFLAGS) -C tests/plugin V="$(V)", \
-		"BUILD", "plugins")
-endif
-
 # Per guest TCG tests
 
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
diff --git a/tests/meson.build b/tests/meson.build
index f834c27..fe2c6d8 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -9,6 +9,9 @@ test('decodetree', sh,
 
 if 'CONFIG_TCG' in config_host
   subdir('fp')
+  if 'CONFIG_PLUGIN' in config_host
+    subdir('plugin')
+  endif
 endif
 
 subdir('qapi-schema')
diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
deleted file mode 100644
index e9348fd..0000000
--- a/tests/plugin/Makefile
+++ /dev/null
@@ -1,46 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# This Makefile example is fairly independent from the main makefile
-# so users can take and adapt it for their build. We only really
-# include config-host.mak so we don't have to repeat probing for
-# cflags that the main configure has already done for us.
-#
-
-BUILD_DIR := $(CURDIR)/../..
-
-include $(BUILD_DIR)/config-host.mak
-
-VPATH += $(SRC_PATH)/tests/plugin
-
-NAMES :=
-NAMES += bb
-NAMES += empty
-NAMES += insn
-NAMES += mem
-NAMES += hotblocks
-NAMES += howvec
-NAMES += hotpages
-NAMES += lockstep
-
-SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
-
-# The main QEMU uses Glib extensively so it's perfectly fine to use it
-# in plugins (which many example do).
-CFLAGS = $(GLIB_CFLAGS)
-CFLAGS += -fPIC
-CFLAGS += $(if $(findstring no-psabi,$(QEMU_CFLAGS)),-Wpsabi)
-CFLAGS += -I$(SRC_PATH)/include/qemu
-
-all: $(SONAMES)
-
-%.o: %.c
-	$(CC) $(CFLAGS) -c -o $@ $<
-
-lib%.so: %.o
-	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
-
-clean:
-	rm -f *.o *.so *.d
-	rm -Rf .libs
-
-.PHONY: all clean
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
new file mode 100644
index 0000000..dbbdcba
--- /dev/null
+++ b/tests/plugin/meson.build
@@ -0,0 +1,7 @@
+t = []
+foreach i : ['bb', 'empty', 'insn', 'mem', 'hotblocks', 'howvec', 'hotpages', 'lockstep']
+  t += shared_module(i, files(i + '.c'),
+                     include_directories: '../../include/qemu',
+                     dependencies: glib)
+endforeach
+alias_target('plugins', t)
-- 
1.8.3.1



