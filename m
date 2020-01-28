Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1712C20CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb5+Sykz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1712C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWDM-0001O0-58
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8K-0004mt-JC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV8H-0000uO-Va
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:39 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV8H-0000rm-Ne
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:37 -0500
Received: by mail-wm1-x344.google.com with SMTP id c84so3564823wme.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RqwRDXjlWxEGitCZIkJjTP2S+VjFa8u5d7/ofPj58Po=;
 b=Sb5+SykzgTVWjnHbnQ7rcHMnO7PMtjHYCmfa23XfzD/Jwmhyvg9BXMiY0E43wFpXOw
 yhLdzwOIfnv3BuRCappH40DXqGMbcbAei5pZSx4sSS09WyvwiBoxUidLhTIlcr4fST70
 JoyRqTm4AkNqMNp3FEQJi5cNsDwOu2pDc9z/gjHyRXT5Ao27W2e/vK/REJmQTNF9MzwX
 kFo04+q5fTY/VK8ghOBkdgc/r137uow6qSkX9++aKlZI3DfDhBU2+frLlqkb/HtRSwKk
 DHIMbsiZhXM7Jry+7II6GtsgWsETy36X1fPBWIwS39ysA3kByCU0Bplid7XA/7Y5AyIc
 pQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RqwRDXjlWxEGitCZIkJjTP2S+VjFa8u5d7/ofPj58Po=;
 b=OHPa9jONZEJk5qBBzO/6jzEbBxrJRNYvk/tDiGnH2EvEz/OS7cK0bU16Ps1V6MEo9Y
 anpfTFhcG0bnFXrCGgNdO15dV3IMWemwGWPdhRFT2cMsNPLILaTBUMAgUjeZH4WHuNdv
 xp4KtbdtvSHKIQBuDrxIVihxoBiKT/03tL6ljsJsz0hKXqQLsolVJ27jy0dWEYNcHR7G
 mHJCmoG+BNMxDBravPO58nXjd3gWrBsxMmVehvo0Fd4hydQhVX4s52vf33eDMN636hsq
 N6ASvRAR8IafWIKqdH4xJLbWkQLosRlN/4DITBB6mXR912ZdwY+DTfP68etFUurdfmh3
 IluQ==
X-Gm-Message-State: APjAAAXsO9rfz00agDUNX4q8uOKtjzpyLTYsiMdchREKDwJCYH3ne/8V
 766BwALbsgA7JTEYEedqGyaDcKF2
X-Google-Smtp-Source: APXvYqwNveUE7auu22khwcOulv5F1DoR0GXKJZn9J6Nyk9MfAehBC6AyAk9y8GllKVaD5I1qGWWrAg==
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr6199807wme.53.1580234316493; 
 Tue, 28 Jan 2020 09:58:36 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 122/142] remove Makefile.target
Date: Tue, 28 Jan 2020 18:53:22 +0100
Message-Id: <20200128175342.9066-123-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile        | 52 ++++---------------------------------------------
 Makefile.objs   | 27 -------------------------
 Makefile.target | 13 -------------
 configure       |  2 --
 4 files changed, 4 insertions(+), 90 deletions(-)
 delete mode 100644 Makefile.target

diff --git a/Makefile b/Makefile
index ddcd39fad5..898aa81232 100644
--- a/Makefile
+++ b/Makefile
@@ -154,24 +154,10 @@ ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/Makefile.objs
 endif
 
-dummy := $(call unnest-vars,, common-obj-y)
-
 include $(SRC_PATH)/tests/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) recurse-all modules
 
-TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
-SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
-SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
-
-SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
-
-.PHONY: $(TARGET_DIRS_RULES)
-# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
-# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
-$(TARGET_DIRS_RULES): $(TARGET_DEPS)
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
-
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
 DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
@@ -213,8 +199,6 @@ subdir-dtc: dtc/all
 subdir-capstone: capstone/all
 subdir-slirp: slirp/all
 
-$(filter %/all, $(TARGET_DIRS_RULES)):
-
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
 ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
@@ -222,11 +206,9 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 $(ROM_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
 
-.PHONY: recurse-all recurse-clean recurse-install
-recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
-recurse-install: $(addsuffix /install, $(TARGET_DIRS))
-$(addsuffix /install, $(TARGET_DIRS)): all
+.PHONY: recurse-all recurse-clean
+recurse-all: $(ROM_DIRS)
+recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
 
 ######################################################################
 
@@ -279,9 +261,6 @@ distclean: clean
 	$(call clean-manual,devel)
 	$(call clean-manual,interop)
 	$(call clean-manual,specs)
-	for d in $(TARGET_DIRS); do \
-	rm -rf $$d || exit 1 ; \
-        done
 	rm -Rf .sdk
 	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
@@ -383,8 +362,7 @@ ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 install: all $(if $(BUILD_DOCS),install-doc) \
 	install-datadir install-localstatedir \
-	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
-	recurse-install
+	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
 ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_PROG) "scripts/qemu-trace-stap" $(DESTDIR)$(bindir)
 endif
