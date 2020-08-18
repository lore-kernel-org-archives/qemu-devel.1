Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27E1C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7192A2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFkEk1p8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7192A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83OR-0003dI-IX
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Lt-0006Ys-6c
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Lh-0007fV-Ex
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvdXfIC4Qn9mzMaxICoeK9SB24WtKqy9qIJx0nDqC6Y=;
 b=SFkEk1p87nfyFmkpJ1XGzdGwOpfRKVgzzoC4JQJ1n0NS73RnR1yniLjFP+rKzBx9rlFxr/
 P5FPy026eqwQnYhzfhHywnXNkdKGsI2I6Vg0DtzGFs1VCWf2m4rx+gc2lx6BOb/xC5G7Go
 E3MlCPAQGCqMAOKUpZgeXoJl7ajIAew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-jNyhLByqPauNMUX1t4oW0Q-1; Tue, 18 Aug 2020 10:12:23 -0400
X-MC-Unique: jNyhLByqPauNMUX1t4oW0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CDA186A56D
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:12:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF3C67A1FA
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:12:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 144/150] meson: convert sample plugins
Date: Tue, 18 Aug 2020 10:10:19 -0400
Message-Id: <20200818141025.21608-145-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 configure                |  4 ----
 tests/Makefile.include   |  9 --------
 tests/meson.build        |  3 +++
 tests/plugin/Makefile    | 46 ----------------------------------------
 tests/plugin/meson.build |  7 ++++++
 5 files changed, 10 insertions(+), 59 deletions(-)
 delete mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/meson.build

diff --git a/configure b/configure
index 19e78fb1b5..94630afca9 100755
--- a/configure
+++ b/configure
@@ -6832,9 +6832,6 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
-echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
-echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
-
 if test "$default_devices" = "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
 else
@@ -8276,7 +8273,6 @@ DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
-LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e023df817d..aec293bdd0 100644
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
index f834c272e8..fe2c6d8e6b 100644
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
index e9348fde4a..0000000000
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
index 0000000000..dbbdcbaa67
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
2.26.2



