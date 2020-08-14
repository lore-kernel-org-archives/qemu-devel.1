Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5133C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0C7206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddf2jieK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0C7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6X5z-0002Pg-Pf
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vo5-00007d-J3
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k6Vny-0003Es-Db
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 05:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597396517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qu7cV9aE0ufsFGzTBou6V+JCrDgZ+Br4ZbHqBOceXoc=;
 b=ddf2jieKNkuPZbNXX33Suu0SBxHDu0N1E0ErkmR3qoTI7k47O3LQ8h9kvLXSMh+PCAYKTp
 wwvrmTsE0VFzwV0LhXWbOyQZda8MUTT9QkXZt8+TboEyKzKRC8xczrBVedkhNl2p/G5IyL
 Yv3uq3xHY4sNSyUqrkXNsxGYR9Dh3io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-u9ZLojSHOZe0qyc3wBOtFw-1; Fri, 14 Aug 2020 05:15:15 -0400
X-MC-Unique: u9ZLojSHOZe0qyc3wBOtFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4E791015DBF
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 834A85C1BD
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 144/150] meson: convert sample plugins
Date: Fri, 14 Aug 2020 05:13:20 -0400
Message-Id: <20200814091326.16173-145-pbonzini@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 05:13:30
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
 configure                |  4 ----
 tests/Makefile.include   |  9 --------
 tests/meson.build        |  3 +++
 tests/plugin/Makefile    | 46 ----------------------------------------
 tests/plugin/meson.build |  7 ++++++
 5 files changed, 10 insertions(+), 59 deletions(-)
 delete mode 100644 tests/plugin/Makefile
 create mode 100644 tests/plugin/meson.build

diff --git a/configure b/configure
index 8122782449..53212313e4 100755
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
@@ -8274,7 +8271,6 @@ DIRS="$DIRS roms/seabios"
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