@@ -429,9 +407,6 @@ endif
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
-	for d in $(TARGET_DIRS); do \
-	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
-        done
 
 # documentation
 MAKEINFO=makeinfo
@@ -526,20 +501,6 @@ docs/interop/qemu-qmp-ref.dvi docs/interop/qemu-qmp-ref.html \
 
 $(filter %.1 %.7 %.8,$(DOCS)): scripts/texi2pod.pl
 
-# Reports/Analysis
-
-%/coverage-report.html:
-	@mkdir -p $*
-	$(call quiet-command,\
-		gcovr -r $(SRC_PATH) \
-		$(foreach t, $(TARGET_DIRS), --object-directory $(BUILD_DIR)/$(t)) \
-		 --object-directory $(BUILD_DIR) \
-		-p --html --html-details -o $@, \
-		"GEN", "coverage-report.html")
-
-.PHONY: coverage-report
-coverage-report: $(CURDIR)/reports/coverage/coverage-report.html
-
 ifdef CONFIG_WIN32
 
 INSTALLER = qemu-setup-$(VERSION)$(EXESUF)
@@ -623,11 +584,6 @@ endif
 	@echo  '  ctags/TAGS      - Generate tags file for editors'
 	@echo  '  cscope          - Generate cscope index'
 	@echo  ''
-	@$(if $(TARGET_DIRS), \
-		echo 'Architecture specific targets:'; \
-		$(foreach t, $(TARGET_DIRS), \
-		printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \
-		echo '')
 	@echo  'Cleaning targets:'
 	@echo  '  clean           - Remove most generated files but keep the config'
 	@echo  '  distclean       - Remove all generated files'
diff --git a/Makefile.objs b/Makefile.objs
index 9fd3932ae0..654667f501 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -28,30 +28,3 @@ crypto-obj-y = crypto/libcrypto.fa
 io-obj-y = io/libio.fa
 
 qom-obj-y = qom/libqom.fa
-
-######################################################################
-# Target independent part of system emulation. The long term path is to
-# suppress *all* target specific code in case of system emulation, i.e. a
-# single QEMU executable should support all CPUs and machines.
-
-ifeq ($(CONFIG_SOFTMMU),y)
-common-obj-$(CONFIG_AUDIO_ALSA) += audio-alsa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_OSS) += audio-oss$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_PA) += audio-pa$(DSOSUF)
-common-obj-$(CONFIG_AUDIO_SDL) += audio-sdl$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURSES),m) += ui-curses$(DSOSUF)
-common-obj-$(if $(CONFIG_GTK),m) += ui-gtk$(DSOSUF)
-common-obj-$(if $(CONFIG_SDL),m) += ui-sdl$(DSOSUF)
-common-obj-$(if $(CONFIG_SPICE),m) += ui-spice-app$(DSOSUF)
-
-common-obj-$(if $(CONFIG_CURL),m) += block-curl$(DSOSUF)
-common-obj-$(if $(CONFIG_GLUSTERFS),m) += block-gluster$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBISCSI),m) += block-iscsi$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBNFS),m) += block-nfs$(DSOSUF)
-common-obj-$(if $(CONFIG_LIBSSH),m) += block-ssh$(DSOSUF)
-common-obj-$(if $(CONFIG_RBD),m) += block-rbd$(DSOSUF)
-
-common-obj-$(if $(CONFIG_LZFSE),m) += block-dmg-lzfse$(DSOSUF)
-common-obj-$(if $(and $(CONFIG_BZIP2),$(CONFIG_DMG)),m) += block-dmg-bz2$(DSOSUF)
-endif
diff --git a/Makefile.target b/Makefile.target
deleted file mode 100644
index 4f72a8950d..0000000000
--- a/Makefile.target
+++ /dev/null
@@ -1,13 +0,0 @@
-# -*- Mode: makefile -*-
-
-BUILD_DIR?=$(CURDIR)/..
-
-include ../config-host.mak
-include config-target.mak
-include $(SRC_PATH)/rules.mak
-
-all:
-clean:
-install: all
-	
-.PHONY: all clean install
diff --git a/configure b/configure
index e39d7ac2d1..089bff7c37 100755
--- a/configure
+++ b/configure
@@ -7796,8 +7796,6 @@ if [ "$TARGET_BASE_ARCH" = "" ]; then
   TARGET_BASE_ARCH=$TARGET_ARCH
 fi
 
-symlink "$source_path/Makefile.target" "$target_dir/Makefile"
-
 upper() {
     echo "$@"| LC_ALL=C tr '[a-z]' '[A-Z]'
 }
-- 
2.21.0



