Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B34BC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F54208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F54208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXPb-0007DJ-E6
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:24:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVXO7-0006Kx-87
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVXO5-0002q5-SU
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hVXO5-0002pA-K4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:23:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDDA081E06;
	Tue, 28 May 2019 08:23:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 63BD27D583;
	Tue, 28 May 2019 08:23:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id ECD641132B6C; Tue, 28 May 2019 10:23:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 28 May 2019 10:23:08 +0200
Message-Id: <20190528082308.22032-5-armbru@redhat.com>
In-Reply-To: <20190528082308.22032-1-armbru@redhat.com>
References: <20190528082308.22032-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 28 May 2019 08:23:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] Makefile: Reuse all's recursion machinery
 for clean and install
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Targets "clean" and "install" run make recursively in a for loop.
This ignores -j and -k.  Target "all" depends on SUBDIR/all to recurse
into each SUBDIR.  Behaves nicely with -j and -k.  Put that to use for
"clean" and "install": depend on SUBDIR/clean or SUBDIR/install,
respectively, and delete the loop.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile | 53 +++++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index 42930b7749..f194c61122 100644
--- a/Makefile
+++ b/Makefile
@@ -437,20 +437,22 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-SUBDIR_RULES=$(addsuffix /all, $(TARGET_DIRS))
-SOFTMMU_SUBDIR_RULES=$(filter %-softmmu/all,$(SUBDIR_RULES))
+TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
 
-$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
-$(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
-$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
+SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
+$(SOFTMMU_ALL_RULES): $(authz-obj-y)
+$(SOFTMMU_ALL_RULES): $(block-obj-y)
+$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
+$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
+$(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): config-all-devices.mak
+$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
 
-.PHONY: $(SUBDIR_RULES)
-$(SUBDIR_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" all,)
+.PHONY: $(TARGET_DIRS_RULES)
+# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
+# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
+$(TARGET_DIRS_RULES):
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
@@ -483,19 +485,19 @@ capstone/all: .git-submodule-status
 slirp/all: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
+$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
 
 ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
-ROMSUBDIR_RULES=$(addsuffix /all, $(ROM_DIRS))
+ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 # Only keep -O and -g cflags
-.PHONY: $(ROMSUBDIR_RULES)
-$(ROMSUBDIR_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
+.PHONY: $(ROM_DIRS_RULES)
+$(ROM_DIRS_RULES):
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
 
-ALL_SUBDIRS=$(TARGET_DIRS) $(ROM_DIRS)
-
-recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
+recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 
 $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")
@@ -641,7 +643,7 @@ clean-coverage:
 		"CLEAN", "coverage files")
 endif
 
-clean:
+clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
 	rm -f qemu-options.def
@@ -662,9 +664,6 @@ clean:
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
 	rm -rf qga/qapi-generated
-	for d in $(ALL_SUBDIRS); do \
-	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
-        done
 	rm -f config-all-devices.mak
 
 VERSION ?= $(shell cat VERSION)
@@ -810,7 +809,8 @@ endif
 ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
 
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
-	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
+	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
+	recurse-install
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
 endif
@@ -870,9 +870,6 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
 	done
 	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
-	for d in $(TARGET_DIRS); do \
-	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
-        done
 
 .PHONY: ctags
 ctags:
-- 
2.17.2


