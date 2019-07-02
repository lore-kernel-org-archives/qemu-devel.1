Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1059C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FA42146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FA42146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiH58-00084V-WF
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60952)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiH3K-0006CI-21
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiH3I-0001Zn-O4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiH3I-0001Xh-5H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6807E30C3192;
 Tue,  2 Jul 2019 11:34:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CEE060C43;
 Tue,  2 Jul 2019 11:34:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30EAE11329C7; Tue,  2 Jul 2019 13:34:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 13:34:14 +0200
Message-Id: <20190702113414.6896-5-armbru@redhat.com>
In-Reply-To: <20190702113414.6896-1-armbru@redhat.com>
References: <20190702113414.6896-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 02 Jul 2019 11:34:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] Makefile: Reuse all's recursion machinery
 for clean and install
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
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
Message-Id: <20190528082308.22032-5-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 53 +++++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index e68982bd99..8cf6cbc4c4 100644
--- a/Makefile
+++ b/Makefile
@@ -454,20 +454,22 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","=
$@")
=20
-SUBDIR_RULES=3D$(addsuffix /all, $(TARGET_DIRS))
-SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu/all,$(SUBDIR_RULES))
+TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t)=
, $(TARGET_DIRS)))
=20
-$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
-$(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
-$(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
-$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
+SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
+$(SOFTMMU_ALL_RULES): $(authz-obj-y)
+$(SOFTMMU_ALL_RULES): $(block-obj-y)
+$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
+$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
+$(SOFTMMU_ALL_RULES): $(io-obj-y)
+$(SOFTMMU_ALL_RULES): config-all-devices.mak
+$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
=20
-.PHONY: $(SUBDIR_RULES)
-$(SUBDIR_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" all,)
+.PHONY: $(TARGET_DIRS_RULES)
+# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
+# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-go=
al
+$(TARGET_DIRS_RULES):
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" $(notdir $@),)
=20
 DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D"$(=
V)" LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
 DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
@@ -500,19 +502,19 @@ capstone/all: .git-submodule-status
 slirp/all: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUILD_=
DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" C=
FLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
=20
-$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
+$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
=20
 ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
-ROMSUBDIR_RULES=3D$(addsuffix /all, $(ROM_DIRS))
+ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS))=
)
 # Only keep -O and -g cflags
-.PHONY: $(ROMSUBDIR_RULES)
-$(ROMSUBDIR_RULES):
-	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))",)
+.PHONY: $(ROM_DIRS_RULES)
+$(ROM_DIRS_RULES):
+	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V)=
" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))" $(notdi=
r $@),)
=20
-ALL_SUBDIRS=3D$(TARGET_DIRS) $(ROM_DIRS)
-
-recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
+recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-install: $(addsuffix /install, $(TARGET_DIRS))
=20
 $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
 	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o=
")
@@ -661,7 +663,7 @@ clean-coverage:
 		"CLEAN", "coverage files")
 endif
=20
-clean:
+clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
 	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h =
gen-op-arm.h
 	rm -f qemu-options.def
@@ -682,9 +684,6 @@ clean:
 	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
 	rm -f qapi-gen-timestamp
 	rm -rf qga/qapi-generated
-	for d in $(ALL_SUBDIRS); do \
-	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
-        done
 	rm -f config-all-devices.mak
=20
 VERSION ?=3D $(shell cat VERSION)
@@ -832,7 +831,8 @@ endif
 ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
=20
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir \
-	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
+	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
+	recurse-install
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDI=
R)$(bindir))
 endif
@@ -898,9 +898,6 @@ endif
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_data=
dir)/keymaps"; \
 	done
 	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir=
)/trace-events-all"
-	for d in $(TARGET_DIRS); do \
-	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; \
-        done
=20
 .PHONY: ctags
 ctags:
--=20
2.21.0


