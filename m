Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F854C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7993620748
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSLbMv9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7993620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mQT-0001sf-K6
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRP-0003NQ-Ak
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lRL-000711-PG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=4jlK73QzxguiMHKjdmTDjOD5o0L8bgiCqglV2Yl2AaE=;
 b=aSLbMv9+VNkBsPFVzqBatG3BpJZB9cQ9yvyoNpRMi0YQow+5ZO5cZ95qI+JPZc6hYOv3nf
 hRZg/HoxbIavX1THtfGFCKUOnlVW9GnUNGsPbYdrlPdO0QzZVS+PVd5tGywnDjeZ/QSY6R
 jmDtT5Tm5VnQ/Dg2C7AlUWmuCSB9WkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-bTFcqmPEMWijJexCuS_p-g-1; Thu, 06 Aug 2020 15:20:33 -0400
X-MC-Unique: bTFcqmPEMWijJexCuS_p-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7094C1DE7
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:32 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B81531D3
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:20:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 139/143] meson: convert sample plugins
Date: Thu,  6 Aug 2020 21:16:15 +0200
Message-Id: <1596741379-12902-140-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
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
 configure                |  4 ----
 tests/Makefile.include   |  9 ---------
 tests/meson.build        |  3 +++
 tests/plugin/Makefile    | 46 ----------------------------------------------
 tests/plugin/meson.build |  7 +++++++
 5 files changed, 10 insertions(+), 59 deletions(-)
 delete mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/meson.build

diff --git a/configure b/configure
index 13b03ac..a0b51d0 100755
--- a/configure
+++ b/configure
@@ -6823,9 +6823,6 @@ echo "GIT_UPDATE=$git_update" >> $config_host_mak
 
 echo "ARCH=$ARCH" >> $config_host_mak
 
-echo "GLIB_CFLAGS=$glib_cflags" >> $config_host_mak
-echo "GLIB_LDFLAGS=$glib_ldflags" >> $config_host_mak
-
 if test "$default_devices" = "yes" ; then
   echo "CONFIG_MINIKCONF_MODE=--defconfig" >> $config_host_mak
 else
@@ -8310,7 +8307,6 @@ DIRS="$DIRS roms/seabios"
 LINKS="Makefile"
 LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
 LINKS="$LINKS tests/tcg/Makefile.target"
-LINKS="$LINKS tests/plugin/Makefile"
 LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
 LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS roms/seabios/Makefile"
diff --git a/tests/Makefile.include b/tests/Makefile.include
index a1e4871..89eeeaa 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -436,15 +436,6 @@ check-speed: $(check-speed-y)
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



